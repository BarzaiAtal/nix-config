# User config stuff
{ config, lib, pkgs, ...}:
{
  # home-manager inception
  programs.home-manager.enable = true;

  # User details
  home.username = "dustin";
  home.homeDirectory = "/home/dustin";

  #ZSH config
  programs.zsh = {
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;
  # OH-My-ZSH
  oh-my-zsh = {
    enable = true; # Turn it on
    plugins = [ "colored-man-pages" ];
    theme = "gnzh";
    };
  shellAliases = {
    vim="nvim";
    };
  };

  # NeoVim config
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [ youcompleteme nerdtree vim-rainbow vim-gitgutter auto-pairs ];
    extraConfig = 
    ''
      set tabstop=4
      set shiftwidth=4
      set number
    '';
  };

  # User application installs
  # Allow proprietary/non-FOSS packages
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
  bitwarden
  element-desktop
  signal-desktop
  alacritty
  vimPlugins.vim-plug
  nextcloud-client
  calibre
  ];
}
