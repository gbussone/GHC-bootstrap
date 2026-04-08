{
  lib,
  stdenv,
  fetchurl,
  binutils,
  gmp,
  ncurses,
  numactl,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "9.0.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb10-linux.tar.xz";
    hash = "sha256-XQuUFLEM+5GEU7zQHF6noYJP6VlIsISY1ngPILokevw=";
  };
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        numactl
      ]
    } utils/ghc-cabal/dist-install/build/tmp/ghc-cabal
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses
        numactl
      ]
    } utils/ghc-pkg/dist-install/build/tmp/ghc-pkg
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses
        numactl
      ]
    } ghc/stage2/build/tmp/ghc-stage2
  '';
  dontBuild = true;
  dontStrip = true;
})
