let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
  poetry2nix = pkgs.callPackage sources.poetry2nix { };
  python-app = pkgs.callPackage ./default.nix { inherit poetry2nix; };
  docker-hello = pkgs.dockerTools.buildLayeredImage {
    name = "myapp";
    tag = "latest";
    contents = [ pkgs.hello ];
    # contents = [ app ];
  };
in
{
  inherit (pkgs) hello;
  inherit docker-hello;
  inherit python-app;
}
