{
  lib,
  stdenv,
  fetchurl,
  perl,
  binutils,
  ncurses5,
  readline,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "6.0.1";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-i386-unknown-linux.tar.bz2";
    hash = "sha256-9xoD3zN+j8Kgv3AWr/4TopfKLIepJ6m5edhIBh9OYAY=";
  };
  nativeBuildInputs = [ perl ];
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        ncurses5
        readline
      ]
    } lib/i386-unknown-linux/ghc-${finalAttrs.version}
    patchelf --set-interpreter ${binutils.dynamicLinker} lib/i386-unknown-linux/unlit
  '';
  dontBuild = true;
})
