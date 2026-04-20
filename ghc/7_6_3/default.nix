{
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  ghc,
  gmp,
  ncurses,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "7.6.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-vUOCPTH2tdCyynt0FRqPmDNqsIAL6F9Fu1kcnCaqyZg=";
  };
  nativeBuildInputs = [
    perl
    gcc
    ghc
  ];
  buildInputs = [
    gmp.dev
    ncurses.dev
  ];
  hardeningDisable = [ "format" ];
  enableParallelBuilding = true;
})
