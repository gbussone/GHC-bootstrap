{
  stdenvNoCC,
  fetchurl,
  perl,
  gnumake42,
  gcc,
  ghc,
  gmp,
  ncurses,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "7.2.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-/2pxgHrRsPlEhRBjm1DTNdz/HDbFzY9VtK0ckf5oBz0=";
  };
  nativeBuildInputs = [
    perl
    gnumake42
    gcc
    ghc
  ];
  buildInputs = [
    gmp.dev
    ncurses.dev
  ];
  enableParallelBuilding = true;
})
