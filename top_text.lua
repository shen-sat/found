top_text = {
  lines = {},
  update = function(self)
    if not btn(5) then self.lines = {} end
  end,
  assign = function(self, text)
    self.lines = self:convert_text_into_lines(text)
  end,
  convert_text_into_lines = function(self,text)
    local words = self.convert_text_into_words(text)
    local line_length = 0
    local lines = {}
    local line = ''
    for word in all(words) do
      local word_length = self.word_length_pixels(word)

      if line_length + word_length < 126 then
        line_length += word_length
      else
        add(lines,line)
        line = ''
        line_length = word_length
      end
      line = line..word
    end
    add(lines,line)
    return lines
  end,
  convert_text_into_words = function(text)
    local words = split(text,' ')
    local transformed_words = {}
    for word in all(words) do
      local letters = split(word,'')

      if letters[#letters] == '.' then
        add(transformed_words,word)
      else
        local word_with_space = word..' '
        add(transformed_words,word_with_space)
      end
    end
    return transformed_words
  end,
  word_length_pixels = function(word)
    local letters = split(word,'')
    local pixels = 0
    for letter in all(letters) do
      if ord(letter) < 128 then
        pixels += 4
      else
        pixels += 8
      end
    end
    return pixels
  end
}