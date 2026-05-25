{
  lib,
  stdenvNoCC,
  fetchurl,
  fetchFromGitHub,
  bash,
  perl,
  gcc,
  ghc,
  gmp,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "4.04";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.gz";
    hash = "sha256-ZKTnMyu0j7l8u81TSXMyhpxqQczO2Br1tSXNDAyB01Y=";
  };
  prePatch = ''
    cp -r ${
      fetchFromGitHub {
        owner = "haskell";
        repo = "happy";
        rev = "6a2f905bf11d66b0be6390a0914b8ae5f1f934ee";
        hash = "sha256-MA9iA6fLFAw1T5oWZ1R9NYR3d/CP31Co33MlaeFvn2A=";
      }
    } happy
    chmod -R u+w happy
    rm happy/src/Parser.ly
  '';
  nativeBuildInputs = [
    perl
    gcc
    ghc
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
    cat > happy/src/happy <<EOF
    #!${bash}/bin/bash
    echo 'Happy Version 1.6'
    EOF
    chmod a+x happy/src/happy
  '';
  postConfigure = ''
    rm happy/src/happy
  '';
  enableParallelBuilding = true;
  preBuild = ''
    ln -s ${ghc}/bin/ghc ghc/driver/ghc
    cd happy
    make
    cd ..
    rm ghc/driver/ghc
    mv happy/src/happy-inplace happy/src/happy
    make boot
  '';
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
  env.NIX_GCC_NEEDS_GREP = true;
})
