pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
  built_pieces = {}
  
  road = {
    type = 'road',
    sprite = 1,
    width = 8,
    x,
    y,
    activate = build_piece
  }

  hut = {
    type = 'hut',
    sprite = 2,
    width = 8,
    x,
    y,
    activate = build_piece
  }

  bin = {
    type = 'bin',
    sprite = 3,
    width = 8,
    x,
    y,
    activate = function(self,pointer,built_pieces)
      local local_bin = copy_piece(self,pointer)
      for bp in all(built_pieces) do
        if do_pieces_match(bp, local_bin, false) then del(built_pieces,bp) end
      end
    end
  }

  query = {
    type = 'query',
    sprite = 4,
    width = 8
  }

  pieces = { road, hut, bin, query }

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

  #include build_bar.lua
end

function _update()
  menu_mode = btn(4) and true or false
  pointer:update(menu_mode)
  build_bar:update(menu_mode, pointer)
end

function _draw()
  cls()
  rect(0,0,127,127,5) --border
  build_bar:draw(menu_mode)
  spr(0,pointer.x,pointer.y)
  local pointer_type_sprite
  spr(pointer,x,y,w,h,flip_x,flip_y)
  print(#built_pieces,10,10,7)
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



__gfx__
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
