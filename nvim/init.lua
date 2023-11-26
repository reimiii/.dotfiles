require("energia.core")
vim.cmd([[
  autocmd BufRead,BufNewFile docker-compose.yaml setfiletype yaml.docker-compose
]])
require("energia.lazy")
