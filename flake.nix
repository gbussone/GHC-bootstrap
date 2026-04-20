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
      pkgs_25_11 = pkgs.callPackage ./nixpkgs/25_11 {
        src = nixpkgs_25_11;
        system = "x86_64-linux";
      };
      pkgs32_25_11 = pkgs.callPackage ./nixpkgs/25_11 {
        src = nixpkgs_25_11;
        system = "i686-linux";
      };
      pkgs_25_05 = pkgs.callPackage ./nixpkgs/25_05 {
        src = nixpkgs_25_05;
        system = "x86_64-linux";
      };
      pkgs32_25_05 = pkgs.callPackage ./nixpkgs/25_05 {
        src = nixpkgs_25_05;
        system = "i686-linux";
      };
      pkgs_24_11 = pkgs.callPackage ./nixpkgs/24_11 {
        src = nixpkgs_24_11;
        system = "x86_64-linux";
      };
      pkgs32_24_11 = pkgs.callPackage ./nixpkgs/24_11 {
        src = nixpkgs_24_11;
        system = "i686-linux";
      };
      pkgs_24_05 = pkgs.callPackage ./nixpkgs/24_05 {
        src = nixpkgs_24_05;
        system = "x86_64-linux";
      };
      pkgs32_24_05 = pkgs.callPackage ./nixpkgs/24_05 {
        src = nixpkgs_24_05;
        system = "i686-linux";
      };
      pkgs_23_11 = pkgs.callPackage ./nixpkgs/23_11 {
        src = nixpkgs_23_11;
        system = "x86_64-linux";
      };
      pkgs32_23_11 = pkgs.callPackage ./nixpkgs/23_11 {
        src = nixpkgs_23_11;
        system = "i686-linux";
      };
      pkgs_23_05 = pkgs.callPackage ./nixpkgs/23_05 {
        src = nixpkgs_23_05;
        system = "x86_64-linux";
      };
      pkgs32_23_05 = pkgs.callPackage ./nixpkgs/23_05 {
        src = nixpkgs_23_05;
        system = "i686-linux";
      };
      pkgs_22_11 = pkgs.callPackage ./nixpkgs/22_11 {
        src = nixpkgs_22_11;
        system = "x86_64-linux";
      };
      pkgs32_22_11 = pkgs.callPackage ./nixpkgs/22_11 {
        src = nixpkgs_22_11;
        system = "i686-linux";
      };
      pkgs_22_05 = pkgs.callPackage ./nixpkgs/22_05 {
        src = nixpkgs_22_05;
        system = "x86_64-linux";
      };
      pkgs32_22_05 = pkgs.callPackage ./nixpkgs/22_05 {
        src = nixpkgs_22_05;
        system = "i686-linux";
      };
      pkgs_21_11 = pkgs.callPackage ./nixpkgs/21_11 {
        src = nixpkgs_21_11;
        system = "x86_64-linux";
      };
      pkgs32_21_11 = pkgs.callPackage ./nixpkgs/21_11 {
        src = nixpkgs_21_11;
        system = "i686-linux";
      };
      pkgs_21_05 = pkgs.callPackage ./nixpkgs/21_05 {
        src = nixpkgs_21_05;
        system = "x86_64-linux";
      };
      pkgs32_21_05 = pkgs.callPackage ./nixpkgs/21_05 {
        src = nixpkgs_21_05;
        system = "i686-linux";
      };
      pkgs_20_09 = pkgs.callPackage ./nixpkgs/20_09 {
        src = nixpkgs_20_09;
        system = "x86_64-linux";
      };
      pkgs32_20_09 = pkgs.callPackage ./nixpkgs/20_09 {
        src = nixpkgs_20_09;
        system = "i686-linux";
      };
      pkgs_20_03 = pkgs.callPackage ./nixpkgs/20_03 {
        src = nixpkgs_20_03;
        system = "x86_64-linux";
      };
      pkgs32_20_03 = pkgs.callPackage ./nixpkgs/20_03 {
        src = nixpkgs_20_03;
        system = "i686-linux";
      };
      pkgs_19_09 = pkgs.callPackage ./nixpkgs/19_09 {
        src = nixpkgs_19_09;
        system = "x86_64-linux";
      };
      pkgs32_19_09 = pkgs.callPackage ./nixpkgs/19_09 {
        src = nixpkgs_19_09;
        system = "i686-linux";
      };
      pkgs_19_03 = pkgs.callPackage ./nixpkgs/19_03 {
        src = nixpkgs_19_03;
        system = "x86_64-linux";
      };
      pkgs32_19_03 = pkgs.callPackage ./nixpkgs/19_03 {
        src = nixpkgs_19_03;
        system = "i686-linux";
      };
      pkgs_18_09 = pkgs.callPackage ./nixpkgs/18_09 {
        src = nixpkgs_18_09;
        system = "x86_64-linux";
      };
      pkgs32_18_09 = pkgs.callPackage ./nixpkgs/18_09 {
        src = nixpkgs_18_09;
        system = "i686-linux";
      };
      pkgs_18_03 = pkgs.callPackage ./nixpkgs/18_03 {
        src = nixpkgs_18_03;
        system = "x86_64-linux";
      };
      pkgs32_18_03 = pkgs.callPackage ./nixpkgs/18_03 {
        src = nixpkgs_18_03;
        system = "i686-linux";
      };
      pkgs_17_09 = pkgs.callPackage ./nixpkgs/17_09 {
        src = nixpkgs_17_09;
        system = "x86_64-linux";
      };
      pkgs32_17_09 = pkgs.callPackage ./nixpkgs/17_09 {
        src = nixpkgs_17_09;
        system = "i686-linux";
      };
      pkgs_17_03 = pkgs.callPackage ./nixpkgs/17_03 {
        src = nixpkgs_17_03;
        system = "x86_64-linux";
      };
      pkgs32_17_03 = pkgs.callPackage ./nixpkgs/17_03 {
        src = nixpkgs_17_03;
        system = "i686-linux";
      };
      pkgs_16_09 = pkgs.callPackage ./nixpkgs/16_09 {
        src = nixpkgs_16_09;
        system = "x86_64-linux";
      };
      pkgs32_16_09 = pkgs.callPackage ./nixpkgs/16_09 {
        src = nixpkgs_16_09;
        system = "i686-linux";
      };
      pkgs_16_03 = pkgs.callPackage ./nixpkgs/16_03 {
        src = nixpkgs_16_03;
        system = "x86_64-linux";
      };
      pkgs32_16_03 = pkgs.callPackage ./nixpkgs/16_03 {
        src = nixpkgs_16_03;
        system = "i686-linux";
      };
      pkgs_15_09 = pkgs.callPackage ./nixpkgs/15_09 {
        src = nixpkgs_15_09;
        system = "x86_64-linux";
      };
      pkgs32_15_09 = pkgs.callPackage ./nixpkgs/15_09 {
        src = nixpkgs_15_09;
        system = "i686-linux";
      };
      pkgs_last_glibc_2_13 = pkgs.callPackage ./nixpkgs/last_glibc_2_13 {
        src = nixpkgs_last_glibc_2_13;
        system = "x86_64-linux";
      };
      pkgs32_last_glibc_2_13 = pkgs.callPackage ./nixpkgs/last_glibc_2_13 {
        src = nixpkgs_last_glibc_2_13;
        system = "i686-linux";
      };
      pkgs_0_14 = pkgs.callPackage ./nixpkgs/0_14 {
        src = nixpkgs_0_14;
        system = "x86_64-linux";
      };
      pkgs32_0_14 = pkgs.callPackage ./nixpkgs/0_14 {
        src = nixpkgs_0_14;
        system = "i686-linux";
      };
      pkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd =
        pkgs.callPackage ./nixpkgs/2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd
          {
            src = nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd;
            system = "x86_64-linux";
          };
      pkgs32_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd =
        pkgs.callPackage ./nixpkgs/2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd
          {
            src = nixpkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd;
            system = "i686-linux";
          };
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

        ghc_6_2_2 = pkgs32.callPackage ./ghc/6_2_2 {
          perl = pkgs32_last_glibc_2_13.perl58;
          gcc = pkgs32_last_glibc_2_13.gcc34;
          ghc = pkgs32.callPackage ./ghc/6_2_2/binary.nix {
            perl = pkgs32_last_glibc_2_13.perl58;
            readline = pkgs32_last_glibc_2_13.readline4;
          };
        };

        ghc_6_4_2 = pkgs.callPackage ./ghc/6_4_2 {
          perl = pkgs_last_glibc_2_13.perl58;
          gcc = pkgs_20_03.wrapCCWith {
            cc = pkgs_17_09.gcc.cc;
            bintools = pkgs_20_03.wrapBintoolsWith {
              bintools = pkgs.binutils.bintools;
              libc = pkgs.libc;
            };
          };
          ghc = pkgs.callPackage ./ghc/6_4_2/binary.nix {
            perl = pkgs_last_glibc_2_13.perl58;
            gmp = pkgs_24_11.gmp4;
            readline = pkgs_21_11.readline5;
          };
        };

        ghc_6_6_1 = pkgs.callPackage ./ghc/6_6_1 {
          perl = pkgs_last_glibc_2_13.perl58;
          gcc = pkgs_20_03.wrapCCWith {
            cc = pkgs_last_glibc_2_13.gcc.gcc;
            bintools = pkgs_20_03.wrapBintoolsWith {
              bintools = pkgs_2ad6c9c6c215d48bd1524e8f281ede8bfea1e2dd.binutils_release;
              libc = pkgs_15_09.glibc;
            };
          };
          ghc = pkgs.callPackage ./ghc/6_6_1/binary.nix {
            perl = pkgs_last_glibc_2_13.perl58;
            gmp = pkgs_24_11.gmp4;
            readline = pkgs_21_11.readline5;
          };
          gmp = pkgs_23_05.gmp;
        };

        ghc_6_8_3 = pkgs.callPackage ./ghc/6_8_3 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc/6_8_3/binary.nix {
            gmp = pkgs_24_11.gmp4;
            readline = pkgs_21_11.readline5;
          };
          gmp = pkgs_23_05.gmp;
        };

        ghc_6_10_4 = pkgs.callPackage ./ghc/6_10_4 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc/6_10_4/binary.nix { gmp = pkgs_24_11.gmp4; };
          gmp = pkgs_23_05.gmp;
          ncurses = pkgs_21_05.ncurses;
        };

        ghc_6_12_3 = pkgs.callPackage ./ghc/6_12_3 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc/6_12_3/binary.nix {
            gcc = pkgs_25_05.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_23_05.gmp;
          ncurses = pkgs_21_05.ncurses;
        };

        ghc_7_0_4 = pkgs.callPackage ./ghc/7_0_4 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc/7_0_4/binary.nix {
            gcc = pkgs_20_03.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_23_05.gmp;
          ncurses = pkgs_21_05.ncurses;
        };

        ghc_7_2_2 = pkgs.callPackage ./ghc/7_2_2 {
          gcc = pkgs_18_03.gcc;
          ghc = pkgs.callPackage ./ghc/7_2_2/binary.nix {
            gcc = pkgs_20_03.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_23_05.gmp;
          ncurses = pkgs_21_05.ncurses;
        };

        ghc_7_4_2 = pkgs.callPackage ./ghc/7_4_2 {
          gcc = pkgs_24_11.gcc;
          ghc = pkgs.callPackage ./ghc/7_4_2/binary.nix {
            gcc = pkgs_25_05.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_24_11.gmp4;
          ncurses = pkgs_25_11.ncurses5;
        };

        ghc_7_6_3 = pkgs.callPackage ./ghc/7_6_3 {
          gcc = pkgs_24_11.gcc;
          ghc = pkgs.callPackage ./ghc/7_6_3/binary.nix {
            gcc = pkgs_25_05.gcc;
            gmp = pkgs_24_11.gmp4;
          };
          gmp = pkgs_24_11.gmp4;
          ncurses = pkgs_25_11.ncurses;
        };

        ghc_7_8_4 = pkgs.callPackage ./ghc/7_8_4 {
          gcc = pkgs_24_11.gcc;
          ghc = pkgs.callPackage ./ghc/7_8_4/binary.nix { gcc = pkgs_25_05.gcc; };
          ncurses = pkgs_25_11.ncurses;
        };

        ghc_7_10_3 = pkgs.callPackage ./ghc/7_10_3 {
          gcc = pkgs_24_11.gcc;
          ghc = pkgs.callPackage ./ghc/7_10_3 {
            gcc = pkgs_24_11.gcc;
            ghc = pkgs.callPackage ./ghc/7_10_3/binary.nix { gcc = pkgs_21_11.gcc; };
            gmp = pkgs_23_05.gmp;
            ncurses = pkgs_25_11.ncurses;
          };
          ncurses = pkgs_25_11.ncurses;
        };

        ghc_8_0_2 = pkgs.callPackage ./ghc/8_0_2 {
          gcc = pkgs.gcc13;
          ghc = pkgs.callPackage ./ghc/8_0_2/binary.nix { };
        };

        ghc_8_2_2 = pkgs.callPackage ./ghc/8_2_2 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/8_2_2/binary.nix { };
        };

        ghc_8_4_4 = pkgs.callPackage ./ghc/8_4_4 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/8_4_4/binary.nix { };
        };

        ghc_8_6_5 = pkgs.callPackage ./ghc/8_6_5 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/8_6_5/binary.nix { };
        };

        ghc_8_8_4 = pkgs.callPackage ./ghc/8_8_4 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/8_8_4/binary.nix { };
        };

        ghc_8_10_7 = pkgs.callPackage ./ghc/8_10_7 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/8_10_7/binary.nix { };
        };

        ghc_9_0_2 = pkgs.callPackage ./ghc/9_0_2 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/9_0_2/binary.nix { };
        };

        ghc_9_2_8 = pkgs.callPackage ./ghc/9_2_8 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/9_2_8/binary.nix { };
        };

        ghc_9_4_8 = pkgs.callPackage ./ghc/9_4_8 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/9_4_8/binary.nix { };
        };

        ghc_9_6_7 = pkgs.callPackage ./ghc/9_6_7 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/9_6_7/binary.nix { };
        };

        ghc_9_8_4 = pkgs.callPackage ./ghc/9_8_4 {
          gcc = pkgs.gcc14;
          ghc = pkgs.callPackage ./ghc/9_8_4/binary.nix { };
        };

        ghc_9_10_3 = pkgs.callPackage ./ghc/9_10_3 { ghc = pkgs.callPackage ./ghc/9_10_3/binary.nix { }; };

        ghc_9_12_3 = pkgs.callPackage ./ghc/9_12_3 { ghc = pkgs.callPackage ./ghc/9_12_3/binary.nix { }; };
      };
    };
}
