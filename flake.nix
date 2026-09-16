{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";

    nix-firefox-addons.url = "github:osipog/nix-firefox-addons";

    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-doom-emacs-unstraightened,
      flake-utils,
      treefmt-nix,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = pkgs.lib;
        config = { };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        # Your custom packages and modifications, exported as overlays
        overlays = import ./overlays { inherit inputs; };

        # Your custom packages
        # Accessible through 'nix build', 'nix shell', etc
        packages = import ./pkgs pkgs;

        # Formatter for your nix files, available through 'nix fmt'
        # Other options beside 'alejandra' include 'nixpkgs-fmt'
        formatter.${system} = treefmtEval.config.build.wrapper;

        # Reusable nixos modules you might want to export
        # These are usually stuff you would upstream into nixpkgs
        nixosModules = import ./modules/nixos;
        # Reusable home-manager modules you might want to export
        # These are usually stuff you would upstream into home-manager
        homeManagerModules = import ./modules/home-manager;

        # NixOS configuration entrypoint
        # Available through 'nixos-rebuild --flake .#your-hostname'
        nixosConfigurations = {
          rivendell = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              # > Our main nixos configuration file <
              ./nixos/configuration.nix
              home-manager.nixosModules.home-manager
            ];
          };
        };

        # NixOS integration tests and flake checks
        checks.${system} = import ./checks {
          inherit
            self
            config
            lib
            pkgs
            inputs
            treefmtEval
            ;
        };
      }
    );
}
