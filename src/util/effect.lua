SynthB.effect = {}

function SynthB.effect.parry()
	return next(SMODS.find_card("j_synthb_parry", false))
end

function SynthB.effect.birdbrain()
	return next(SMODS.find_card("j_synthb_birdbrain", false))
end

function SynthB.effect.erb()
	return next(SMODS.find_card("j_synthb_ego_renegade_boy", false))
end

function SynthB.effect.future_of_beginnings()
	return next(SMODS.find_card("j_synthb_future_of_beginnings", false))
end