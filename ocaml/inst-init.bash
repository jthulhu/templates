while (($# > 0)); do
    case "$1" in
	--menhir )
	    patch flake.nix inst-init.d/flake-menhir.patch
	    patch dune-project  inst-init.d/dune-project-menhir.patch
	    patch src/dune inst-init.d/dune-menhir.patch
	    touch src/parser.mly
	    touch src/lexer.mll
	    shift
	    break
	    ;;
	* )
	    echo "Unknown option $1"
	    exit 1
    esac
done

rm -r inst-init.d
