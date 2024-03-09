return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Server
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "rshkarin/mason-nvim-lint",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",

    -- Tools
    "stevearc/conform.nvim",
    "mfussenegger/nvim-lint",

    -- Completion
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-omni",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
      },
    },
    -- UI
    "j-hui/fidget.nvim",
  },
  config = function()
    -- Completion engine
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    cmp.setup({
      snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
      completion = { completeopt = "menu,menuone,noinsert" },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-j>"] = cmp.mapping.select_prev_item(),
        ["<C-k>"] = cmp.mapping.select_next_item(),
        ["<C-P>"] = cmp.mapping.scroll_docs(-4),
        ["<C-N>"] = cmp.mapping.scroll_docs(4),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      },
    })

    -- LSP
    --- Setup LSP behavior on LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        -- Keymaps
        --- Helper function for LSP-related keymaps
        ---@param keys string
        ---@param func function
        ---@param desc string
        local map = function(keys, func, desc)
          vim.keymap.set(
            "n",
            keys,
            func,
            { buffer = event.buf, desc = "⚒ : " .. desc, noremap = true, silent = true }
          )
        end

        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gr", vim.lsp.buf.references, "Go to references")
        map("gI", vim.lsp.buf.implementation, "Go to implementations")
        map(
          "<leader>la",
          function()
            vim.lsp.buf.code_action({
              context = { only = { "quickfix", "refactor", "source" } },
            })
          end,
          "Code action"
        )
        map("<leader>lr", vim.lsp.buf.rename, "Rename")
        map("<leader>ls", vim.lsp.buf.signature_help, "Get signature help")
        map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format code")
      end,
    })

    --- Update capabilities of LSP
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities =
      vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    --- Server configurations
    local servers = {
      ["ruff_lsp"] = {},
      ["bashls"] = {},
      ["lua-language-server"] = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
              },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      ["julia-lsp"] = {
        on_new_config = function(new_config, _)
          local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
          if require("lspconfig").util.path.is_file(julia) then new_config.cmd[1] = julia end
        end,
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("Project.toml")(fname)
            or util.find_git_ancestor(fname)
            or util.path.dirname(fname)
        end,
      },
    }

    --- Generate list of servers or tools to have installed
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- Language-Servers
      "marksman",

      -- Formatters
      "stylua",
      "jq",
      "shfmt",
      "bibtex-tidy",

      -- Linters
      "shellcheck",
      "luacheck",
      "proselint",
    })

    --- Setup up everything!
    require("neodev").setup()
    require("mason").setup({ ui = { border = vim.g.defaults.border.normal } })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          require("lspconfig")[server_name].setup({
            cmd = server.cmd,
            settings = server.settings,
            filetypes = server.filetypes,
            capabilities = vim.tbl_deep_extend(
              "force",
              {},
              capabilities,
              server.capabilities or {}
            ),
          })
          require("lspconfig.ui.windows").default_options.border =
            vim.g.defaults.border.floating
        end,
      },
    })

    -- Formatters
    require("conform").setup({
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
        lua = { "stylua" },
        json = { "jq" },
        bib = { "bibtex-tidy" },
        sh = { "shfmt" },
      },
    })

    -- Linters
    local lint = require("lint")
    lint.linters_by_ft = {
      shell = { "shellcheck" },
      -- lua = { "luacheck" },
      markdown = { "proselint" },
    }
    require("mason-nvim-lint").setup()

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      pattern = "*",
      callback = function() require("lint").try_lint() end,
    })

    -- UI
    require("fidget").setup({
      tag = "v1.4.x",
      config = function()
        require("fidget").setup({
          progress = {
            display = {
              progress_icon = { pattern = "circle_halves", period = 1 },
              done_icon = "⏺ ",
            },
          },
        })
      end,
    })

    --- Borders
    local border_style = vim.g.defaults.border.normal
    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = border_style })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = border_style })
    vim.diagnostic.config({
      float = { border = border_style },
    })
  end,
}
