{
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  flex,
  ghc,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "6.0.1";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-qolkpmVLMifA98+rKcCi3lQ/GHIObfdHSlkHjFYCpic=";
  };
  patches = [ ./ucred.patch ];
  nativeBuildInputs = [
    perl
    gcc
    flex
    ghc
  ];
})
