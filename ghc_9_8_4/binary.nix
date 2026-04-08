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
  version = "9.8.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb12-linux.tar.xz";
    hash = "sha256-tQVFtUk0BopWkiXj3eJnqLWqtmRJMw1j4CqM8olyN14=";
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
