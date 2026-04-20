{
  description = "GHC bootstrap";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs_25_11.url = "github:NixOS/nixpkgs/25.11";
    nixpkgs_25_05.url = "github:NixOS/nixpkgs/25.05";
    nixpkgs_24_11.url = "github:NixOS/nixpkgs/24.11";
    nixpkgs_24_05.url = "github:NixOS/nixpkgs/24.05";
    nixpkgs_23_11.url = "github:NixOS/nixpkgs/23.11";
    nixpkgs_23_05.url = "github:NixOS/nixpkgs/23.05";
    nixpkgs_22_11.url = "github:NixOS/nixpkgs/22.11";
    nixpkgs_22_05.url = "github:NixOS/nixpkgs/22.05";
    nixpkgs_21_11.url = "github:NixOS/nixpkgs/21.11";
    nixpkgs_21_05.url = "github:NixOS/nixpkgs/21.05";
    nixpkgs_20_09.url = "github:NixOS/nixpkgs/20.09";
    nixpkgs_20_03 = {
      url = "github:NixOS/nixpkgs/20.03";
      flake = false;
    };
    nixpkgs_19_09 = {
      url = "github:NixOS/nixpkgs/19.09";
      flake = false;
    };
    nixpkgs_19_03 = {
      url = "github:NixOS/nixpkgs/19.03";
      flake = false;
    };
    nixpkgs_18_09 = {
      url = "github:NixOS/nixpkgs/18.09";
      flake = false;
    };
    nixpkgs_18_03 = {
      url = "github:NixOS/nixpkgs/18.03";
      flake = false;
    };
    nixpkgs_17_09 = {
      url = "github:NixOS/nixpkgs/17.09";
      flake = false;
    };
    nixpkgs_17_03 = {
      url = "github:NixOS/nixpkgs/17.03";
      flake = false;
    };
    nixpkgs_16_09 = {
      url = "github:NixOS/nixpkgs/16.09";
      flake = false;
    };
    nixpkgs_16_03 = {
      url = "github:NixOS/nixpkgs/16.03";
      flake = false;
    };
    nixpkgs_15_09 = {
      url = "github:NixOS/nixpkgs/15.09";
      flake = false;
    };
    nixpkgs_last_glibc_2_13 = {
      url = "github:NixOS/nixpkgs/last-glibc-2.13";
      flake = false;
    };
    nixpkgs_0_14 = {
      url = "github:NixOS/nixpkgs/0.14";
      flake = false;
    };
    nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd = {
      url = "github:NixOS/nixpkgs/2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs_25_11,
      nixpkgs_25_05,
      nixpkgs_24_11,
      nixpkgs_24_05,
      nixpkgs_23_11,
      nixpkgs_23_05,
      nixpkgs_22_11,
      nixpkgs_22_05,
      nixpkgs_21_11,
      nixpkgs_21_05,
      nixpkgs_20_09,
      nixpkgs_20_03,
      nixpkgs_19_09,
      nixpkgs_19_03,
      nixpkgs_18_09,
      nixpkgs_18_03,
      nixpkgs_17_09,
      nixpkgs_17_03,
      nixpkgs_16_09,
      nixpkgs_16_03,
      nixpkgs_15_09,
      nixpkgs_last_glibc_2_13,
      nixpkgs_0_14,
      nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd,
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pkgs32 = nixpkgs.legacyPackages.i686-linux;
      pkgs_25_11 = nixpkgs_25_11.legacyPackages.x86_64-linux;
      pkgs32_25_11 = nixpkgs_25_11.legacyPackages.i686-linux;
      pkgs_25_05 = nixpkgs_25_05.legacyPackages.x86_64-linux;
      pkgs32_25_05 = nixpkgs_25_05.legacyPackages.i686-linux;
      pkgs_24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
      pkgs32_24_11 = nixpkgs_24_11.legacyPackages.i686-linux;
      pkgs_24_05 = nixpkgs_24_05.legacyPackages.x86_64-linux;
      pkgs32_24_05 = nixpkgs_24_05.legacyPackages.i686-linux;
      pkgs_23_11 = nixpkgs_23_11.legacyPackages.x86_64-linux;
      pkgs32_23_11 = nixpkgs_23_11.legacyPackages.i686-linux;
      pkgs_23_05 = nixpkgs_23_05.legacyPackages.x86_64-linux;
      pkgs32_23_05 = nixpkgs_23_05.legacyPackages.i686-linux;
      pkgs_22_11 = nixpkgs_22_11.legacyPackages.x86_64-linux;
      pkgs32_22_11 = nixpkgs_22_11.legacyPackages.i686-linux;
      pkgs_22_05 = nixpkgs_22_05.legacyPackages.x86_64-linux;
      pkgs32_22_05 = nixpkgs_22_05.legacyPackages.i686-linux;
      pkgs_21_11 = nixpkgs_21_11.legacyPackages.x86_64-linux;
      pkgs32_21_11 = nixpkgs_21_11.legacyPackages.i686-linux;
      pkgs_21_05 = nixpkgs_21_05.legacyPackages.x86_64-linux;
      pkgs32_21_05 = nixpkgs_21_05.legacyPackages.i686-linux;
      pkgs_20_09 = nixpkgs_20_09.legacyPackages.x86_64-linux;
      pkgs32_20_09 = nixpkgs_20_09.legacyPackages.i686-linux;
      pkgs_20_03 = (import nixpkgs_20_03 { system = "x86_64-linux"; }).pkgs;
      pkgs32_20_03 = (import nixpkgs_20_03 { system = "i686-linux"; }).pkgs;
      pkgs_19_09 = (import nixpkgs_19_09 { system = "x86_64-linux"; }).pkgs;
      pkgs32_19_09 = (import nixpkgs_19_09 { system = "i686-linux"; }).pkgs;
      pkgs_19_03 = (import nixpkgs_19_03 { system = "x86_64-linux"; }).pkgs;
      pkgs32_19_03 = (import nixpkgs_19_03 { system = "i686-linux"; }).pkgs;
      pkgs_18_09 = (import nixpkgs_18_09 { system = "x86_64-linux"; }).pkgs;
      pkgs32_18_09 = (import nixpkgs_18_09 { system = "i686-linux"; }).pkgs;
      pkgs_18_03 = (import nixpkgs_18_03 { system = "x86_64-linux"; }).pkgs;
      pkgs32_18_03 = (import nixpkgs_18_03 { system = "i686-linux"; }).pkgs;
      pkgs_17_09 = (import nixpkgs_17_09 { system = "x86_64-linux"; }).pkgs;
      pkgs32_17_09 = (import nixpkgs_17_09 { system = "i686-linux"; }).pkgs;
      pkgs_17_03 = (import nixpkgs_17_03 { system = "x86_64-linux"; }).pkgs;
      pkgs32_17_03 = (import nixpkgs_17_03 { system = "i686-linux"; }).pkgs;
      pkgs_16_09 = (import nixpkgs_16_09 { system = "x86_64-linux"; }).pkgs;
      pkgs32_16_09 = (import nixpkgs_16_09 { system = "i686-linux"; }).pkgs;
      pkgs_16_03 = (import nixpkgs_16_03 { system = "x86_64-linux"; }).pkgs;
      pkgs32_16_03 = (import nixpkgs_16_03 { system = "i686-linux"; }).pkgs;
      pkgs_15_09 = (import nixpkgs_15_09 { system = "x86_64-linux"; }).pkgs;
      pkgs32_15_09 = (import nixpkgs_15_09 { system = "i686-linux"; }).pkgs;
      nixpkgs_last_glibc_2_13' = pkgs.applyPatches {
        name = "nixpkgs";
        src = nixpkgs_last_glibc_2_13;
        patches = [ ./nixpkgs_last_glibc_2_13/perl_5_8.patch ];
        prePatch = ''
          cp ${
            pkgs.fetchurl {
              url = "http://bugs.gentoo.org/attachment.cgi?id=111427";
              sha256 = "017pj0nbqb7kwj3cs727c2l2d8c45l9cwxf71slgb807kn3ppgmn";
            }
          } pkgs/development/interpreters/perl/5.8/111427.patch
        '';
      };
      pkgs_last_glibc_2_13 = (import nixpkgs_last_glibc_2_13' { system = "x86_64-linux"; }).pkgs;
      pkgs32_last_glibc_2_13 = (import nixpkgs_last_glibc_2_13' { system = "i686-linux"; }).pkgs;
      pkgs_0_14 = import nixpkgs_0_14 { system = "x86_64-linux"; };
      pkgs32_0_14 = import nixpkgs_0_14 { system = "i686-linux"; };
      nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd' = pkgs.applyPatches {
        name = "nixpkgs";
        src = nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd;
        patches = [
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/binutils_2_20_1.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/binutils_2_20_51.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/bootstrap_tools.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/cloog_ppl_0_15_9.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/curl_7_21_0.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/libsigsegv_2_8.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/libssh2_1_2_6.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/mpc_0_8_2.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/openssl_1_0_0.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/patchelf_0_5.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/xz_5_0_0.patch
          ./nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd/zlib_1_2_5.patch
        ];
        prePatch = ''
          cp ${
            pkgs.fetchurl {
              url = "http://nixos.org/tarballs/binutils-2.20.51-pre-20100901.tar.bz2";
              sha256 = "1872fdnbnq5z5svq7mvc0vyyad8pknwvx2glxq1bbk0xv7arp72y";
            }
          } pkgs/development/tools/misc/binutils/binutils-2.20.51-pre-20100901.tar.bz2
          cp ${
            pkgs.fetchurl {
              url = "http://nixos.org/tarballs/stdenv-linux/x86_64/r23302/bootstrap-tools.cpio.bz2";
              sha256 = "0w89kqhx47yl0jifp2vffp073pyrqha5f312kp971smi4h41drna";
            }
          } pkgs/stdenv/linux/bootstrap/x86_64/bootstrap-tools.cpio.bz2
          cp ${
            pkgs.fetchurl {
              url = "https://ftp2.osuosl.org/pub/clfs/conglomeration/cloog-ppl/cloog-ppl-0.15.9.tar.gz";
              sha256 = "19a2n75k3d3n8llng25f2g88lpvd4zn0lm073rkndjw6l6yd8m4c";
            }
          } pkgs/development/libraries/cloog-ppl/cloog-ppl-0.15.9.tar.gz
          cp ${
            pkgs.fetchurl {
              url = "https://curl.se/download/archeology/curl-7.21.0.tar.gz";
              hash = "sha256-s+IEfG9w6zIVV6+YCpVU8KmPsSLZY28cmIMyYu7Y3h0=";
            }
          } pkgs/tools/networking/curl/curl-7.21.0.tar.gz
          cp ${
            pkgs.fetchurl {
              url = "http://www.libssh2.org/download/libssh2-1.2.6.tar.gz";
              sha256 = "00f6hw972v7jd0rrdr6kx5cn7pa1spyx8xgc7vhjydksgsig3f8b";
            }
          } pkgs/development/libraries/libssh2/libssh2-1.2.6.tar.gz
          cp ${
            pkgs.fetchurl {
              url = "https://www.multiprecision.org/downloads/mpc-0.8.2.tar.gz";
              sha256 = "1iw0ag28l5r88k7kpn6i89rqn3yhk2irqzk0d1mlb1la3paghydf";
            }
          } pkgs/development/libraries/mpc/mpc-0.8.2.tar.gz
          cp ${
            pkgs.fetchurl {
              url = "http://www.openssl.org/source/openssl-1.0.0c.tar.gz";
              sha256 = "1sq4sswyjxnr08lyjcafwdha6j5jd2b48vxfg48kdapdwdnv6cgp";
            }
          } pkgs/development/libraries/openssl/openssl-1.0.0c.tar.gz
          cp ${
            pkgs.fetchurl {
              url = "http://nixos.org/releases/patchelf/patchelf-0.5/patchelf-0.5.tar.bz2";
              sha256 = "24b9a850af45e1a277e234b9eb090b52305a2e1c6b02addeb3ae98b4b49d37ce";
            }
          } pkgs/development/tools/misc/patchelf/patchelf-0.5.tar.bz2
          cp ${
            pkgs.fetchurl {
              url = "http://tukaani.org/xz/xz-5.0.0.tar.bz2";
              sha256 = "1n2nc00d83di0jl5d9qwpngkmlk3wqhs4w9q2ah680v9qijrxa27";
            }
          } pkgs/tools/compression/xz/xz-5.0.0.tar.bz2
          cp ${
            pkgs.fetchurl {
              url = "https://zlib.net/fossils/zlib-1.2.5.tar.gz";
              sha256 = "0n7rlgvjn73pyil3s1l6p77m7wkc809n934rnzxv1b1za4pfar30";
            }
          } pkgs/development/libraries/zlib/zlib-1.2.5.tar.gz
        '';
      };
      pkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd =
        import nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd'
          { system = "x86_64-linux"; };
      pkgs32_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd =
        import nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd'
          { system = "i686-linux"; };
    in
    {
      packages.x86_64-linux = {
        default = self.packages.x86_64-linux.ghc_9_12_3;

        ghc_0_29 = throw "todo";
        ghc_2_10 = throw "todo";
        ghc_3_2 = throw "todo";
        ghc_4_2 = throw "todo";
        ghc_4_4 = throw "todo";
        ghc_4_6 = throw "todo";
        ghc_4_8_2 = throw "todo";
        ghc_5_0_2 = throw "todo";
        ghc_5_2_3 = throw "todo";
        ghc_5_4_3 = throw "todo";
        ghc_6_0_1 = throw "todo";

        ghc_6_2_2 = pkgs32.callPackage ./ghc_6_2_2 {
          perl = pkgs32_last_glibc_2_13.perl58;
          gcc = pkgs32_last_glibc_2_13.gcc34;
          ghc = pkgs32.callPackage ./ghc_6_2_2/binary.nix {
            perl = pkgs32_last_glibc_2_13.perl58;
            readline = pkgs32_last_glibc_2_13.readline4;
          };
        };

        ghc_6_4_2 = pkgs.callPackage ./ghc_6_4_2 {
          perl = pkgs_last_glibc_2_13.perl58;
          gcc = pkgs_20_03.wrapCCWith {
            cc = pkgs_17_09.gcc.cc;
            bintools = pkgs_20_03.wrapBintoolsWith {
              bintools = pkgs.binutils.bintools;
              libc = pkgs.libc;
            };
          };
          ghc = pkgs.callPackage ./ghc_6_4_2/binary.nix {
            perl = pkgs_last_glibc_2_13.perl58;
            gmp = pkgs_24_11.gmp4;
            readline = pkgs_21_11.readline5;
          };
        };

        ghc_6_6_1 = pkgs.callPackage ./ghc_6_6_1 {
          perl = pkgs_last_glibc_2_13.perl58;
          gcc = pkgs_20_03.wrapCCWith {
            cc = pkgs_last_glibc_2_13.gcc.gcc;
            bintools = pkgs_20_03.wrapBintoolsWith {
              bintools = pkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd.binutils_release;
              libc = pkgs_15_09.glibc;
            };
          };
          ghc = pkgs.callPackage ./ghc_6_6_1/binary.nix {
            perl = pkgs_last_glibc_2_13.perl58;
            gmp = pkgs_24_11.gmp4;
            readline = pkgs_21_11.readline5;
          };
          gmp = pkgs_23_05.gmp;
        };

        ghc_6_8_3 = pkgs.callPackage ./ghc_6_8_3 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc_6_8_3/binary.nix {
            gmp = pkgs_24_11.gmp4;
            readline = pkgs_21_11.readline5;
          };
          gmp = pkgs_23_05.gmp;
        };

        ghc_6_10_4 = pkgs.callPackage ./ghc_6_10_4 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc_6_10_4/binary.nix { gmp = pkgs_24_11.gmp4; };
          gmp = pkgs_23_05.gmp;
          ncurses = pkgs_21_05.ncurses;
        };

        ghc_6_12_3 = pkgs.callPackage ./ghc_6_12_3 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc_6_12_3/binary.nix {
            gcc = pkgs_25_05.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_23_05.gmp;
          ncurses = pkgs_21_05.ncurses;
        };

        ghc_7_0_4 = pkgs.callPackage ./ghc_7_0_4 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc_7_0_4/binary.nix {
            gcc = pkgs_20_03.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_23_05.gmp;
          ncurses = pkgs_21_05.ncurses;
        };

        ghc_7_2_2 = pkgs.callPackage ./ghc_7_2_2 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc_7_2_2/binary.nix {
            gcc = pkgs_20_03.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_23_05.gmp;
          ncurses = pkgs_21_05.ncurses;
        };

        ghc_7_4_2 = pkgs.callPackage ./ghc_7_4_2 {
          gcc = pkgs_24_11.gcc;
          ghc = pkgs.callPackage ./ghc_7_4_2/binary.nix {
            gcc = pkgs_25_05.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_24_11.gmp4;
          ncurses = pkgs_25_11.ncurses5;
        };

        ghc_7_6_3 = pkgs.callPackage ./ghc_7_6_3 {
          gcc = pkgs_24_11.gcc;
          ghc = pkgs.callPackage ./ghc_7_6_3/binary.nix {
            gcc = pkgs_25_05.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_24_11.gmp4;
          ncurses = pkgs_25_11.ncurses;
        };

        ghc_7_8_4 = pkgs.callPackage ./ghc_7_8_4 {
          gcc = pkgs_24_11.gcc;
          ghc = pkgs.callPackage ./ghc_7_8_4/binary.nix { gcc = pkgs_25_05.gcc; };
          ncurses = pkgs_25_11.ncurses;
        };

        ghc_7_10_3 = pkgs.callPackage ./ghc_7_10_3 {
          gcc = pkgs_24_11.gcc;
          ghc = pkgs.callPackage ./ghc_7_10_3 {
            gcc = pkgs_24_11.gcc;
            ghc = pkgs.callPackage ./ghc_7_10_3/binary.nix { gcc = pkgs_21_11.gcc; };
            gmp = pkgs_23_05.gmp;
            ncurses = pkgs_25_11.ncurses;
          };
          ncurses = pkgs_25_11.ncurses;
        };

        ghc_8_0_2 = pkgs.callPackage ./ghc_8_0_2 {
          gcc = pkgs.gcc13;
          ghc = pkgs.callPackage ./ghc_8_0_2/binary.nix { };
        };

        ghc_8_2_2 = pkgs.callPackage ./ghc_8_2_2 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_8_2_2/binary.nix { };
        };

        ghc_8_4_4 = pkgs.callPackage ./ghc_8_4_4 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_8_4_4/binary.nix { };
        };

        ghc_8_6_5 = pkgs.callPackage ./ghc_8_6_5 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_8_6_5/binary.nix { };
        };

        ghc_8_8_4 = pkgs.callPackage ./ghc_8_8_4 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_8_8_4/binary.nix { };
        };

        ghc_8_10_7 = pkgs.callPackage ./ghc_8_10_7 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_8_10_7/binary.nix { };
        };

        ghc_9_0_2 = pkgs.callPackage ./ghc_9_0_2 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_9_0_2/binary.nix { };
        };

        ghc_9_2_8 = pkgs.callPackage ./ghc_9_2_8 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_9_2_8/binary.nix { };
        };

        ghc_9_4_8 = pkgs.callPackage ./ghc_9_4_8 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_9_4_8/binary.nix { };
        };

        ghc_9_6_7 = pkgs.callPackage ./ghc_9_6_7 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_9_6_7/binary.nix { };
        };

        ghc_9_8_4 = pkgs.callPackage ./ghc_9_8_4 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc_9_8_4/binary.nix { };
        };

        ghc_9_10_3 = pkgs.callPackage ./ghc_9_10_3 { ghc = pkgs.callPackage ./ghc_9_10_3/binary.nix { }; };

        ghc_9_12_3 = pkgs.callPackage ./ghc_9_12_3 { ghc = pkgs.callPackage ./ghc_9_12_3/binary.nix { }; };
      };
    };
}
