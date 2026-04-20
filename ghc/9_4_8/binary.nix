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
  version = "9.4.8";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-deb11-linux.tar.xz";
    hash = "sha256-J0NinQQPMhNJkUbLUVRiHW8l6FJxAZr8m5AJ4E1mv2w=";
  };
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses
      ]
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
