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
  version = "9.10.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb12-linux.tar.xz";
    hash = "sha256-GsY/BOrArVUdRcveOPJ+Dj9Dzu/ZiDP64fo/Lb0EI2c=";
  };
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } bin/ghc-pkg
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses
      ]
    } bin/ghc
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } bin/hsc2hs
  '';
  dontBuild = true;
  dontStrip = true;
})
