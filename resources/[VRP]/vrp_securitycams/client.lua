local cameraActive = false
local currentCameraIndex = 0
local currentCameraIndexIndex = 0
local createdCamera = 0

vRP = Proxy.getInterface("vRP")
vrpscams = {}
local propcams = {}
local disabledCam = false
Tunnel.bindInterface("vrpscams", vrpscams)

SCServer = Tunnel.getInterface("vrpscams","vrpscams")

Citizen.CreateThread(function()
    while true do
        for a = 1, #SecurityCamConfig.Locations do
            local ped = GetPlayerPed(PlayerId())
            local pedPos = GetEntityCoords(ped, false)
            local pedHead = GetEntityRotation(ped, 2)
            local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, SecurityCamConfig.Locations[a].camBox[1].x, SecurityCamConfig.Locations[a].camBox[1].y, SecurityCamConfig.Locations[a].camBox[1].z)
            local distance2 = Vdist(pedPos.x, pedPos.y, pedPos.z, SecurityCamConfig.Locations[a].camBox[2].x, SecurityCamConfig.Locations[a].camBox[2].y, SecurityCamConfig.Locations[a].camBox[2].z)


            if SecurityCamConfig.DebugMode then
                Draw3DText(pedPos.x, pedPos.y, pedPos.z + 0.6, tostring("X: " .. pedPos.x))
                Draw3DText(pedPos.x, pedPos.y, pedPos.z + 0.4, tostring("Y: " .. pedPos.y))
                Draw3DText(pedPos.x, pedPos.y, pedPos.z + 0.2, tostring("Z: " .. pedPos.z))
                Draw3DText(pedPos.x, pedPos.y, pedPos.z, tostring("H: " .. pedHead))
            end
            local pedAllowed = false
            if #SecurityCamConfig.Locations[a].allowedModels >= 1 then
                pedAllowed = IsPedAllowed(ped, SecurityCamConfig.Locations[a].allowedModels)
            else
                pedAllowed = true
            end
            if pedAllowed then
                if distance <= 5.0 or distance2 <= 5.0then
                    local box_label = SecurityCamConfig.Locations[a].camBox[1].label
                    local box_x = SecurityCamConfig.Locations[a].camBox[1].x
                    local box_y = SecurityCamConfig.Locations[a].camBox[1].y
                    local box_z = SecurityCamConfig.Locations[a].camBox[1].z
                    Draw3DText(box_x, box_y, box_z, tostring("~o~[E]~w~ Usar " .. box_label))
                    local box_label2 = SecurityCamConfig.Locations[a].camBox[2].label
                    local box_x2 = SecurityCamConfig.Locations[a].camBox[2].x
                    local box_y2 = SecurityCamConfig.Locations[a].camBox[2].y
                    local box_z2 = SecurityCamConfig.Locations[a].camBox[2].z
                    Draw3DText(box_x2, box_y2, box_z2, tostring("~o~[E]~w~ Usar " .. box_label2))
                    
                    if IsControlJustPressed(1, 38) and createdCamera == 0 and (distance <= 1.2 or distance2 <= 1.2) then
                        SCServer.checkIsHackerAndPay({},function(resultado)
                            if resultado then
                                local firstCamx = SecurityCamConfig.Locations[a].cameras[1].x
                                local firstCamy = SecurityCamConfig.Locations[a].cameras[1].y
                                local firstCamz = SecurityCamConfig.Locations[a].cameras[1].z
                                local firstCamr = SecurityCamConfig.Locations[a].cameras[1].r
                                local firstActive = SecurityCamConfig.Locations[a].cameras[1].active

                                SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
                                ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr, firstActive)
                                SendNUIMessage({
                                    type = "enablecam",
                                    label = SecurityCamConfig.Locations[a].cameras[1].label,
                                    box = SecurityCamConfig.Locations[a].camBox.label
                                })
                                currentCameraIndex = a
                                currentCameraIndexIndex = 1
                                FreezeEntityPosition(GetPlayerPed(PlayerId()), true)
                            else
                                TriggerEvent("Notify","negado","Você não tem acesso as câmeras!")
                            end
                        end)
                    end
                end
            end

            if createdCamera ~= 0 or disabledCam then
                local instructions = CreateInstuctionScaleform("instructional_buttons")
                DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
                SetTimecycleModifier("scanline_cam_cheap")
                SetTimecycleModifierStrength(2.0)

                if SecurityCamConfig.HideRadar then
                    DisplayRadar(false)
                end

                -- CLOSE CAMERAS
                if IsControlJustPressed(1, 194) then
                    CloseSecurityCamera()
                    SendNUIMessage({
                        type = "disablecam",
                    })
			        if SecurityCamConfig.HideRadar then
                        DisplayRadar(true)
                	end
                end

                -- GO BACK CAMERA
                if IsControlJustPressed(1, 174) then
                    local newCamIndex

                    if currentCameraIndexIndex == 1 then
                        newCamIndex = #SecurityCamConfig.Locations[currentCameraIndex].cameras
                    else
                        newCamIndex = currentCameraIndexIndex - 1
                    end

                    local newCamx = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].x
                    local newCamy = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].y
                    local newCamz = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].z
                    local newCamr = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].r
                    local newCamActive = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].active

                    SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)
                    SendNUIMessage({
                        type = "updatecam",
                        label = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].label,
                        active = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].active
                    })
                    ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr, newCamActive)
                    currentCameraIndexIndex = newCamIndex
                end

                -- GO FORWARD CAMERA
                if IsControlJustPressed(1, 175) then
                    local newCamIndex
                    
                    if currentCameraIndexIndex == #SecurityCamConfig.Locations[currentCameraIndex].cameras then
                        newCamIndex = 1
                    else
                        newCamIndex = currentCameraIndexIndex + 1
                    end

                    local newCamx = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].x
                    local newCamy = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].y
                    local newCamz = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].z
                    local newCamr = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].r
                    local newCamActive = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].active

                    SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)
                    SendNUIMessage({
                        type = "updatecam",
                        label = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].label,
                        active = SecurityCamConfig.Locations[currentCameraIndex].cameras[newCamIndex].active
                    })
                    ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr, newCamActive)
                    currentCameraIndexIndex = newCamIndex
                end

                ---------------------------------------------------------------------------
                -- CAMERA ROTATION CONTROLS
                ---------------------------------------------------------------------------
                if SecurityCamConfig.Locations[currentCameraIndex].cameras[currentCameraIndexIndex].canRotate then
                    local getCameraRot = GetCamRot(createdCamera, 2)

                    -- ROTATE UP
                    if IsControlPressed(1, 32) then
                        if getCameraRot.x <= 0.0 then
                            SetCamRot(createdCamera, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2)
                        end
                    end

                    -- ROTATE DOWN
                    if IsControlPressed(1, 33) then
                        if getCameraRot.x >= -50.0 then
                            SetCamRot(createdCamera, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2)
                        end
                    end

                    -- ROTATE LEFT
                    if IsControlPressed(1, 34) then
                        SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
                    end

                    -- ROTATE RIGHT
                    if IsControlPressed(1, 35) then
                        SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
                    end
                end
            end
        end
        Citizen.Wait(10)
    end
