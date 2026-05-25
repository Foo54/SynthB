---@meta


---@overload fun(self: SynthB.Tuning): SynthB.Tuning
SynthB.Tuning = setmetatable({}, {
	__call = function(self)
		return self
	end
})
