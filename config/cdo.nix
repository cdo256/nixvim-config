{
  keymaps = [
    {
      mode = "n";
      key = "<leader>Cs";
      action.__raw = ''
        function()
          require("telescope.builtin").find_files {
            cwd = "/home/cdo/src/nix-config/";
          }
        end
      '';
      options = {
        desc = "Edit system configuration";
      };
    }
  ];
}
