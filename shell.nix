let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = { allowUnfree = true; }; overlays = []; };

  git = pkgs.git.overrideAttrs (oldAttrs: rec {
    version = "2.42.0";
  });

  podman = pkgs.podman.overrideAttrs (oldAttrs: rec {
    version = "4.7.2";
  });

  postgresql = pkgs.postgresql_15.overrideAttrs (oldAttrs: rec {
    version = "15.4";
  });
in

pkgs.mkShell {
  packages = with pkgs; [
    git
    podman
    nodejs_20
    python311
    python311Packages.pip
    pdm
    redis
    postgresql
  ];

  shellHook = ''
  alias docker=podman
  export NIX_SHELL_DIR=$PWD/.nix-shell
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  export PGDATA=$NIX_SHELL_DIR/db
  export PGHOST=localhost
  export PGUSER=postgres
  export PGPASSWORD=password
  
  if [ ! -d "$NIX_SHELL_DIR" ]; then
    mkdir -p $NIX_SHELL_DIR
  fi

  # Attempt to gracefully stop PostgreSQL and Redis on shell exit
  trap "pg_ctl -D $PGDATA stop; pkill redis-server" EXIT
  
  # Initialize PostgreSQL database directory if it doesn't exist
  if [ ! -d "$PGDATA" ]; then
    initdb -D $PGDATA --no-locale --encoding=UTF8
  fi

  # Adjust PostgreSQL authentication method for local connections
  HOST_COMMON="host\s\+all\s\+all"
  sed -i "s|^$HOST_COMMON.*127.*$|host all all 0.0.0.0/0 trust|" $PGDATA/pg_hba.conf
  sed -i "s|^$HOST_COMMON.*::1.*$|host all all ::/0 trust|" $PGDATA/pg_hba.conf
  
  # Start PostgreSQL, consider checking if it's already running or manage it outside of nix-shell
  pg_ctl -D $PGDATA -l $PGDATA/postgres.log start || (echo "Failed to start PostgreSQL. Check $PGDATA/postgres.log for details." && exit 1)
  
  # Setup PostgreSQL database and user if necessary
  # Consider managing this outside of nix-shell for more predictable control
  
  # Redis startup with port check
  if ! nc -z localhost 6379; then
    nohup redis-server > $NIX_SHELL_DIR/redis.log 2>&1 &
  else
    echo "Redis is already running or port 6379 is in use."
  fi
  '';

}
