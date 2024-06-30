{
  description = "Idris2 + VSCodium developer environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.default = pkgs.buildEnv {
      name = "idris2-develop";
      paths = with pkgs; [
        (vscode-with-extensions.override {
          vscode = vscodium;
          vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "idris-vscode";
              publisher = "meraymond";
              version = "0.0.14";
              sha256 = "sha256-QAzjm+8Z+4TDbM5amh3UEkSmp0n8ZlRHYpUGAewIVXk=";
            }
          ];
        })
        idris2
      ];
    };
    apps.${system}.default = {
      type = "app";
      program = "${self.packages.${system}.default}/bin/codium";
    };
  };
}
