{
  lib,
  buildFHSEnv,
  writeShellScriptBin,
  stdenvNoCC,
  stdenv,
  fetchurl,
  perl,
  binutils,
  gmp,
  ncurses5,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ghc-binary";
  version = "6.10.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86_64-unknown-linux-n.tar.bz2";
    hash = "sha256-tuhpYC3D7tJbkmYxw/iMrHALjNmSe+UCpx8CprfgzGg=";
  };
  nativeBuildInputs = [ perl ];
  postPatch = ''
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/pwd/pwd
    ln -sf ${
      let
        installPackage = stdenvNoCC.mkDerivation {
          pname = "installPackage-binary";
          version = finalAttrs.version;
          src = finalAttrs.src;
          postPatch = ''
            patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
              lib.strings.makeLibraryPath [ gmp ]
            } utils/installPackage/install-inplace/bin/installPackage
          '';
          dontConfigure = true;
          dontBuild = true;
          installPhase = ''
            runHook preInstall

            mkdir -p $out/bin
            cp utils/installPackage/install-inplace/bin/installPackage $out/bin/installPackage

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
          (writeShellScriptBin "ranlib" ''
            exit 0
          '')
          (writeShellScriptBin "strip" ''
            exit 0
          '')
        ];
        runScript = "installPackage";
      }
    }/bin/installPackage utils/installPackage/install-inplace/bin/installPackage
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/ghc-pkg/dist-install/build/ghc-pkg/ghc-pkg
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } libraries/ifBuildable/ifBuildable
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [
        gmp
        ncurses5
      ]
    } ghc/dist-stage2/build/ghc/ghc
    patchelf --set-interpreter ${binutils.dynamicLinker} --add-rpath ${
      lib.strings.makeLibraryPath [ gmp ]
    } utils/hsc2hs/dist-install/build/hsc2hs/hsc2hs
    patchelf --set-interpreter ${binutils.dynamicLinker} utils/unlit/unlit
  '';
  dontBuild = true;
  dontStrip = true;
})
