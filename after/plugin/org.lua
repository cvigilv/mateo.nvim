require('orgmode').setup_ts_grammar()
require('orgmode').setup(
  {
    -- Sources
    org_agenda_files = {
      '/home/carlos/zk/inbox/agenda.org',
      '/home/carlos/zk/inbox/birthdays.org',
    },

    -- Quality-of-life
    org_agenda_templates = {
      i = {
        description = 'Ideas',
        template = '* %?\n%u',
        target = '~/zk/inbox/ideas.org',
      },
      c = {
        description = 'Code',
        template = '* %?\n%u\n%a',
        target = '~/zk/inbox/code.org',
      },
      t = 'Task',
      te = {
        description = 'Event',
        template = '** [#A] %?\nSCHEDULED: %t',
        target = '~/zk/inbox/agenda.org',
        headline = 'event'
      },
      to = {
        description = 'One-time task',
        template = '** %?\nSCHEDULED: %t',
        target = '~/zk/inbox/agenda.org',
        headline = 'one-time'
      },
      tr = {
        description = 'Recurrent task',
        template = '** %?\nSCHEDULED: %t',
        target = '~/zk/inbox/agenda.org',
        headline = 'recurring'
      },
    },
    org_indent_mode = 'noindent',
    org_blank_before_new_entry = { heading = false, plain_list_item = false },
    org_hide_emphasis_markers = true,

    -- Agenda
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,
    org_agenda_span = 'month',
    org_tags_column = 0,
    win_split_mode = 'auto',
    org_todo_keywords = {
      'TODO(t)',
      'DOING(.)',
      'WAITING(w)',
      'DELEGATED(e)',
      '|',
      'DONE(d)',
      'CANCELED(x)'
    },
    org_todo_keyword_faces = {
      TODO = ':foreground #ec5f67',
      DOING = ':foreground #ECBE7B',
      DONE = ':foreground #98be65',
      WAITING = ':foreground #008080',
      DELEGATED = ':foreground #464d72',
      CANCELED = ':foreground #464d72'
    },

    -- Notifications
    notifications = { enabled = true },
  }
)

require('org-bullets').setup {
  concealcursor = false,
  symbols = {
    headlines = { '○', '◌', '◍', '◎', '●', '◐', '◑', '◒', '◓', '◔', '◕', '◖', '◗', '◙' },
  }
}

vim.cmd [[ syntax match Normal '\[#A\]' conceal cchar=Ⓐ  ]]
vim.cmd [[ syntax match Normal '\[#B\]' conceal cchar=Ⓑ  ]]
vim.cmd [[ syntax match Normal '\[#C\]' conceal cchar=Ⓒ  ]]
