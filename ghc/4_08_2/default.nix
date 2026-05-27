{
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  happy,
  ghc,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "4.08.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-ONw+HviIATOD0gWomR4dFvRNTmD1hSPd5rtkRny3JCs=";
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
  preBuild = ''
    make boot
  '';
  env.NIX_GCC_NEEDS_GREP = true;
})
