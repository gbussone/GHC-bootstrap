{
  src,
  system,
  applyPatches,
  fetchurl,
}:

(import (applyPatches {
  name = "nixpkgs";
  src = src;
  patches = [
    ./bootstrap_tools.patch
    ./ed_1_5.patch
    ./glibc_2_13.patch
    ./isl_0_07.patch
    ./mpc_0_9.patch
    ./pcre_8_21.patch
    ./ppl_0_11_2.patch
    ./xz_5_0_3.patch
  ];
  prePatch = ''
    cp ${
      fetchurl {
        url = "http://nixos.org/tarballs/stdenv-linux/i686/r24519/bootstrap-tools.cpio.bz2";
        sha256 = "0imypaxy6piwbk8ff2y1nr7yk49pqmdgdbv6g8miq1zs5yfip6ij";
      }
    } pkgs/stdenv/linux/bootstrap/i686/bootstrap-tools.cpio.bz2
    cp ${
      fetchurl {
        url = "mirror://gnu/ed/ed-1.5.tar.gz";
        sha256 = "18gvhyhwpabmgv4lh21lg8vl3z7acdyhh2mr2kj9g75wksj39pcp";
      }
    } pkgs/applications/editors/ed/ed-1.5.tar.gz
    cp ${./ctype.patch} pkgs/development/libraries/glibc/2.13/ctype.patch
    cp ${
      fetchurl {
        urls = [
          "http://www.kotnet.org/~skimo/isl/isl-0.07.tar.bz2"
          "ftp://ftp.linux.student.kuleuven.be/pub/people/skimo/isl/isl-0.07.tar.bz2"
        ];
        sha256 = "0kpxmvhrwwdygqqafqzjf9xiksq7paac2x24g9jhr3f9ajj3zkyx";
      }
    } pkgs/development/libraries/isl/isl-0.07.tar.bz2
    cp ${
      fetchurl {
        url = "http://www.multiprecision.org/mpc/download/mpc-0.9.tar.gz";
        sha1 = "229722d553030734d49731844abfef7617b64f1a";
      }
    } pkgs/development/libraries/mpc/mpc-0.9.tar.gz
    cp ${
      fetchurl {
        url = "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.21.tar.bz2";
        sha256 = "1qwrqldbwszbmr4cw4f0xmcl889cmmjbf58l9vxn89zw26fm1f54";
      }
    } pkgs/development/libraries/pcre/pcre-8.21.tar.bz2
    cp ${
      fetchurl {
        url = "https://ftp.lip6.fr/pub/minix/distfiles/backup/ppl-0.11.2.tar.gz";
        hash = "sha256-ZmVCuFO+61eTzTJ//48jGoMX4WJlToF/RBQn/h+FuDU=";
      }
    } pkgs/development/libraries/ppl/ppl-0.11.2.tar.gz
    cp ${
      fetchurl {
        url = "http://tukaani.org/xz/xz-5.0.3.tar.bz2";
        sha256 = "1sgaq4gdh8llz3gnlgvd65x610fwc8h4m32skhqn5npwgghvj4as";
      }
    } pkgs/tools/compression/xz/xz-5.0.3.tar.bz2
  '';
}) { system = system; }).pkgs
