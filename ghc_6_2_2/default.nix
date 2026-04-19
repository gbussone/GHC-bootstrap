{
  stdenvNoCC,
  fetchurl,
  perl,
  m4,
  gcc,
  ghc,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghc";
  version = "6.2.2";
  src = fetchurl {
    url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.bz2";
    hash = "sha256-oP5+uNRH8l+8YWzbziu04DlhqITCw3lp0eI1iLWIqFI=";
  };
  patches = [ ./ucred.patch ];
  nativeBuildInputs = [
    perl
    m4
    gcc
    ghc
  ];
})
