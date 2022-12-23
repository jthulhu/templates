#!/usr/bin/env bash

function pushd() {
    builtin pushd "$@" >/dev/null
}

function popd() {
    builtin popd "$@" >/dev/null
}

ERROR=$'\e[91;1m'
FAT=$'\e[97;1m'
RESET=$'\e[0m'
PROTOCOL=https
IMAGE_VERSION=60
IMAGE_SUBVERSION=547
IMAGE_SHA256=3d817051d10eea2178d3db06aa8d990ce7ddc8dc98e0c46f709b269c22e2b57f
IMAGE_SOURCE=files.pharo.org/image/$IMAGE_VERSION/$IMAGE_VERSION$IMAGE_SUBVERSION.zip
MAXATTEMPTS=3

CACHE=${XDG_CACHE:-$HOME/.cache}/isc

if [[ ! -d $CACHE ]]; then
    mkdir -p $CACHE
fi

function download_image_into() {
    dir=`mktemp -d`
    archive=pharo-$IMAGE_VERSION.zip
    pushd $dir
    if [[ ! -f "$CACHE/$archive" ]]; then
	echo " ${FAT}note:${RESET} $archive not found in cache, downloading."
	if ! curl --output \
	     "$CACHE/$archive" "$PROTOCOL://$IMAGE_SOURCE"
	then
	    rm -r "$dir"
	    popd
	    return 2
	fi
    fi
    cp "$CACHE/$archive" "$archive"
    checksum=`sha256sum $archive | cut -d' ' -f 1`
    if [[ "$checksum" == "$IMAGE_SHA256" ]]; then
	unzip "$archive"
	mv {"Pharo-$IMAGE_VERSION$IMAGE_SUBVERSION","$1/pharo-$IMAGE_VERSION"}.image 
	mv {"Pharo-$IMAGE_VERSION$IMAGE_SUBVERSION","$1/pharo-$IMAGE_VERSION"}.changes
    else
	echo "${ERROR}error:${RESET} checksum mismatch"
	echo " ${FAT}expected: $IMAGE_SHA256${RESET}"
	echo "    ${FAT}found: $checksum${RESET}"
	echo
	echo " ${FAT}note:${RESET} removing cached version, which is invalid."
	rm "$CACHE/$archive"
	rm -r "$dir"
	popd
	return 2
    fi

    rm -r "$dir"
    popd
}

for attempt in `seq 1 $MAXATTEMPTS`; do
    echo "${FAT}Attempt $attempt/$MAXATTEMPTS at downloading pharo-$IMAGE_VERSION...${RESET}"
    download_image_into `pwd` && exit 0
    if (( attempt != MAXATTEMPS )); then
	echo "${ERROR}error:${RESET} attempt failed. Retrying soon."
	sleep 1
    else
	echo "${ERROR}error:${RESET} attempt failed. No further attempts."
    fi
done
echo
echo "${ERROR}error:${RESET} failed to download pharo-$IMAGE_VERSION"
exit 2
