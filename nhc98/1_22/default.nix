{
  lib,
  stdenvNoCC,
  fetchurl,
  gcc,
  nhc98,
  bootstrap ? false,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "nhc98${lib.strings.optionalString bootstrap "-hc"}";
  version = "1.22";
  src = fetchurl {
    url = "https://www.haskell.org/nhc98/nhc98src-${finalAttrs.version}.tar.gz";
    hash = "sha256-FMXBbDNtC7Febj0bqtiivKk8BTihKfsY3x1H0fTrbzo=";
  };
  nativeBuildInputs = [ gcc ] ++ lib.lists.optional (!bootstrap) nhc98;
  configureFlags = lib.lists.optional (!bootstrap) "--buildwith=nhc98";
})
