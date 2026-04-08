{
  lib,
  stdenv,
  fetchurl,
  binutils,
  gmp,
  ncurses,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "9.2.8";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb10-linux.tar.xz";
    hash = "sha256-ENG+JUh7z5msjrd76qIgyF5p+MEQb0IZzgGSBuzArFE=";
  };
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/ghc-cabal/dist-install/build/tmp/ghc-cabal
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses
      ]
    } utils/ghc-pkg/dist-install/build/tmp/ghc-pkg
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses
      ]
    } ghc/stage2/build/tmp/ghc-stage2
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/hsc2hs/dist-install/build/tmp/hsc2hs
  '';
  dontBuild = true;
  dontStrip = true;
})
