---@meta


---@overload fun(self: SynthB.Joker): SynthB.Joker
SynthB.Joker = setmetatable({}, {
	__call = function(self)
		return self
	end
})
