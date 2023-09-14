local fluid_to_inline = function()
  print("Convert Fluid to Inline")
end

return {
  vim.api.nvim_create_user_command("FluidInline", function()
    fluid_to_inline()
  end, {}),
}
