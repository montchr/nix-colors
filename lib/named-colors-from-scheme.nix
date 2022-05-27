colors:
with colors;
{
  background = base00;
  foreground = base0F;

  # ANSI color names
  # https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
  normal = {
    black = base00;
    red = base01;
    green = base02;
    yellow = base03;
    blue = base04;
    magenta = base05;
    cyan = base06;
    # The ANSI name "white" is confusing. True white is considered a "bright" color.
    white = base07;
  };

  bright = {
    # Sometimes known as "grey".
    black = base08;
    red = base09;
    green = base0A;
    yellow = base0B;
    blue = base0C;
    magenta = base0D;
    cyan = base0E;
    # This is actually white
    white = base0F;
  };
}
