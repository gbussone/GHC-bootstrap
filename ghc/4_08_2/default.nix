{
  stdenvNoCC,
  fetchurl,
  fetchFromGitHub,
  perl,
  gcc,
  ghc,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "4.08.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-ONw+HviIATOD0gWomR4dFvRNTmD1hSPd5rtkRny3JCs=";
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
            rev = "9ba23c6499b396edc5d3420dedecaa04a0c7f76c";
            hash = "sha256-Bs8kB99G+xe1WUy95BVvbDBjGvmpvfwpkXKaJfFE7do=";
          }
        } ghc-${finalAttrs.version}/happy
        chmod -R u+w ghc-${finalAttrs.version}/happy
      '';
      sourceRoot = "ghc-${finalAttrs.version}/happy";
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
                rev = "9ba23c6499b396edc5d3420dedecaa04a0c7f76c";
                hash = "sha256-Bs8kB99G+xe1WUy95BVvbDBjGvmpvfwpkXKaJfFE7do=";
              }
            } ghc-${finalAttrs.version}/happy
            chmod -R u+w ghc-${finalAttrs.version}/happy
          '';
          sourceRoot = "ghc-${finalAttrs.version}/happy";
          dontMakeSourcesWritable = true;
          prePatch = ''
            rm src/Parser.ly
          '';
          nativeBuildInputs = [
            perl
            gcc
            ghc
          ];
          preConfigure = ''
            export NIX_CFLAGS_COMPILE=
            cd ..
          '';
          postConfigure = ''
            cd happy
          '';
          preInstall = ''
            make -C .. glafp-utils
          '';
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
      preInstall = ''
        make -C .. glafp-utils
      '';
    })
    ghc
  ];
  preConfigure = ''
    export NIX_CFLAGS_COMPILE=
  '';
  preBuild = ''
    make boot
  '';
  env.NIX_GCC_NEEDS_GREP = true;
})
