{
  lib,
  stdenv,
  fetchurl,
  perl,
  binutils,
  gmp,
  ncurses5,
  numactl,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "8.4.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb9-linux.tar.xz";
    hash = "sha256-R8gKMtjwKDiiQBQUyUuiYNH+grfQkEeZlFIiQsdnzIM=";
  };
  nativeBuildInputs = [ perl ];
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
        ncurses5
        numactl
      ]
    } utils/ghc-pkg/dist-install/build/tmp/ghc-pkg
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses5
        numactl
      ]
    } ghc/stage2/build/tmp/ghc-stage2
  '';
  dontBuild = true;
  dontStrip = true;
})
