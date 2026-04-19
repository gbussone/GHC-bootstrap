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
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      lib = pkgs.lib;
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
        ghc_5_4 = throw "todo";
        ghc_5_4_3 = throw "todo";
        ghc_6_0 = throw "todo";
        ghc_6_0_1 = throw "todo";

        ghc_6_2_2 =
          let
            pkgs = nixpkgs.legacyPackages.i686-linux;
            pkgs_last_glibc_2_13 = (import nixpkgs_last_glibc_2_13 { system = "i686-linux"; }).pkgs;
          in
          pkgs.callPackage ./ghc_6_2_2 {
            perl =
              with pkgs_last_glibc_2_13.perl58;
              pkgs_last_glibc_2_13.stdenv.mkDerivation {
                patches = [
                  (lib.lists.elemAt patches 0)
                  (lib.lists.elemAt patches 1)
                  (pkgs.fetchurl {
                    url = "http://bugs.gentoo.org/attachment.cgi?id=111427";
                    sha256 = "017pj0nbqb7kwj3cs727c2l2d8c45l9cwxf71slgb807kn3ppgmn";
                  })
                ];
                inherit
                  name
                  phase
                  phases
                  setupHook
                  src
                  ;
              };
            gcc = pkgs_last_glibc_2_13.gcc34;
            ghc = pkgs.callPackage ghc_6_2_2/binary.nix {
              perl =
                with pkgs_last_glibc_2_13.perl58;
                pkgs_last_glibc_2_13.stdenv.mkDerivation {
                  patches = [
                    (lib.lists.elemAt patches 0)
                    (lib.lists.elemAt patches 1)
                    (pkgs.fetchurl {
                      url = "http://bugs.gentoo.org/attachment.cgi?id=111427";
                      sha256 = "017pj0nbqb7kwj3cs727c2l2d8c45l9cwxf71slgb807kn3ppgmn";
                    })
                  ];
                  inherit
                    name
                    phase
                    phases
                    setupHook
                    src
                    ;
                };
              readline = pkgs_last_glibc_2_13.readline4;
            };
          };

        ghc_6_4_2 =
          let
            pkgs24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
            pkgs21_11 = nixpkgs_21_11.legacyPackages.x86_64-linux;
            pkgs20_03 = (import nixpkgs_20_03 { system = "x86_64-linux"; }).pkgs;
            pkgs17_09 = (import nixpkgs_17_09 { system = "x86_64-linux"; }).pkgs;
            pkgs_last_glibc_2_13 = (import nixpkgs_last_glibc_2_13 { system = "x86_64-linux"; }).pkgs;
          in
          pkgs.callPackage ./ghc_6_4_2 {
            perl =
              with pkgs_last_glibc_2_13.perl58;
              pkgs_last_glibc_2_13.stdenv.mkDerivation {
                patches = [
                  (lib.lists.elemAt patches 0)
                  (lib.lists.elemAt patches 1)
                  (pkgs.fetchurl {
                    url = "http://bugs.gentoo.org/attachment.cgi?id=111427";
                    sha256 = "017pj0nbqb7kwj3cs727c2l2d8c45l9cwxf71slgb807kn3ppgmn";
                  })
                ];
                inherit
                  name
                  phase
                  phases
                  setupHook
                  src
                  ;
              };
            gcc = pkgs20_03.wrapCCWith {
              cc = pkgs17_09.gcc.cc;
              bintools = pkgs20_03.wrapBintoolsWith {
                bintools = pkgs.binutils.bintools;
                libc = pkgs.libc;
              };
            };
            ghc = pkgs.callPackage ghc_6_4_2/binary.nix {
              perl =
                with pkgs_last_glibc_2_13.perl58;
                pkgs_last_glibc_2_13.stdenv.mkDerivation {
                  patches = [
                    (lib.lists.elemAt patches 0)
                    (lib.lists.elemAt patches 1)
                    (pkgs.fetchurl {
                      url = "http://bugs.gentoo.org/attachment.cgi?id=111427";
                      sha256 = "017pj0nbqb7kwj3cs727c2l2d8c45l9cwxf71slgb807kn3ppgmn";
                    })
                  ];
                  inherit
                    name
                    phase
                    phases
                    setupHook
                    src
                    ;
                };
              gmp = pkgs24_11.gmp4;
              readline = pkgs21_11.readline5;
            };
          };

        ghc_6_6_1 =
          let
            pkgs24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
            pkgs23_05 = nixpkgs_23_05.legacyPackages.x86_64-linux;
            pkgs21_11 = nixpkgs_21_11.legacyPackages.x86_64-linux;
            pkgs20_03 = (import nixpkgs_20_03 { system = "x86_64-linux"; }).pkgs;
            pkgs15_09 = (import nixpkgs_15_09 { system = "x86_64-linux"; }).pkgs;
            pkgs_last_glibc_2_13 = (import nixpkgs_last_glibc_2_13 { system = "x86_64-linux"; }).pkgs;
            pkgs_0_14 = import nixpkgs_0_14 { system = "x86_64-linux"; };
          in
          pkgs.callPackage ./ghc_6_6_1 {
            perl =
              with pkgs_last_glibc_2_13.perl58;
              pkgs_last_glibc_2_13.stdenv.mkDerivation {
                patches = [
                  (lib.lists.elemAt patches 0)
                  (lib.lists.elemAt patches 1)
                  (pkgs.fetchurl {
                    url = "http://bugs.gentoo.org/attachment.cgi?id=111427";
                    sha256 = "017pj0nbqb7kwj3cs727c2l2d8c45l9cwxf71slgb807kn3ppgmn";
                  })
                ];
                inherit
                  name
                  phase
                  phases
                  setupHook
                  src
                  ;
              };
            gcc = pkgs20_03.wrapCCWith {
              cc = pkgs_last_glibc_2_13.gcc;
              bintools = pkgs20_03.wrapBintoolsWith {
                bintools =
                  with pkgs_0_14.binutils;
                  let
                    version = "2.20.1";
                  in
                  pkgs_0_14.stdenv.mkDerivation {
                    name = "binutils-${version}";
                    src = pkgs.fetchurl {
                      url = "mirror://gnu/binutils/binutils-${version}.tar.bz2";
                      hash = "sha256-cdN8lkUTM8XAuEsXAWn9yxOLuyc5fcBigZBdlxfI7WQ=";
                    };
                    inherit
                      buildInputs
                      configureFlags
                      enableParallelBuilding
                      NIX_CFLAGS_COMPILE
                      noSysDirs
                      patches
                      preConfigure
                      ;
                  };
                libc = pkgs15_09.glibc;
              };
            };
            ghc = pkgs.callPackage ghc_6_6_1/binary.nix {
              perl =
                with pkgs_last_glibc_2_13.perl58;
                pkgs_last_glibc_2_13.stdenv.mkDerivation {
                  patches = [
                    (lib.lists.elemAt patches 0)
                    (lib.lists.elemAt patches 1)
                    (pkgs.fetchurl {
                      url = "http://bugs.gentoo.org/attachment.cgi?id=111427";
                      sha256 = "017pj0nbqb7kwj3cs727c2l2d8c45l9cwxf71slgb807kn3ppgmn";
                    })
                  ];
                  inherit
                    name
                    phase
                    phases
                    setupHook
                    src
                    ;
                };
              gmp = pkgs24_11.gmp4;
              readline = pkgs21_11.readline5;
            };
            gmp = pkgs23_05.gmp;
          };

        ghc_6_8_3 =
          let
            pkgs24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
            pkgs23_05 = nixpkgs_23_05.legacyPackages.x86_64-linux;
            pkgs21_11 = nixpkgs_21_11.legacyPackages.x86_64-linux;
            pkgs18_03 = (import nixpkgs_18_03 { system = "x86_64-linux"; }).pkgs;
          in
          pkgs.callPackage ./ghc_6_8_3 {
            gcc = pkgs18_03.gcc;
            ghc = pkgs.callPackage ghc_6_8_3/binary.nix {
              gmp = pkgs24_11.gmp4;
              readline = pkgs21_11.readline5;
            };
            gmp = pkgs23_05.gmp;
          };

        ghc_6_10_4 =
          let
            pkgs_24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
            pkgs_23_05 = nixpkgs_23_05.legacyPackages.x86_64-linux;
            pkgs_21_05 = nixpkgs_21_05.legacyPackages.x86_64-linux;
            pkgs_18_03 = (import nixpkgs_18_03 { system = "x86_64-linux"; }).pkgs;
          in
          pkgs.callPackage ./ghc_6_10_4 {
            gcc = pkgs_18_03.gcc;
            ghc = pkgs.callPackage ghc_6_10_4/binary.nix { gmp = pkgs_24_11.gmp4; };
            gmp = pkgs_23_05.gmp;
            ncurses = pkgs_21_05.ncurses;
          };

        ghc_6_12_3 =
          let
            pkgs_25_05 = nixpkgs_25_05.legacyPackages.x86_64-linux;
            pkgs_24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
            pkgs_23_05 = nixpkgs_23_05.legacyPackages.x86_64-linux;
            pkgs_21_05 = nixpkgs_21_05.legacyPackages.x86_64-linux;
            pkgs_18_03 = (import nixpkgs_18_03 { system = "x86_64-linux"; }).pkgs;
          in
          pkgs.callPackage ./ghc_6_12_3 {
            gcc = pkgs_18_03.gcc;
            ghc = pkgs.callPackage ghc_6_12_3/binary.nix {
              gcc = pkgs_25_05.gcc;
              gmp = pkgs_24_11.gmp4;
            };
            gmp = pkgs_23_05.gmp;
            ncurses = pkgs_21_05.ncurses;
          };

        ghc_7_0_4 =
          let
            pkgs_24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
            pkgs_23_05 = nixpkgs_23_05.legacyPackages.x86_64-linux;
            pkgs_21_05 = nixpkgs_21_05.legacyPackages.x86_64-linux;
            pkgs_20_03 = (import nixpkgs_20_03 { system = "x86_64-linux"; }).pkgs;
            pkgs_18_03 = (import nixpkgs_18_03 { system = "x86_64-linux"; }).pkgs;
          in
          pkgs.callPackage ./ghc_7_0_4 {
            gcc = pkgs_18_03.gcc;
            ghc = pkgs.callPackage ghc_7_0_4/binary.nix {
              gcc = pkgs_20_03.gcc;
              gmp = pkgs_24_11.gmp4;
            };
            gmp = pkgs_23_05.gmp;
            ncurses = pkgs_21_05.ncurses;
          };

        ghc_7_2_2 =
          let
            pkgs_24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
            pkgs_23_05 = nixpkgs_23_05.legacyPackages.x86_64-linux;
            pkgs_21_05 = nixpkgs_21_05.legacyPackages.x86_64-linux;
            pkgs_20_03 = (import nixpkgs_20_03 { system = "x86_64-linux"; }).pkgs;
            pkgs_18_03 = (import nixpkgs_18_03 { system = "x86_64-linux"; }).pkgs;
          in
          pkgs.callPackage ./ghc_7_2_2 {
            gcc = pkgs_18_03.gcc;
            ghc = pkgs.callPackage ghc_7_2_2/binary.nix {
              gcc = pkgs_20_03.gcc;
              gmp = pkgs_24_11.gmp4;
            };
            gmp = pkgs_23_05.gmp;
            ncurses = pkgs_21_05.ncurses;
          };

        ghc_7_4_2 =
          let
            pkgs_25_11 = nixpkgs_25_11.legacyPackages.x86_64-linux;
            pkgs_25_05 = nixpkgs_25_05.legacyPackages.x86_64-linux;
            pkgs_24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
          in
          pkgs.callPackage ./ghc_7_4_2 {
            gcc = pkgs_24_11.gcc;
            ghc = pkgs.callPackage ghc_7_4_2/binary.nix {
              gcc = pkgs_25_05.gcc;
              gmp = pkgs_24_11.gmp4;
            };
            gmp = pkgs_24_11.gmp4;
            ncurses = pkgs_25_11.ncurses5;
          };

        ghc_7_6_3 =
          let
            pkgs_25_11 = nixpkgs_25_11.legacyPackages.x86_64-linux;
            pkgs_25_05 = nixpkgs_25_05.legacyPackages.x86_64-linux;
            pkgs_24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
          in
          pkgs.callPackage ./ghc_7_6_3 {
            gcc = pkgs_24_11.gcc;
            ghc = pkgs.callPackage ghc_7_6_3/binary.nix {
              gcc = pkgs_25_05.gcc;
              gmp = pkgs_24_11.gmp4;
            };
            gmp = pkgs_24_11.gmp4;
            ncurses = pkgs_25_11.ncurses;
          };

        ghc_7_8_4 =
          let
            pkgs_25_11 = nixpkgs_25_11.legacyPackages.x86_64-linux;
            pkgs_25_05 = nixpkgs_25_05.legacyPackages.x86_64-linux;
            pkgs_24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
          in
          pkgs.callPackage ./ghc_7_8_4 {
            gcc = pkgs_24_11.gcc;
            ghc = pkgs.callPackage ghc_7_8_4/binary.nix { gcc = pkgs_25_05.gcc; };
            ncurses = pkgs_25_11.ncurses;
          };

        ghc_7_10_3 =
          let
            pkgs_25_11 = nixpkgs_25_11.legacyPackages.x86_64-linux;
            pkgs_24_11 = nixpkgs_24_11.legacyPackages.x86_64-linux;
            pkgs_23_05 = nixpkgs_23_05.legacyPackages.x86_64-linux;
            pkgs_21_11 = nixpkgs_21_11.legacyPackages.x86_64-linux;
          in
          pkgs.callPackage ./ghc_7_10_3 {
            gcc = pkgs_24_11.gcc;
            ghc = pkgs.callPackage ./ghc_7_10_3 {
              gcc = pkgs_24_11.gcc;
              ghc = pkgs.callPackage ghc_7_10_3/binary.nix { gcc = pkgs_21_11.gcc; };
              gmp = pkgs_23_05.gmp;
              ncurses = pkgs_25_11.ncurses;
            };
            ncurses = pkgs_25_11.ncurses;
          };

        ghc_8_0_2 = pkgs.callPackage ./ghc_8_0_2 {
          gcc = pkgs.gcc13;
          ghc = pkgs.callPackage ghc_8_0_2/binary.nix { };
        };

        ghc_8_2_2 = pkgs.callPackage ./ghc_8_2_2 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_8_2_2/binary.nix { };
        };

        ghc_8_4_4 = pkgs.callPackage ./ghc_8_4_4 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_8_4_4/binary.nix { };
        };

        ghc_8_6_5 = pkgs.callPackage ./ghc_8_6_5 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_8_6_5/binary.nix { };
        };

        ghc_8_8_4 = pkgs.callPackage ./ghc_8_8_4 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_8_8_4/binary.nix { };
        };

        ghc_8_10_7 = pkgs.callPackage ./ghc_8_10_7 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_8_10_7/binary.nix { };
        };

        ghc_9_0_2 = pkgs.callPackage ./ghc_9_0_2 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_9_0_2/binary.nix { };
        };

        ghc_9_2_8 = pkgs.callPackage ./ghc_9_2_8 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_9_2_8/binary.nix { };
        };

        ghc_9_4_8 = pkgs.callPackage ./ghc_9_4_8 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_9_4_8/binary.nix { };
        };

        ghc_9_6_7 = pkgs.callPackage ./ghc_9_6_7 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_9_6_7/binary.nix { };
        };

        ghc_9_8_4 = pkgs.callPackage ./ghc_9_8_4 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ghc_9_8_4/binary.nix { };
        };

        ghc_9_10_3 = pkgs.callPackage ./ghc_9_10_3 { ghc = pkgs.callPackage ghc_9_10_3/binary.nix { }; };

        ghc_9_12_3 = pkgs.callPackage ./ghc_9_12_3 { ghc = pkgs.callPackage ghc_9_12_3/binary.nix { }; };
      };
    };
}
