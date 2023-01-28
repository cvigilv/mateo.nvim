require('orgmode').setup_ts_grammar()
require('orgmode').setup(
  {
    org_agenda_files = {
      '/home/carlos/zk/inbox/agenda.org',
      '/home/carlos/zk/inbox/recurrent.org',
      '/home/carlos/zk/inbox/birthdays.org',
    },
    org_agenda_templates = {
      i = {
        description = "Ideas",
        template = "* %?\n  %u",
        target = "~/zk/inbox/ideas.org",
      },
      c = {
        description = "Code",
        template = "* %?\n  %u\n  %a",
        target = "~/zk/inbox/code.org",
      },
      T = {
        description = "Scheduled task",
        template = "* TODO %?\n  DEADLINE: %t",
        target = "~/zk/inbox/agenda.org",
      },
      t = {
        description = "Task",
        template = "* TODO %?",
        target = "~/zk/inbox/agenda.org",
      },
    },
    org_todo_keywords = { "TODO", "DOING", "DONE", "WAITING", "DELEGATED", "CANCELED" },
    notifications = { enabled = true },
    org_agenda_span = "month",
    org_tags_column = 0,
    org_hide_emphasis_markers = true,
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,
    org_blank_before_new_entry = { heading = false, plain_list_item = false },
    org_hide_leading_stars = true,
    win_split_mode = 'auto',
    -- org_todo_keyword_faces = {
    --   TODO = "",
    --   DOING = "",
    --   DONE = "",
    --   WAITING = "",
    --   DELEGATED = "",
    --   CANCELED = ""
    -- }
  }
)
