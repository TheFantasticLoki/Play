--[[-- startup logic --]]--
local args = {...}
if #args < 1 then
	error('supply file name')
end

local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")
local decoder = dfpwm.make_decoder()
for chunk in io.lines("/Music/" .. args[1] .. '.dfpwm', 16 * 1024) do
    local buffer = decoder(chunk)
    while not speaker.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end
end
