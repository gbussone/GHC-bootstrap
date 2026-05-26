{
  lib,
  writeShellScriptBin,
  stdenvNoCC,
  fetchurl,
  fetchFromGitHub,
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
  nativeBuildInputs = [
    perl
    gcc
    (stdenvNoCC.mkDerivation {
      pname = "happy";
      version = "unstable";
      src = finalAttrs.src;
      postUnpack = ''
        cp -r ${
          fetchFromGitHub {
            owner = "haskell";
            repo = "happy";
            rev = "6a2f905bf11d66b0be6390a0914b8ae5f1f934ee";
            hash = "sha256-MA9iA6fLFAw1T5oWZ1R9NYR3d/CP31Co33MlaeFvn2A=";
          }
        } fptools/happy
        chmod -R u+w fptools/happy
      '';
      sourceRoot = "fptools/happy";
      dontMakeSourcesWritable = true;
      nativeBuildInputs = [
        perl
        gcc
        (stdenvNoCC.mkDerivation {
          pname = "happy";
          version = "unstable";
          src = finalAttrs.src;
          postUnpack = ''
            cp -r ${
              fetchFromGitHub {
                owner = "haskell";
                repo = "happy";
                rev = "6a2f905bf11d66b0be6390a0914b8ae5f1f934ee";
                hash = "sha256-MA9iA6fLFAw1T5oWZ1R9NYR3d/CP31Co33MlaeFvn2A=";
              }
            } fptools/happy
            chmod -R u+w fptools/happy
          '';
          sourceRoot = "fptools/happy";
          dontMakeSourcesWritable = true;
          prePatch = ''
            rm src/Parser.ly
          '';
          nativeBuildInputs = [
            perl
            gcc
            (writeShellScriptBin "happy" ''
              echo "Happy Version 1.6"
            '')
            ghc
          ];
          preConfigure = ''
            export NIX_CFLAGS_COMPILE=
            cd ..
          '';
          postConfigure = ''
            cd happy
          '';
          preBuild = ''
            ln -s ${ghc}/bin/ghc ../ghc/driver/ghc
          '';
          postBuild = ''
            rm ../ghc/driver/ghc
          '';
          preInstall = ''
            make -C .. glafp-utils
          '';
          env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
        })
        ghc
      ];
      preConfigure = ''
        export NIX_CFLAGS_COMPILE=
        cd ..
      '';
      postConfigure = ''
        cd happy
      '';
      preBuild = ''
        ln -s ${ghc}/bin/ghc ../ghc/driver/ghc
      '';
      postBuild = ''
        rm ../ghc/driver/ghc
      '';
      preInstall = ''
        make -C .. glafp-utils
      '';
      env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
    })
    ghc
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  enableParallelBuilding = true;
  preBuild = ''
    make boot
  '';
  env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
  env.NIX_GCC_NEEDS_GREP = true;
})
