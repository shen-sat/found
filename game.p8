pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
  error_messages = {}

  built_pieces = {}
 
  pointer = {
   x = 0,
   y = 0,
   piece,
   update = function(self, menu_mode)
    if menu_mode then return end
    self:move()
    if btnp(5) then
      if not self.piece then return end
      self.piece:activate(self,built_pieces)
    end
   end,
   move = function(self)
     if btnp(1) then 
       self.x = min(self.x + 8,120)
     elseif btnp(0) then
       self.x = max(self.x - 8,0)
     elseif btnp(2) then
       self.y = max(self.y - 8,0)
     elseif btnp(3) then
       self.y = min(self.y + 8,120)
     end
   end
  }

  #include pieces.lua
  #include build_bar.lua
  #include top_text.lua
end

function _update()
  if #error_messages > 0 then return end
  menu_mode = btn(4) and true or false
  top_text:update()
  pointer:update(menu_mode)
  build_bar:update(menu_mode, pointer)
end

function _draw()
  cls()
  if #error_messages > 0 then
    print_error_lines(error_messages)
    return 
  end
  rect(0,0,127,127,5) --border
  build_bar:draw(menu_mode)
  spr(0,pointer.x,pointer.y)
  local pointer_type_sprite
  spr(pointer,x,y,w,h,flip_x,flip_y)
  print_lines(top_text.lines)
  for p in all(built_pieces) do
   spr(p.sprite,p.x,p.y)
  end
  if pointer.piece then spr(pointer.piece.sprite,pointer.x,pointer.y) end
end

function calculate_x1(x0, width)
  return x0 + width - 1
end

function calculate_y1(y0, height)
  return y0 + height - 1
end

function copy_table(table)
  new_table = {}
  for k,v in pairs(table) do
   new_table[k] = v
  end

  return new_table
end

function build_piece(piece,pointer,built_pieces)
  local piece = copy_piece(piece,pointer)
  for bp in all(built_pieces) do
    if do_pieces_match(bp, piece, true) then return end
    if do_pieces_match(bp, piece, false) then del(built_pieces,bp) end
  end
  add(built_pieces, piece)
end

function do_pieces_match(piece1, piece2, check_sprite)
  if check_sprite then
    return (piece1.x == piece2.x and piece1.y == piece2.y and piece1.sprite == piece2.sprite)
  else
    return (piece1.x == piece2.x and piece1.y == piece2.y)
  end
end

function copy_piece(piece,pointer)
  local piece_copy = copy_table(piece)
  piece_copy.x = pointer.x
  piece_copy.y = pointer.y

  return piece_copy
end

function convert_text_into_lines(text)
  local words = convert_text_into_words(text)
  local line_length = 0
  local lines = {}
  local line = ''
  for word in all(words) do
    local word_length = word_length_pixels(word)

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
end

function convert_text_into_words(text)
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
end

function word_length_pixels(word)
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

function print_error_lines(error_messages)
  all_error_lines = {}
  for message in all(error_messages) do
    local error_lines = convert_text_into_lines(message)
    for error_line in all(error_lines) do
      add(all_error_lines,error_line)
    end
  end

  print_lines(all_error_lines)
end

function print_lines(lines)
  for line in all(lines) do
    if line == lines[1] then
      print(line,1,1,7)
    else
      print(line)
    end
  end
end

__gfx__
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
