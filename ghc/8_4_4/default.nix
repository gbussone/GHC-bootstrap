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
  version = "8.4.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-ERF3NaWOUHxIHAnz85rloxTp+/SfwxCVKPmep5WQBLI=";
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
  hardeningDisable = [ "format" ];
  enableParallelBuilding = true;
})
