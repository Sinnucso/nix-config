{config, pkgs, ... }:

{
  imports = [
  ./konsole/konsole.nix
  ];
 
  programs = {
    plasma = {
      enable = true;
      workspace = {
        colorScheme = "BreezeDark";    #window borders and navbars etc. plasma-apply-colorscheme --list-schemes
        cursor.theme = "Breeze";
        lookAndFeel = "org.kde.breezedark.desktop"; #"global Theme", also sets colorscheme  plasma-apply-cursortheme --list-themes
	theme = "default";	  #taskbar, start menu, overall theme  plasma-apply-lookandfeel --list
      };
      configFile = {
        "kdeglobals"."General"."AccentColor" = "0,211,184";
        "kdeglobals"."General"."LastUsedCustomAccentColor" = "0,211,184";
      };
    };
  };
}


#if i add another gui other then kde, i could use special args in flake.nix to determine which gui im using and check if that variable says "kde", and only then apply the settings. like Librephoenix did it: 
#   https://www.youtube.com/watch?v=H_Qct7TVB6o
