{
  stdenvNoCC,
  stdenv,
  fetchurl,
  autoconf,
  automake,
  python3,
  cacert,
  ghc,
  gmp,
  ncurses,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "9.10.3";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-0maGS54Le3QavoydankNfAHCHPQ6FBmDkRklWHjrxZo=";
  };
  nativeBuildInputs = [
    autoconf
    automake
    python3
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
          assert ghc.version == "9.10.3";
          ''
            cp ${./plan-bootstrap-9_10_3.json} hadrian/bootstrap/plan-bootstrap-9_10_3.json
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
        outputHash = "sha256-Oz97e7ijfOSOQ/l0h8XrGNgPjopd+hqJQ4RSlO/+puU=";
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
