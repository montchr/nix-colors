{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.generateColorscheme;
  generateFromPicture = picture: kind: pkgs.stdenv.mkDerivation {
    name = "generated-colorscheme";
    buildInputs = with pkgs; [ flavours ];
    dontBuild = true;
    installPhase = ''
      wallpaper_basename="$(basename "${picture}")"

      read -r -d "" template << END
      {
        slug = "generated-$wallpaper_basename";
        name = "Generated ($wallpaper_basename)";
        author = "{{scheme-author}}";
        colors = {
          base00 = "{{base00-hex}}";
          base01 = "{{base01-hex}}";
          base02 = "{{base02-hex}}";
          base03 = "{{base03-hex}}";
          base04 = "{{base04-hex}}";
          base05 = "{{base05-hex}}";
          base06 = "{{base06-hex}}";
          base07 = "{{base07-hex}}";
          base08 = "{{base08-hex}}";
          base09 = "{{base09-hex}}";
          base0A = "{{base0A-hex}}";
          base0B = "{{base0B-hex}}";
          base0C = "{{base0C-hex}}";
          base0D = "{{base0D-hex}}";
          base0E = "{{base0E-hex}}";
          base0F = "{{base0F-hex}}";
        };
      }
      END

      flavours generate "${kind}" "${import picture}" --sdout | \
      flavours build <( tee ) <( echo "$template" ) > $out/scheme.nix
    '';
  };
in {
  options.generateColorscheme = {
    picture = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = ''
        If set, generates a colorscheme using the picture from the given path.
        If using flakes, the picture must be inside a repository.

        You can control whether the generated scheme will be dark or light
        by setting `colorscheme.kind`. Falling back to dark if not set.
      '';
    };
    kind = mkOption {
      type = types.enum [ "dark" "light" ];
      default = "dark";
      description = ''
        Whether the generated scheme should be dark or light
      '';
    };
  };
  config = lib.mkIf (cfg.picture != null) {
    colorscheme = import "${generateFromPicture ../../wallpapers/cthulhu.jpg cfg.kind}/scheme.nix";
  };
}
