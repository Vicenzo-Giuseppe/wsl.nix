{theme ? "default"}:
# Aceita um argumento `theme` com valor padrão "default"
let
  # Cores base (padrão)
  defaultColors = rec {
    red = "#f38ba8";
    yellow = "#f9e2af";
    blue = "#89b4fa";
    green = "#a6e3a1";
    specialTeal = "#00ffd0";
    purple = "#ca9ee6";
    lavender = "#";
    specialBlue = "#643FFF";
    cyan = "#8bd5ca";
    teal = cyan;
    sapphire = "#7dc4e4";
    sky = "#91d7e3";
    pink = "#f5bde6";
  };

  themes = {
    default = defaultColors; # Usa as cores base

    dark =
      defaultColors
      // {
        green = "006400"; # Verde escuro
        blue = "00008B"; # Azul escuro
        red = "8B0000"; # Vermelho escuro
        yellow = "CCCC00"; # Amarelo escuro
      };

    light =
      defaultColors
      // {
        green = "90EE90"; # Verde claro
        blue = "ADD8E6"; # Azul claro
        red = "FF6347"; # Vermelho claro (tom de coral)
        yellow = "FFD700"; # Amarelo claro (dourado)
      };

    pastel =
      defaultColors
      // {
        green = "77DD77"; # Verde pastel
        blue = "AEC6CF"; # Azul pastel
        red = "FF6961"; # Vermelho pastel
        yellow = "FDFD96"; # Amarelo pastel
      };
  };
in
  themes.${theme}
# Retorna o tema selecionado

