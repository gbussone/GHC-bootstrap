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
  version = "7.8.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-unknown-linux-deb7.tar.xz";
    hash = "sha256-9i4A6TpawW6/6XzXy4zebG8xVgc9SRhiBUK+PgrVX40=";
  };
  nativeBuildInputs = [
    perl
    gcc
  ];
  postPatch = ''
    patchShebangs --build utils/ghc-pwd/dist-install/build/tmp/ghc-pwd-bindist
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/ghc-pwd/dist-install/build/tmp/ghc-pwd
    patchShebangs --build utils/ghc-cabal/dist-install/build/tmp/ghc-cabal-bindist
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/ghc-cabal/dist-install/build/tmp/ghc-cabal
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses5
      ]
    } utils/ghc-pkg/dist-install/build/tmp/ghc-pkg
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses5
      ]
    } ghc/stage2/build/tmp/ghc-stage2
    patchelf --set-interpreter ${binutils.dynamicLinker} utils/unlit/dist/build/tmp/unlit
  '';
  dontBuild = true;
  dontStrip = true;
})
