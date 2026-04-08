{
  stdenvNoCC,
  fetchurl,
  gcc,
  ghc,
  gmp,
  ncurses,
  numactl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "9.0.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-FA5CuWNGMi0aOesXYCvNx24pICitSmkoayMLqxiKkZc=";
  };
  nativeBuildInputs = [
    gcc
    ghc
  ];
  buildInputs = [
    gmp.dev
    ncurses.dev
    numactl.dev
  ];
  enableParallelBuilding = true;
  env.LC_ALL = "C.UTF-8";
})
