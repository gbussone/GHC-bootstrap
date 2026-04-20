{
  lib,
  stdenv,
  fetchurl,
  perl,
  binutils,
  gmp,
  ncurses5,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "8.0.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb8-linux.tar.xz";
    hash = "sha256-XuaCkNsAygt51XvDpb3ORw3pzp2gsJinzmxQRgWFbI8=";
  };
  nativeBuildInputs = [ perl ];
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
  '';
  dontBuild = true;
  dontStrip = true;
})
