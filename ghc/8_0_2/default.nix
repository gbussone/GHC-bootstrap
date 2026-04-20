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
  version = "8.0.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-EWJUU+HQaGs/pnOZiPcOysg2ytwwufDItJ75CR1hGLE=";
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
