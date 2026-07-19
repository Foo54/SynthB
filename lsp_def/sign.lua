---@meta


---@overload fun(self: SynthB.Sign): SynthB.Sign
SynthB.Sign = setmetatable({}, {
	__call = function(self)
		return self
	end
})
