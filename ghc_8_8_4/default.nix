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
  version = "8.8.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-8FBeOLIjX/nxCQtR9E1sjv03EGjlprtCoqbYtntf/C0=";
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
