{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  m4,
  gcc,
  happy,
  ghc,
  readline,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "5.00.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-s41/BDZX2KtcnNfb4hA6nim+IIU45RjRUoz2bODuhNg=";
  };
  nativeBuildInputs = [
    perl
    m4
    gcc
    happy
    ghc
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [ readline ];
  env.NIX_GCC_NEEDS_GREP = true;
})
