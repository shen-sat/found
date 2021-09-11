pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
  pointer = {
   x = 0,
   y = 0
  }

  road = {
    sprite = 1,
    width = 8 
  }

  hut = {
    sprite = 2,
    width = 8
  }

  bin = {
    sprite = 3,
    width = 8
  }

  query = {
    sprite = 4,
    width = 8
  }

  #include build_bar.lua
end

function _update()
  if btnp(1) then 
    pointer.x = min(pointer.x + 8,120)
  elseif btnp(0) then
    -- if pointer.x + 8 > 127 then return end
    -- pointer.x -= 8
    pointer.x = max(pointer.x - 8,0)
  elseif btnp(2) then
    pointer.y = max(pointer.y - 8,0)
  elseif btnp(3) then
    pointer.y = min(pointer.y + 8,120)
  end
end

function _draw()
  cls()
  
  -- rect(x0,y0,x1,y1,col)
  -- game.draw()

  -- draw sprites
  -- spr()

  --controls (goes from 0-5)
  -- if btn(0) then do_something() end

  rect(0,0,127,127,5) --border
  
  
  if btn(4) then build_bar:draw() end
  spr(0,pointer.x,pointer.y)
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

-- function show_menu()
--   game.update = menu_update
--   game.draw = menu_draw
-- end

-- function menu_update()
--   include trigger to run next thing eg run_level_one()
-- end

-- function menu_draw()
-- end

__gfx__
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
