LANG=english

while (($# > 0)); do
    case "$1" in
	--lang )
	    if (($# < 2)); then
		echo "The option --lang takes an additional parameter LANG."
		exit 1
	    fi
	    LANG=$2
	    shift 2
	    break
	    ;;
	* )
	    echo "Unknown option $1"
	    exit 1
    esac
done

sed -i "s/!LANG!/$LANG/" src/!NAME!.tex
