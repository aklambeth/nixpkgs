{
  description = "My custom Nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
      # Supported systems
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      # Helper to provide system-specific attributes
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system: 
        let 
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          crawl4ai = pkgs.callPackage ./tools/crawl4ai {};
          catppuccin_mocha-zsh-syntax-highlighting = pkgs.callPackage ./themes/catppuccin/zsh-syntax-highlighting.nix {};
        });
    };
}