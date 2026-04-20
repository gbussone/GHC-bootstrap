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
    ./binutils_2_20_1.patch
    ./binutils_2_20_51.patch
    ./bootstrap_tools.patch
    ./cloog_ppl_0_15_9.patch
    ./curl_7_21_0.patch
    ./libsigsegv_2_8.patch
    ./libssh2_1_2_6.patch
    ./mpc_0_8_2.patch
    ./openssl_1_0_0.patch
    ./patchelf_0_5.patch
    ./xz_5_0_0.patch
    ./zlib_1_2_5.patch
  ];
  prePatch = ''
    cp ${
      fetchurl {
        url = "http://nixos.org/tarballs/binutils-2.20.51-pre-20100901.tar.bz2";
        sha256 = "1872fdnbnq5z5svq7mvc0vyyad8pknwvx2glxq1bbk0xv7arp72y";
      }
    } pkgs/development/tools/misc/binutils/binutils-2.20.51-pre-20100901.tar.bz2
    cp ${
      fetchurl {
        url = "http://nixos.org/tarballs/stdenv-linux/x86_64/r23302/bootstrap-tools.cpio.bz2";
        sha256 = "0w89kqhx47yl0jifp2vffp073pyrqha5f312kp971smi4h41drna";
      }
    } pkgs/stdenv/linux/bootstrap/x86_64/bootstrap-tools.cpio.bz2
    cp ${
      fetchurl {
        url = "https://ftp2.osuosl.org/pub/clfs/conglomeration/cloog-ppl/cloog-ppl-0.15.9.tar.gz";
        sha256 = "19a2n75k3d3n8llng25f2g88lpvd4zn0lm073rkndjw6l6yd8m4c";
      }
    } pkgs/development/libraries/cloog-ppl/cloog-ppl-0.15.9.tar.gz
    cp ${
      fetchurl {
        url = "https://curl.se/download/archeology/curl-7.21.0.tar.gz";
        hash = "sha256-s+IEfG9w6zIVV6+YCpVU8KmPsSLZY28cmIMyYu7Y3h0=";
      }
    } pkgs/tools/networking/curl/curl-7.21.0.tar.gz
    cp ${
      fetchurl {
        url = "http://www.libssh2.org/download/libssh2-1.2.6.tar.gz";
        sha256 = "00f6hw972v7jd0rrdr6kx5cn7pa1spyx8xgc7vhjydksgsig3f8b";
      }
    } pkgs/development/libraries/libssh2/libssh2-1.2.6.tar.gz
    cp ${
      fetchurl {
        url = "https://www.multiprecision.org/downloads/mpc-0.8.2.tar.gz";
        sha256 = "1iw0ag28l5r88k7kpn6i89rqn3yhk2irqzk0d1mlb1la3paghydf";
      }
    } pkgs/development/libraries/mpc/mpc-0.8.2.tar.gz
    cp ${
      fetchurl {
        url = "http://www.openssl.org/source/openssl-1.0.0c.tar.gz";
        sha256 = "1sq4sswyjxnr08lyjcafwdha6j5jd2b48vxfg48kdapdwdnv6cgp";
      }
    } pkgs/development/libraries/openssl/openssl-1.0.0c.tar.gz
    cp ${
      fetchurl {
        url = "http://nixos.org/releases/patchelf/patchelf-0.5/patchelf-0.5.tar.bz2";
        sha256 = "24b9a850af45e1a277e234b9eb090b52305a2e1c6b02addeb3ae98b4b49d37ce";
      }
    } pkgs/development/tools/misc/patchelf/patchelf-0.5.tar.bz2
    cp ${
      fetchurl {
        url = "http://tukaani.org/xz/xz-5.0.0.tar.bz2";
        sha256 = "1n2nc00d83di0jl5d9qwpngkmlk3wqhs4w9q2ah680v9qijrxa27";
      }
    } pkgs/tools/compression/xz/xz-5.0.0.tar.bz2
    cp ${
      fetchurl {
        url = "https://zlib.net/fossils/zlib-1.2.5.tar.gz";
        sha256 = "0n7rlgvjn73pyil3s1l6p77m7wkc809n934rnzxv1b1za4pfar30";
      }
    } pkgs/development/libraries/zlib/zlib-1.2.5.tar.gz
  '';
}) { system = system; }
