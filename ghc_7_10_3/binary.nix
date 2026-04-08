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
  version = "7.10.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb8-linux.tar.xz";
    hash = "sha256-tHjigq+/SJYU0BM+9pi6ROkB7rF5T0RTwPsIB80nG5Y=";
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
  '';
  dontBuild = true;
  dontStrip = true;
})
