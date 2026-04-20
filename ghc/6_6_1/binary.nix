{
  lib,
  stdenv,
  fetchurl,
  perl,
  binutils,
  gmp,
  ncurses5,
  readline,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "6.6.1";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-unknown-linux.tar.bz2";
    hash = "sha256-FXRvVIZbdyDbExsPpfxPKluEB0R7lG1aFLyeVXqgejM=";
  };
  nativeBuildInputs = [ perl ];
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses5
        readline
      ]
    } lib/x86_64-unknown-linux/ghc-${finalAttrs.version}
    patchelf --set-interpreter ${binutils.dynamicLinker} lib/x86_64-unknown-linux/unlit
  '';
  dontBuild = true;
  dontStrip = true;
})
