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
  version = "9.6.7";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-0FO/bOHViKdc/oyTFiaUhunY+4nc32/ZKDb6Lj32EwU=";
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
          assert ghc.version == "9.6.7";
          ''
            cp ${./plan-bootstrap-9_6_7.json} hadrian/bootstrap/plan-bootstrap-9_6_7.json
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
        outputHash = "sha256-ixhhlOV0886GRAmdgamHchv/TooPr5UGDMEJ10dTcgA=";
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
  env.LC_ALL = "C.UTF-8";
})
