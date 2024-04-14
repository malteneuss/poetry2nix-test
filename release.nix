let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
  poetry2nix = pkgs.callPackage sources.poetry2nix { };
  mypoetry2nix = poetry2nix.overrideScope (self: super: {

    # pyself & pysuper refers to python packages
    defaultPoetryOverrides = super.defaultPoetryOverrides.extend (pyself: pysuper: {
      
    });

  });

  python-app = pkgs.callPackage ./default.nix { poetry2nix= mypoetry2nix; };
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
