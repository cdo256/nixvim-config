{
  config,
  lib,
  ...
}:
{
  plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "horizontal";
      float_opts = {
        border = "curved";
        height = 30;
        width = 130;
      };
    };
  };

  keymaps = lib.mkIf config.plugins.toggleterm.enable [
    {
      mode = [
        "n"
      ];
      key = "<leader>t";
      action = "<Cmd>execute v:count . \"ToggleTerm\"<CR>";
    }
  ];
}