end)

---------------------------------------------------------------------------
-- SPAWN CAMERAS INITIAL
---------------------------------------------------------------------------
Citizen.CreateThread(function()
        local camera_prop = "prop_cctv_cam_01a"
        RequestModel(camera_prop)
        while not HasModelLoaded(camera_prop) do
            Citizen.Wait(10)
        end

        for a = 1, #SecurityCamConfig.Locations[1].cameras do
            local loc = SecurityCamConfig.Locations[1].cameras[a]
            local camera_prop = CreateObjectNoOffset(camera_prop, loc.x, loc.y, loc.z, 1, 0, 1)
            propcams[loc.id] = camera_prop
            SetEntityVisible(camera_prop, true)
        end
end)
---------------------------------------------------------------------------
-- CHECK CAMERA LIFE
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do 
        for a = 1, #propcams do
            local cam = propcams[a]
            local life = GetEntityHealth(cam)
            if life < 1000 then 
                local camera = {}
                for b = 1, # SecurityCamConfig.Locations[1].cameras do 
                    local id =  SecurityCamConfig.Locations[1].cameras[b].id
                    if id == a then
                        SecurityCamConfig.Locations[1].cameras[b].active = false
                    end
                end
            end
        end
        Citizen.Wait(1000)
    end
end)
---------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------
function ChangeSecurityCamera(x, y, z, r, a)
    if createdCamera ~= 0 then
        DestroyCam(createdCamera, 0)
        createdCamera = 0
    end
    if a then 
        local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamCoord(cam, x, y, z)
        SetCamRot(cam, r.x, r.y, r.z, 2)
        RenderScriptCams(1, 0, 0, 1, 1)
        Citizen.Wait(250)
        createdCamera = cam
    else
        disabledCam = true
    end
end

function CloseSecurityCamera()
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    disabledCam = false
    ClearTimecycleModifier("scanline_cam_cheap")
    -- SetEntityCoords(GetPlayerPed(PlayerId()), SecurityCamConfig.Locations[a].camBox.x,SecurityCamConfig.Locations[a].camBox.y,SecurityCamConfig.Locations[a].camBox.z, 0, 0, 0, 0)
    SetFocusEntity(GetPlayerPed(PlayerId()))
    if SecurityCamConfig.HideRadar then
        DisplayRadar(true)
    end
    FreezeEntityPosition(GetPlayerPed(PlayerId()), false)
    -- SetTimeout(2000, function()
        
    -- end)
end

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) 
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0*scale, 0.35*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function IsPedAllowed(ped, pedList)
    for i = 1, #pedList do
		if GetHashKey(pedList[i]) == GetEntityModel(ped) then
			return true
		end
	end
    return false
end

function CreateInstuctionScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    InstructionButton(GetControlInstructionalButton(1, 175, true))
    InstructionButtonMessage("Avançar")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage("Sair da câmera")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    InstructionButton(GetControlInstructionalButton(1, 174, true))
    InstructionButtonMessage("Voltar")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function InstructionButton(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end
 