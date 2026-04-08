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
  version = "8.10.7";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-4+72IpzpkI3+HqQUNr77BFX++xkyVZ6GCtTGBrDQPJ0=";
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
