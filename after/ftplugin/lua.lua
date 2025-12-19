vim.b.minisurround_config = {
  custom_surroundings = {
    c = {
      input = { '%[%[().-()%]%]' },
      output = { left = '[[', right = ']]' },
    },
    l = {
      input = { '%[%[().-()%]%]' },
      output = { left = 'function() ', right = ' end' },
    },
  },
}
