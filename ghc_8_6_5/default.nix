{
  stdenvNoCC,
  fetchurl,
  gcc,
  ghc,
  gmp,
  ncurses,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "8.6.5";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-TUqh6W9AAbk0rGGTqwmvXWFy9B9aXTnY5DOTuar+42E=";
  };
  nativeBuildInputs = [
    gcc
    ghc
  ];
  buildInputs = [
    gmp.dev
    ncurses.dev
  ];
  enableParallelBuilding = true;
})
