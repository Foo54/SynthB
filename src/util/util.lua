function SynthB.song_info(info_queue, key)
	if SynthB.mod.config.display_song_info then
		info_queue[#info_queue+1] = {set = "SongInfo", key = key, type="descriptions"}
	end
end