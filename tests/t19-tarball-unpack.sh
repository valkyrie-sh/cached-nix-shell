#!/bin/sh
. ./lib.sh
# Check that tarball unpacking wont interfere with the cache.

mkdir -p tmp/repo/data
echo '(import <nixpkgs> {}).hello' > tmp/repo/data/default.nix
tar -C tmp/repo -cf tmp/repo.tar data

R=$$_$(date +%s)

run cached-nix-shell -I q="file://$PWD/tmp/repo.tar?a$R" -p 'import <q>' --run :
check_slow

run cached-nix-shell -I q="file://$PWD/tmp/repo.tar?a$R" -p 'import <q>' --run :
skip '[ "$(uname)" = Darwin ]' check_fast

run cached-nix-shell -p "fetchTarball file://$PWD/tmp/repo.tar?b$R" --run :
check_slow

run cached-nix-shell -p "fetchTarball file://$PWD/tmp/repo.tar?b$R" --run :
skip '[ "$(uname)" = Darwin ]' check_fast
