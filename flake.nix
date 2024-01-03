{
  description = "Nix recipe for Katana-MK2-FxFloorBoard";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };

        pname = "Katana-MK2-FxFloorBoard";

        fxfloorboard =
          { alsa-lib
          , bluez
          , fetchzip
          , qmake
          , qtbase
          , qtconnectivity
          , stdenv
          , wrapQtAppsHook
          , unzip
          }: stdenv.mkDerivation {
            inherit pname;
            version = "1.0";

            src = fetchzip {
              url = "https://downloads.sourceforge.net/project/fxfloorboard/KatanaFxFloorBoard/Katana%20FxFloorboard%20for%20MK2%20Desktop/Katana_Mk2_FxFloorBoard_FW2-source_code.zip";
              hash = "sha256-vTxddRIRVwV4IWhnOlZNow4VZ3Q13tKf4OCM0xspy4k=";
            };

            buildInputs = [ qtbase unzip alsa-lib bluez qtconnectivity ];
            nativeBuildInputs = [
              wrapQtAppsHook
              qmake
            ];
            qtWrapperArgs = [ ''--set HELP_ROOT ${placeholder "out"}/bin/help/help.html'' ];
            installPhase = ''
              runHook preInstall

              install -D packager/Katana-MK2-FxFloorBoard -t $out/bin/
              install -Dm644 packager/help/help.html -t $out/bin/help/
              install -Dm644 packager/help/help_files/* -t $out/bin/help/help_files

              runHook postInstall
            '';
            patches = [
              ./patches/help.patch
            ];

          };

      in
      {
        packages.${pname} = pkgs.libsForQt5.callPackage fxfloorboard { };
        packages.default = self.packages.${system}.${pname};
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}

