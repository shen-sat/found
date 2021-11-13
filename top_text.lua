top_text = {
  lines = {},
  update = function(self)
    if not btn(5) then self.lines = {} end
  end,
  assign = function(self, text)
    self.lines = convert_text_into_lines(text)
  end
}