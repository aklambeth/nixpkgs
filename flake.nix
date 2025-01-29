{
  description = "A minimal development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        myPackage = pkgs.callPackage ./tools/crawl4ai { };
      in
      {

        packages.default = myPackage;
        devShells.default = pkgs.mkShell {
          buildInputs = [ myPackage ];

          shellHook = ''
          '';
        };
        
      });
}