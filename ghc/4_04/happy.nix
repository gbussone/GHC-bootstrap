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
}:

stdenvNoCC.mkDerivation {
  pname = "happy";
  version = "unstable";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/4.04/ghc-4.04-src.tar.gz";
    hash = "sha256-ZKTnMyu0j7l8u81TSXMyhpxqQczO2Br1tSXNDAyB01Y=";
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
  nativeBuildInputs = [
    perl
    gcc
    happy
    ghc
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  makeFlags = [
    "-C"
    "happy"
  ];
  preBuild = ''
    ln -s ${ghc}/bin/ghc ghc/driver/ghc
  '';
  postBuild = ''
    rm ghc/driver/ghc
  '';
  preInstall = ''
    make -C glafp-utils/mkdirhier
  '';
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
}
