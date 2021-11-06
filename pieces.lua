function create_piece(sprite,width,activate,text)
  local piece = {
    sprite = sprite,
    width = width,
    x,
    y,
    activate = activate,
    text = text
  }

  return piece
end

road = create_piece(1,8,build_piece,'road. connects buildings. allows movement of peeple')
hut = create_piece(2,8,build_piece,'hut. houses peeple.')

bin = {
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
  sprite = 4,
  width = 8,
  x,
  y,
  activate = function(self,pointer,built_pieces)
    local local_query = copy_piece(self,pointer)
    for bp in all(built_pieces) do
      if do_pieces_match(bp, local_query, false) then top_text:assign(bp.text) end
    end
  end
}

pieces = { road, hut, bin, query }