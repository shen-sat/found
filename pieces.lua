function create_piece(arg)
  local piece = {
    name = arg.name,
    sprite = arg.sprite,
    width = arg.width,
    x,
    y,
    activate = arg.activate,
    text = arg.text,
    validate = function(self)
      local errors = self:errors()
      if  #errors > 0 then
        for e in all(errors) do
          add(error_messages, e)
        end
      end
    end,
    errors = function(self)
      local result = {}  
      if not self.name then 
        add(result,"a piece is missing attribute:name")
      else
        if not self.sprite then add(result,"piece:"..self.name.." is missing attribute:sprite") end
        if not self.width then add(result,"piece:"..self.name.." is missing attribute:width") end
        if self.x then add(result,"piece:"..self.name.." should not have attribute:x") end
        if self.y then add(result,"piece:"..self.name.." should not have attribute:y") end
        if not self.activate then add(result,"piece:"..self.name.." is missing attribute:activate") end
        if not self.text then add(result,"piece:"..self.name.." is missing attribute:text") end
        if #convert_text_into_lines(self.text) > 2 then add(result,"piece:"..self.name.." has too much text") end
      end
      return result
    end
  }

  return piece
end

road = create_piece(
  {
    name = 'road',
    sprite = 1,
    width = 8,
    activate = build_piece,
    text = 'road. connects buildings. allows movement of peeple'
  }
)

hut = create_piece(
  {
    name = 'hut',
    sprite = 2,
    width = 8,
    activate = build_piece,
    text = 'hut. houses peeple'
  }
)

bin = create_piece(
  {
    name = 'bin',
    sprite = 3,
    width = 8,
    activate = nil,
    text = 'bin. demolishes stuff'
  }
)
bin.activate = function(self,pointer,built_pieces)
  local local_bin = copy_piece(self,pointer)
  for bp in all(built_pieces) do
    if do_pieces_match(bp, local_bin, false) then del(built_pieces,bp) end
  end  
end

query = create_piece(
  {
    name = 'query',
    sprite = 4,
    width = 8,
    activate = nil,
    text = 'query. see info about stuff'
  }
)
query.activate = function(self,pointer,built_pieces)
  local local_query = copy_piece(self,pointer)
  for bp in all(built_pieces) do
    if do_pieces_match(bp, local_query, false) then top_text:assign(bp.text) end
  end
end

pieces = { road, hut, bin, query }

for piece in all(pieces) do
  piece:validate()
end