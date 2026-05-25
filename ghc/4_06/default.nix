{
  lib,
  stdenvNoCC,
  fetchurl,
  fetchFromGitHub,
  perl,
  gcc,
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
  prePatch = ''
    cp -r ${
      fetchFromGitHub {
        owner = "haskell";
        repo = "happy";
        rev = "6a2f905bf11d66b0be6390a0914b8ae5f1f934ee";
        hash = "sha256-MA9iA6fLFAw1T5oWZ1R9NYR3d/CP31Co33MlaeFvn2A=";
      }
    } happy
    chmod -R u+w happy
    rm happy/src/Parser.ly
  '';
  nativeBuildInputs = [
    perl
    gcc
    ghc
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  enableParallelBuilding = true;
  preBuild = ''
    cd happy
    make
    cd ..
    make boot
  '';
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
  env.NIX_GCC_NEEDS_GREP = true;
})
