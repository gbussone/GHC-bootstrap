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
  version = "6.2.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-i386-unknown-linux.tar.bz2";
    hash = "sha256-wyQkngWLkOE4q2UE5Xvq0/TYQuQudlY9dVdSoSPx324=";
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
