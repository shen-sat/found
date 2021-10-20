pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
  road = {
    type = 'road',
    sprite = 1,
    width = 8 
  }

  hut = {
    type = 'hut',
    sprite = 2,
    width = 8
  }

  bin = {
    type = 'bin',
    sprite = 3,
    width = 8
  }

  query = {
    type = 'query',
    sprite = 4,
    width = 8
  }

  pieces = { road, hut, bin, query }

  built_pieces = {}

  pointer = {
   x = 0,
   y = 0,
   piece,
   update = function(self, menu_mode)
    if menu_mode then return end
    self:move()
    if btnp(5) then
      self:build_piece()
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
   end,
   build_piece = function(self)
     if not self.piece then return end
     local piece = {
       x = self.x,
       y = self.y,
       sprite = pointer.piece.sprite
     }
     for bp in all(built_pieces) do
       if self.do_pieces_match(bp, piece, true) then return end
       if self.do_pieces_match(bp, piece, false) then del(built_pieces,bp) end
     end
     add(built_pieces, piece)
   end,
   do_pieces_match = function(piece1, piece2, check_sprite)
     if check_sprite then
       return (piece1.x == piece2.x and piece1.y == piece2.y and piece1.sprite == piece2.sprite)
     else
       return (piece1.x == piece2.x and piece1.y == piece2.y)
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
  for v in all(table) do
   add(new_table,v)
  end

  return new_table
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
