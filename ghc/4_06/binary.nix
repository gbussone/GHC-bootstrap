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
  version = "4.06";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-i386-unknown-linux.tar.gz";
    hash = "sha256-sYXWP//94OuQyowRlvM/zyLcoYAsuAe9juENIMqGksc=";
  };
  nativeBuildInputs = [
    perl
    gcc
  ];
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } lib/i386-unknown-linux/hsc
    patchelf --set-interpreter ${binutils.dynamicLinker} lib/i386-unknown-linux/unlit
  '';
  dontBuild = true;
})
