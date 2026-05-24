{
  stdenvNoCC,
  fetchurl,
  fetchFromGitHub,
  perl,
  gcc,
  ghc,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "4.08.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-ONw+HviIATOD0gWomR4dFvRNTmD1hSPd5rtkRny3JCs=";
  };
  prePatch = ''
    cp -r ${
      fetchFromGitHub {
        owner = "haskell";
        repo = "happy";
        rev = "9ba23c6499b396edc5d3420dedecaa04a0c7f76c";
        hash = "sha256-Bs8kB99G+xe1WUy95BVvbDBjGvmpvfwpkXKaJfFE7do=";
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
  preBuild = ''
    cd happy
    make
    cd ..
    make boot
  '';
  env.NIX_GCC_NEEDS_GREP = true;
})
