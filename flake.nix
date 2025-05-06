{
  description = "rpatool flake or smth";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      stdenv = pkgs.stdenv;
    in
    {
      packages.x86_64-linux.default = self.packages.x86_64-linux.rpatool;
      packages.x86_64-linux.rpatool = stdenv.mkDerivation {
        name = "rpatool";
        src = self;
        buildInputs = with pkgs; [ python3 ];
        installPhase = ''
            mkdir -p $out/bin
            cp rpatool $out/bin
          '';
      };
    };
}
