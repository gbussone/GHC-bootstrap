{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  binutils,
  gmp,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "4.04";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-i386-unknown-linux-glibc2.1.tar.gz";
    hash = "sha256-VmQ5bQKqS1LHsdgTJUUX0unVQmJarOmKnFaXgILY1e4=";
  };
  nativeBuildInputs = [
    perl
    gcc
  ];
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } lib/i386-unknown-linux/ghc-${finalAttrs.version}/hsc
    patchelf --set-interpreter ${binutils.dynamicLinker} lib/i386-unknown-linux/ghc-${finalAttrs.version}/unlit
  '';
  dontBuild = true;
})
