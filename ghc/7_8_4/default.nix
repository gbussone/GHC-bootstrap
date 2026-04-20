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
  version = "7.8.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-wxnNlK2yhBd+0ObSFUbtC5AK2EuGuHwGqZ6sNRUpgsQ=";
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
