---@meta


---@overload fun(self: SynthB.Character): SynthB.Character
SynthB.Character = setmetatable({}, {
	__call = function(self)
		return self
	end
})
