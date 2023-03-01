local Utils = {}

function Utils.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function Utils.nmap(shortcut, command)
  Utils.map('n', shortcut, command)
end

function Utils.imap(shortcut, command)
  Utils.map('i', shortcut, command)
end

function Utils.vmap(shortcut, command)
  Utils.map('v', shortcut, command)
end

function Utils.cmap(shortcut, command)
  Utils.map('c', shortcut, command)
end

function Utils.tmap(shortcut, command)
  Utils.map('t', shortcut, command)
end

return Utils
