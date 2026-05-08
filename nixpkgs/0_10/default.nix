{
  src,
  system,
  applyPatches,
  fetchpatch,
}:

import "${
  applyPatches {
    name = "nixpkgs";
    src = src;
    patches = [
      (fetchpatch {
        url = "https://github.com/NixOS/nixpkgs/commit/a579a5503b7091683a8c297bc0f4d09c67fda26d.patch";
        hash = "sha256-gPqflyrg1zOlfJfCG7T+M7dsTN0qlhiiIO1tp+1nIbI=";
      })
    ];
  }
}/pkgs/top-level/all-packages.nix" { system = system; }
