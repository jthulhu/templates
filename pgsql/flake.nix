{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:numtide/flake-utils;
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = pkgs.mkShell {
          name = "pgsql";
          shellHook = ''
            GREEN='\e[1;32m'
            WHITE='\e[1;37m'
            ITALIC='\e[4m'
            END='\e[0m'
            export PGDATA=$PWD/.data
            export PGHOST=$PGDATA
            if [ ! -d .data ]; then
              initdb
              echo "unix_socket_directories = '$PGHOST'" >>.data/postgresql.conf
            fi
            alias pg_ctl="pg_ctl -l pgsql.log"
            echo
            echo -e "         ''${GREEN}Start PostgreSQL:''${END} ''${WHITE}pg_ctl start''${END}"
            echo -e "        ''${GREEN}Create a database:''${END} ''${WHITE}createdb ''${ITALIC}db_name''${END}"
            echo -e "  ''${GREEN}Connect to the database:''${END} ''${WHITE}psql ''${ITALIC}db_name''${END}"
            echo -e "          ''${GREEN}Stop PostgreSQL:''${END} ''${WHITE}pg_ctl stop''${END}"
          '';
          packages = with pkgs; [
            postgresql
          ];
        };
      });
}
