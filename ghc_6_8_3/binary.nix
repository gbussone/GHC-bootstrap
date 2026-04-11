{
  lib,
  buildFHSEnv,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  binutils,
  gmp,
  ncurses5,
  readline,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "6.8.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-unknown-linux.tar.bz2";
    hash = "sha256-B9Bu+pIiY4yAtyztqVfTx7y9wmZalzjdbvbAdRoF6O0=";
  };
  nativeBuildInputs = [
    perl
    gcc
  ];
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/pwd/pwd
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/ghc-pkg/ghc-pkg.bin
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } libraries/ifBuildable/ifBuildable
    ln -sf ${
      let
        installPackage = stdenvNoCC.mkDerivation {
          pname = "installPackage-binary";
          version = finalAttrs.version;
          src = finalAttrs.src;
          postPatch = ''
            patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
              lib.strings.makeLibraryPath [ gmp ]
            } libraries/installPackage/installPackage
          '';
          dontConfigure = true;
          dontBuild = true;
          installPhase = ''
            runHook preInstall

            mkdir -p $out/bin
            cp libraries/installPackage/installPackage $out/bin/installPackage

            runHook postInstall
          '';
        };
      in
      buildFHSEnv {
        pname = installPackage.pname;
        version = installPackage.version;
        executableName = "installPackage";
        targetPkgs = _: [
          installPackage
          gcc
        ];
        runScript = "installPackage";
      }
    }/bin/installPackage libraries/installPackage/installPackage
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses5
        readline
      ]
    } compiler/stage3/ghc-${finalAttrs.version}
    patchelf --set-interpreter ${binutils.dynamicLinker} utils/unlit/unlit
  '';
  dontBuild = true;
  dontStrip = true;
})
