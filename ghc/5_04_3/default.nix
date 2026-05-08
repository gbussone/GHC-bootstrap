{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  flex,
  ghc,
  ncurses,
  readline,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "5.04.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-xmJYk4PUn9TBKPE3ibKaf321Xp0UYDJRm/sceW2PcVM=";
  };
  nativeBuildInputs = [
    perl
    gcc
    flex
    ghc
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [
    ncurses
    readline
  ];
  env.NIX_GCC_NEEDS_GREP = true;
})
