{
  src,
  system,
  applyPatches,
  fetchurl,
}:

(import (applyPatches {
  name = "nixpkgs";
  src = src;
  patches = [ ./perl_5_8.patch ];
  prePatch = ''
    cp ${
      fetchurl {
        url = "http://bugs.gentoo.org/attachment.cgi?id=111427";
        sha256 = "017pj0nbqb7kwj3cs727c2l2d8c45l9cwxf71slgb807kn3ppgmn";
      }
    } pkgs/development/interpreters/perl/5.8/111427.patch
  '';
}) { system = system; }).pkgs
