local fluid_to_inline = function() end

return {
  vim.api.nvim_create_user_command("FluidInline", function()
    fluid_to_inline()
  end, {}),
}
