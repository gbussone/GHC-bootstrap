{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  flex,
  bison,
  happy,
  ghc,
  gmp,
  bootstrap ? false,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc${lib.strings.optionalString bootstrap "-hc"}";
  version = "4.02";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.gz";
    hash = "sha256-KeNUkV5ecjlmzyNm/hsWRoaS3G1oSl9wel8xmoHN/ZU=";
  };
  postUnpack = lib.strings.optionalString bootstrap ''
    tar xf ${
      fetchurl {
        url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86-hc.tar.gz";
        hash = "sha256-MhG9i50O8cCKCh9kxRLptE08VoF6KC8e9h7EIdWnMLU=";
      }
    } -C fptools
  '';
  patches = [ ./hsparser.patch ];
  nativeBuildInputs = [
    perl
    gcc
    flex
    bison
    happy
  ]
  ++ lib.lists.optional (!bootstrap) ghc;
  configureFlags = lib.lists.optional bootstrap (lib.strings.enableFeature true "hc-boot");
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  preBuild = lib.strings.optionalString (!bootstrap) ''
    make boot
  '';
  postBuild = lib.strings.optionalString bootstrap ''
    ./configure
    make -C ghc/lib clean
    make -C ghc/lib boot
    make -C ghc/lib
    ./configure --prefix=$out ${lib.strings.enableFeature true "hc-boot"}
  '';
  env.fptools_cv_gnu_cpp = "${gcc.gcc}/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/cpp0";
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
  env.NIX_GCC_NEEDS_GREP = true;
})
