gg_cam_Camera_001 = nil
function InitGlobals()
end

local REPLACE_ME
function CreateNeutralPassive()
    local p = Player(PLAYER_NEUTRAL_PASSIVE)
    local u
    local unitID
    local t
    local life
    u = BlzCreateUnitWithSkin(p, FourCC("nvlw"), 2804.5, -4316.2, 159.208, FourCC("nvlw"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvlk"), 2386.1, -3037.9, 246.899, FourCC("nvlk"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvk2"), 2431.0, -3062.8, 206.967, FourCC("nvk2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvlw"), 1512.6, -3050.4, 278.567, FourCC("nvlw"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvl2"), 1506.5, -3833.3, 308.094, FourCC("nvl2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvil"), 1522.8, -3920.0, 39.473, FourCC("nvil"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvil"), 2881.8, -3889.8, 208.095, FourCC("nvil"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvl2"), 2375.6, -4005.7, 193.693, FourCC("nvl2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvl2"), 1332.0, -2627.9, 208.850, FourCC("nvl2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvil"), 1173.7, -2574.4, 291.118, FourCC("nvil"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvk2"), 2877.6, -2768.2, 49.653, FourCC("nvk2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvlk"), 2862.8, -2630.5, -26.454, FourCC("nvlk"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvlw"), 3041.6, -2641.1, 205.458, FourCC("nvlw"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvlw"), 1391.9, -4093.0, 8.764, FourCC("nvlw"))
    u = BlzCreateUnitWithSkin(p, FourCC("nbee"), 2550.7, -4365.4, 109.620, FourCC("nbee"))
    u = BlzCreateUnitWithSkin(p, FourCC("hrdh"), 3101.3, -2818.5, 316.620, FourCC("hrdh"))
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
end

function CreateAllUnits()
    CreatePlayerBuildings()
    CreateNeutralPassive()
    CreatePlayerUnits()
end

function CreateCameras()
    gg_cam_Camera_001 = CreateCameraSetup()
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ZOFFSET, 0.0, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ROTATION, 90.0, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ANGLE_OF_ATTACK, 304.0, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_TARGET_DISTANCE, 1996.5, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ROLL, 0.0, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_FARZ, 5000.0, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_NEARZ, 16.0, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_LOCAL_PITCH, 0.0, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_LOCAL_YAW, 0.0, 0.0)
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_LOCAL_ROLL, 0.0, 0.0)
    CameraSetupSetDestPosition(gg_cam_Camera_001, 2116.2, -3115.3, 0.0)
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
end

function main()
    SetCameraBounds(-30208.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -29696.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 31232.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 31744.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -30208.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 31744.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 31232.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -29696.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    CreateCameras()
    CreateAllUnits()
    InitBlizzard()
    InitGlobals()
end

function config()
    SetMapName("TRIGSTR_003")
    SetMapDescription("TRIGSTR_005")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, -5824.0, -704.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end

