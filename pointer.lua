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
 draw = function(self)
   spr(0,pointer.x,pointer.y)
   if self.piece then spr(self.piece.sprite,self.x,self.y) end
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