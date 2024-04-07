{ lib, poetry2nix, python311 }:
poetry2nix.mkPoetryApplication {
  projectDir = ./.;
  src = lib.cleanSource ./.;
  python = python311;
  preferWheel = true;

  #buildInputs = [ pkgs.python38Packages.requests ];
}
 