{ lib, poetry2nix, python311 }:
let
  dontCheckPython = drv: drv.overridePythonAttrs (old: { doCheck = false; });
in
poetry2nix.mkPoetryApplication
{
  projectDir = ./.;
  src = lib.cleanSource ./.;
  python = python311;
  preferWheel = true;
  overrides = poetry2nix.overrides.withDefaults (self: super: {
    torch = super.torch.overridePythonAttrs (oldAttrs: {
      doCheck = false;
    });
    numpy = super.numpy.overridePythonAttrs (oldAttrs: {
      doCheck = false;
    });
    pynacl = super.pynacl.overridePythonAttrs (oldAttrs: {
      doCheck = false;
    });

  });


  USE_CUDA = 0;

  #buildInputs = [ pkgs.python38Packages.requests ];
}
 