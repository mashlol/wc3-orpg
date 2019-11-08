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
    u = BlzCreateUnitWithSkin(p, FourCC("nvlk"), 2386.1, -3037.9, 246.899, FourCC("nvlk"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvk2"), 2431.0, -3062.8, 206.967, FourCC("nvk2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvlw"), 1512.6, -3050.4, 278.567, FourCC("nvlw"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvl2"), 1506.5, -3833.3, 143.079, FourCC("nvl2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvil"), 1529.5, -3974.4, 142.156, FourCC("nvil"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvil"), 2509.8, -4196.5, 321.690, FourCC("nvil"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvl2"), 2638.1, -4316.8, 196.090, FourCC("nvl2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvl2"), 1332.0, -2627.9, 208.850, FourCC("nvl2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvil"), 1173.7, -2574.4, 291.118, FourCC("nvil"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvk2"), 2825.3, -2869.2, 10.837, FourCC("nvk2"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvlk"), 2697.9, -2633.7, 114.215, FourCC("nvlk"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvlw"), 3026.8, -2649.9, 196.724, FourCC("nvlw"))
    u = BlzCreateUnitWithSkin(p, FourCC("nvlw"), 1318.5, -4309.9, 100.934, FourCC("nvlw"))
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
    CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_TARGET_DISTANCE, 2415.8, 0.0)
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
    SetCameraBounds(-7424.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -7680.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 7424.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 7168.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -7424.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 7168.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 7424.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -7680.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
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

