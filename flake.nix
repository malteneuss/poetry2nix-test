{
  description = "Python application packaged using poetry2nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.poetry2nix.url = "github:nix-community/poetry2nix";

  outputs = { self, nixpkgs, poetry2nix }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # create a custom "mkPoetryApplication" function that uses
      # the packages from our nixpkgs input:
      inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication;
      myapp = mkPoetryApplication { projectDir = self; };
    in
    {
      apps.${system}.default = {
        type = "app";
        # replace <script> with the name in [tool.poetry.scripts] in pyproject.toml
        program = "${myapp}/bin/<script>";
      };
    };
}