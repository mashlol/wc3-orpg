function InitGlobals()
end


function initInput()
    print("INited inputs")
    unit1 = CreateUnit(Player(0), FourCC("Hpal"), -150, -125, 0)
    unit2 = CreateUnit(Player(1), FourCC("Hpal"), -150, -125, 0)
end

TimerStart(CreateTimer(), 0.0, false, initInput)

function mouseMoved()
    local pos = BlzGetTriggerPlayerMousePosition()
    local player = GetTriggerPlayer()
    if GetPlayerId(player) == 0 then
        SetUnitPosition(unit1, GetLocationX(pos), GetLocationY(pos))
    end
    if GetPlayerId(player) == 1 then
        SetUnitPosition(unit2, GetLocationX(pos), GetLocationY(pos))
    end
end

local trigger = CreateTrigger()

TriggerRegisterPlayerEvent(trigger, Player(0), EVENT_PLAYER_MOUSE_MOVE)
TriggerRegisterPlayerEvent(trigger, Player(1), EVENT_PLAYER_MOUSE_MOVE)

TriggerAddAction(trigger, mouseMoved)function setMoney()
    SetPlayerState(Player(0), PLAYER_STATE_RESOURCE_GOLD, 15000)
    print("Test setMoney New")
end

TimerStart(CreateTimer(), 0.0, false, setMoney)function initUI()
    print("INited UI")
    local face = BlzCreateFrameByType("BACKDROP", "Face", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)--Create a new frame of Type BACKDROP
    local faceHover = BlzCreateFrameByType("FRAME", "FaceFrame", face,"", 0) --face is a BACKDROP it can not have events nor a tooltip, thats why one creates an empty frame managing that.
    local tooltip = BlzCreateFrameByType("TEXT", "FaceFrameTooltip", face,"", 0)--Create a new frame of Type TEXT
    --faceHover would be unneeded if face would support events/tooltip

    BlzFrameSetAllPoints(faceHover, face) --faceHover copies the size and position of face.
    BlzFrameSetTooltip(faceHover, tooltip) --when faceHover is hovered with the mouse frame tooltip becomes visible.

    BlzFrameSetSize(face, 0.04, 0.04)
    BlzFrameSetAbsPoint(face, FRAMEPOINT_CENTER, 0.4, 0.3)
    BlzFrameSetAbsPoint(tooltip, FRAMEPOINT_CENTER, 0.2, 0.3)
    BlzFrameSetText(tooltip, "Human Paladin Face")

    if GetPlayerId(GetLocalPlayer()) == 0 then
       BlzFrameSetTexture(face, "ReplaceableTextures\\CommandButtons\\BTNAbomination",0, true)--face uses paladin blp as texture.
    else
        BlzFrameSetTexture(face, "UI\\Glues\\ScoreScreen\\scorescreen-player-bloodelf",0, true)--face uses paladin blp as texture.
    end
end

TimerStart(CreateTimer(), 0.0, false, initUI)
function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(1), true)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerTeam(Player(1), 0)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 1)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(1, 1)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
end

function main()
    SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    InitBlizzard()
    InitGlobals()
end

function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(2)
    SetTeams(2)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, 256.0, 2368.0)
    DefineStartLocation(1, 2368.0, 1856.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    SetPlayerSlotAvailable(Player(1), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
    InitAllyPriorities()
end

