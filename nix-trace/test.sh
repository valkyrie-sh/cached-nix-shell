#!/bin/sh

run() {
	rm -f test-tmp/log
	env \
		DYLD_INSERT_LIBRARIES="$PWD"/build/trace-nix.so \
		LD_PRELOAD="$PWD"/build/trace-nix.so \
		TRACE_NIX=test-tmp/log \
		nix-shell --run : "$@" 2>/dev/null &
	NIX_PID=$!
	wait
}

result=0

dir_b3sum() {
	find "$1" -mindepth 1 -maxdepth 1 -printf '%P=%y\0' |
		sed -z 's/[^dlf]$/u/' |
		LC_ALL=C sort -z |
		b3sum |
		head -c 32
}

check() {
	local grep_opts=
	[ "$1" != "--first" ] || { shift; grep_opts=-m1; }
	local name="$1" key="$2" val="$3"

	if ! grep -qzFx -- "$key" test-tmp/log; then
		printf "\33[31mFail: %s: can't find key\33[m\n" "$name"
		return
		result=1
	fi

	local actual_val=$(
		grep $grep_opts -zFx -A1 -- "$key" test-tmp/log |
		tail -zn1 |
		tr -d '\0'
	)
	if [ "$val" != "$actual_val" ]; then
		printf "\33[31mFail: %s: expected '%s', got '%s'\33[m\n" \
			"$name" "$val" "$actual_val"
		return
		result=1
	fi

	printf "\33[32mOK: %s\33[m\n" "$name"
}

rm -rf test-tmp
mkdir test-tmp
echo '"foo"' > test-tmp/test.nix
: > test-tmp/empty
ln -s empty test-tmp/link

mkdir -p test-tmp/repo/data test-tmp/tmpdir
echo '{}' > test-tmp/repo/data/default.nix
tar -C test-tmp/repo -cf test-tmp/repo.tar .

x=""
for i in {1..64};do
	x=x$x
	mkdir -p test-tmp/many-dirs/$x
done

export XDG_CACHE_HOME="$PWD/test-tmp/xdg-cache"
export TMPDIR="$PWD/test-tmp/tmpdir"


run -p 'with import <unstable> {}; bash'
check import-channel \
	"s/nix/var/nix/profiles/per-user/root/channels/unstable" \
	"l$(readlink /nix/var/nix/profiles/per-user/root/channels/unstable)"

run -p 'with import <nonexistentChannel> {}; bash'
check import-channel-ne \
	"s/nix/var/nix/profiles/per-user/root/channels/nonexistentChannel" '-'


run -p 'import ./test-tmp/test.nix'
check import-relative-nix \
	"s$PWD/test-tmp/test.nix" "+"

run -p 'import ./test-tmp'
check import-relative-nix-dir \
	"s$PWD/test-tmp" "d"

run -p 'import ./nonexistent.nix'
check import-relative-nix-ne \
	"s$PWD/nonexistent.nix" "-"


run -p 'builtins.readFile ./test-tmp/test.nix'
check builtins.readFile \
	"f$PWD/test-tmp/test.nix" \
	"$(b3sum ./test-tmp/test.nix | head -c 32)"

run -p 'builtins.readFile "/nonexistent/readFile"'
check builtins.readFile-ne \
	"f/nonexistent/readFile" "-"

run -p 'builtins.readFile ./test-tmp'
check builtins.readFile-dir \
	"f$PWD/test-tmp" "e"

run -p 'builtins.readFile ./test-tmp/empty'
check builtins.readFile-empty \
	"f$PWD/test-tmp/empty" \
	"$(b3sum ./test-tmp/empty | head -c 32)"


run -p 'builtins.readDir ./test-tmp'
check builtins.readDir \
	"d$PWD/test-tmp" "$(dir_b3sum ./test-tmp)"

run -p 'builtins.readDir "/nonexistent/readDir"'
check builtins.readDir-ne \
	"d/nonexistent/readDir" "-"


run -p 'builtins.readDir ./test-tmp/many-dirs'
check builtins.readDir-many-dirs \
	"d$PWD/test-tmp/many-dirs" "$(dir_b3sum ./test-tmp/many-dirs)"

run
check implicit:shell.nix \
	"s$PWD/shell.nix" "-"
check implicit:default.nix \
	"s$PWD/default.nix" "-"


run -p "fetchTarball file://$PWD/test-tmp/repo.tar?1"
check --first fetchTarball:create \
	"t$PWD/test-tmp/tmpdir/nix-$NIX_PID-1" "+"
check fetchTarball:delete \
	"t$PWD/test-tmp/tmpdir/nix-$NIX_PID-1" "-"

run -I "q=file://$PWD/test-tmp/repo.tar?2" -p "import <q>"
check --first tarball-I:create \
	"t$PWD/test-tmp/tmpdir/nix-$NIX_PID-1" "+"
check tarball-I:delete \
	"t$PWD/test-tmp/tmpdir/nix-$NIX_PID-1" "-"

exit $result
