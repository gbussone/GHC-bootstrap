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
  version = "6.4.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-1RflLgIEoHfFTNoRtnv5tqw9qkese8zxVhr8fFcua+A=";
  };
  nativeBuildInputs = [
    perl
    gcc
    ghc
  ];
  buildInputs = [ gmp.dev ];
  hardeningDisable = [ "all" ];
  preConfigure = ''
    export HOME=$(mktemp -d)
  '';
  enableParallelBuilding = true;
  env.NIX_CFLAGS_COMPILE = "-std=gnu89";
})
