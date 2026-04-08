{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  binutils,
  gmp,
  ncurses5,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "7.6.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-unknown-linux.tar.bz2";
    hash = "sha256-OY3V+m7UecB1759jjvT8LMD7+ZThtZtU13wmqOHnPKA=";
  };
  nativeBuildInputs = [
    perl
    gcc
  ];
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/ghc-pwd/dist-install/build/tmp/ghc-pwd
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses5
      ]
    } ghc/stage2/build/tmp/ghc-stage2
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses5
      ]
    } utils/ghc-pkg/dist-install/build/tmp/ghc-pkg
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/ghc-cabal/dist-install/build/tmp/ghc-cabal
    patchelf --set-interpreter ${binutils.dynamicLinker} utils/unlit/dist/build/tmp/unlit
  '';
  dontBuild = true;
  dontStrip = true;
})
