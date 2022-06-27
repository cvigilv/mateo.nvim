-- Configuration {{{
require('fidget').setup(
  {
    text = {
      spinner = { "◐", "◓", "◑", "◒" },
      done = "●",
      commenced = "Started",
      completed = "Done!",
    },
    timer = {
      spinner_rate = 50,
      fidget_decay = 1000,
      task_decay = 10000,
    },
    window = {
      relative = "win",
      blend = 0,
      zindex = nil,
    },
  })
-- }}}
