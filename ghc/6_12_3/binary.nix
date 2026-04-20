{
  lib,
  symlinkJoin,
  buildFHSEnv,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  binutils,
  gmp,
  ncurses5,
}:

let
  ghc = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "ghc-binary";
    version = "6.12.3";
    src = fetchurl {
      url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-unknown-linux-n.tar.bz2";
      hash = "sha256-8OE73sBA8GsQdFld3DkGT3UhSu4F1kVU9ICdyj4TgAE=";
    };
    nativeBuildInputs = [
      perl
      gcc
    ];
    postPatch = ''
      patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
        lib.strings.makeLibraryPath [ gmp ]
      } utils/ghc-pwd/ghc-pwd
      patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
        lib.strings.makeLibraryPath [
          gmp
          ncurses5
        ]
      } utils/ghc-pkg/dist-install/build/tmp/ghc-pkg
      patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
        lib.strings.makeLibraryPath [ gmp ]
      } inplace/bin/ghc-cabal
      patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
        lib.strings.makeLibraryPath [
          gmp
          ncurses5
        ]
      } ghc/stage2/build/tmp/ghc-stage2
      patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
        lib.strings.makeLibraryPath [ gmp ]
      } utils/unlit/dist/build/tmp/unlit
    '';
    dontBuild = true;
    dontStrip = true;
  });
in
symlinkJoin {
  pname = ghc.pname;
  version = ghc.version;
  paths = [
    (buildFHSEnv {
      pname = ghc.pname;
      version = ghc.version;
      executableName = "ghc";
      targetPkgs = _: [
        ghc
        gcc
      ];
      runScript = "ghc";
    })
    ghc
  ];
}
