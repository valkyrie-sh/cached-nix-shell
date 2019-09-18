# Generated by carnix 0.10.0: carnix generate-nix --src ./.
{ lib, buildPlatform, buildRustCrate, buildRustCrateHelpers, cratesIO, fetchgit }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {
  crates = cratesIO // rec {
# cached-nix-shell-0.1.0

    crates.cached_nix_shell."0.1.0" = deps: { features?(features_.cached_nix_shell."0.1.0" deps {}) }: buildRustCrate {
      crateName = "cached-nix-shell";
      version = "0.1.0";
      authors = [ "Albert Safin <xzfcpw@gmail.com>" ];
      edition = "2018";
      src = include [ "src/**/*" "Cargo.toml" ] ./.;
      dependencies = mapFeatures features ([
        (cratesIO.crates."clap"."${deps."cached_nix_shell"."0.1.0"."clap"}" deps)
        (cratesIO.crates."regex"."${deps."cached_nix_shell"."0.1.0"."regex"}" deps)
        (cratesIO.crates."rust_crypto"."${deps."cached_nix_shell"."0.1.0"."rust_crypto"}" deps)
        (cratesIO.crates."serde"."${deps."cached_nix_shell"."0.1.0"."serde"}" deps)
        (cratesIO.crates."serde_json"."${deps."cached_nix_shell"."0.1.0"."serde_json"}" deps)
        (cratesIO.crates."shellwords"."${deps."cached_nix_shell"."0.1.0"."shellwords"}" deps)
        (cratesIO.crates."xdg"."${deps."cached_nix_shell"."0.1.0"."xdg"}" deps)
      ]);
    };
    features_.cached_nix_shell."0.1.0" = deps: f: updateFeatures f (rec {
      cached_nix_shell."0.1.0".default = (f.cached_nix_shell."0.1.0".default or true);
      clap."${deps.cached_nix_shell."0.1.0".clap}".default = true;
      regex."${deps.cached_nix_shell."0.1.0".regex}".default = true;
      rust_crypto."${deps.cached_nix_shell."0.1.0".rust_crypto}".default = true;
      serde = fold recursiveUpdate {} [
        { "${deps.cached_nix_shell."0.1.0".serde}"."derive" = true; }
        { "${deps.cached_nix_shell."0.1.0".serde}".default = true; }
      ];
      serde_json."${deps.cached_nix_shell."0.1.0".serde_json}".default = true;
      shellwords."${deps.cached_nix_shell."0.1.0".shellwords}".default = true;
      xdg."${deps.cached_nix_shell."0.1.0".xdg}".default = true;
    }) [
      (cratesIO.features_.clap."${deps."cached_nix_shell"."0.1.0"."clap"}" deps)
      (cratesIO.features_.regex."${deps."cached_nix_shell"."0.1.0"."regex"}" deps)
      (cratesIO.features_.rust_crypto."${deps."cached_nix_shell"."0.1.0"."rust_crypto"}" deps)
      (cratesIO.features_.serde."${deps."cached_nix_shell"."0.1.0"."serde"}" deps)
      (cratesIO.features_.serde_json."${deps."cached_nix_shell"."0.1.0"."serde_json"}" deps)
      (cratesIO.features_.shellwords."${deps."cached_nix_shell"."0.1.0"."shellwords"}" deps)
      (cratesIO.features_.xdg."${deps."cached_nix_shell"."0.1.0"."xdg"}" deps)
    ];


# end

  };

  cached_nix_shell = crates.crates.cached_nix_shell."0.1.0" deps;
  __all = [ (cached_nix_shell {}) ];
  deps.aho_corasick."0.7.6" = {
    memchr = "2.2.1";
  };
  deps.ansi_term."0.11.0" = {
    winapi = "0.3.8";
  };
  deps.atty."0.2.13" = {
    libc = "0.2.62";
    winapi = "0.3.8";
  };
  deps.bitflags."1.1.0" = {};
  deps.cached_nix_shell."0.1.0" = {
    clap = "2.33.0";
    regex = "1.3.1";
    rust_crypto = "0.2.36";
    serde = "1.0.101";
    serde_json = "1.0.40";
    shellwords = "1.0.0";
    xdg = "2.2.0";
  };
  deps.clap."2.33.0" = {
    atty = "0.2.13";
    bitflags = "1.1.0";
    strsim = "0.8.0";
    textwrap = "0.11.0";
    unicode_width = "0.1.6";
    vec_map = "0.8.1";
    ansi_term = "0.11.0";
  };
  deps.fuchsia_cprng."0.1.1" = {};
  deps.gcc."0.3.55" = {};
  deps.itoa."0.4.4" = {};
  deps.lazy_static."1.4.0" = {};
  deps.libc."0.2.62" = {};
  deps.memchr."2.2.1" = {};
  deps.proc_macro2."1.0.3" = {
    unicode_xid = "0.2.0";
  };
  deps.quote."1.0.2" = {
    proc_macro2 = "1.0.3";
  };
  deps.rand."0.3.23" = {
    libc = "0.2.62";
    rand = "0.4.6";
  };
  deps.rand."0.4.6" = {
    rand_core = "0.3.1";
    rdrand = "0.4.0";
    fuchsia_cprng = "0.1.1";
    libc = "0.2.62";
    winapi = "0.3.8";
  };
  deps.rand_core."0.3.1" = {
    rand_core = "0.4.2";
  };
  deps.rand_core."0.4.2" = {};
  deps.rdrand."0.4.0" = {
    rand_core = "0.3.1";
  };
  deps.redox_syscall."0.1.56" = {};
  deps.regex."1.3.1" = {
    aho_corasick = "0.7.6";
    memchr = "2.2.1";
    regex_syntax = "0.6.12";
    thread_local = "0.3.6";
  };
  deps.regex_syntax."0.6.12" = {};
  deps.rust_crypto."0.2.36" = {
    libc = "0.2.62";
    rand = "0.3.23";
    rustc_serialize = "0.3.24";
    time = "0.1.42";
    gcc = "0.3.55";
  };
  deps.rustc_serialize."0.3.24" = {};
  deps.ryu."1.0.0" = {};
  deps.serde."1.0.101" = {
    serde_derive = "1.0.101";
  };
  deps.serde_derive."1.0.101" = {
    proc_macro2 = "1.0.3";
    quote = "1.0.2";
    syn = "1.0.5";
  };
  deps.serde_json."1.0.40" = {
    itoa = "0.4.4";
    ryu = "1.0.0";
    serde = "1.0.101";
  };
  deps.shellwords."1.0.0" = {
    lazy_static = "1.4.0";
    regex = "1.3.1";
  };
  deps.strsim."0.8.0" = {};
  deps.syn."1.0.5" = {
    proc_macro2 = "1.0.3";
    quote = "1.0.2";
    unicode_xid = "0.2.0";
  };
  deps.textwrap."0.11.0" = {
    unicode_width = "0.1.6";
  };
  deps.thread_local."0.3.6" = {
    lazy_static = "1.4.0";
  };
  deps.time."0.1.42" = {
    libc = "0.2.62";
    redox_syscall = "0.1.56";
    winapi = "0.3.8";
  };
  deps.unicode_width."0.1.6" = {};
  deps.unicode_xid."0.2.0" = {};
  deps.vec_map."0.8.1" = {};
  deps.winapi."0.3.8" = {
    winapi_i686_pc_windows_gnu = "0.4.0";
    winapi_x86_64_pc_windows_gnu = "0.4.0";
  };
  deps.winapi_i686_pc_windows_gnu."0.4.0" = {};
  deps.winapi_x86_64_pc_windows_gnu."0.4.0" = {};
  deps.xdg."2.2.0" = {};
}
