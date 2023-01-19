-- make Mason work on corp proxy https://github.com/williamboman/mason.nvim/issues/828#issuecomment-1374424686
require("mason").setup {
    providers = { "mason.providers.client", "mason.providers.registry-api", }
}
