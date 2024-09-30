{ pkgs, ...}:
{
#home.stateVersion = "23.11";
  programs = {
    konsole = {
      enable = true;
      customColorSchemes."ownBreath" = ./ownBreath.colorscheme;
      defaultProfile = "ownProfile";
      profiles."ownProfile" = {
        colorScheme = "ownBreath";
	command = "${pkgs.zsh}/bin/zsh";
      };
    };
  };

}
