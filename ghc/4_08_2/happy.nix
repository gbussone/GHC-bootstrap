{
  lib,
  stdenvNoCC,
  fetchurl,
  fetchFromGitHub,
  perl,
  gcc,
  happy,
  ghc,
  bootstrap ? false,
}:

stdenvNoCC.mkDerivation {
  pname = "happy";
  version = "unstable";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/4.08.2/ghc-4.08.2-src.tar.bz2";
    hash = "sha256-ONw+HviIATOD0gWomR4dFvRNTmD1hSPd5rtkRny3JCs=";
  };
  postUnpack = ''
    cp -r ${
      fetchFromGitHub {
        owner = "haskell";
        repo = "happy";
        rev = "9ba23c6499b396edc5d3420dedecaa04a0c7f76c";
        hash = "sha256-Bs8kB99G+xe1WUy95BVvbDBjGvmpvfwpkXKaJfFE7do=";
      }
    } ghc-4.08.2/happy
    chmod -R u+w ghc-4.08.2/happy
  '';
  prePatch = lib.strings.optionalString bootstrap ''
    rm happy/src/Parser.ly
  '';
  nativeBuildInputs = [
    perl
    gcc
  ]
  ++ lib.lists.optional (!bootstrap) happy
  ++ [ ghc ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  makeFlags = [
    "-C"
    "happy"
  ];
  preInstall = ''
    make -C glafp-utils/mkdirhier
  '';
}
