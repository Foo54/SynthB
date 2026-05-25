---@meta


---@overload fun(self: SynthB.MisTuning): SynthB.MisTuning
SynthB.MisTuning = setmetatable({}, {
	__call = function(self)
		return self
	end
})
