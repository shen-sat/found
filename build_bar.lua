  build_bar = {
   x0 = 0,
   y0 = 112,
   x1 = 127,
   y1 = 127,
   height = function(self)
    return self.y1 - self.y0 + 1
   end,
   border = 1,
   col = 4,
   btn_config = {
    height = 14,
    gap = 2,
    outer_col = 2,
    inner_col = 3,
    icon_border = 3, -- from outer edge of btn to icon edge
    inner_btn_border = 2, -- from outer edge of btn to outer inner btn edge
    width = function(self, sprite_width)
      return ((self.icon_border * 2) + sprite_width)
    end
    },
    btn_index = 0,
    sprites = pieces,
    update = function(self, menu_mode, pointer)
      self:update_btn_index(menu_mode)
      local btn_index = self.btn_index
      local chosen_icon = self.btns(self)[btn_index].icon
      if menu_mode then pointer.piece = chosen_icon end
    end,
    draw = function(self, menu_mode)
      if not menu_mode then return end
      -- draw build bar
      rectfill(self.x0,self.y0,self.x1,self.y1,self.col)
      -- draw buttons
      local btns = self.btns(self)
      for b in all(btns) do
        if b == btns[self.btn_index] then
          rectfill(b.x0,b.y0,b.x1,b.y1,7)
        else
          rectfill(b.x0,b.y0,b.x1,b.y1,build_bar.btn_config.outer_col)
        end
        rectfill(b.inner_btn.x0,b.inner_btn.y0,b.inner_btn.x1,b.inner_btn.y1,build_bar.btn_config.inner_col)
        spr(b.icon.sprite,b.icon.x,b.icon.y)
      end
    end,
    btns = function(self)
      local icons = self.sprites
      local first_icon = icons[1]
      local btns = {}
      local prev_btn

      for i in all(icons) do
        local btn
        if i == first_icon then
          btn = self.create_first_btn(self, first_icon)
        else
          btn = self.create_other_btn(self, prev_btn, i)
        end
        self.create_inner_btn(self,btn)
        self.create_icon(self,btn,i)
        add(btns,btn)
        prev_btn = btn
      end

      return btns
    end,
    create_first_btn = function(bb, i)
      local btn = {
        x0 = bb.x0 + bb.border,
        y0 = bb.y0 + bb.border
      }
      local first_btn_width = bb.btn_config:width(i.width)
      btn.x1 = calculate_x1(btn.x0, first_btn_width)
      btn.y1 = calculate_y1(btn.y0, bb.btn_config.height)

      return btn
    end,
    create_other_btn = function(bb, prev_btn, i)
      local btn = {
        x0 = prev_btn.x1 + bb.btn_config.gap + 1,
        y0 = prev_btn.y0,
        y1 = prev_btn.y1
      }
      local btn_width = bb.btn_config:width(i.width)
      btn.x1 = calculate_x1(btn.x0,btn_width)

      return btn
    end,
    create_inner_btn = function(bb,btn)
      local inner_btn = {
        x0 = btn.x0 + bb.btn_config.inner_btn_border,
        x1 = btn.x1 - bb.btn_config.inner_btn_border,
        y0 = btn.y0 + bb.btn_config.inner_btn_border,
        y1 = btn.y1 - bb.btn_config.inner_btn_border,
      }

      btn.inner_btn = inner_btn
    end,
    create_icon = function(bb,btn,i)
      btn.icon = i
      btn.icon.x = btn.x0 + bb.btn_config.icon_border
      btn.icon.y = btn.y0 + bb.btn_config.icon_border
    end,
    update_btn_index = function(self,menu_mode)
      if menu_mode then
        if btnp(1) then
          self.btn_index += 1
        elseif btnp(0) then
          self.btn_index -= 1
        end
        self.btn_index = self.btn_index % #self.sprites
        if self.btn_index == 0 then self.btn_index = #self.sprites end
      else
        self.btn_index = 1
      end
    end
  }