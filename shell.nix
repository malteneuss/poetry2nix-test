let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    config = {
      doCheck = false;
    };
  };
  python311 = pkgs.python311.overrideAttrs (oldAttrs: {
    doCheck = false;
  });
  poetry = pkgs.poetry.override {
    python3 = python311;
  };

  # po = pkgs.poetry.overrideAttrs.override {
  #   python3 = pkgs.python39;
  # };
in
pkgs.mkShell {
  buildInputs = [
    python311
    poetry
  ];
}
