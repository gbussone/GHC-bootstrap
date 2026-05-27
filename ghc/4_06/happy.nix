{
  lib,
  stdenvNoCC,
  fetchurl,
  fetchFromGitHub,
  perl,
  gcc,
  happy,
  ghc,
  gmp,
  bootstrap ? false,
}:

stdenvNoCC.mkDerivation {
  pname = "happy";
  version = "unstable";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/4.06/ghc-4.06-src.tar.gz";
    hash = "sha256-zksvEM87OafEHCt37DbPYyqjIysHLnoYSw9mhNrQZDg=";
  };
  postUnpack = ''
    cp -r ${
      fetchFromGitHub {
        owner = "haskell";
        repo = "happy";
        rev = "6a2f905bf11d66b0be6390a0914b8ae5f1f934ee";
        hash = "sha256-MA9iA6fLFAw1T5oWZ1R9NYR3d/CP31Co33MlaeFvn2A=";
      }
    } fptools/happy
    chmod -R u+w fptools/happy
  '';
  sourceRoot = "fptools/happy";
  dontMakeSourcesWritable = true;
  prePatch = lib.strings.optionalString bootstrap ''
    rm src/Parser.ly
  '';
  nativeBuildInputs = [
    perl
    gcc
  ]
  ++ lib.lists.optional (!bootstrap) happy
  ++ [ ghc ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
    cd ..
  '';
  postConfigure = ''
    cd happy
  '';
  preInstall = ''
    make -C .. glafp-utils
  '';
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
}
