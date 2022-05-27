{ pkgs }:

{
  # Takes a scheme, resulting wallpaper height and width, plus logo scale, and ouputs the generated wallpaper path
  # Example:
  # wallpaper = nixWallpaperFromScheme {
  #   scheme = config.colorscheme;
  #   width = 2560;
  #   height = 1080;
  #   logoScale = 5.0;
  # };
  nixWallpaperFromScheme = import ./nix-wallpaper.nix { inherit pkgs; };

  # Takes a picture path and a scheme kind ("dark" or "light"), and outputs a colorscheme based on it
  # Please note the path must be accessible by your flake on pure mode
  # Example:
  # colorscheme = colorschemFromPicture {
  #   path = ./my/cool/wallpaper.png;
  #   kind = "dark";
  # };
  colorschemeFromPicture = import ./from-picture.nix { inherit pkgs; };

  # Takes a scheme, outputs a generated materia GTK theme
  # Example:
  # gtk.theme.package = gtkThemeFromScheme {
  #   scheme = config.colorscheme;
  # };
  gtkThemeFromScheme = import ./gtk-theme.nix { inherit pkgs; };

  # Takes a scheme, outputs a vim theme package.
  #
  # The output theme name will be "nix-" followed by the coloscheme's slug, and
  # should be set, for example, by adding to your vim config:
  # "colorscheme nix-${config.colorscheme.slug}"
  #
  # Example:
  # programs.vim.plugins = [
  #   {
  #     plugin = vimThemeFromScheme { scheme = config.colorscheme; };
  #     config = "colorscheme ${config.colorscheme.slug}";
  #   }
  # ];
  vimThemeFromScheme = import ./vim-theme.nix { inherit pkgs; };

  # Map a scheme to attrs of named ANSI colors.
  #
  # Base16 color values always map directly and unequivocally to the same named
  # colors regardless of the color's actual value. The mapping is not
  # customisable via the module system because the mapping never changes. This
  # function only reshapes the input values into the expected names.
  #
  # In a dark-background color scheme, named colors should correspond pretty
  # closely to their appearance, though the degree to which that's true can
  # vary. If the values in a dark-background color scheme seem widly misaligned with
  # their name mapping (e.g. if 'red' is obviously blue and 'blue' is obviously
  # red), there may be a problem with the template or even the scheme's design.
  #
  # But, very importantly: light-background color schemes will map base16 values
  # to named colors *in the opposite direction*. For example: `normal.black`
  # will have a value of `ffffff`, and `bright.white` will have a value of
  # `000000`. The mapping may seem logically wrong, but so it goes with anything
  # involving shell behavior.
  #
  # Example:
  #   namedColorsFromScheme config.colorscheme.colors
  #   => {
  #     normal = {
  #       black = "000000";
  #       red = "a60000";
  #       ...
  #     };
  #     bright = {
  #       black = "595959";
  #       red = "972500";
  #       ...
  #     };
  #   }
  namedColorsFromScheme = import ./named-colors-from-scheme;
}
