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
  version = "8.8.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb9-linux.tar.xz";
    hash = "sha256-SGJVnSIRU8r5ePS/LBWoLBFNHh9Dspiy7P8qyUtYbSA=";
  };
  nativeBuildInputs = [ perl ];
  postPatch = ''
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
