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
  version = "9.6.7";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb11-linux.tar.xz";
    hash = "sha256-/GpiR9GDF0XGeyfWIS9pEcNakzBD87aFFyTi4BSE0Hc=";
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
