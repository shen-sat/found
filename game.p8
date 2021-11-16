pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
  error_messages = {}

  built_pieces = {}

  foobar = {}
  start_x = 0
  for var=1,16,1 do
    local start_y = 0
    for var=1,16,1 do
        local points = {start_x,start_y}
        add(foobar,points)
        start_y += 8
    end
    start_x += 8
  end
  seedling = {
    points = {},
    populate_points = function(self)
      for point in all(foobar) do
        local start_x = point[1]
        local start_y = point[2]

        local x_min = 0 + start_x
        local x_max = 5 + start_x
        local y_min = 0 + start_y
        local y_max = 6 + start_y

        local x = rnd(x_max - x_min) + x_min
        local y = rnd(y_max - y_min) + y_min

        add(self.points,{x,y})
        add(self.points,{x+1,y+1})
        add(self.points,{x+2,y})
      end
    end,
    draw = function(self)
      if #self.points < 1 then self:populate_points() end
      for point in all(self.points) do
        pset(point[1],point[2],11)
      end
    end
  }

  #include pointer.lua
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
  -- print(foobar[256][1],0,0,7)
  if #error_messages > 0 then
    print_error_lines(error_messages)
    return 
  end
  rectfill(0,0,127,127,3)
  rect(0,0,127,127,5) --border
  build_bar:draw(menu_mode)
  top_text:draw()
  for p in all(built_pieces) do
   spr(p.sprite,p.x,p.y)
  end
  pointer:draw()
  seedling:draw()

end

#include shared_functions.lua

__gfx__
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7000000700ffff00009999000088880000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
