{
  stdenvNoCC,
  fetchurl,
  fetchpatch,
  perl,
  gcc,
  ghc,
  gmp,
  ncurses,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "6.12.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-bL2+QVAR8sfRXk2FB1jY05P3Bhe4jLMjfSxgK7YOXmg=";
  };
  patches = [
    (fetchpatch {
      url = "https://gitlab.haskell.org/ghc/ghc/-/commit/51b85031ce99f1e9d4c72249d6d85672188f0fbd.patch";
      excludes = [
        "rts/Messages.h"
        "rts/sm/MarkStack.h"
        "rts/sm/Sanity.h"
      ];
      hash = "sha256-WsRV5CAGt5kNiGlUwiC2Rrll6pltfJhuYM6yOREJQQ8=";
    })
    ./rts_private.patch
  ];
  nativeBuildInputs = [
    perl
    gcc
    ghc
  ];
  buildInputs = [
    gmp.dev
    ncurses.dev
  ];
})
