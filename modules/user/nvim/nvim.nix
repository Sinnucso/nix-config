{config, pkgs, ... }:
{
  imports = [
  ];

  programs.git = {
    enable = true;
    userName = "Sinnucso";
    userEmail = "Sinnucso@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
