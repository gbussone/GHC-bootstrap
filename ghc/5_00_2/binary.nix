{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  binutils,
  ncurses,
  readline,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "5.00.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-i386-unknown-linux.tar.bz2";
    hash = "sha256-BafPnKg6/9svMxJi/a+1S/VBA7Y4Ilgk6RSZt7qMNlk=";
  };
  nativeBuildInputs = [
    perl
    gcc
  ];
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        ncurses
        readline
      ]
    } lib/i386-unknown-linux/ghc-${finalAttrs.version}
    patchelf --set-interpreter ${binutils.dynamicLinker} bin/i386-unknown-linux/pkgconf
    patchelf --set-interpreter ${binutils.dynamicLinker} lib/i386-unknown-linux/unlit
  '';
  dontBuild = true;
})
