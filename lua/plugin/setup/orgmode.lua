local execute = vim.api.nvim_command

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require 'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- disable = {'org'},
    additional_vim_regex_highlighting = { 'org' },
  },
  indent = {
    enable = true,
  },
  ensure_installed = { 'org' }, -- Or run :TSUpdate org
}

-- Orgmode.nvim setup
require('orgmode').setup({
  -- File location
  org_agenda_files = { '~/documents/zk/*/*' },
  org_default_notes_file = '~/documents/zk/refile.org',

  -- Mappings
  mappings = {
    global = {
      org_agenda = 'gA',
      org_capture = 'gC'
    }
  },

  -- Agenda
  org_agenda_min_height = 32,
  org_agenda_skip_scheduled_if_done = true,
  org_agenda_skip_deadline_if_done = true,
  org_src_window_setup = 'right 32new',

  -- Templates
  org_agenda_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n %u',
      target = '~/documents/zk/refile.org',
    },
    c = {
      description = 'Code',
      template = '* TODO %? :: %(return string.format("[[%s:%s:]]", vim.api.nvim_buf_get_name(0), vim.api.nvim_win_get_cursor(0)[1]))\nSCHEDULED: %t',
      target = '~/documents/zk/code.org',
    },
    m = {
      description = 'Meeting',
      template = '* Meeting :: %^{Meeting title} :: %<%Y.%m.%d>\n  %?',
      target = string.format('~/documents/zk/meetings/meeting_%s.org', os.date('%Y%m%d')),
    },
    j = {
      description = 'Journal',
      template = '** %<%Y.%m.%d>\n*** %?',
      target = string.format('~/documents/zk/journal/journal_%s.org', os.date('%Y%m%d')),
    },
    b = {
      description = 'Bibliograpy',
      template = '* %^{Author (Year)} :: %^{Title} :: %^{DOI}\n** %?',
      target = '~/documents/zk/refile.org'
    },
  }
})

-- Setup autocompletion
require 'cmp'.setup({
  sources = {
    { name = 'orgmode' }
  }
})

-- Custom capture templates

-- Custom capture prompt command
execute [[ command OrgCapturePrompt :lua require("orgmode").action("capture.prompt")<CR> ]]
