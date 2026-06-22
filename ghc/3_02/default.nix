{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  happy,
  ghc,
  bootstrap ? false,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc${lib.strings.optionalString bootstrap "-hc"}";
  version = "3.02";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.gz";
    hash = "sha256-1KEMwg4gn2z2O3RMXkcGZm+JtxAnCMIGBFoEK0sfSrI=";
  };
  postUnpack = lib.strings.optionalString bootstrap ''
    tar xf ${
      fetchurl {
        url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-hc.tar.gz";
        hash = "sha256-YuZkUhmBhg3fhJRG+MAl3irG54Eh4wQkRMQCeN27IEk=";
      }
    } -C fptools
  '';
  patches =
    lib.lists.optional (!bootstrap) ./compiler.patch
    ++ lib.lists.optional (!bootstrap) ./config.patch
    ++ lib.lists.optional bootstrap ./config_hc.patch
    ++ [
      ./lib.patch
      ./signals.patch
    ];
  nativeBuildInputs = [
    perl
    gcc
    happy
  ]
  ++ lib.lists.optional (!bootstrap) ghc;
  configureFlags = lib.lists.optional bootstrap (lib.strings.enableFeature true "hc-boot");
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  preBuild = ''
    make boot
  '';
  postBuild = lib.strings.optionalString bootstrap ''
    ./configure --prefix=$out
    make -C ghc/lib clean
    make -C ghc/lib boot
    make -C ghc/lib
  '';
  env.ac_cv_gnu_cpp = "${gcc.gcc}/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/cpp0";
  env.NIX_GCC_NEEDS_GREP = true;
})
