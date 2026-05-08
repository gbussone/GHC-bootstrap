{
  src,
  system,
  applyPatches,
  fetchurl,
}:

import (applyPatches {
  name = "nixpkgs";
  src = src;
  patches = [
    ./attr_2_4_43.patch
    ./binutils_2_19_1.patch
    ./bootstrap_tools.patch
    ./glibc_2_9.patch
    ./lzma_4_32_7.patch
    ./mpfr_2_4_1.patch
  ];
  prePatch = ''
    cp ${
      fetchurl {
        url = "mirror://gentoo/distfiles/attr_2.4.43-1.tar.gz";
        sha256 = "1gy5zspj8ynxv6q29r24d18cfvq06zirg1pxcdg27bg2ncrv4n6k";
      }
    } pkgs/development/libraries/attr/attr_2.4.43-1.tar.gz
    cp ${
      fetchurl {
        url = "http://nixos.org/tarballs/stdenv-linux/i686/r16022/bootstrap-tools.cpio.bz2";
        sha256 = "1x014icv3dxfs55qzshxjs9gaczmhwlrn144p4314zvl4xz6wq3f";
      }
    } pkgs/stdenv/linux/bootstrap/i686/bootstrap-tools.cpio.bz2
    cp ${
      fetchurl {
        url = "http://nixos.org/tarballs/glibc-2.9-20081208.tar.bz2";
        sha256 = "0zhxbgcsl97pf349m0lz8d5ljvvzrcqc23yf08d888xlk4ms8m3h";
      }
    } pkgs/development/libraries/glibc-2.9/glibc-2.9-20081208.tar.bz2
    cp ${
      fetchurl {
        url = "mirror://gentoo/distfiles/lzma-4.32.7.tar.gz";
        sha256 = "0b03bdvm388kwlcz97aflpr3ir1zpa3m0bq3s6cd3pp5a667lcwz";
      }
    } pkgs/tools/compression/lzma/lzma-4.32.7.tar.gz
    cp ${
      fetchurl {
        url = "http://www.mpfr.org/mpfr-2.4.1/mpfr-2.4.1.tar.bz2";
        sha256 = "0pj879vbwbik8xkgnxy2ll32ljq3bgqjsqapqasq9rkfbkl90a34";
      }
    } pkgs/development/libraries/mpfr/mpfr-2.4.1.tar.bz2
  '';
}) { system = system; }
