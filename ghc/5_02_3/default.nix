{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  flex,
  happy,
  ghc,
  ncurses,
  readline,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "5.02.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-B97MORMdvJEPi1rguBY9juAzWvJnH4yVfZIoM775Aec=";
  };
  nativeBuildInputs = [
    perl
    gcc
    flex
    happy
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
