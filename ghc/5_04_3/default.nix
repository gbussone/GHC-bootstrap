{
  lib,
  stdenvNoCC,
  fetchurl,
  fetchpatch,
  perl,
  gcc,
  flex,
  ghc,
  ncurses,
  readline,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "5.04.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-xmJYk4PUn9TBKPE3ibKaf321Xp0UYDJRm/sceW2PcVM=";
  };
  patches = [
    ./mangler.patch
    (fetchpatch {
      url = "https://gitlab.haskell.org/ghc/ghc/-/commit/5ecfa1f1d48111f5c95ec2fdae895fa24f8e321a.patch";
      hash = "sha256-4jfkh254fQuvJmjOPQvTba61kcxgjEs9e4xS2zZqPVU=";
    })
    ./clockticks.patch
    ./syntax.patch
    ./ucred.patch
  ];
  nativeBuildInputs = [
    perl
    gcc
    flex
    ghc
  ];
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [
    ncurses
    readline
  ];
})
