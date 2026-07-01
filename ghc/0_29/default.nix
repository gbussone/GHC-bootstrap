{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  flex,
  ghc,
  bootstrap ? false,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc${lib.strings.optionalString bootstrap "-hc"}";
  version = "0.29";
  srcs = [
    (fetchurl {
      url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.gz";
      hash = "sha256-P2kPQucY7npa0wxaMWJFcTs5g4qGUbQA7kWMVq7bCX8=";
    })
  ]
  ++ lib.lists.optional bootstrap (fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-hc-files.tar.gz";
    hash = "sha256-8t0ek8rbV3QXQvNgwqGcIaNM8I1vJXgC6Nc7bJn7mVE=";
  });
  patches = [
    ./hscpp.patch
    ./jmake.patch
  ]
  ++ lib.lists.optional (!bootstrap) ./lib.patch
  ++ lib.lists.optional (!bootstrap) ./libtime.patch
  ++ lib.lists.optional (!bootstrap) ./mkdependhs.patch
  ++ [
    ./mprotect.patch
    ./parallel.patch
    ./signals.patch
    ./tolocaltime.patch
    ./toutctime.patch
  ];
  prePatch =
    lib.strings.optionalString (!bootstrap) ''
      cd ghc/utils/ugen
      flex -o lex.c lex.l
      cd ../../..
    ''
    + ''
      rm glafp-utils/verbatim/verbatim.c
    '';
  nativeBuildInputs = [
    perl
    gcc
    flex
  ]
  ++ lib.lists.optional (!bootstrap) ghc;
  configureFlags = [
    (lib.strings.withFeatureAs true "hc" (if bootstrap then "c" else "ghc"))
    (lib.strings.enableFeature bootstrap "native-code-generator")
    (lib.strings.enableFeature bootstrap "profiling")
    (lib.strings.withFeatureAs (!bootstrap) "max-heap" "1000m")
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=-DYY_SKIP_YYWRAP
  '';
  enableParallelBuilding = true;
  makeFlags = [
    "-C"
    "ghc"
  ];
  preBuild = ''
    sh < STARTUP
  '';
  env.JMAKECPP = "${gcc.gcc}/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/cpp0";
  env.NIX_GCC_NEEDS_GREP = true;
})
