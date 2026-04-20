{
  stdenvNoCC,
  fetchurl,
  autoconf,
  automake,
  python3,
  gcc,
  ghc,
  alex,
  happy,
  gmp,
  ncurses,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "9.2.8";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.xz";
    hash = "sha256-XxPReGv0/RL0tF+qN6vttbs/NtXlj32lMH6L/oilZ6E=";
  };
  nativeBuildInputs = [
    autoconf
    automake
    python3
    gcc
    ghc
    alex
    happy
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
          assert ghc.version == "9.2.8";
          ''
            cp ${./plan-bootstrap-9_2_8.json} hadrian/bootstrap/plan-bootstrap-9_2_8.json
          '';
        nativeBuildInputs = [
          python3
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
        outputHash = "sha256-ZIxQ8KeOVfZ0COijO78Sodi0XWFpzKXIVWNNMr/Z/Os=";
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
