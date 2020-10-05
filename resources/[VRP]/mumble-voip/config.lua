mumbleConfig = {
    voiceModes = {
        {2, "Sussurrando"}, -- Whisper speech distance in gta distance units
        {6, "Normal"}, -- Normal speech distance in gta distance units
        {15, "Gritando"}, -- Shout speech distance in gta distance units
    },
    speakerRange = 4.0, -- Speaker distance in gta distance units (how close you need to be to another player to hear other players on the radio or phone)
    callSpeakerEnabled = true, -- Allow players to hear all talking participants of a phone call if standing next to someone that is on the phone
    radioSpeakerEnabled = true, -- Allow players to hear all talking participants in a radio if standing next to someone that has a radio
    radioEnabled = true, -- Enable or disable using the radio
    micClicks = true, -- Are clicks enabled or not
    micClickOn = true, -- Is click sound on active
    micClickOff = true, -- Is click sound off active
    micClickVolume = 0.2, -- How loud a mic click is
    radioClickMaxChannel = 100, -- Set the max amount of radio channels that will have local radio clicks enabled
    controls = { -- Change default key binds
        proximity = {
            key = 212, -- home
        }, -- Switch proximity mode
        radio = {
            pressed = false, -- don't touch
            key = 137, -- capital
        }, -- Use radio
        speaker = {
            key = 212, -- home
            secondary = 20, -- z
        } -- Toggle speaker mode (phone calls)
    },
    radioChannelNames = { -- Add named radio channels (Defaults to [channel number] MHz)
        [1] = "WRENCH",
        [1000] = "Cosa",
        [1001] = "MDM",
        [1002] = "ROC",
        [1003] = "CDD",
        [1004] = "G1",
        [1005] = "G2",
        [1006] = "G3",
        [1007] = "G4",
        [1008] = "Mecanico",
        [1009] = "Paramedico",
        [1010] = "Mercenarios",
        [1011] = "Policia",
        [1012] = "Vanilla",
    }
}

-- Update config properties from another script
function SetMumbleProperty(key, value)
	if mumbleConfig[key] ~= nil and mumbleConfig[key] ~= "controls" and mumbleConfig[key] ~= "radioChannelNames" then
		mumbleConfig[key] = value
	end
end

function AddRadioChannelName(channel, name)
    local channel = tonumber(channel)

    if channel ~= nil and name ~= nil and name ~= "" then
        if not mumbleConfig.radioChannelNames[channel] then
            mumbleConfig.radioChannelNames[channel] = tostring(name)
        end
    end
end

-- Make exports available on first tick
exports("SetMumbleProperty", SetMumbleProperty)
exports("SetTokoProperty", SetMumbleProperty)
exports("AddRadioChannelName", AddRadioChannelName)