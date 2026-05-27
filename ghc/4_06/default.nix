{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  happy,
  ghc,
  gmp,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "4.06";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.gz";
    hash = "sha256-zksvEM87OafEHCt37DbPYyqjIysHLnoYSw9mhNrQZDg=";
  };
  nativeBuildInputs = [
    perl
    gcc
    happy
    ghc
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  enableParallelBuilding = true;
  preBuild = ''
    make boot
  '';
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
  env.NIX_GCC_NEEDS_GREP = true;
})
