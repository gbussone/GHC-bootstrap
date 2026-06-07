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
  pname = "ghc";
  version = "4.02";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.gz";
    hash = "sha256-KeNUkV5ecjlmzyNm/hsWRoaS3G1oSl9wel8xmoHN/ZU=";
  };
  patches = [
    ./hsparser.patch
  ]
  ++ lib.lists.optionals bootstrap [
    ./abscstixgen.patch
    ./cgbindery.patch
    ./cgmonad.patch
    ./cmdlineopts.patch
    ./confold.patch
    ./const.patch
    ./coreunfold.patch
    ./dsforeign.patch
    ./simplstg.patch
    ./stixinfo.patch
  ];
  nativeBuildInputs = [
    perl
    gcc
    flex
    bison
    happy
    ghc
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  preBuild = ''
    make boot
  '';
  env.fptools_cv_gnu_cpp = "${gcc.gcc}/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/cpp0";
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
  env.NIX_GCC_NEEDS_GREP = true;
})
