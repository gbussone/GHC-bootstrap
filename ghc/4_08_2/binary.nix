{
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  binutils,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "4.08.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-i386-unknown-linux.tar.bz2";
    hash = "sha256-UHk3WiQwpYQQ6zKl0998oc5sp6t8czuUxYoHZMFUrwA=";
  };
  nativeBuildInputs = [
    perl
    gcc
  ];
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} lib/i386-unknown-linux/hsc
    patchelf --set-interpreter ${binutils.dynamicLinker} lib/i386-unknown-linux/unlit
  '';
  dontBuild = true;
})
