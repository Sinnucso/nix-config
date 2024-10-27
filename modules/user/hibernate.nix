{config, pkgs, ... }:
{
  imports = [
  ];

  programs.plasma.powerdevil = {
    AC = {
      autoSuspend.action = "nothing";
      autoSuspend.idleTimeout = null;
      dimDisplay.enable = false;
      dimDisplay.idleTimeout = null;
      displayBrightness = null;
      inhibitLidActionWhenExternalMonitorConnected = null;
      powerButtonAction = "showLogoutScreen";
      powerProfile = "performance";
      turnOffDisplay.idleTimeout = "never";
      turnOffDisplay.idleTimeoutWhenLocked = null;
      whenLaptopLidClosed = "sleep";
      whenSleepingEnter = "standbyThenHibernate";
    };
    battery = {
      autoSuspend.action = "nothing";
      autoSuspend.idleTimeout = null;
      dimDisplay.enable = true;
      dimDisplay.idleTimeout = 120;
      displayBrightness = null;
      inhibitLidActionWhenExternalMonitorConnected = null;
      powerButtonAction = "showLogoutScreen";
      powerProfile = "balanced";
      turnOffDisplay.idleTimeout = 900;
      turnOffDisplay.idleTimeoutWhenLocked = null;
      whenLaptopLidClosed = "sleep";
      whenSleepingEnter = "standbyThenHibernate";
    };
    lowBattery = {
      autoSuspend.action = "nothing";
      autoSuspend.idleTimeout = null;
      dimDisplay.enable = true;
      dimDisplay.idleTimeout = 30;
      displayBrightness = 15;
      inhibitLidActionWhenExternalMonitorConnected = null;
      powerButtonAction = "showLogoutScreen";
      powerProfile = "powerSaving";
      turnOffDisplay.idleTimeout = 120;
      turnOffDisplay.idleTimeoutWhenLocked = "immediately";
      whenLaptopLidClosed = "hibernate";
      whenSleepingEnter = null;
    };
    batteryLevels.lowLevel = 15;
    batteryLevels.criticalLevel = 3;
    batteryLevels.criticalAction = "hibernate";
    general.pausePlayersOnSuspend = false;
  };
  # also needed in configuration.nix:
  #  #needed for Suspend then Hibernate (1800 = 30 min)
  #  systemd.sleep.extraConfig =''
  #    HibernateDelaySec = 1800
  #  '';
  #
  #hibernate on nixos currently only works with a swap partition (not a swap file).


}
