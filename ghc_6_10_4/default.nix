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
  version = "6.10.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-1mqOUlcvT/gZ/lxONMbdHoSndj4lw/rcwiJFPAvYU00=";
  };
  patches = [ ./ar.patch ];
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
