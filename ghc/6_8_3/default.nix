{
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  ghc,
  gmp,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "6.8.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-H8H/gqVVUy8cnS3GKP2d5ebrqyzm7pSQo0F0zrb3bms=";
  };
  nativeBuildInputs = [
    perl
    gcc
    ghc
  ];
  buildInputs = [ gmp.dev ];
  hardeningDisable = [ "format" ];
  enableParallelBuilding = true;
  env.NIX_CFLAGS_COMPILE = "-std=gnu89";
})
