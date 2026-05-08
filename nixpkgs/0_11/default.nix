{
  src,
  system,
  applyPatches,
  fetchurl,
  fetchpatch,
}:

import (applyPatches {
  name = "nixpkgs";
  src = src;
  patches = [
    (fetchpatch {
      url = "https://github.com/NixOS/nixpkgs/commit/a579a5503b7091683a8c297bc0f4d09c67fda26d.patch";
      hash = "sha256-gPqflyrg1zOlfJfCG7T+M7dsTN0qlhiiIO1tp+1nIbI=";
    })
    ./binutils_2_17.patch
    ./bootstrap_tools.patch
    ./linux_headers_2_6_20_11.patch
    ./pcre_7_1.patch
  ];
  prePatch = ''
    cp ${
      fetchurl {
        url = "https://ftp.gnu.org/gnu/binutils/binutils-2.17.tar.bz2";
        hash = "sha256-uLY2MSGpmq8DCdCm9joYwgPduzT1NoPJpW1Wi+K2pUk=";
      }
    } pkgs/development/tools/misc/binutils/binutils-2.17.tar.bz2
    cp ${
      fetchurl {
        url = "https://tarballs.nixos.org/stdenv-linux/i686/r6881/binutils.tar.bz2";
        sha1 = "fa77c29ef4f13ddf43bba3f4f020ceafa6604ccc";
      }
    } pkgs/stdenv/linux/bootstrap/i686/binutils.tar.bz2
    cp ${
      fetchurl {
        url = "https://tarballs.nixos.org/stdenv-linux/i686/r6881/gcc.tar.bz2";
        sha1 = "ea7171fc2f70880e8a6c2480b3d3fed7409b7a4e";
      }
    } pkgs/stdenv/linux/bootstrap/i686/gcc.tar.bz2
    cp ${
      fetchurl {
        url = "https://tarballs.nixos.org/stdenv-linux/i686/r6881/glibc.tar.bz2";
        sha1 = "728e0a9e66e01cf2815eca8cc638e5ed140a36cd";
      }
    } pkgs/stdenv/linux/bootstrap/i686/glibc.tar.bz2
    cp ${
      fetchurl {
        url = "https://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.20.tar.bz2";
        hash = "sha256-LBStoax9Jy4DtDDTpTDWD8nsacyCUjgqoEmvun0rhVg=";
      }
    } pkgs/os-specific/linux/kernel-headers/linux-2.6.20.tar.bz2
    cp ${
      fetchurl {
        url = "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-7.1.tar.bz2";
        sha256 = "0rpkcw07jas3fw6ava3ni5zcrmbncwa8xlsa0lzq6z2iph5510li";
      }
    } pkgs/development/libraries/pcre/pcre-7.1.tar.bz2
  '';
}) { system = system; }
