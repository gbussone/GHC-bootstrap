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
  version = "7.0.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-Gpt42dZsnCHebAky42u4dAakhW8WEb+DvURTm9xu0O0=";
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
