{
  description = "Christina's NeoVim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:cdo256/nixvim?ref=fix-cornelis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    blink-cmp = {
      url = "github:saghen/blink.cmp";
    };
  };

  outputs =
    {
      nixvim,
      flake-parts,
      pre-commit-hooks,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      #debug = true;

      perSystem =
        {
          system,
          pkgs,
          self',
          ...
        }:
        let
          nixvim' = nixvim.legacyPackages.${system};
          nvimConfig = {
            inherit pkgs;
            module = ./config;
            extraSpecialArgs = {
              inherit inputs system;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nvimConfig;
        in
        {
          #debugAttrs = {
          #  inherit nvim nixvim' nvimConfig;
          #};
          checks = {
            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                statix.enable = true;
                nixfmt-rfc-style.enable = true;
                deadnix = {
                  enable = true;
                  settings = {
                    edit = true;
                  };
                };
              };
            };
          };

          formatter = pkgs.nixfmt-rfc-style;

          packages.default = nvim;

          devShells = {
            default = with pkgs; mkShell { inherit (self'.checks.pre-commit-check) shellHook; };
          };
        };
    };
}
