{
  stdenvNoCC,
  fetchurl,
  autoconf,
  automake,
  python3,
  cacert,
  gcc,
  ghc,
  gmp,
  ncurses,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "9.8.4";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-F+gYjzyKXC9z+0410BAy6NwliDXsh21SyK2O49JLL8U=";
  };
  nativeBuildInputs = [
    autoconf
    automake
    python3
    gcc
    ghc
  ];
  buildInputs = [
    gmp.dev
    ncurses.dev
  ];
  postPatch = ''
    patchShebangs --build hadrian/bootstrap/bootstrap.py
  '';
  preBuild = ''
    tar czf bootstrap-sources.tar.gz -C ${
      stdenvNoCC.mkDerivation {
        pname = "bootstrap-sources";
        version = finalAttrs.version;
        src = finalAttrs.src;
        prePatch =
          assert ghc.version == "9.8.4";
          ''
            cp ${./plan-bootstrap-9_8_4.json} hadrian/bootstrap/plan-bootstrap-9_8_4.json
          '';
        nativeBuildInputs = [
          python3
          cacert
          ghc
        ];
        postPatch = ''
          patchShebangs --build hadrian/bootstrap/bootstrap.py
        '';
        dontConfigure = true;
        buildPhase = ''
          runHook preBuild

          hadrian/bootstrap/bootstrap.py fetch

          runHook postBuild
        '';
        installPhase = ''
          runHook preInstall

          mkdir $out
          tar xf bootstrap-sources.tar.gz -C $out

          runHook postInstall
        '';
        outputHash = "sha256-j/gRS8j/FKR3eFmOH3UVY1Kiss/CXbankHMBSEYDD0I=";
        outputHashMode = "recursive";
      }
    } .
    hadrian/bootstrap/bootstrap.py -s bootstrap-sources.tar.gz
  '';
  buildPhase = ''
    runHook preBuild

    _build/bin/hadrian -j

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    _build/bin/hadrian -j install --docs=none --prefix=$out

    runHook postInstall
  '';
})
