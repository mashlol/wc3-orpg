---@class real
---@class handle
---@class code

---@class agent                    : handle
---@class event                 : agent
---@class player                : agent
---@class widget                : agent
---@class unit                  : widget
---@class destructable          : widget
---@class item                  : widget
---@class ability               : agent
---@class buff                  : ability
---@class force                 : agent
---@class group                 : agent
---@class trigger               : agent
---@class triggercondition      : agent
---@class triggeraction         : handle
---@class timer                 : agent
---@class location              : agent
---@class region                : agent
---@class rect                  : agent
---@class boolexpr              : agent
---@class sound                 : agent
---@class conditionfunc         : boolexpr
---@class filterfunc            : boolexpr
---@class unitpool              : handle
---@class itempool              : handle
---@class race                  : handle
---@class alliancetype          : handle
---@class racepreference        : handle
---@class gamestate             : handle
---@class igamestate            : gamestate
---@class fgamestate            : gamestate
---@class playerstate           : handle
---@class playerscore           : handle
---@class playergameresult      : handle
---@class unitstate             : handle
---@class aidifficulty          : handle
---@class eventid               : handle
---@class gameevent             : eventid
---@class playerevent           : eventid
---@class playerunitevent       : eventid
---@class unitevent             : eventid
---@class limitop               : eventid
---@class widgetevent           : eventid
---@class dialogevent           : eventid
---@class unittype              : handle
---@class gamespeed             : handle
---@class gamedifficulty        : handle
---@class gametype              : handle
---@class mapflag               : handle
---@class mapvisibility         : handle
---@class mapsetting            : handle
---@class mapdensity            : handle
---@class mapcontrol            : handle
---@class playerslotstate       : handle
---@class volumegroup           : handle
---@class camerafield           : handle
---@class camerasetup           : handle
---@class playercolor           : handle
---@class placement             : handle
---@class startlocprio          : handle
---@class raritycontrol         : handle
---@class blendmode             : handle
---@class texmapflags           : handle
---@class effect                : agent
---@class effecttype            : handle
---@class weathereffect         : handle
---@class terraindeformation    : handle
---@class fogstate              : handle
---@class fogmodifier           : agent
---@class dialog                : agent
---@class button                : agent
---@class quest                 : agent
---@class questitem             : agent
---@class defeatcondition       : agent
---@class timerdialog           : agent
---@class leaderboard           : agent
---@class multiboard            : agent
---@class multiboarditem        : agent
---@class trackable             : agent
---@class gamecache             : agent
---@class version               : handle
---@class itemtype              : handle
---@class texttag               : handle
---@class attacktype            : handle
---@class damagetype            : handle
---@class weapontype            : handle
---@class soundtype             : handle
---@class lightning             : handle
---@class pathingtype           : handle
---@class mousebuttontype       : handle
---@class animtype              : handle
---@class subanimtype           : handle
---@class image                 : handle
---@class ubersplat             : handle
---@class hashtable             : agent

---@class framehandle
---@class originframetype
---@class framepointtype
---@class frameeventtype
---@class textaligntype
---@class oskeytype

---@class abilitybooleanfield
---@class abilityintegerfield
---@class abilityfloatfield
---@class abilitystringfield
---@class abilitybooleanlevelfield
---@class abilityintegerlevelfield
---@class abilityfloatlevelfield
---@class abilitystringlevelfield
---@class abilitybooleanlevelarrayfield
---@class abilityintegerlevelarrayfield
---@class abilityfloatlevelarrayfield
---@class abilitystringlevelarrayfield
---@class itembooleanfield
---@class itemintegerfield
---@class itemfloatfield
---@class itemstringfield
---@class unitbooleanfield
---@class unitintegerfield
---@class unitfloatfield
---@class unitstringfield
---@class unitweaponbooleanfield
---@class unitweaponintegerfield
---@class unitweaponfloatfield
---@class unitweaponstringfield

---@param msg string
function BJDebugMsg(msg) end
---@param a real
---@param b real
function RMinBJ(a, b) end
---@param a real
---@param b real
function RMaxBJ(a, b) end
---@param a real
function RAbsBJ(a) end
---@param a real
function RSignBJ(a) end
---@param a integer
---@param b integer
function IMinBJ(a, b) end
---@param a integer
---@param b integer
function IMaxBJ(a, b) end
---@param a integer
function IAbsBJ(a) end
---@param a integer
function ISignBJ(a) end
---@param degrees real
function SinBJ(degrees) end
---@param degrees real
function CosBJ(degrees) end
---@param degrees real
function TanBJ(degrees) end
---@param degrees real
function AsinBJ(degrees) end
---@param degrees real
function AcosBJ(degrees) end
---@param degrees real
function AtanBJ(degrees) end
---@param y real
---@param x real
function Atan2BJ(y, x) end
---@param locA location
---@param locB location
function AngleBetweenPoints(locA, locB) end
---@param locA location
---@param locB location
function DistanceBetweenPoints(locA, locB) end
---@param source location
---@param dist real
---@param angle real
function PolarProjectionBJ(source, dist, angle) end
function GetRandomDirectionDeg() end
function GetRandomPercentageBJ() end
---@param whichRect rect
function GetRandomLocInRect(whichRect) end
---@param dividend integer
---@param divisor integer
function ModuloInteger(dividend, divisor) end
---@param dividend real
---@param divisor real
function ModuloReal(dividend, divisor) end
---@param loc location
---@param dx real
---@param dy real
function OffsetLocation(loc, dx, dy) end
---@param r rect
---@param dx real
---@param dy real
function OffsetRectBJ(r, dx, dy) end
---@param center location
---@param width real
---@param height real
function RectFromCenterSizeBJ(center, width, height) end
---@param r rect
---@param x real
---@param y real
function RectContainsCoords(r, x, y) end
---@param r rect
---@param loc location
function RectContainsLoc(r, loc) end
---@param r rect
---@param whichUnit unit
function RectContainsUnit(r, whichUnit) end
---@param whichItem item
---@param r rect
function RectContainsItem(whichItem, r) end
---@param trig trigger
function ConditionalTriggerExecute(trig) end
---@param trig trigger
---@param checkConditions boolean
function TriggerExecuteBJ(trig, checkConditions) end
---@param trig trigger
---@param checkConditions boolean
function PostTriggerExecuteBJ(trig, checkConditions) end
function QueuedTriggerCheck() end
---@param trig trigger
function QueuedTriggerGetIndex(trig) end
---@param trigIndex integer
function QueuedTriggerRemoveByIndex(trigIndex) end
function QueuedTriggerAttemptExec() end
---@param trig trigger
---@param checkConditions boolean
function QueuedTriggerAddBJ(trig, checkConditions) end
---@param trig trigger
function QueuedTriggerRemoveBJ(trig) end
function QueuedTriggerDoneBJ() end
function QueuedTriggerClearBJ() end
function QueuedTriggerClearInactiveBJ() end
function QueuedTriggerCountBJ() end
function IsTriggerQueueEmptyBJ() end
---@param trig trigger
function IsTriggerQueuedBJ(trig) end
function GetForLoopIndexA() end
---@param newIndex integer
function SetForLoopIndexA(newIndex) end
function GetForLoopIndexB() end
---@param newIndex integer
function SetForLoopIndexB(newIndex) end
---@param duration real
function PolledWait(duration) end
---@param flag boolean
---@param valueA integer
---@param valueB integer
function IntegerTertiaryOp(flag, valueA, valueB) end
function DoNothing() end
---@param commentString string
function CommentString(commentString) end
---@param theString string
function StringIdentity(theString) end
---@param valueA boolean
---@param valueB boolean
function GetBooleanAnd(valueA, valueB) end
---@param valueA boolean
---@param valueB boolean
function GetBooleanOr(valueA, valueB) end
---@param percentage real
---@param max integer
function PercentToInt(percentage, max) end
---@param percentage real
function PercentTo255(percentage) end
function GetTimeOfDay() end
---@param whatTime real
function SetTimeOfDay(whatTime) end
---@param scalePercent real
function SetTimeOfDayScalePercentBJ(scalePercent) end
function GetTimeOfDayScalePercentBJ() end
---@param soundName string
function PlaySound(soundName) end
---@param A location
---@param B location
function CompareLocationsBJ(A, B) end
---@param A rect
---@param B rect
function CompareRectsBJ(A, B) end
---@param center location
---@param radius real
function GetRectFromCircleBJ(center, radius) end
function GetCurrentCameraSetup() end
---@param doPan boolean
---@param whichSetup camerasetup
---@param whichPlayer player
---@param duration real
function CameraSetupApplyForPlayer(doPan, whichSetup, whichPlayer, duration) end
---@param whichField camerafield
---@param whichSetup camerasetup
function CameraSetupGetFieldSwap(whichField, whichSetup) end
---@param whichPlayer player
---@param whichField camerafield
---@param value real
---@param duration real
function SetCameraFieldForPlayer(whichPlayer, whichField, value, duration) end
---@param whichPlayer player
---@param whichUnit unit
---@param xoffset real
---@param yoffset real
---@param inheritOrientation boolean
function SetCameraTargetControllerNoZForPlayer(whichPlayer, whichUnit, xoffset, yoffset, inheritOrientation) end
---@param whichPlayer player
---@param x real
---@param y real
function SetCameraPositionForPlayer(whichPlayer, x, y) end
---@param whichPlayer player
---@param loc location
function SetCameraPositionLocForPlayer(whichPlayer, loc) end
---@param degrees real
---@param loc location
---@param whichPlayer player
---@param duration real
function RotateCameraAroundLocBJ(degrees, loc, whichPlayer, duration) end
---@param whichPlayer player
---@param x real
---@param y real
function PanCameraToForPlayer(whichPlayer, x, y) end
---@param whichPlayer player
---@param loc location
function PanCameraToLocForPlayer(whichPlayer, loc) end
---@param whichPlayer player
---@param x real
---@param y real
---@param duration real
function PanCameraToTimedForPlayer(whichPlayer, x, y, duration) end
---@param whichPlayer player
---@param loc location
---@param duration real
function PanCameraToTimedLocForPlayer(whichPlayer, loc, duration) end
---@param whichPlayer player
---@param loc location
---@param zOffset real
---@param duration real
function PanCameraToTimedLocWithZForPlayer(whichPlayer, loc, zOffset, duration) end
---@param whichPlayer player
---@param loc location
---@param duration real
function SmartCameraPanBJ(whichPlayer, loc, duration) end
---@param whichPlayer player
---@param cameraModelFile string
function SetCinematicCameraForPlayer(whichPlayer, cameraModelFile) end
---@param whichPlayer player
---@param duration real
function ResetToGameCameraForPlayer(whichPlayer, duration) end
---@param whichPlayer player
---@param magnitude real
---@param velocity real
function CameraSetSourceNoiseForPlayer(whichPlayer, magnitude, velocity) end
---@param whichPlayer player
---@param magnitude real
---@param velocity real
function CameraSetTargetNoiseForPlayer(whichPlayer, magnitude, velocity) end
---@param whichPlayer player
---@param magnitude real
function CameraSetEQNoiseForPlayer(whichPlayer, magnitude) end
---@param whichPlayer player
function CameraClearNoiseForPlayer(whichPlayer) end
function GetCurrentCameraBoundsMapRectBJ() end
function GetCameraBoundsMapRect() end
function GetPlayableMapRect() end
function GetEntireMapRect() end
---@param r rect
function SetCameraBoundsToRect(r) end
---@param whichPlayer player
---@param r rect
function SetCameraBoundsToRectForPlayerBJ(whichPlayer, r) end
---@param adjustMethod integer
---@param dxWest real
---@param dxEast real
---@param dyNorth real
---@param dySouth real
function AdjustCameraBoundsBJ(adjustMethod, dxWest, dxEast, dyNorth, dySouth) end
---@param adjustMethod integer
---@param whichPlayer player
---@param dxWest real
---@param dxEast real
---@param dyNorth real
---@param dySouth real
function AdjustCameraBoundsForPlayerBJ(adjustMethod, whichPlayer, dxWest, dxEast, dyNorth, dySouth) end
---@param whichPlayer player
---@param x real
---@param y real
function SetCameraQuickPositionForPlayer(whichPlayer, x, y) end
---@param whichPlayer player
---@param loc location
function SetCameraQuickPositionLocForPlayer(whichPlayer, loc) end
---@param loc location
function SetCameraQuickPositionLoc(loc) end
---@param whichPlayer player
function StopCameraForPlayerBJ(whichPlayer) end
---@param whichPlayer player
---@param whichUnit unit
---@param xoffset real
---@param yoffset real
function SetCameraOrientControllerForPlayerBJ(whichPlayer, whichUnit, xoffset, yoffset) end
---@param factor real
function CameraSetSmoothingFactorBJ(factor) end
function CameraResetSmoothingFactorBJ() end
---@param toForce force
---@param message string
function DisplayTextToForce(toForce, message) end
---@param toForce force
---@param duration real
---@param message string
function DisplayTimedTextToForce(toForce, duration, message) end
---@param toForce force
function ClearTextMessagesBJ(toForce) end
---@param source string
---@param start integer
---@param _end integer
function SubStringBJ(source, start, _end) end
---@param h handle
function GetHandleIdBJ(h) end
---@param s string
function StringHashBJ(s) end
---@param trig trigger
---@param timeout real
function TriggerRegisterTimerEventPeriodic(trig, timeout) end
---@param trig trigger
---@param timeout real
function TriggerRegisterTimerEventSingle(trig, timeout) end
---@param trig trigger
---@param t timer
function TriggerRegisterTimerExpireEventBJ(trig, t) end
---@param trig trigger
---@param whichPlayer player
---@param whichEvent playerunitevent
function TriggerRegisterPlayerUnitEventSimple(trig, whichPlayer, whichEvent) end
---@param trig trigger
---@param whichEvent playerunitevent
function TriggerRegisterAnyUnitEventBJ(trig, whichEvent) end
---@param trig trigger
---@param whichPlayer player
---@param selected boolean
function TriggerRegisterPlayerSelectionEventBJ(trig, whichPlayer, selected) end
---@param trig trigger
---@param whichPlayer player
---@param keType integer
---@param keKey integer
function TriggerRegisterPlayerKeyEventBJ(trig, whichPlayer, keType, keKey) end
---@param trig trigger
---@param whichPlayer player
---@param meType integer
function TriggerRegisterPlayerMouseEventBJ(trig, whichPlayer, meType) end
---@param trig trigger
---@param whichPlayer player
function TriggerRegisterPlayerEventVictory(trig, whichPlayer) end
---@param trig trigger
---@param whichPlayer player
function TriggerRegisterPlayerEventDefeat(trig, whichPlayer) end
---@param trig trigger
---@param whichPlayer player
function TriggerRegisterPlayerEventLeave(trig, whichPlayer) end
---@param trig trigger
---@param whichPlayer player
function TriggerRegisterPlayerEventAllianceChanged(trig, whichPlayer) end
---@param trig trigger
---@param whichPlayer player
function TriggerRegisterPlayerEventEndCinematic(trig, whichPlayer) end
---@param trig trigger
---@param opcode limitop
---@param limitval real
function TriggerRegisterGameStateEventTimeOfDay(trig, opcode, limitval) end
---@param trig trigger
---@param whichRegion region
function TriggerRegisterEnterRegionSimple(trig, whichRegion) end
---@param trig trigger
---@param whichRegion region
function TriggerRegisterLeaveRegionSimple(trig, whichRegion) end
---@param trig trigger
---@param r rect
function TriggerRegisterEnterRectSimple(trig, r) end
---@param trig trigger
---@param r rect
function TriggerRegisterLeaveRectSimple(trig, r) end
---@param trig trigger
---@param whichUnit unit
---@param condition boolexpr
---@param range real
function TriggerRegisterDistanceBetweenUnits(trig, whichUnit, condition, range) end
---@param trig trigger
---@param range real
---@param whichUnit unit
function TriggerRegisterUnitInRangeSimple(trig, range, whichUnit) end
---@param trig trigger
---@param whichUnit unit
---@param opcode limitop
---@param limitval real
function TriggerRegisterUnitLifeEvent(trig, whichUnit, opcode, limitval) end
---@param trig trigger
---@param whichUnit unit
---@param opcode limitop
---@param limitval real
function TriggerRegisterUnitManaEvent(trig, whichUnit, opcode, limitval) end
---@param trig trigger
---@param whichDialog dialog
function TriggerRegisterDialogEventBJ(trig, whichDialog) end
---@param trig trigger
function TriggerRegisterShowSkillEventBJ(trig) end
---@param trig trigger
function TriggerRegisterBuildSubmenuEventBJ(trig) end
---@param trig trigger
function TriggerRegisterGameLoadedEventBJ(trig) end
---@param trig trigger
function TriggerRegisterGameSavedEventBJ(trig) end
function RegisterDestDeathInRegionEnum() end
---@param trig trigger
---@param r rect
function TriggerRegisterDestDeathInRegionEvent(trig, r) end
---@param where rect
---@param effectID integer
function AddWeatherEffectSaveLast(where, effectID) end
function GetLastCreatedWeatherEffect() end
---@param whichWeatherEffect weathereffect
function RemoveWeatherEffectBJ(whichWeatherEffect) end
---@param duration real
---@param permanent boolean
---@param where location
---@param radius real
---@param depth real
function TerrainDeformationCraterBJ(duration, permanent, where, radius, depth) end
---@param duration real
---@param limitNeg boolean
---@param where location
---@param startRadius real
---@param endRadius real
---@param depth real
---@param wavePeriod real
---@param waveWidth real
function TerrainDeformationRippleBJ(duration, limitNeg, where, startRadius, endRadius, depth, wavePeriod, waveWidth) end
---@param duration real
---@param source location
---@param target location
---@param radius real
---@param depth real
---@param trailDelay real
function TerrainDeformationWaveBJ(duration, source, target, radius, depth, trailDelay) end
---@param duration real
---@param where location
---@param radius real
---@param minDelta real
---@param maxDelta real
---@param updateInterval real
function TerrainDeformationRandomBJ(duration, where, radius, minDelta, maxDelta, updateInterval) end
---@param deformation terraindeformation
---@param duration real
function TerrainDeformationStopBJ(deformation, duration) end
function GetLastCreatedTerrainDeformation() end
---@param codeName string
---@param where1 location
---@param where2 location
function AddLightningLoc(codeName, where1, where2) end
---@param whichBolt lightning
function DestroyLightningBJ(whichBolt) end
---@param whichBolt lightning
---@param where1 location
---@param where2 location
function MoveLightningLoc(whichBolt, where1, where2) end
---@param whichBolt lightning
function GetLightningColorABJ(whichBolt) end
---@param whichBolt lightning
function GetLightningColorRBJ(whichBolt) end
---@param whichBolt lightning
function GetLightningColorGBJ(whichBolt) end
---@param whichBolt lightning
function GetLightningColorBBJ(whichBolt) end
---@param whichBolt lightning
---@param r real
---@param g real
---@param b real
---@param a real
function SetLightningColorBJ(whichBolt, r, g, b, a) end
function GetLastCreatedLightningBJ() end
---@param abilcode integer
---@param t effecttype
---@param index integer
function GetAbilityEffectBJ(abilcode, t, index) end
---@param abilcode integer
---@param t soundtype
function GetAbilitySoundBJ(abilcode, t) end
---@param where location
function GetTerrainCliffLevelBJ(where) end
---@param where location
function GetTerrainTypeBJ(where) end
---@param where location
function GetTerrainVarianceBJ(where) end
---@param where location
---@param terrainType integer
---@param variation integer
---@param area integer
---@param shape integer
function SetTerrainTypeBJ(where, terrainType, variation, area, shape) end
---@param where location
---@param t pathingtype
function IsTerrainPathableBJ(where, t) end
---@param where location
---@param t pathingtype
---@param flag boolean
function SetTerrainPathableBJ(where, t, flag) end
---@param red real
---@param green real
---@param blue real
---@param transparency real
function SetWaterBaseColorBJ(red, green, blue, transparency) end
---@param whichPlayer player
---@param whichFogState fogstate
---@param r rect
---@param afterUnits boolean
function CreateFogModifierRectSimple(whichPlayer, whichFogState, r, afterUnits) end
---@param whichPlayer player
---@param whichFogState fogstate
---@param center location
---@param radius real
---@param afterUnits boolean
function CreateFogModifierRadiusLocSimple(whichPlayer, whichFogState, center, radius, afterUnits) end
---@param enabled boolean
---@param whichPlayer player
---@param whichFogState fogstate
---@param r rect
function CreateFogModifierRectBJ(enabled, whichPlayer, whichFogState, r) end
---@param enabled boolean
---@param whichPlayer player
---@param whichFogState fogstate
---@param center location
---@param radius real
function CreateFogModifierRadiusLocBJ(enabled, whichPlayer, whichFogState, center, radius) end
function GetLastCreatedFogModifier() end
function FogEnableOn() end
function FogEnableOff() end
function FogMaskEnableOn() end
function FogMaskEnableOff() end
---@param flag boolean
function UseTimeOfDayBJ(flag) end
---@param style integer
---@param zstart real
---@param zend real
---@param density real
---@param red real
---@param green real
---@param blue real
function SetTerrainFogExBJ(style, zstart, zend, density, red, green, blue) end
function ResetTerrainFogBJ() end
---@param animName string
---@param doodadID integer
---@param radius real
---@param center location
function SetDoodadAnimationBJ(animName, doodadID, radius, center) end
---@param animName string
---@param doodadID integer
---@param r rect
function SetDoodadAnimationRectBJ(animName, doodadID, r) end
---@param add boolean
---@param animProperties string
---@param whichUnit unit
function AddUnitAnimationPropertiesBJ(add, animProperties, whichUnit) end
---@param file string
---@param size real
---@param where location
---@param zOffset real
---@param imageType integer
function CreateImageBJ(file, size, where, zOffset, imageType) end
---@param flag boolean
---@param whichImage image
function ShowImageBJ(flag, whichImage) end
---@param whichImage image
---@param where location
---@param zOffset real
function SetImagePositionBJ(whichImage, where, zOffset) end
---@param whichImage image
---@param red real
---@param green real
---@param blue real
---@param alpha real
function SetImageColorBJ(whichImage, red, green, blue, alpha) end
function GetLastCreatedImage() end
---@param where location
---@param name string
---@param red real
---@param green real
---@param blue real
---@param alpha real
---@param forcePaused boolean
---@param noBirthTime boolean
function CreateUbersplatBJ(where, name, red, green, blue, alpha, forcePaused, noBirthTime) end
---@param flag boolean
---@param whichSplat ubersplat
function ShowUbersplatBJ(flag, whichSplat) end
function GetLastCreatedUbersplat() end
---@param soundHandle sound
function PlaySoundBJ(soundHandle) end
---@param soundHandle sound
---@param fadeOut boolean
function StopSoundBJ(soundHandle, fadeOut) end
---@param soundHandle sound
---@param volumePercent real
function SetSoundVolumeBJ(soundHandle, volumePercent) end
---@param newOffset real
---@param soundHandle sound
function SetSoundOffsetBJ(newOffset, soundHandle) end
---@param soundHandle sound
---@param cutoff real
function SetSoundDistanceCutoffBJ(soundHandle, cutoff) end
---@param soundHandle sound
---@param pitch real
function SetSoundPitchBJ(soundHandle, pitch) end
---@param soundHandle sound
---@param loc location
---@param z real
function SetSoundPositionLocBJ(soundHandle, loc, z) end
---@param soundHandle sound
---@param whichUnit unit
function AttachSoundToUnitBJ(soundHandle, whichUnit) end
---@param soundHandle sound
---@param inside real
---@param outside real
---@param outsideVolumePercent real
function SetSoundConeAnglesBJ(soundHandle, inside, outside, outsideVolumePercent) end
---@param soundHandle sound
function KillSoundWhenDoneBJ(soundHandle) end
---@param soundHandle sound
---@param volumePercent real
---@param loc location
---@param z real
function PlaySoundAtPointBJ(soundHandle, volumePercent, loc, z) end
---@param soundHandle sound
---@param volumePercent real
---@param whichUnit unit
function PlaySoundOnUnitBJ(soundHandle, volumePercent, whichUnit) end
---@param soundHandle sound
---@param volumePercent real
---@param startingOffset real
function PlaySoundFromOffsetBJ(soundHandle, volumePercent, startingOffset) end
---@param musicFileName string
function PlayMusicBJ(musicFileName) end
---@param musicFileName string
---@param startingOffset real
---@param fadeInTime real
function PlayMusicExBJ(musicFileName, startingOffset, fadeInTime) end
---@param newOffset real
function SetMusicOffsetBJ(newOffset) end
---@param musicName string
function PlayThematicMusicBJ(musicName) end
---@param musicName string
---@param startingOffset real
function PlayThematicMusicExBJ(musicName, startingOffset) end
---@param newOffset real
function SetThematicMusicOffsetBJ(newOffset) end
function EndThematicMusicBJ() end
---@param fadeOut boolean
function StopMusicBJ(fadeOut) end
function ResumeMusicBJ() end
---@param volumePercent real
function SetMusicVolumeBJ(volumePercent) end
---@param soundHandle sound
function GetSoundDurationBJ(soundHandle) end
---@param musicFileName string
function GetSoundFileDurationBJ(musicFileName) end
function GetLastPlayedSound() end
function GetLastPlayedMusic() end
---@param vgroup volumegroup
---@param percent real
function VolumeGroupSetVolumeBJ(vgroup, percent) end
function SetCineModeVolumeGroupsImmediateBJ() end
function SetCineModeVolumeGroupsBJ() end
function SetSpeechVolumeGroupsImmediateBJ() end
function SetSpeechVolumeGroupsBJ() end
function VolumeGroupResetImmediateBJ() end
function VolumeGroupResetBJ() end
---@param soundHandle sound
function GetSoundIsPlayingBJ(soundHandle) end
---@param soundHandle sound
---@param offset real
function WaitForSoundBJ(soundHandle, offset) end
---@param musicName string
---@param index integer
function SetMapMusicIndexedBJ(musicName, index) end
---@param musicName string
function SetMapMusicRandomBJ(musicName) end
function ClearMapMusicBJ() end
---@param add boolean
---@param soundHandle sound
---@param r rect
function SetStackedSoundBJ(add, soundHandle, r) end
---@param whichPlayer player
---@param soundHandle sound
function StartSoundForPlayerBJ(whichPlayer, soundHandle) end
---@param whichPlayer player
---@param vgroup volumegroup
---@param scale real
function VolumeGroupSetVolumeForPlayerBJ(whichPlayer, vgroup, scale) end
---@param flag boolean
function EnableDawnDusk(flag) end
function IsDawnDuskEnabled() end
---@param inLabel string
function SetAmbientDaySound(inLabel) end
---@param inLabel string
function SetAmbientNightSound(inLabel) end
---@param where location
---@param modelName string
function AddSpecialEffectLocBJ(where, modelName) end
---@param attachPointName string
---@param targetWidget widget
---@param modelName string
function AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget, modelName) end
---@param whichEffect effect
function DestroyEffectBJ(whichEffect) end
function GetLastCreatedEffectBJ() end
---@param whichItem item
function GetItemLoc(whichItem) end
---@param whichWidget widget
function GetItemLifeBJ(whichWidget) end
---@param whichWidget widget
---@param life real
function SetItemLifeBJ(whichWidget, life) end
---@param xpToAdd integer
---@param whichHero unit
---@param showEyeCandy boolean
function AddHeroXPSwapped(xpToAdd, whichHero, showEyeCandy) end
---@param whichHero unit
---@param newLevel integer
---@param showEyeCandy boolean
function SetHeroLevelBJ(whichHero, newLevel, showEyeCandy) end
---@param abilcode integer
---@param whichUnit unit
function DecUnitAbilityLevelSwapped(abilcode, whichUnit) end
---@param abilcode integer
---@param whichUnit unit
function IncUnitAbilityLevelSwapped(abilcode, whichUnit) end
---@param abilcode integer
---@param whichUnit unit
---@param level integer
function SetUnitAbilityLevelSwapped(abilcode, whichUnit, level) end
---@param abilcode integer
---@param whichUnit unit
function GetUnitAbilityLevelSwapped(abilcode, whichUnit) end
---@param whichUnit unit
---@param buffcode integer
function UnitHasBuffBJ(whichUnit, buffcode) end
---@param buffcode integer
---@param whichUnit unit
function UnitRemoveBuffBJ(buffcode, whichUnit) end
---@param whichItem item
---@param whichHero unit
function UnitAddItemSwapped(whichItem, whichHero) end
---@param itemId integer
---@param whichHero unit
function UnitAddItemByIdSwapped(itemId, whichHero) end
---@param whichItem item
---@param whichHero unit
function UnitRemoveItemSwapped(whichItem, whichHero) end
---@param itemSlot integer
---@param whichHero unit
function UnitRemoveItemFromSlotSwapped(itemSlot, whichHero) end
---@param itemId integer
---@param loc location
function CreateItemLoc(itemId, loc) end
function GetLastCreatedItem() end
function GetLastRemovedItem() end
---@param whichItem item
---@param loc location
function SetItemPositionLoc(whichItem, loc) end
function GetLearnedSkillBJ() end
---@param flag boolean
---@param whichHero unit
function SuspendHeroXPBJ(flag, whichHero) end
---@param whichPlayer player
---@param handicapPercent real
function SetPlayerHandicapXPBJ(whichPlayer, handicapPercent) end
---@param whichPlayer player
function GetPlayerHandicapXPBJ(whichPlayer) end
---@param whichPlayer player
---@param handicapPercent real
function SetPlayerHandicapBJ(whichPlayer, handicapPercent) end
---@param whichPlayer player
function GetPlayerHandicapBJ(whichPlayer) end
---@param whichStat integer
---@param whichHero unit
---@param includeBonuses boolean
function GetHeroStatBJ(whichStat, whichHero, includeBonuses) end
---@param whichHero unit
---@param whichStat integer
---@param value integer
function SetHeroStat(whichHero, whichStat, value) end
---@param whichStat integer
---@param whichHero unit
---@param modifyMethod integer
---@param value integer
function ModifyHeroStat(whichStat, whichHero, modifyMethod, value) end
---@param whichHero unit
---@param modifyMethod integer
---@param value integer
function ModifyHeroSkillPoints(whichHero, modifyMethod, value) end
---@param whichUnit unit
---@param whichItem item
---@param x real
---@param y real
function UnitDropItemPointBJ(whichUnit, whichItem, x, y) end
---@param whichUnit unit
---@param whichItem item
---@param loc location
function UnitDropItemPointLoc(whichUnit, whichItem, loc) end
---@param whichUnit unit
---@param whichItem item
---@param slot integer
function UnitDropItemSlotBJ(whichUnit, whichItem, slot) end
---@param whichUnit unit
---@param whichItem item
---@param target widget
function UnitDropItemTargetBJ(whichUnit, whichItem, target) end
---@param whichUnit unit
---@param whichItem item
---@param target widget
function UnitUseItemDestructable(whichUnit, whichItem, target) end
---@param whichUnit unit
---@param whichItem item
---@param loc location
function UnitUseItemPointLoc(whichUnit, whichItem, loc) end
---@param whichUnit unit
---@param itemSlot integer
function UnitItemInSlotBJ(whichUnit, itemSlot) end
---@param whichUnit unit
---@param itemId integer
function GetInventoryIndexOfItemTypeBJ(whichUnit, itemId) end
---@param whichUnit unit
---@param itemId integer
function GetItemOfTypeFromUnitBJ(whichUnit, itemId) end
---@param whichUnit unit
---@param itemId integer
function UnitHasItemOfTypeBJ(whichUnit, itemId) end
---@param whichUnit unit
function UnitInventoryCount(whichUnit) end
---@param whichUnit unit
function UnitInventorySizeBJ(whichUnit) end
---@param whichItem item
---@param flag boolean
function SetItemInvulnerableBJ(whichItem, flag) end
---@param whichItem item
---@param flag boolean
function SetItemDropOnDeathBJ(whichItem, flag) end
---@param whichItem item
---@param flag boolean
function SetItemDroppableBJ(whichItem, flag) end
---@param whichItem item
---@param whichPlayer player
---@param changeColor boolean
function SetItemPlayerBJ(whichItem, whichPlayer, changeColor) end
---@param show boolean
---@param whichItem item
function SetItemVisibleBJ(show, whichItem) end
---@param whichItem item
function IsItemHiddenBJ(whichItem) end
---@param level integer
function ChooseRandomItemBJ(level) end
---@param level integer
---@param whichType itemtype
function ChooseRandomItemExBJ(level, whichType) end
function ChooseRandomNPBuildingBJ() end
---@param level integer
function ChooseRandomCreepBJ(level) end
---@param r rect
---@param actionFunc code
function EnumItemsInRectBJ(r, actionFunc) end
function RandomItemInRectBJEnum() end
---@param r rect
---@param filter boolexpr
function RandomItemInRectBJ(r, filter) end
---@param r rect
function RandomItemInRectSimpleBJ(r) end
---@param whichItem item
---@param status integer
function CheckItemStatus(whichItem, status) end
---@param itemId integer
---@param status integer
function CheckItemcodeStatus(itemId, status) end
---@param unitId integer
function UnitId2OrderIdBJ(unitId) end
---@param unitIdString string
function String2UnitIdBJ(unitIdString) end
---@param unitId integer
function UnitId2StringBJ(unitId) end
---@param orderIdString string
function String2OrderIdBJ(orderIdString) end
---@param orderId integer
function OrderId2StringBJ(orderId) end
function GetIssuedOrderIdBJ() end
function GetKillingUnitBJ() end
---@param id player
---@param unitid integer
---@param loc location
---@param face real
function CreateUnitAtLocSaveLast(id, unitid, loc, face) end
function GetLastCreatedUnit() end
---@param count integer
---@param unitId integer
---@param whichPlayer player
---@param loc location
---@param face real
function CreateNUnitsAtLoc(count, unitId, whichPlayer, loc, face) end
---@param count integer
---@param unitId integer
---@param whichPlayer player
---@param loc location
---@param lookAt location
function CreateNUnitsAtLocFacingLocBJ(count, unitId, whichPlayer, loc, lookAt) end
function GetLastCreatedGroupEnum() end
function GetLastCreatedGroup() end
---@param unitid integer
---@param whichPlayer player
---@param loc location
function CreateCorpseLocBJ(unitid, whichPlayer, loc) end
---@param suspend boolean
---@param whichUnit unit
function UnitSuspendDecayBJ(suspend, whichUnit) end
function DelayedSuspendDecayStopAnimEnum() end
function DelayedSuspendDecayBoneEnum() end
function DelayedSuspendDecayFleshEnum() end
function DelayedSuspendDecay() end
function DelayedSuspendDecayCreate() end
---@param style integer
---@param unitid integer
---@param whichPlayer player
---@param loc location
---@param facing real
function CreatePermanentCorpseLocBJ(style, unitid, whichPlayer, loc, facing) end
---@param whichState unitstate
---@param whichUnit unit
function GetUnitStateSwap(whichState, whichUnit) end
---@param whichUnit unit
---@param whichState unitstate
---@param whichMaxState unitstate
function GetUnitStatePercent(whichUnit, whichState, whichMaxState) end
---@param whichUnit unit
function GetUnitLifePercent(whichUnit) end
---@param whichUnit unit
function GetUnitManaPercent(whichUnit) end
---@param whichUnit unit
function SelectUnitSingle(whichUnit) end
function SelectGroupBJEnum() end
---@param g group
function SelectGroupBJ(g) end
---@param whichUnit unit
function SelectUnitAdd(whichUnit) end
---@param whichUnit unit
function SelectUnitRemove(whichUnit) end
---@param whichPlayer player
function ClearSelectionForPlayer(whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function SelectUnitForPlayerSingle(whichUnit, whichPlayer) end
---@param g group
---@param whichPlayer player
function SelectGroupForPlayerBJ(g, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function SelectUnitAddForPlayer(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function SelectUnitRemoveForPlayer(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param newValue real
function SetUnitLifeBJ(whichUnit, newValue) end
---@param whichUnit unit
---@param newValue real
function SetUnitManaBJ(whichUnit, newValue) end
---@param whichUnit unit
---@param percent real
function SetUnitLifePercentBJ(whichUnit, percent) end
---@param whichUnit unit
---@param percent real
function SetUnitManaPercentBJ(whichUnit, percent) end
---@param whichUnit unit
function IsUnitDeadBJ(whichUnit) end
---@param whichUnit unit
function IsUnitAliveBJ(whichUnit) end
function IsUnitGroupDeadBJEnum() end
---@param g group
function IsUnitGroupDeadBJ(g) end
function IsUnitGroupEmptyBJEnum() end
---@param g group
function IsUnitGroupEmptyBJ(g) end
function IsUnitGroupInRectBJEnum() end
---@param g group
---@param r rect
function IsUnitGroupInRectBJ(g, r) end
---@param whichUnit unit
function IsUnitHiddenBJ(whichUnit) end
---@param whichUnit unit
function ShowUnitHide(whichUnit) end
---@param whichUnit unit
function ShowUnitShow(whichUnit) end
function IssueHauntOrderAtLocBJFilter() end
---@param whichPeon unit
---@param loc location
function IssueHauntOrderAtLocBJ(whichPeon, loc) end
---@param whichPeon unit
---@param unitId integer
---@param loc location
function IssueBuildOrderByIdLocBJ(whichPeon, unitId, loc) end
---@param whichUnit unit
---@param unitId integer
function IssueTrainOrderByIdBJ(whichUnit, unitId) end
---@param g group
---@param unitId integer
function GroupTrainOrderByIdBJ(g, unitId) end
---@param whichUnit unit
---@param techId integer
function IssueUpgradeOrderByIdBJ(whichUnit, techId) end
function GetAttackedUnitBJ() end
---@param whichUnit unit
---@param newHeight real
---@param rate real
function SetUnitFlyHeightBJ(whichUnit, newHeight, rate) end
---@param whichUnit unit
---@param turnSpeed real
function SetUnitTurnSpeedBJ(whichUnit, turnSpeed) end
---@param whichUnit unit
---@param propWindow real
function SetUnitPropWindowBJ(whichUnit, propWindow) end
---@param whichUnit unit
function GetUnitPropWindowBJ(whichUnit) end
---@param whichUnit unit
function GetUnitDefaultPropWindowBJ(whichUnit) end
---@param whichUnit unit
---@param blendTime real
function SetUnitBlendTimeBJ(whichUnit, blendTime) end
---@param whichUnit unit
---@param acquireRange real
function SetUnitAcquireRangeBJ(whichUnit, acquireRange) end
---@param whichUnit unit
---@param canSleep boolean
function UnitSetCanSleepBJ(whichUnit, canSleep) end
---@param whichUnit unit
function UnitCanSleepBJ(whichUnit) end
---@param whichUnit unit
function UnitWakeUpBJ(whichUnit) end
---@param whichUnit unit
function UnitIsSleepingBJ(whichUnit) end
function WakePlayerUnitsEnum() end
---@param whichPlayer player
function WakePlayerUnits(whichPlayer) end
---@param enable boolean
function EnableCreepSleepBJ(enable) end
---@param whichUnit unit
---@param generate boolean
function UnitGenerateAlarms(whichUnit, generate) end
---@param whichUnit unit
function DoesUnitGenerateAlarms(whichUnit) end
function PauseAllUnitsBJEnum() end
---@param pause boolean
function PauseAllUnitsBJ(pause) end
---@param pause boolean
---@param whichUnit unit
function PauseUnitBJ(pause, whichUnit) end
---@param whichUnit unit
function IsUnitPausedBJ(whichUnit) end
---@param flag boolean
---@param whichUnit unit
function UnitPauseTimedLifeBJ(flag, whichUnit) end
---@param duration real
---@param buffId integer
---@param whichUnit unit
function UnitApplyTimedLifeBJ(duration, buffId, whichUnit) end
---@param share boolean
---@param whichUnit unit
---@param whichPlayer player
function UnitShareVisionBJ(share, whichUnit, whichPlayer) end
---@param buffType integer
---@param whichUnit unit
function UnitRemoveBuffsBJ(buffType, whichUnit) end
---@param polarity integer
---@param resist integer
---@param whichUnit unit
---@param bTLife boolean
---@param bAura boolean
function UnitRemoveBuffsExBJ(polarity, resist, whichUnit, bTLife, bAura) end
---@param polarity integer
---@param resist integer
---@param whichUnit unit
---@param bTLife boolean
---@param bAura boolean
function UnitCountBuffsExBJ(polarity, resist, whichUnit, bTLife, bAura) end
---@param abilityId integer
---@param whichUnit unit
function UnitRemoveAbilityBJ(abilityId, whichUnit) end
---@param abilityId integer
---@param whichUnit unit
function UnitAddAbilityBJ(abilityId, whichUnit) end
---@param whichType unittype
---@param whichUnit unit
function UnitRemoveTypeBJ(whichType, whichUnit) end
---@param whichType unittype
---@param whichUnit unit
function UnitAddTypeBJ(whichType, whichUnit) end
---@param permanent boolean
---@param abilityId integer
---@param whichUnit unit
function UnitMakeAbilityPermanentBJ(permanent, abilityId, whichUnit) end
---@param whichUnit unit
---@param exploded boolean
function SetUnitExplodedBJ(whichUnit, exploded) end
---@param whichUnit unit
function ExplodeUnitBJ(whichUnit) end
function GetTransportUnitBJ() end
function GetLoadedUnitBJ() end
---@param whichUnit unit
---@param whichTransport unit
function IsUnitInTransportBJ(whichUnit, whichTransport) end
---@param whichUnit unit
function IsUnitLoadedBJ(whichUnit) end
---@param whichUnit unit
function IsUnitIllusionBJ(whichUnit) end
---@param whichUnit unit
---@param newUnitId integer
---@param unitStateMethod integer
function ReplaceUnitBJ(whichUnit, newUnitId, unitStateMethod) end
function GetLastReplacedUnitBJ() end
---@param whichUnit unit
---@param loc location
---@param facing real
function SetUnitPositionLocFacingBJ(whichUnit, loc, facing) end
---@param whichUnit unit
---@param loc location
---@param lookAt location
function SetUnitPositionLocFacingLocBJ(whichUnit, loc, lookAt) end
---@param itemId integer
---@param whichUnit unit
---@param currentStock integer
---@param stockMax integer
function AddItemToStockBJ(itemId, whichUnit, currentStock, stockMax) end
---@param unitId integer
---@param whichUnit unit
---@param currentStock integer
---@param stockMax integer
function AddUnitToStockBJ(unitId, whichUnit, currentStock, stockMax) end
---@param itemId integer
---@param whichUnit unit
function RemoveItemFromStockBJ(itemId, whichUnit) end
---@param unitId integer
---@param whichUnit unit
function RemoveUnitFromStockBJ(unitId, whichUnit) end
---@param enable boolean
---@param whichUnit unit
function SetUnitUseFoodBJ(enable, whichUnit) end
---@param whichUnit unit
---@param delay real
---@param radius real
---@param loc location
---@param amount real
---@param whichAttack attacktype
---@param whichDamage damagetype
function UnitDamagePointLoc(whichUnit, delay, radius, loc, amount, whichAttack, whichDamage) end
---@param whichUnit unit
---@param target unit
---@param amount real
---@param whichAttack attacktype
---@param whichDamage damagetype
function UnitDamageTargetBJ(whichUnit, target, amount, whichAttack, whichDamage) end
---@param objectid integer
---@param loc location
---@param facing real
---@param scale real
---@param variation integer
function CreateDestructableLoc(objectid, loc, facing, scale, variation) end
---@param objectid integer
---@param loc location
---@param facing real
---@param scale real
---@param variation integer
function CreateDeadDestructableLocBJ(objectid, loc, facing, scale, variation) end
function GetLastCreatedDestructable() end
---@param flag boolean
---@param d destructable
function ShowDestructableBJ(flag, d) end
---@param d destructable
---@param flag boolean
function SetDestructableInvulnerableBJ(d, flag) end
---@param d destructable
function IsDestructableInvulnerableBJ(d) end
---@param whichDestructable destructable
function GetDestructableLoc(whichDestructable) end
---@param r rect
---@param actionFunc code
function EnumDestructablesInRectAll(r, actionFunc) end
function EnumDestructablesInCircleBJFilter() end
---@param d destructable
function IsDestructableDeadBJ(d) end
---@param d destructable
function IsDestructableAliveBJ(d) end
function RandomDestructableInRectBJEnum() end
---@param r rect
---@param filter boolexpr
function RandomDestructableInRectBJ(r, filter) end
---@param r rect
function RandomDestructableInRectSimpleBJ(r) end
---@param radius real
---@param loc location
---@param actionFunc code
function EnumDestructablesInCircleBJ(radius, loc, actionFunc) end
---@param d destructable
---@param percent real
function SetDestructableLifePercentBJ(d, percent) end
---@param d destructable
---@param max real
function SetDestructableMaxLifeBJ(d, max) end
---@param gateOperation integer
---@param d destructable
function ModifyGateBJ(gateOperation, d) end
---@param d destructable
function GetElevatorHeight(d) end
---@param d destructable
---@param newHeight integer
function ChangeElevatorHeight(d, newHeight) end
function NudgeUnitsInRectEnum() end
function NudgeItemsInRectEnum() end
---@param nudgeArea rect
function NudgeObjectsInRect(nudgeArea) end
function NearbyElevatorExistsEnum() end
---@param x real
---@param y real
function NearbyElevatorExists(x, y) end
function FindElevatorWallBlockerEnum() end
---@param x real
---@param y real
---@param facing real
---@param open boolean
function ChangeElevatorWallBlocker(x, y, facing, open) end
---@param open boolean
---@param walls integer
---@param d destructable
function ChangeElevatorWalls(open, walls, d) end
---@param activate boolean
---@param waygate unit
function WaygateActivateBJ(activate, waygate) end
---@param waygate unit
function WaygateIsActiveBJ(waygate) end
---@param waygate unit
---@param loc location
function WaygateSetDestinationLocBJ(waygate, loc) end
---@param waygate unit
function WaygateGetDestinationLocBJ(waygate) end
---@param flag boolean
---@param whichUnit unit
function UnitSetUsesAltIconBJ(flag, whichUnit) end
---@param whichPlayer player
---@param key string
function ForceUIKeyBJ(whichPlayer, key) end
---@param whichPlayer player
function ForceUICancelBJ(whichPlayer) end
---@param whichGroup group
---@param callback code
function ForGroupBJ(whichGroup, callback) end
---@param whichUnit unit
---@param whichGroup group
function GroupAddUnitSimple(whichUnit, whichGroup) end
---@param whichUnit unit
---@param whichGroup group
function GroupRemoveUnitSimple(whichUnit, whichGroup) end
function GroupAddGroupEnum() end
---@param sourceGroup group
---@param destGroup group
function GroupAddGroup(sourceGroup, destGroup) end
function GroupRemoveGroupEnum() end
---@param sourceGroup group
---@param destGroup group
function GroupRemoveGroup(sourceGroup, destGroup) end
---@param whichPlayer player
---@param whichForce force
function ForceAddPlayerSimple(whichPlayer, whichForce) end
---@param whichPlayer player
---@param whichForce force
function ForceRemovePlayerSimple(whichPlayer, whichForce) end
function GroupPickRandomUnitEnum() end
---@param whichGroup group
function GroupPickRandomUnit(whichGroup) end
function ForcePickRandomPlayerEnum() end
---@param whichForce force
function ForcePickRandomPlayer(whichForce) end
---@param whichPlayer player
---@param enumFilter boolexpr
---@param enumAction code
function EnumUnitsSelected(whichPlayer, enumFilter, enumAction) end
---@param r rect
---@param filter boolexpr
function GetUnitsInRectMatching(r, filter) end
---@param r rect
function GetUnitsInRectAll(r) end
function GetUnitsInRectOfPlayerFilter() end
---@param r rect
---@param whichPlayer player
function GetUnitsInRectOfPlayer(r, whichPlayer) end
---@param radius real
---@param whichLocation location
---@param filter boolexpr
function GetUnitsInRangeOfLocMatching(radius, whichLocation, filter) end
---@param radius real
---@param whichLocation location
function GetUnitsInRangeOfLocAll(radius, whichLocation) end
function GetUnitsOfTypeIdAllFilter() end
---@param unitid integer
function GetUnitsOfTypeIdAll(unitid) end
---@param whichPlayer player
---@param filter boolexpr
function GetUnitsOfPlayerMatching(whichPlayer, filter) end
---@param whichPlayer player
function GetUnitsOfPlayerAll(whichPlayer) end
function GetUnitsOfPlayerAndTypeIdFilter() end
---@param whichPlayer player
---@param unitid integer
function GetUnitsOfPlayerAndTypeId(whichPlayer, unitid) end
---@param whichPlayer player
function GetUnitsSelectedAll(whichPlayer) end
---@param whichPlayer player
function GetForceOfPlayer(whichPlayer) end
function GetPlayersAll() end
---@param whichControl mapcontrol
function GetPlayersByMapControl(whichControl) end
---@param whichPlayer player
function GetPlayersAllies(whichPlayer) end
---@param whichPlayer player
function GetPlayersEnemies(whichPlayer) end
---@param filter boolexpr
function GetPlayersMatching(filter) end
function CountUnitsInGroupEnum() end
---@param g group
function CountUnitsInGroup(g) end
function CountPlayersInForceEnum() end
---@param f force
function CountPlayersInForceBJ(f) end
function GetRandomSubGroupEnum() end
---@param count integer
---@param sourceGroup group
function GetRandomSubGroup(count, sourceGroup) end
function LivingPlayerUnitsOfTypeIdFilter() end
---@param unitId integer
---@param whichPlayer player
function CountLivingPlayerUnitsOfTypeId(unitId, whichPlayer) end
---@param whichUnit unit
function ResetUnitAnimation(whichUnit) end
---@param whichUnit unit
---@param percentScale real
function SetUnitTimeScalePercent(whichUnit, percentScale) end
---@param whichUnit unit
---@param percentScaleX real
---@param percentScaleY real
---@param percentScaleZ real
function SetUnitScalePercent(whichUnit, percentScaleX, percentScaleY, percentScaleZ) end
---@param whichUnit unit
---@param red real
---@param green real
---@param blue real
---@param transparency real
function SetUnitVertexColorBJ(whichUnit, red, green, blue, transparency) end
---@param whichUnit unit
---@param red real
---@param green real
---@param blue real
---@param transparency real
function UnitAddIndicatorBJ(whichUnit, red, green, blue, transparency) end
---@param whichDestructable destructable
---@param red real
---@param green real
---@param blue real
---@param transparency real
function DestructableAddIndicatorBJ(whichDestructable, red, green, blue, transparency) end
---@param whichItem item
---@param red real
---@param green real
---@param blue real
---@param transparency real
function ItemAddIndicatorBJ(whichItem, red, green, blue, transparency) end
---@param whichUnit unit
---@param target location
---@param duration real
function SetUnitFacingToFaceLocTimed(whichUnit, target, duration) end
---@param whichUnit unit
---@param target unit
---@param duration real
function SetUnitFacingToFaceUnitTimed(whichUnit, target, duration) end
---@param whichUnit unit
---@param whichAnimation string
function QueueUnitAnimationBJ(whichUnit, whichAnimation) end
---@param d destructable
---@param whichAnimation string
function SetDestructableAnimationBJ(d, whichAnimation) end
---@param d destructable
---@param whichAnimation string
function QueueDestructableAnimationBJ(d, whichAnimation) end
---@param d destructable
---@param percentScale real
function SetDestAnimationSpeedPercent(d, percentScale) end
---@param flag boolean
---@param whichDialog dialog
---@param whichPlayer player
function DialogDisplayBJ(flag, whichDialog, whichPlayer) end
---@param whichDialog dialog
---@param message string
function DialogSetMessageBJ(whichDialog, message) end
---@param whichDialog dialog
---@param buttonText string
function DialogAddButtonBJ(whichDialog, buttonText) end
---@param whichDialog dialog
---@param buttonText string
---@param hotkey integer
function DialogAddButtonWithHotkeyBJ(whichDialog, buttonText, hotkey) end
---@param whichDialog dialog
function DialogClearBJ(whichDialog) end
function GetLastCreatedButtonBJ() end
function GetClickedButtonBJ() end
function GetClickedDialogBJ() end
---@param sourcePlayer player
---@param whichAllianceSetting alliancetype
---@param value boolean
---@param otherPlayer player
function SetPlayerAllianceBJ(sourcePlayer, whichAllianceSetting, value, otherPlayer) end
---@param sourcePlayer player
---@param otherPlayer player
---@param flag boolean
function SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, flag) end
---@param sourcePlayer player
---@param otherPlayer player
---@param flag boolean
function SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, flag) end
---@param sourcePlayer player
---@param otherPlayer player
---@param flag boolean
function SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, flag) end
---@param sourcePlayer player
---@param otherPlayer player
---@param flag boolean
function SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, flag) end
---@param sourcePlayer player
---@param otherPlayer player
---@param allianceState integer
function SetPlayerAllianceStateBJ(sourcePlayer, otherPlayer, allianceState) end
---@param sourceForce force
---@param targetForce force
---@param allianceState integer
function SetForceAllianceStateBJ(sourceForce, targetForce, allianceState) end
---@param playerA player
---@param playerB player
function PlayersAreCoAllied(playerA, playerB) end
---@param whichPlayer player
function ShareEverythingWithTeamAI(whichPlayer) end
---@param whichPlayer player
function ShareEverythingWithTeam(whichPlayer) end
function ConfigureNeutralVictim() end
function MakeUnitsPassiveForPlayerEnum() end
---@param whichPlayer player
function MakeUnitsPassiveForPlayer(whichPlayer) end
---@param whichPlayer player
function MakeUnitsPassiveForTeam(whichPlayer) end
---@param gameResult playergameresult
function AllowVictoryDefeat(gameResult) end
function EndGameBJ() end
---@param whichPlayer player
---@param leftGame boolean
function MeleeVictoryDialogBJ(whichPlayer, leftGame) end
---@param whichPlayer player
---@param leftGame boolean
function MeleeDefeatDialogBJ(whichPlayer, leftGame) end
---@param whichPlayer player
---@param leftGame boolean
function GameOverDialogBJ(whichPlayer, leftGame) end
---@param whichPlayer player
---@param gameResult playergameresult
---@param leftGame boolean
function RemovePlayerPreserveUnitsBJ(whichPlayer, gameResult, leftGame) end
function CustomVictoryOkBJ() end
function CustomVictoryQuitBJ() end
---@param whichPlayer player
function CustomVictoryDialogBJ(whichPlayer) end
---@param whichPlayer player
function CustomVictorySkipBJ(whichPlayer) end
---@param whichPlayer player
---@param showDialog boolean
---@param showScores boolean
function CustomVictoryBJ(whichPlayer, showDialog, showScores) end
function CustomDefeatRestartBJ() end
function CustomDefeatReduceDifficultyBJ() end
function CustomDefeatLoadBJ() end
function CustomDefeatQuitBJ() end
---@param whichPlayer player
---@param message string
function CustomDefeatDialogBJ(whichPlayer, message) end
---@param whichPlayer player
---@param message string
function CustomDefeatBJ(whichPlayer, message) end
---@param nextLevel string
function SetNextLevelBJ(nextLevel) end
---@param flag boolean
---@param whichPlayer player
function SetPlayerOnScoreScreenBJ(flag, whichPlayer) end
---@param questType integer
---@param title string
---@param description string
---@param iconPath string
function CreateQuestBJ(questType, title, description, iconPath) end
---@param whichQuest quest
function DestroyQuestBJ(whichQuest) end
---@param enabled boolean
---@param whichQuest quest
function QuestSetEnabledBJ(enabled, whichQuest) end
---@param whichQuest quest
---@param title string
function QuestSetTitleBJ(whichQuest, title) end
---@param whichQuest quest
---@param description string
function QuestSetDescriptionBJ(whichQuest, description) end
---@param whichQuest quest
---@param completed boolean
function QuestSetCompletedBJ(whichQuest, completed) end
---@param whichQuest quest
---@param failed boolean
function QuestSetFailedBJ(whichQuest, failed) end
---@param whichQuest quest
---@param discovered boolean
function QuestSetDiscoveredBJ(whichQuest, discovered) end
function GetLastCreatedQuestBJ() end
---@param whichQuest quest
---@param description string
function CreateQuestItemBJ(whichQuest, description) end
---@param whichQuestItem questitem
---@param description string
function QuestItemSetDescriptionBJ(whichQuestItem, description) end
---@param whichQuestItem questitem
---@param completed boolean
function QuestItemSetCompletedBJ(whichQuestItem, completed) end
function GetLastCreatedQuestItemBJ() end
---@param description string
function CreateDefeatConditionBJ(description) end
---@param whichCondition defeatcondition
function DestroyDefeatConditionBJ(whichCondition) end
---@param whichCondition defeatcondition
---@param description string
function DefeatConditionSetDescriptionBJ(whichCondition, description) end
function GetLastCreatedDefeatConditionBJ() end
function FlashQuestDialogButtonBJ() end
---@param f force
---@param messageType integer
---@param message string
function QuestMessageBJ(f, messageType, message) end
---@param t timer
---@param periodic boolean
---@param timeout real
function StartTimerBJ(t, periodic, timeout) end
---@param periodic boolean
---@param timeout real
function CreateTimerBJ(periodic, timeout) end
---@param whichTimer timer
function DestroyTimerBJ(whichTimer) end
---@param pause boolean
---@param whichTimer timer
function PauseTimerBJ(pause, whichTimer) end
function GetLastCreatedTimerBJ() end
---@param t timer
---@param title string
function CreateTimerDialogBJ(t, title) end
---@param td timerdialog
function DestroyTimerDialogBJ(td) end
---@param td timerdialog
---@param title string
function TimerDialogSetTitleBJ(td, title) end
---@param td timerdialog
---@param red real
---@param green real
---@param blue real
---@param transparency real
function TimerDialogSetTitleColorBJ(td, red, green, blue, transparency) end
---@param td timerdialog
---@param red real
---@param green real
---@param blue real
---@param transparency real
function TimerDialogSetTimeColorBJ(td, red, green, blue, transparency) end
---@param td timerdialog
---@param speedMultFactor real
function TimerDialogSetSpeedBJ(td, speedMultFactor) end
---@param show boolean
---@param td timerdialog
---@param whichPlayer player
function TimerDialogDisplayForPlayerBJ(show, td, whichPlayer) end
---@param show boolean
---@param td timerdialog
function TimerDialogDisplayBJ(show, td) end
function GetLastCreatedTimerDialogBJ() end
---@param lb leaderboard
function LeaderboardResizeBJ(lb) end
---@param whichPlayer player
---@param lb leaderboard
---@param val integer
function LeaderboardSetPlayerItemValueBJ(whichPlayer, lb, val) end
---@param whichPlayer player
---@param lb leaderboard
---@param val string
function LeaderboardSetPlayerItemLabelBJ(whichPlayer, lb, val) end
---@param whichPlayer player
---@param lb leaderboard
---@param showLabel boolean
---@param showValue boolean
---@param showIcon boolean
function LeaderboardSetPlayerItemStyleBJ(whichPlayer, lb, showLabel, showValue, showIcon) end
---@param whichPlayer player
---@param lb leaderboard
---@param red real
---@param green real
---@param blue real
---@param transparency real
function LeaderboardSetPlayerItemLabelColorBJ(whichPlayer, lb, red, green, blue, transparency) end
---@param whichPlayer player
---@param lb leaderboard
---@param red real
---@param green real
---@param blue real
---@param transparency real
function LeaderboardSetPlayerItemValueColorBJ(whichPlayer, lb, red, green, blue, transparency) end
---@param lb leaderboard
---@param red real
---@param green real
---@param blue real
---@param transparency real
function LeaderboardSetLabelColorBJ(lb, red, green, blue, transparency) end
---@param lb leaderboard
---@param red real
---@param green real
---@param blue real
---@param transparency real
function LeaderboardSetValueColorBJ(lb, red, green, blue, transparency) end
---@param lb leaderboard
---@param label string
function LeaderboardSetLabelBJ(lb, label) end
---@param lb leaderboard
---@param showLabel boolean
---@param showNames boolean
---@param showValues boolean
---@param showIcons boolean
function LeaderboardSetStyleBJ(lb, showLabel, showNames, showValues, showIcons) end
---@param lb leaderboard
function LeaderboardGetItemCountBJ(lb) end
---@param lb leaderboard
---@param whichPlayer player
function LeaderboardHasPlayerItemBJ(lb, whichPlayer) end
---@param lb leaderboard
---@param toForce force
function ForceSetLeaderboardBJ(lb, toForce) end
---@param toForce force
---@param label string
function CreateLeaderboardBJ(toForce, label) end
---@param lb leaderboard
function DestroyLeaderboardBJ(lb) end
---@param show boolean
---@param lb leaderboard
function LeaderboardDisplayBJ(show, lb) end
---@param whichPlayer player
---@param lb leaderboard
---@param label string
---@param value integer
function LeaderboardAddItemBJ(whichPlayer, lb, label, value) end
---@param whichPlayer player
---@param lb leaderboard
function LeaderboardRemovePlayerItemBJ(whichPlayer, lb) end
---@param lb leaderboard
---@param sortType integer
---@param ascending boolean
function LeaderboardSortItemsBJ(lb, sortType, ascending) end
---@param lb leaderboard
---@param ascending boolean
function LeaderboardSortItemsByPlayerBJ(lb, ascending) end
---@param lb leaderboard
---@param ascending boolean
function LeaderboardSortItemsByLabelBJ(lb, ascending) end
---@param whichPlayer player
---@param lb leaderboard
function LeaderboardGetPlayerIndexBJ(whichPlayer, lb) end
---@param position integer
---@param lb leaderboard
function LeaderboardGetIndexedPlayerBJ(position, lb) end
---@param whichPlayer player
function PlayerGetLeaderboardBJ(whichPlayer) end
function GetLastCreatedLeaderboard() end
---@param cols integer
---@param rows integer
---@param title string
function CreateMultiboardBJ(cols, rows, title) end
---@param mb multiboard
function DestroyMultiboardBJ(mb) end
function GetLastCreatedMultiboard() end
---@param show boolean
---@param mb multiboard
function MultiboardDisplayBJ(show, mb) end
---@param minimize boolean
---@param mb multiboard
function MultiboardMinimizeBJ(minimize, mb) end
---@param mb multiboard
---@param red real
---@param green real
---@param blue real
---@param transparency real
function MultiboardSetTitleTextColorBJ(mb, red, green, blue, transparency) end
---@param flag boolean
function MultiboardAllowDisplayBJ(flag) end
---@param mb multiboard
---@param col integer
---@param row integer
---@param showValue boolean
---@param showIcon boolean
function MultiboardSetItemStyleBJ(mb, col, row, showValue, showIcon) end
---@param mb multiboard
---@param col integer
---@param row integer
---@param val string
function MultiboardSetItemValueBJ(mb, col, row, val) end
---@param mb multiboard
---@param col integer
---@param row integer
---@param red real
---@param green real
---@param blue real
---@param transparency real
function MultiboardSetItemColorBJ(mb, col, row, red, green, blue, transparency) end
---@param mb multiboard
---@param col integer
---@param row integer
---@param width real
function MultiboardSetItemWidthBJ(mb, col, row, width) end
---@param mb multiboard
---@param col integer
---@param row integer
---@param iconFileName string
function MultiboardSetItemIconBJ(mb, col, row, iconFileName) end
---@param size real
function TextTagSize2Height(size) end
---@param speed real
function TextTagSpeed2Velocity(speed) end
---@param tt texttag
---@param red real
---@param green real
---@param blue real
---@param transparency real
function SetTextTagColorBJ(tt, red, green, blue, transparency) end
---@param tt texttag
---@param speed real
---@param angle real
function SetTextTagVelocityBJ(tt, speed, angle) end
---@param tt texttag
---@param s string
---@param size real
function SetTextTagTextBJ(tt, s, size) end
---@param tt texttag
---@param loc location
---@param zOffset real
function SetTextTagPosBJ(tt, loc, zOffset) end
---@param tt texttag
---@param whichUnit unit
---@param zOffset real
function SetTextTagPosUnitBJ(tt, whichUnit, zOffset) end
---@param tt texttag
---@param flag boolean
function SetTextTagSuspendedBJ(tt, flag) end
---@param tt texttag
---@param flag boolean
function SetTextTagPermanentBJ(tt, flag) end
---@param tt texttag
---@param age real
function SetTextTagAgeBJ(tt, age) end
---@param tt texttag
---@param lifespan real
function SetTextTagLifespanBJ(tt, lifespan) end
---@param tt texttag
---@param fadepoint real
function SetTextTagFadepointBJ(tt, fadepoint) end
---@param s string
---@param loc location
---@param zOffset real
---@param size real
---@param red real
---@param green real
---@param blue real
---@param transparency real
function CreateTextTagLocBJ(s, loc, zOffset, size, red, green, blue, transparency) end
---@param s string
---@param whichUnit unit
---@param zOffset real
---@param size real
---@param red real
---@param green real
---@param blue real
---@param transparency real
function CreateTextTagUnitBJ(s, whichUnit, zOffset, size, red, green, blue, transparency) end
---@param tt texttag
function DestroyTextTagBJ(tt) end
---@param show boolean
---@param tt texttag
---@param whichForce force
function ShowTextTagForceBJ(show, tt, whichForce) end
function GetLastCreatedTextTag() end
function PauseGameOn() end
function PauseGameOff() end
---@param whichForce force
function SetUserControlForceOn(whichForce) end
---@param whichForce force
function SetUserControlForceOff(whichForce) end
---@param whichForce force
---@param fadeDuration real
function ShowInterfaceForceOn(whichForce, fadeDuration) end
---@param whichForce force
---@param fadeDuration real
function ShowInterfaceForceOff(whichForce, fadeDuration) end
---@param whichForce force
---@param x real
---@param y real
---@param duration real
function PingMinimapForForce(whichForce, x, y, duration) end
---@param whichForce force
---@param loc location
---@param duration real
function PingMinimapLocForForce(whichForce, loc, duration) end
---@param whichPlayer player
---@param x real
---@param y real
---@param duration real
function PingMinimapForPlayer(whichPlayer, x, y, duration) end
---@param whichPlayer player
---@param loc location
---@param duration real
function PingMinimapLocForPlayer(whichPlayer, loc, duration) end
---@param whichForce force
---@param x real
---@param y real
---@param duration real
---@param style integer
---@param red real
---@param green real
---@param blue real
function PingMinimapForForceEx(whichForce, x, y, duration, style, red, green, blue) end
---@param whichForce force
---@param loc location
---@param duration real
---@param style integer
---@param red real
---@param green real
---@param blue real
function PingMinimapLocForForceEx(whichForce, loc, duration, style, red, green, blue) end
---@param enable boolean
---@param f force
function EnableWorldFogBoundaryBJ(enable, f) end
---@param enable boolean
---@param f force
function EnableOcclusionBJ(enable, f) end
function CancelCineSceneBJ() end
function TryInitCinematicBehaviorBJ() end
---@param soundHandle sound
---@param portraitUnitId integer
---@param color playercolor
---@param speakerTitle string
---@param text string
---@param sceneDuration real
---@param voiceoverDuration real
function SetCinematicSceneBJ(soundHandle, portraitUnitId, color, speakerTitle, text, sceneDuration, voiceoverDuration) end
---@param soundHandle sound
---@param timeType integer
---@param timeVal real
function GetTransmissionDuration(soundHandle, timeType, timeVal) end
---@param soundHandle sound
---@param timeType integer
---@param timeVal real
function WaitTransmissionDuration(soundHandle, timeType, timeVal) end
---@param unitId integer
---@param color playercolor
---@param x real
---@param y real
---@param soundHandle sound
---@param unitName string
---@param message string
---@param duration real
function DoTransmissionBasicsXYBJ(unitId, color, x, y, soundHandle, unitName, message, duration) end
---@param toForce force
---@param whichUnit unit
---@param unitName string
---@param soundHandle sound
---@param message string
---@param timeType integer
---@param timeVal real
---@param wait boolean
function TransmissionFromUnitWithNameBJ(toForce, whichUnit, unitName, soundHandle, message, timeType, timeVal, wait) end
---@param toForce force
---@param fromPlayer player
---@param unitId integer
---@param unitName string
---@param loc location
---@param soundHandle sound
---@param message string
---@param timeType integer
---@param timeVal real
---@param wait boolean
function TransmissionFromUnitTypeWithNameBJ(toForce, fromPlayer, unitId, unitName, loc, soundHandle, message, timeType, timeVal, wait) end
function GetLastTransmissionDurationBJ() end
---@param flag boolean
function ForceCinematicSubtitlesBJ(flag) end
---@param cineMode boolean
---@param forForce force
---@param interfaceFadeTime real
function CinematicModeExBJ(cineMode, forForce, interfaceFadeTime) end
---@param cineMode boolean
---@param forForce force
function CinematicModeBJ(cineMode, forForce) end
---@param flag boolean
function DisplayCineFilterBJ(flag) end
---@param red real
---@param green real
---@param blue real
---@param duration real
---@param tex string
---@param startTrans real
---@param endTrans real
function CinematicFadeCommonBJ(red, green, blue, duration, tex, startTrans, endTrans) end
function FinishCinematicFadeBJ() end
---@param duration real
function FinishCinematicFadeAfterBJ(duration) end
function ContinueCinematicFadeBJ() end
---@param duration real
---@param red real
---@param green real
---@param blue real
---@param trans real
---@param tex string
function ContinueCinematicFadeAfterBJ(duration, red, green, blue, trans, tex) end
function AbortCinematicFadeBJ() end
---@param fadetype integer
---@param duration real
---@param tex string
---@param red real
---@param green real
---@param blue real
---@param trans real
function CinematicFadeBJ(fadetype, duration, tex, red, green, blue, trans) end
---@param duration real
---@param bmode blendmode
---@param tex string
---@param red0 real
---@param green0 real
---@param blue0 real
---@param trans0 real
---@param red1 real
---@param green1 real
---@param blue1 real
---@param trans1 real
function CinematicFilterGenericBJ(duration, bmode, tex, red0, green0, blue0, trans0, red1, green1, blue1, trans1) end
---@param whichUnit unit
---@param rescuer player
---@param changeColor boolean
function RescueUnitBJ(whichUnit, rescuer, changeColor) end
function TriggerActionUnitRescuedBJ() end
function TryInitRescuableTriggersBJ() end
---@param changeColor boolean
function SetRescueUnitColorChangeBJ(changeColor) end
---@param changeColor boolean
function SetRescueBuildingColorChangeBJ(changeColor) end
function MakeUnitRescuableToForceBJEnum() end
---@param whichUnit unit
---@param isRescuable boolean
---@param whichForce force
function MakeUnitRescuableToForceBJ(whichUnit, isRescuable, whichForce) end
function InitRescuableBehaviorBJ() end
---@param techid integer
---@param levels integer
---@param whichPlayer player
function SetPlayerTechResearchedSwap(techid, levels, whichPlayer) end
---@param techid integer
---@param maximum integer
---@param whichPlayer player
function SetPlayerTechMaxAllowedSwap(techid, maximum, whichPlayer) end
---@param maximum integer
---@param whichPlayer player
function SetPlayerMaxHeroesAllowed(maximum, whichPlayer) end
---@param techid integer
---@param whichPlayer player
function GetPlayerTechCountSimple(techid, whichPlayer) end
---@param techid integer
---@param whichPlayer player
function GetPlayerTechMaxAllowedSwap(techid, whichPlayer) end
---@param avail boolean
---@param abilid integer
---@param whichPlayer player
function SetPlayerAbilityAvailableBJ(avail, abilid, whichPlayer) end
---@param campaignNumber integer
function SetCampaignMenuRaceBJ(campaignNumber) end
---@param available boolean
---@param missionIndex integer
function SetMissionAvailableBJ(available, missionIndex) end
---@param available boolean
---@param campaignNumber integer
function SetCampaignAvailableBJ(available, campaignNumber) end
---@param available boolean
---@param cinematicIndex integer
function SetCinematicAvailableBJ(available, cinematicIndex) end
---@param campaignFile string
function InitGameCacheBJ(campaignFile) end
---@param cache gamecache
function SaveGameCacheBJ(cache) end
function GetLastCreatedGameCacheBJ() end
function InitHashtableBJ() end
function GetLastCreatedHashtableBJ() end
---@param value real
---@param key string
---@param missionKey string
---@param cache gamecache
function StoreRealBJ(value, key, missionKey, cache) end
---@param value integer
---@param key string
---@param missionKey string
---@param cache gamecache
function StoreIntegerBJ(value, key, missionKey, cache) end
---@param value boolean
---@param key string
---@param missionKey string
---@param cache gamecache
function StoreBooleanBJ(value, key, missionKey, cache) end
---@param value string
---@param key string
---@param missionKey string
---@param cache gamecache
function StoreStringBJ(value, key, missionKey, cache) end
---@param whichUnit unit
---@param key string
---@param missionKey string
---@param cache gamecache
function StoreUnitBJ(whichUnit, key, missionKey, cache) end
---@param value real
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveRealBJ(value, key, missionKey, table) end
---@param value integer
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveIntegerBJ(value, key, missionKey, table) end
---@param value boolean
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveBooleanBJ(value, key, missionKey, table) end
---@param value string
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveStringBJ(value, key, missionKey, table) end
---@param whichPlayer player
---@param key integer
---@param missionKey integer
---@param table hashtable
function SavePlayerHandleBJ(whichPlayer, key, missionKey, table) end
---@param whichWidget widget
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveWidgetHandleBJ(whichWidget, key, missionKey, table) end
---@param whichDestructable destructable
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveDestructableHandleBJ(whichDestructable, key, missionKey, table) end
---@param whichItem item
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveItemHandleBJ(whichItem, key, missionKey, table) end
---@param whichUnit unit
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveUnitHandleBJ(whichUnit, key, missionKey, table) end
---@param whichAbility ability
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveAbilityHandleBJ(whichAbility, key, missionKey, table) end
---@param whichTimer timer
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveTimerHandleBJ(whichTimer, key, missionKey, table) end
---@param whichTrigger trigger
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveTriggerHandleBJ(whichTrigger, key, missionKey, table) end
---@param whichTriggercondition triggercondition
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveTriggerConditionHandleBJ(whichTriggercondition, key, missionKey, table) end
---@param whichTriggeraction triggeraction
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveTriggerActionHandleBJ(whichTriggeraction, key, missionKey, table) end
---@param whichEvent event
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveTriggerEventHandleBJ(whichEvent, key, missionKey, table) end
---@param whichForce force
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveForceHandleBJ(whichForce, key, missionKey, table) end
---@param whichGroup group
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveGroupHandleBJ(whichGroup, key, missionKey, table) end
---@param whichLocation location
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveLocationHandleBJ(whichLocation, key, missionKey, table) end
---@param whichRect rect
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveRectHandleBJ(whichRect, key, missionKey, table) end
---@param whichBoolexpr boolexpr
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveBooleanExprHandleBJ(whichBoolexpr, key, missionKey, table) end
---@param whichSound sound
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveSoundHandleBJ(whichSound, key, missionKey, table) end
---@param whichEffect effect
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveEffectHandleBJ(whichEffect, key, missionKey, table) end
---@param whichUnitpool unitpool
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveUnitPoolHandleBJ(whichUnitpool, key, missionKey, table) end
---@param whichItempool itempool
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveItemPoolHandleBJ(whichItempool, key, missionKey, table) end
---@param whichQuest quest
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveQuestHandleBJ(whichQuest, key, missionKey, table) end
---@param whichQuestitem questitem
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveQuestItemHandleBJ(whichQuestitem, key, missionKey, table) end
---@param whichDefeatcondition defeatcondition
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveDefeatConditionHandleBJ(whichDefeatcondition, key, missionKey, table) end
---@param whichTimerdialog timerdialog
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveTimerDialogHandleBJ(whichTimerdialog, key, missionKey, table) end
---@param whichLeaderboard leaderboard
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveLeaderboardHandleBJ(whichLeaderboard, key, missionKey, table) end
---@param whichMultiboard multiboard
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveMultiboardHandleBJ(whichMultiboard, key, missionKey, table) end
---@param whichMultiboarditem multiboarditem
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveMultiboardItemHandleBJ(whichMultiboarditem, key, missionKey, table) end
---@param whichTrackable trackable
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveTrackableHandleBJ(whichTrackable, key, missionKey, table) end
---@param whichDialog dialog
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveDialogHandleBJ(whichDialog, key, missionKey, table) end
---@param whichButton button
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveButtonHandleBJ(whichButton, key, missionKey, table) end
---@param whichTexttag texttag
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveTextTagHandleBJ(whichTexttag, key, missionKey, table) end
---@param whichLightning lightning
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveLightningHandleBJ(whichLightning, key, missionKey, table) end
---@param whichImage image
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveImageHandleBJ(whichImage, key, missionKey, table) end
---@param whichUbersplat ubersplat
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveUbersplatHandleBJ(whichUbersplat, key, missionKey, table) end
---@param whichRegion region
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveRegionHandleBJ(whichRegion, key, missionKey, table) end
---@param whichFogState fogstate
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveFogStateHandleBJ(whichFogState, key, missionKey, table) end
---@param whichFogModifier fogmodifier
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveFogModifierHandleBJ(whichFogModifier, key, missionKey, table) end
---@param whichAgent agent
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveAgentHandleBJ(whichAgent, key, missionKey, table) end
---@param str string
function FourCC(str) end
---@param whichHashtable hashtable
---@param key integer
---@param missionKey integer
---@param table hashtable
function SaveHashtableHandleBJ(whichHashtable, key, missionKey, table) end
---@param key string
---@param missionKey string
---@param cache gamecache
function GetStoredRealBJ(key, missionKey, cache) end
---@param key string
---@param missionKey string
---@param cache gamecache
function GetStoredIntegerBJ(key, missionKey, cache) end
---@param key string
---@param missionKey string
---@param cache gamecache
function GetStoredBooleanBJ(key, missionKey, cache) end
---@param key string
---@param missionKey string
---@param cache gamecache
function GetStoredStringBJ(key, missionKey, cache) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadRealBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadIntegerBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadBooleanBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadStringBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadPlayerHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadWidgetHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadDestructableHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadItemHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadUnitHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadAbilityHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadTimerHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadTriggerHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadTriggerConditionHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadTriggerActionHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadTriggerEventHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadForceHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadGroupHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadLocationHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadRectHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadBooleanExprHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadSoundHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadEffectHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadUnitPoolHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadItemPoolHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadQuestHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadQuestItemHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadDefeatConditionHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadTimerDialogHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadLeaderboardHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadMultiboardHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadMultiboardItemHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadTrackableHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadDialogHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadButtonHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadTextTagHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadLightningHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadImageHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadUbersplatHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadRegionHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadFogStateHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadFogModifierHandleBJ(key, missionKey, table) end
---@param key integer
---@param missionKey integer
---@param table hashtable
function LoadHashtableHandleBJ(key, missionKey, table) end
---@param key string
---@param missionKey string
---@param cache gamecache
---@param forWhichPlayer player
---@param loc location
---@param facing real
function RestoreUnitLocFacingAngleBJ(key, missionKey, cache, forWhichPlayer, loc, facing) end
---@param key string
---@param missionKey string
---@param cache gamecache
---@param forWhichPlayer player
---@param loc location
---@param lookAt location
function RestoreUnitLocFacingPointBJ(key, missionKey, cache, forWhichPlayer, loc, lookAt) end
function GetLastRestoredUnitBJ() end
---@param cache gamecache
function FlushGameCacheBJ(cache) end
---@param missionKey string
---@param cache gamecache
function FlushStoredMissionBJ(missionKey, cache) end
---@param table hashtable
function FlushParentHashtableBJ(table) end
---@param missionKey integer
---@param table hashtable
function FlushChildHashtableBJ(missionKey, table) end
---@param key string
---@param valueType integer
---@param missionKey string
---@param cache gamecache
function HaveStoredValue(key, valueType, missionKey, cache) end
---@param key integer
---@param valueType integer
---@param missionKey integer
---@param table hashtable
function HaveSavedValue(key, valueType, missionKey, table) end
---@param show boolean
---@param whichButton integer
function ShowCustomCampaignButton(show, whichButton) end
---@param whichButton integer
function IsCustomCampaignButtonVisibile(whichButton) end
---@param loadFileName string
---@param doScoreScreen boolean
function LoadGameBJ(loadFileName, doScoreScreen) end
---@param saveFileName string
---@param newLevel string
---@param doScoreScreen boolean
function SaveAndChangeLevelBJ(saveFileName, newLevel, doScoreScreen) end
---@param saveFileName string
---@param loadFileName string
---@param doScoreScreen boolean
function SaveAndLoadGameBJ(saveFileName, loadFileName, doScoreScreen) end
---@param sourceDirName string
---@param destDirName string
function RenameSaveDirectoryBJ(sourceDirName, destDirName) end
---@param sourceDirName string
function RemoveSaveDirectoryBJ(sourceDirName) end
---@param sourceSaveName string
---@param destSaveName string
function CopySaveGameBJ(sourceSaveName, destSaveName) end
---@param whichPlayer player
function GetPlayerStartLocationX(whichPlayer) end
---@param whichPlayer player
function GetPlayerStartLocationY(whichPlayer) end
---@param whichPlayer player
function GetPlayerStartLocationLoc(whichPlayer) end
---@param whichRect rect
function GetRectCenter(whichRect) end
---@param whichPlayer player
---@param whichState playerslotstate
function IsPlayerSlotState(whichPlayer, whichState) end
---@param seconds real
function GetFadeFromSeconds(seconds) end
---@param seconds real
function GetFadeFromSecondsAsReal(seconds) end
---@param whichPlayer player
---@param whichPlayerState playerstate
---@param delta integer
function AdjustPlayerStateSimpleBJ(whichPlayer, whichPlayerState, delta) end
---@param delta integer
---@param whichPlayer player
---@param whichPlayerState playerstate
function AdjustPlayerStateBJ(delta, whichPlayer, whichPlayerState) end
---@param whichPlayer player
---@param whichPlayerState playerstate
---@param value integer
function SetPlayerStateBJ(whichPlayer, whichPlayerState, value) end
---@param whichPlayerFlag playerstate
---@param flag boolean
---@param whichPlayer player
function SetPlayerFlagBJ(whichPlayerFlag, flag, whichPlayer) end
---@param rate integer
---@param whichResource playerstate
---@param sourcePlayer player
---@param otherPlayer player
function SetPlayerTaxRateBJ(rate, whichResource, sourcePlayer, otherPlayer) end
---@param whichResource playerstate
---@param sourcePlayer player
---@param otherPlayer player
function GetPlayerTaxRateBJ(whichResource, sourcePlayer, otherPlayer) end
---@param whichPlayerFlag playerstate
---@param whichPlayer player
function IsPlayerFlagSetBJ(whichPlayerFlag, whichPlayer) end
---@param delta integer
---@param whichUnit unit
function AddResourceAmountBJ(delta, whichUnit) end
---@param whichPlayer player
function GetConvertedPlayerId(whichPlayer) end
---@param convertedPlayerId integer
function ConvertedPlayer(convertedPlayerId) end
---@param r rect
function GetRectWidthBJ(r) end
---@param r rect
function GetRectHeightBJ(r) end
---@param goldMine unit
---@param whichPlayer player
function BlightGoldMineForPlayerBJ(goldMine, whichPlayer) end
---@param goldMine unit
---@param whichPlayer player
function BlightGoldMineForPlayer(goldMine, whichPlayer) end
function GetLastHauntedGoldMine() end
---@param where location
function IsPointBlightedBJ(where) end
function SetPlayerColorBJEnum() end
---@param whichPlayer player
---@param color playercolor
---@param changeExisting boolean
function SetPlayerColorBJ(whichPlayer, color, changeExisting) end
---@param unitId integer
---@param allowed boolean
---@param whichPlayer player
function SetPlayerUnitAvailableBJ(unitId, allowed, whichPlayer) end
function LockGameSpeedBJ() end
function UnlockGameSpeedBJ() end
---@param whichUnit unit
---@param order string
---@param targetWidget widget
function IssueTargetOrderBJ(whichUnit, order, targetWidget) end
---@param whichUnit unit
---@param order string
---@param whichLocation location
function IssuePointOrderLocBJ(whichUnit, order, whichLocation) end
---@param whichUnit unit
---@param order string
---@param targetWidget widget
function IssueTargetDestructableOrder(whichUnit, order, targetWidget) end
---@param whichUnit unit
---@param order string
---@param targetWidget widget
function IssueTargetItemOrder(whichUnit, order, targetWidget) end
---@param whichUnit unit
---@param order string
function IssueImmediateOrderBJ(whichUnit, order) end
---@param whichGroup group
---@param order string
---@param targetWidget widget
function GroupTargetOrderBJ(whichGroup, order, targetWidget) end
---@param whichGroup group
---@param order string
---@param whichLocation location
function GroupPointOrderLocBJ(whichGroup, order, whichLocation) end
---@param whichGroup group
---@param order string
function GroupImmediateOrderBJ(whichGroup, order) end
---@param whichGroup group
---@param order string
---@param targetWidget widget
function GroupTargetDestructableOrder(whichGroup, order, targetWidget) end
---@param whichGroup group
---@param order string
---@param targetWidget widget
function GroupTargetItemOrder(whichGroup, order, targetWidget) end
function GetDyingDestructable() end
---@param whichUnit unit
---@param targPos location
function SetUnitRallyPoint(whichUnit, targPos) end
---@param whichUnit unit
---@param targUnit unit
function SetUnitRallyUnit(whichUnit, targUnit) end
---@param whichUnit unit
---@param targDest destructable
function SetUnitRallyDestructable(whichUnit, targDest) end
function SaveDyingWidget() end
---@param addBlight boolean
---@param whichPlayer player
---@param r rect
function SetBlightRectBJ(addBlight, whichPlayer, r) end
---@param addBlight boolean
---@param whichPlayer player
---@param loc location
---@param radius real
function SetBlightRadiusLocBJ(addBlight, whichPlayer, loc, radius) end
---@param abilcode integer
function GetAbilityName(abilcode) end
function MeleeStartingVisibility() end
function MeleeStartingResources() end
---@param whichPlayer player
---@param techId integer
---@param limit integer
function ReducePlayerTechMaxAllowed(whichPlayer, techId, limit) end
function MeleeStartingHeroLimit() end
function MeleeTrainedUnitIsHeroBJFilter() end
---@param whichUnit unit
function MeleeGrantItemsToHero(whichUnit) end
function MeleeGrantItemsToTrainedHero() end
function MeleeGrantItemsToHiredHero() end
function MeleeGrantHeroItems() end
function MeleeClearExcessUnit() end
---@param x real
---@param y real
---@param range real
function MeleeClearNearbyUnits(x, y, range) end
function MeleeClearExcessUnits() end
function MeleeEnumFindNearestMine() end
---@param src location
---@param range real
function MeleeFindNearestMine(src, range) end
---@param p player
---@param id1 integer
---@param id2 integer
---@param id3 integer
---@param id4 integer
---@param loc location
function MeleeRandomHeroLoc(p, id1, id2, id3, id4, loc) end
---@param src location
---@param targ location
---@param distance real
---@param deltaAngle real
function MeleeGetProjectedLoc(src, targ, distance, deltaAngle) end
---@param val real
---@param minVal real
---@param maxVal real
function MeleeGetNearestValueWithin(val, minVal, maxVal) end
---@param src location
---@param r rect
function MeleeGetLocWithinRect(src, r) end
---@param whichPlayer player
---@param startLoc location
---@param doHeroes boolean
---@param doCamera boolean
---@param doPreload boolean
function MeleeStartingUnitsHuman(whichPlayer, startLoc, doHeroes, doCamera, doPreload) end
---@param whichPlayer player
---@param startLoc location
---@param doHeroes boolean
---@param doCamera boolean
---@param doPreload boolean
function MeleeStartingUnitsOrc(whichPlayer, startLoc, doHeroes, doCamera, doPreload) end
---@param whichPlayer player
---@param startLoc location
---@param doHeroes boolean
---@param doCamera boolean
---@param doPreload boolean
function MeleeStartingUnitsUndead(whichPlayer, startLoc, doHeroes, doCamera, doPreload) end
---@param whichPlayer player
---@param startLoc location
---@param doHeroes boolean
---@param doCamera boolean
---@param doPreload boolean
function MeleeStartingUnitsNightElf(whichPlayer, startLoc, doHeroes, doCamera, doPreload) end
---@param whichPlayer player
---@param startLoc location
---@param doHeroes boolean
---@param doCamera boolean
---@param doPreload boolean
function MeleeStartingUnitsUnknownRace(whichPlayer, startLoc, doHeroes, doCamera, doPreload) end
function MeleeStartingUnits() end
---@param whichRace race
---@param whichPlayer player
---@param loc location
---@param doHeroes boolean
function MeleeStartingUnitsForPlayer(whichRace, whichPlayer, loc, doHeroes) end
---@param num player
---@param s1 string
---@param s2 string
---@param s3 string
function PickMeleeAI(num, s1, s2, s3) end
function MeleeStartingAI() end
---@param targ unit
function LockGuardPosition(targ) end
---@param playerIndex integer
---@param opponentIndex integer
function MeleePlayerIsOpponent(playerIndex, opponentIndex) end
---@param whichPlayer player
function MeleeGetAllyStructureCount(whichPlayer) end
---@param whichPlayer player
function MeleeGetAllyCount(whichPlayer) end
---@param whichPlayer player
function MeleeGetAllyKeyStructureCount(whichPlayer) end
function MeleeDoDrawEnum() end
function MeleeDoVictoryEnum() end
---@param whichPlayer player
function MeleeDoDefeat(whichPlayer) end
function MeleeDoDefeatEnum() end
---@param whichPlayer player
function MeleeDoLeave(whichPlayer) end
function MeleeRemoveObservers() end
function MeleeCheckForVictors() end
function MeleeCheckForLosersAndVictors() end
---@param whichPlayer player
function MeleeGetCrippledWarningMessage(whichPlayer) end
---@param whichPlayer player
function MeleeGetCrippledTimerMessage(whichPlayer) end
---@param whichPlayer player
function MeleeGetCrippledRevealedMessage(whichPlayer) end
---@param whichPlayer player
---@param expose boolean
function MeleeExposePlayer(whichPlayer, expose) end
function MeleeExposeAllPlayers() end
function MeleeCrippledPlayerTimeout() end
---@param whichPlayer player
function MeleePlayerIsCrippled(whichPlayer) end
function MeleeCheckForCrippledPlayers() end
---@param lostUnit unit
function MeleeCheckLostUnit(lostUnit) end
---@param addedUnit unit
function MeleeCheckAddedUnit(addedUnit) end
function MeleeTriggerActionConstructCancel() end
function MeleeTriggerActionUnitDeath() end
function MeleeTriggerActionUnitConstructionStart() end
function MeleeTriggerActionPlayerDefeated() end
function MeleeTriggerActionPlayerLeft() end
function MeleeTriggerActionAllianceChange() end
function MeleeTriggerTournamentFinishSoon() end
---@param whichPlayer player
function MeleeWasUserPlayer(whichPlayer) end
---@param multiplier integer
function MeleeTournamentFinishNowRuleA(multiplier) end
function MeleeTriggerTournamentFinishNow() end
function MeleeInitVictoryDefeat() end
function CheckInitPlayerSlotAvailability() end
---@param whichPlayer player
---@param control mapcontrol
function SetPlayerSlotAvailable(whichPlayer, control) end
---@param teamCount integer
function TeamInitPlayerSlots(teamCount) end
function MeleeInitPlayerSlots() end
function FFAInitPlayerSlots() end
function OneOnOneInitPlayerSlots() end
function InitGenericPlayerSlots() end
function SetDNCSoundsDawn() end
function SetDNCSoundsDusk() end
function SetDNCSoundsDay() end
function SetDNCSoundsNight() end
function InitDNCSounds() end
function InitBlizzardGlobals() end
function InitQueuedTriggers() end
function InitMapRects() end
function InitSummonableCaps() end
---@param whichItem item
function UpdateStockAvailability(whichItem) end
function UpdateEachStockBuildingEnum() end
---@param iType itemtype
---@param iLevel integer
function UpdateEachStockBuilding(iType, iLevel) end
function PerformStockUpdates() end
function StartStockUpdates() end
function RemovePurchasedItem() end
function InitNeutralBuildings() end
function MarkGameStarted() end
function DetectGameStarted() end
function InitBlizzard() end
function RandomDistReset() end
---@param inID integer
---@param inChance integer
function RandomDistAddItem(inID, inChance) end
function RandomDistChoose() end
---@param inUnit unit
---@param inItemID integer
function UnitDropItem(inUnit, inItemID) end
---@param inWidget widget
---@param inItemID integer
function WidgetDropItem(inWidget, inItemID) end
function BlzIsLastInstanceObjectFunctionSuccessful() end
---@param whichAbility ability
---@param whichField abilitybooleanfield
---@param value boolean
function BlzSetAbilityBooleanFieldBJ(whichAbility, whichField, value) end
---@param whichAbility ability
---@param whichField abilityintegerfield
---@param value integer
function BlzSetAbilityIntegerFieldBJ(whichAbility, whichField, value) end
---@param whichAbility ability
---@param whichField abilityfloatfield
---@param value real
function BlzSetAbilityRealFieldBJ(whichAbility, whichField, value) end
---@param whichAbility ability
---@param whichField abilitystringfield
---@param value string
function BlzSetAbilityStringFieldBJ(whichAbility, whichField, value) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelfield
---@param level integer
---@param value boolean
function BlzSetAbilityBooleanLevelFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityintegerlevelfield
---@param level integer
---@param value integer
function BlzSetAbilityIntegerLevelFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityfloatlevelfield
---@param level integer
---@param value real
function BlzSetAbilityRealLevelFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitystringlevelfield
---@param level integer
---@param value string
function BlzSetAbilityStringLevelFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelarrayfield
---@param level integer
---@param index integer
---@param value boolean
function BlzSetAbilityBooleanLevelArrayFieldBJ(whichAbility, whichField, level, index, value) end
---@param whichAbility ability
---@param whichField abilityintegerlevelarrayfield
---@param level integer
---@param index integer
---@param value integer
function BlzSetAbilityIntegerLevelArrayFieldBJ(whichAbility, whichField, level, index, value) end
---@param whichAbility ability
---@param whichField abilityfloatlevelarrayfield
---@param level integer
---@param index integer
---@param value real
function BlzSetAbilityRealLevelArrayFieldBJ(whichAbility, whichField, level, index, value) end
---@param whichAbility ability
---@param whichField abilitystringlevelarrayfield
---@param level integer
---@param index integer
---@param value string
function BlzSetAbilityStringLevelArrayFieldBJ(whichAbility, whichField, level, index, value) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelarrayfield
---@param level integer
---@param value boolean
function BlzAddAbilityBooleanLevelArrayFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityintegerlevelarrayfield
---@param level integer
---@param value integer
function BlzAddAbilityIntegerLevelArrayFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityfloatlevelarrayfield
---@param level integer
---@param value real
function BlzAddAbilityRealLevelArrayFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitystringlevelarrayfield
---@param level integer
---@param value string
function BlzAddAbilityStringLevelArrayFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelarrayfield
---@param level integer
---@param value boolean
function BlzRemoveAbilityBooleanLevelArrayFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityintegerlevelarrayfield
---@param level integer
---@param value integer
function BlzRemoveAbilityIntegerLevelArrayFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityfloatlevelarrayfield
---@param level integer
---@param value real
function BlzRemoveAbilityRealLevelArrayFieldBJ(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitystringlevelarrayfield
---@param level integer
---@param value string
function BlzRemoveAbilityStringLevelArrayFieldBJ(whichAbility, whichField, level, value) end
---@param whichItem item
---@param abilCode integer
function BlzItemAddAbilityBJ(whichItem, abilCode) end
---@param whichItem item
---@param abilCode integer
function BlzItemRemoveAbilityBJ(whichItem, abilCode) end
---@param whichItem item
---@param whichField itembooleanfield
---@param value boolean
function BlzSetItemBooleanFieldBJ(whichItem, whichField, value) end
---@param whichItem item
---@param whichField itemintegerfield
---@param value integer
function BlzSetItemIntegerFieldBJ(whichItem, whichField, value) end
---@param whichItem item
---@param whichField itemfloatfield
---@param value real
function BlzSetItemRealFieldBJ(whichItem, whichField, value) end
---@param whichItem item
---@param whichField itemstringfield
---@param value string
function BlzSetItemStringFieldBJ(whichItem, whichField, value) end
---@param whichUnit unit
---@param whichField unitbooleanfield
---@param value boolean
function BlzSetUnitBooleanFieldBJ(whichUnit, whichField, value) end
---@param whichUnit unit
---@param whichField unitintegerfield
---@param value integer
function BlzSetUnitIntegerFieldBJ(whichUnit, whichField, value) end
---@param whichUnit unit
---@param whichField unitfloatfield
---@param value real
function BlzSetUnitRealFieldBJ(whichUnit, whichField, value) end
---@param whichUnit unit
---@param whichField unitstringfield
---@param value string
function BlzSetUnitStringFieldBJ(whichUnit, whichField, value) end
---@param whichUnit unit
---@param whichField unitweaponbooleanfield
---@param index integer
---@param value boolean
function BlzSetUnitWeaponBooleanFieldBJ(whichUnit, whichField, index, value) end
---@param whichUnit unit
---@param whichField unitweaponintegerfield
---@param index integer
---@param value integer
function BlzSetUnitWeaponIntegerFieldBJ(whichUnit, whichField, index, value) end
---@param whichUnit unit
---@param whichField unitweaponfloatfield
---@param index integer
---@param value real
function BlzSetUnitWeaponRealFieldBJ(whichUnit, whichField, index, value) end
---@param whichUnit unit
---@param whichField unitweaponstringfield
---@param index integer
---@param value string
function BlzSetUnitWeaponStringFieldBJ(whichUnit, whichField, index, value) end
---@param i integer
function ConvertRace(i) end
---@param i integer
function ConvertAllianceType(i) end
---@param i integer
function ConvertRacePref(i) end
---@param i integer
function ConvertIGameState(i) end
---@param i integer
function ConvertFGameState(i) end
---@param i integer
function ConvertPlayerState(i) end
---@param i integer
function ConvertPlayerScore(i) end
---@param i integer
function ConvertPlayerGameResult(i) end
---@param i integer
function ConvertUnitState(i) end
---@param i integer
function ConvertAIDifficulty(i) end
---@param i integer
function ConvertGameEvent(i) end
---@param i integer
function ConvertPlayerEvent(i) end
---@param i integer
function ConvertPlayerUnitEvent(i) end
---@param i integer
function ConvertWidgetEvent(i) end
---@param i integer
function ConvertDialogEvent(i) end
---@param i integer
function ConvertUnitEvent(i) end
---@param i integer
function ConvertLimitOp(i) end
---@param i integer
function ConvertUnitType(i) end
---@param i integer
function ConvertGameSpeed(i) end
---@param i integer
function ConvertPlacement(i) end
---@param i integer
function ConvertStartLocPrio(i) end
---@param i integer
function ConvertGameDifficulty(i) end
---@param i integer
function ConvertGameType(i) end
---@param i integer
function ConvertMapFlag(i) end
---@param i integer
function ConvertMapVisibility(i) end
---@param i integer
function ConvertMapSetting(i) end
---@param i integer
function ConvertMapDensity(i) end
---@param i integer
function ConvertMapControl(i) end
---@param i integer
function ConvertPlayerColor(i) end
---@param i integer
function ConvertPlayerSlotState(i) end
---@param i integer
function ConvertVolumeGroup(i) end
---@param i integer
function ConvertCameraField(i) end
---@param i integer
function ConvertBlendMode(i) end
---@param i integer
function ConvertRarityControl(i) end
---@param i integer
function ConvertTexMapFlags(i) end
---@param i integer
function ConvertFogState(i) end
---@param i integer
function ConvertEffectType(i) end
---@param i integer
function ConvertVersion(i) end
---@param i integer
function ConvertItemType(i) end
---@param i integer
function ConvertAttackType(i) end
---@param i integer
function ConvertDamageType(i) end
---@param i integer
function ConvertWeaponType(i) end
---@param i integer
function ConvertSoundType(i) end
---@param i integer
function ConvertPathingType(i) end
---@param i integer
function ConvertMouseButtonType(i) end
---@param i integer
function ConvertAnimType(i) end
---@param i integer
function ConvertSubAnimType(i) end
---@param i integer
function ConvertOriginFrameType(i) end
---@param i integer
function ConvertFramePointType(i) end
---@param i integer
function ConvertTextAlignType(i) end
---@param i integer
function ConvertFrameEventType(i) end
---@param i integer
function ConvertOsKeyType(i) end
---@param i integer
function ConvertAbilityIntegerField(i) end
---@param i integer
function ConvertAbilityRealField(i) end
---@param i integer
function ConvertAbilityBooleanField(i) end
---@param i integer
function ConvertAbilityStringField(i) end
---@param i integer
function ConvertAbilityIntegerLevelField(i) end
---@param i integer
function ConvertAbilityRealLevelField(i) end
---@param i integer
function ConvertAbilityBooleanLevelField(i) end
---@param i integer
function ConvertAbilityStringLevelField(i) end
---@param i integer
function ConvertAbilityIntegerLevelArrayField(i) end
---@param i integer
function ConvertAbilityRealLevelArrayField(i) end
---@param i integer
function ConvertAbilityBooleanLevelArrayField(i) end
---@param i integer
function ConvertAbilityStringLevelArrayField(i) end
---@param i integer
function ConvertUnitIntegerField(i) end
---@param i integer
function ConvertUnitRealField(i) end
---@param i integer
function ConvertUnitBooleanField(i) end
---@param i integer
function ConvertUnitStringField(i) end
---@param i integer
function ConvertUnitWeaponIntegerField(i) end
---@param i integer
function ConvertUnitWeaponRealField(i) end
---@param i integer
function ConvertUnitWeaponBooleanField(i) end
---@param i integer
function ConvertUnitWeaponStringField(i) end
---@param i integer
function ConvertItemIntegerField(i) end
---@param i integer
function ConvertItemRealField(i) end
---@param i integer
function ConvertItemBooleanField(i) end
---@param i integer
function ConvertItemStringField(i) end
---@param i integer
function ConvertMoveType(i) end
---@param i integer
function ConvertTargetFlag(i) end
---@param i integer
function ConvertArmorType(i) end
---@param i integer
function ConvertHeroAttribute(i) end
---@param i integer
function ConvertDefenseType(i) end
---@param i integer
function ConvertRegenType(i) end
---@param i integer
function ConvertUnitCategory(i) end
---@param i integer
function ConvertPathingFlag(i) end
---@param  orderIdString string
function OrderId( orderIdString) end
---@param orderId integer
function OrderId2String(orderId) end
---@param  unitIdString string
function UnitId( unitIdString) end
---@param unitId integer
function UnitId2String(unitId) end
---@param  abilityIdString string
function AbilityId( abilityIdString) end
---@param abilityId integer
function AbilityId2String(abilityId) end
---@param objectId integer
function GetObjectName(objectId) end
function GetBJMaxPlayers() end
function GetBJPlayerNeutralVictim() end
function GetBJPlayerNeutralExtra() end
function GetBJMaxPlayerSlots() end
function GetPlayerNeutralPassive() end
function GetPlayerNeutralAggressive() end
---@param degrees real
function Deg2Rad(degrees) end
---@param radians real
function Rad2Deg(radians) end
---@param radians real
function Sin(radians) end
---@param radians real
function Cos(radians) end
---@param radians real
function Tan(radians) end
---@param y real
function Asin(y) end
---@param x real
function Acos(x) end
---@param x real
function Atan(x) end
---@param y real
---@param x real
function Atan2(y, x) end
---@param x real
function SquareRoot(x) end
---@param x real
---@param power real
function Pow(x, power) end
---@param i integer
function I2R(i) end
---@param r real
function R2I(r) end
---@param i integer
function I2S(i) end
---@param r real
function R2S(r) end
---@param r real
---@param width integer
---@param precision integer
function R2SW(r, width, precision) end
---@param s string
function S2I(s) end
---@param s string
function S2R(s) end
---@param h handle
function GetHandleId(h) end
---@param source string
---@param start integer
---@param _end integer
function SubString(source, start, _end) end
---@param s string
function StringLength(s) end
---@param source string
---@param upper boolean
function StringCase(source, upper) end
---@param s string
function StringHash(s) end
---@param source string
function GetLocalizedString(source) end
---@param source string
function GetLocalizedHotkey(source) end
---@param name string
function SetMapName(name) end
---@param description string
function SetMapDescription(description) end
---@param teamcount integer
function SetTeams(teamcount) end
---@param playercount integer
function SetPlayers(playercount) end
---@param whichStartLoc integer
---@param x real
---@param y real
function DefineStartLocation(whichStartLoc, x, y) end
---@param whichStartLoc integer
---@param whichLocation location
function DefineStartLocationLoc(whichStartLoc, whichLocation) end
---@param whichStartLoc integer
---@param prioSlotCount integer
function SetStartLocPrioCount(whichStartLoc, prioSlotCount) end
---@param whichStartLoc integer
---@param prioSlotIndex integer
---@param otherStartLocIndex integer
---@param priority startlocprio
function SetStartLocPrio(whichStartLoc, prioSlotIndex, otherStartLocIndex, priority) end
---@param whichStartLoc integer
---@param prioSlotIndex integer
function GetStartLocPrioSlot(whichStartLoc, prioSlotIndex) end
---@param whichStartLoc integer
---@param prioSlotIndex integer
function GetStartLocPrio(whichStartLoc, prioSlotIndex) end
---@param whichGameType gametype
---@param value boolean
function SetGameTypeSupported(whichGameType, value) end
---@param whichMapFlag mapflag
---@param value boolean
function SetMapFlag(whichMapFlag, value) end
---@param whichPlacementType placement
function SetGamePlacement(whichPlacementType) end
---@param whichspeed gamespeed
function SetGameSpeed(whichspeed) end
---@param whichdifficulty gamedifficulty
function SetGameDifficulty(whichdifficulty) end
---@param whichdensity mapdensity
function SetResourceDensity(whichdensity) end
---@param whichdensity mapdensity
function SetCreatureDensity(whichdensity) end
function GetTeams() end
function GetPlayers() end
---@param whichGameType gametype
function IsGameTypeSupported(whichGameType) end
function GetGameTypeSelected() end
---@param whichMapFlag mapflag
function IsMapFlagSet(whichMapFlag) end
function GetGamePlacement() end
function GetGameSpeed() end
function GetGameDifficulty() end
function GetResourceDensity() end
function GetCreatureDensity() end
---@param whichStartLocation integer
function GetStartLocationX(whichStartLocation) end
---@param whichStartLocation integer
function GetStartLocationY(whichStartLocation) end
---@param whichStartLocation integer
function GetStartLocationLoc(whichStartLocation) end
---@param whichPlayer player
---@param whichTeam integer
function SetPlayerTeam(whichPlayer, whichTeam) end
---@param whichPlayer player
---@param startLocIndex integer
function SetPlayerStartLocation(whichPlayer, startLocIndex) end
---@param whichPlayer player
---@param startLocIndex integer
function ForcePlayerStartLocation(whichPlayer, startLocIndex) end
---@param whichPlayer player
---@param color playercolor
function SetPlayerColor(whichPlayer, color) end
---@param sourcePlayer player
---@param otherPlayer player
---@param whichAllianceSetting alliancetype
---@param value boolean
function SetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting, value) end
---@param sourcePlayer player
---@param otherPlayer player
---@param whichResource playerstate
---@param rate integer
function SetPlayerTaxRate(sourcePlayer, otherPlayer, whichResource, rate) end
---@param whichPlayer player
---@param whichRacePreference racepreference
function SetPlayerRacePreference(whichPlayer, whichRacePreference) end
---@param whichPlayer player
---@param value boolean
function SetPlayerRaceSelectable(whichPlayer, value) end
---@param whichPlayer player
---@param controlType mapcontrol
function SetPlayerController(whichPlayer, controlType) end
---@param whichPlayer player
---@param name string
function SetPlayerName(whichPlayer, name) end
---@param whichPlayer player
---@param flag boolean
function SetPlayerOnScoreScreen(whichPlayer, flag) end
---@param whichPlayer player
function GetPlayerTeam(whichPlayer) end
---@param whichPlayer player
function GetPlayerStartLocation(whichPlayer) end
---@param whichPlayer player
function GetPlayerColor(whichPlayer) end
---@param whichPlayer player
function GetPlayerSelectable(whichPlayer) end
---@param whichPlayer player
function GetPlayerController(whichPlayer) end
---@param whichPlayer player
function GetPlayerSlotState(whichPlayer) end
---@param sourcePlayer player
---@param otherPlayer player
---@param whichResource playerstate
function GetPlayerTaxRate(sourcePlayer, otherPlayer, whichResource) end
---@param whichPlayer player
---@param pref racepreference
function IsPlayerRacePrefSet(whichPlayer, pref) end
---@param whichPlayer player
function GetPlayerName(whichPlayer) end
function CreateTimer() end
---@param whichTimer timer
function DestroyTimer(whichTimer) end
---@param whichTimer timer
---@param timeout real
---@param periodic boolean
---@param handlerFunc code
function TimerStart(whichTimer, timeout, periodic, handlerFunc) end
---@param whichTimer timer
function TimerGetElapsed(whichTimer) end
---@param whichTimer timer
function TimerGetRemaining(whichTimer) end
---@param whichTimer timer
function TimerGetTimeout(whichTimer) end
---@param whichTimer timer
function PauseTimer(whichTimer) end
---@param whichTimer timer
function ResumeTimer(whichTimer) end
function GetExpiredTimer() end
function CreateGroup() end
---@param whichGroup group
function DestroyGroup(whichGroup) end
---@param whichGroup group
---@param whichUnit unit
function GroupAddUnit(whichGroup, whichUnit) end
---@param whichGroup group
---@param whichUnit unit
function GroupRemoveUnit(whichGroup, whichUnit) end
---@param whichGroup group
---@param addGroup group
function BlzGroupAddGroupFast(whichGroup, addGroup) end
---@param whichGroup group
---@param removeGroup group
function BlzGroupRemoveGroupFast(whichGroup, removeGroup) end
---@param whichGroup group
function GroupClear(whichGroup) end
---@param whichGroup group
function BlzGroupGetSize(whichGroup) end
---@param whichGroup group
---@param index integer
function BlzGroupUnitAt(whichGroup, index) end
---@param whichGroup group
---@param unitname string
---@param filter boolexpr
function GroupEnumUnitsOfType(whichGroup, unitname, filter) end
---@param whichGroup group
---@param whichPlayer player
---@param filter boolexpr
function GroupEnumUnitsOfPlayer(whichGroup, whichPlayer, filter) end
---@param whichGroup group
---@param unitname string
---@param filter boolexpr
---@param countLimit integer
function GroupEnumUnitsOfTypeCounted(whichGroup, unitname, filter, countLimit) end
---@param whichGroup group
---@param r rect
---@param filter boolexpr
function GroupEnumUnitsInRect(whichGroup, r, filter) end
---@param whichGroup group
---@param r rect
---@param filter boolexpr
---@param countLimit integer
function GroupEnumUnitsInRectCounted(whichGroup, r, filter, countLimit) end
---@param whichGroup group
---@param x real
---@param y real
---@param radius real
---@param filter boolexpr
function GroupEnumUnitsInRange(whichGroup, x, y, radius, filter) end
---@param whichGroup group
---@param whichLocation location
---@param radius real
---@param filter boolexpr
function GroupEnumUnitsInRangeOfLoc(whichGroup, whichLocation, radius, filter) end
---@param whichGroup group
---@param x real
---@param y real
---@param radius real
---@param filter boolexpr
---@param countLimit integer
function GroupEnumUnitsInRangeCounted(whichGroup, x, y, radius, filter, countLimit) end
---@param whichGroup group
---@param whichLocation location
---@param radius real
---@param filter boolexpr
---@param countLimit integer
function GroupEnumUnitsInRangeOfLocCounted(whichGroup, whichLocation, radius, filter, countLimit) end
---@param whichGroup group
---@param whichPlayer player
---@param filter boolexpr
function GroupEnumUnitsSelected(whichGroup, whichPlayer, filter) end
---@param whichGroup group
---@param order string
function GroupImmediateOrder(whichGroup, order) end
---@param whichGroup group
---@param order integer
function GroupImmediateOrderById(whichGroup, order) end
---@param whichGroup group
---@param order string
---@param x real
---@param y real
function GroupPointOrder(whichGroup, order, x, y) end
---@param whichGroup group
---@param order string
---@param whichLocation location
function GroupPointOrderLoc(whichGroup, order, whichLocation) end
---@param whichGroup group
---@param order integer
---@param x real
---@param y real
function GroupPointOrderById(whichGroup, order, x, y) end
---@param whichGroup group
---@param order integer
---@param whichLocation location
function GroupPointOrderByIdLoc(whichGroup, order, whichLocation) end
---@param whichGroup group
---@param order string
---@param targetWidget widget
function GroupTargetOrder(whichGroup, order, targetWidget) end
---@param whichGroup group
---@param order integer
---@param targetWidget widget
function GroupTargetOrderById(whichGroup, order, targetWidget) end
---@param whichGroup group
---@param callback code
function ForGroup(whichGroup, callback) end
---@param whichGroup group
function FirstOfGroup(whichGroup) end
function CreateForce() end
---@param whichForce force
function DestroyForce(whichForce) end
---@param whichForce force
---@param whichPlayer player
function ForceAddPlayer(whichForce, whichPlayer) end
---@param whichForce force
---@param whichPlayer player
function ForceRemovePlayer(whichForce, whichPlayer) end
---@param whichForce force
---@param whichPlayer player
function BlzForceHasPlayer(whichForce, whichPlayer) end
---@param whichForce force
function ForceClear(whichForce) end
---@param whichForce force
---@param filter boolexpr
function ForceEnumPlayers(whichForce, filter) end
---@param whichForce force
---@param filter boolexpr
---@param countLimit integer
function ForceEnumPlayersCounted(whichForce, filter, countLimit) end
---@param whichForce force
---@param whichPlayer player
---@param filter boolexpr
function ForceEnumAllies(whichForce, whichPlayer, filter) end
---@param whichForce force
---@param whichPlayer player
---@param filter boolexpr
function ForceEnumEnemies(whichForce, whichPlayer, filter) end
---@param whichForce force
---@param callback code
function ForForce(whichForce, callback) end
---@param minx real
---@param miny real
---@param maxx real
---@param maxy real
function Rect(minx, miny, maxx, maxy) end
---@param min location
---@param max location
function RectFromLoc(min, max) end
---@param whichRect rect
function RemoveRect(whichRect) end
---@param whichRect rect
---@param minx real
---@param miny real
---@param maxx real
---@param maxy real
function SetRect(whichRect, minx, miny, maxx, maxy) end
---@param whichRect rect
---@param min location
---@param max location
function SetRectFromLoc(whichRect, min, max) end
---@param whichRect rect
---@param newCenterX real
---@param newCenterY real
function MoveRectTo(whichRect, newCenterX, newCenterY) end
---@param whichRect rect
---@param newCenterLoc location
function MoveRectToLoc(whichRect, newCenterLoc) end
---@param whichRect rect
function GetRectCenterX(whichRect) end
---@param whichRect rect
function GetRectCenterY(whichRect) end
---@param whichRect rect
function GetRectMinX(whichRect) end
---@param whichRect rect
function GetRectMinY(whichRect) end
---@param whichRect rect
function GetRectMaxX(whichRect) end
---@param whichRect rect
function GetRectMaxY(whichRect) end
function CreateRegion() end
---@param whichRegion region
function RemoveRegion(whichRegion) end
---@param whichRegion region
---@param r rect
function RegionAddRect(whichRegion, r) end
---@param whichRegion region
---@param r rect
function RegionClearRect(whichRegion, r) end
---@param whichRegion region
---@param x real
---@param y real
function RegionAddCell(whichRegion, x, y) end
---@param whichRegion region
---@param whichLocation location
function RegionAddCellAtLoc(whichRegion, whichLocation) end
---@param whichRegion region
---@param x real
---@param y real
function RegionClearCell(whichRegion, x, y) end
---@param whichRegion region
---@param whichLocation location
function RegionClearCellAtLoc(whichRegion, whichLocation) end
---@param x real
---@param y real
function Location(x, y) end
---@param whichLocation location
function RemoveLocation(whichLocation) end
---@param whichLocation location
---@param newX real
---@param newY real
function MoveLocation(whichLocation, newX, newY) end
---@param whichLocation location
function GetLocationX(whichLocation) end
---@param whichLocation location
function GetLocationY(whichLocation) end
---@param whichLocation location
function GetLocationZ(whichLocation) end
---@param whichRegion region
---@param whichUnit unit
function IsUnitInRegion(whichRegion, whichUnit) end
---@param whichRegion region
---@param x real
---@param y real
function IsPointInRegion(whichRegion, x, y) end
---@param whichRegion region
---@param whichLocation location
function IsLocationInRegion(whichRegion, whichLocation) end
function GetWorldBounds() end
function CreateTrigger() end
---@param whichTrigger trigger
function DestroyTrigger(whichTrigger) end
---@param whichTrigger trigger
function ResetTrigger(whichTrigger) end
---@param whichTrigger trigger
function EnableTrigger(whichTrigger) end
---@param whichTrigger trigger
function DisableTrigger(whichTrigger) end
---@param whichTrigger trigger
function IsTriggerEnabled(whichTrigger) end
---@param whichTrigger trigger
---@param flag boolean
function TriggerWaitOnSleeps(whichTrigger, flag) end
---@param whichTrigger trigger
function IsTriggerWaitOnSleeps(whichTrigger) end
function GetFilterUnit() end
function GetEnumUnit() end
function GetFilterDestructable() end
function GetEnumDestructable() end
function GetFilterItem() end
function GetEnumItem() end
function GetFilterPlayer() end
function GetEnumPlayer() end
function GetTriggeringTrigger() end
function GetTriggerEventId() end
---@param whichTrigger trigger
function GetTriggerEvalCount(whichTrigger) end
---@param whichTrigger trigger
function GetTriggerExecCount(whichTrigger) end
---@param funcName string
function ExecuteFunc(funcName) end
---@param operandA boolexpr
---@param operandB boolexpr
function And(operandA, operandB) end
---@param operandA boolexpr
---@param operandB boolexpr
function Or(operandA, operandB) end
---@param operand boolexpr
function Not(operand) end
---@param func code
function Condition(func) end
---@param c conditionfunc
function DestroyCondition(c) end
---@param func code
function Filter(func) end
---@param f filterfunc
function DestroyFilter(f) end
---@param e boolexpr
function DestroyBoolExpr(e) end
---@param whichTrigger trigger
---@param varName string
---@param opcode limitop
---@param limitval real
function TriggerRegisterVariableEvent(whichTrigger, varName, opcode, limitval) end
---@param whichTrigger trigger
---@param timeout real
---@param periodic boolean
function TriggerRegisterTimerEvent(whichTrigger, timeout, periodic) end
---@param whichTrigger trigger
---@param t timer
function TriggerRegisterTimerExpireEvent(whichTrigger, t) end
---@param whichTrigger trigger
---@param whichState gamestate
---@param opcode limitop
---@param limitval real
function TriggerRegisterGameStateEvent(whichTrigger, whichState, opcode, limitval) end
---@param whichTrigger trigger
---@param whichDialog dialog
function TriggerRegisterDialogEvent(whichTrigger, whichDialog) end
---@param whichTrigger trigger
---@param whichButton button
function TriggerRegisterDialogButtonEvent(whichTrigger, whichButton) end
function GetEventGameState() end
---@param whichTrigger trigger
---@param whichGameEvent gameevent
function TriggerRegisterGameEvent(whichTrigger, whichGameEvent) end
function GetWinningPlayer() end
---@param whichTrigger trigger
---@param whichRegion region
---@param filter boolexpr
function TriggerRegisterEnterRegion(whichTrigger, whichRegion, filter) end
function GetTriggeringRegion() end
function GetEnteringUnit() end
---@param whichTrigger trigger
---@param whichRegion region
---@param filter boolexpr
function TriggerRegisterLeaveRegion(whichTrigger, whichRegion, filter) end
function GetLeavingUnit() end
---@param whichTrigger trigger
---@param t trackable
function TriggerRegisterTrackableHitEvent(whichTrigger, t) end
---@param whichTrigger trigger
---@param t trackable
function TriggerRegisterTrackableTrackEvent(whichTrigger, t) end
function GetTriggeringTrackable() end
function GetClickedButton() end
function GetClickedDialog() end
function GetTournamentFinishSoonTimeRemaining() end
function GetTournamentFinishNowRule() end
function GetTournamentFinishNowPlayer() end
---@param whichPlayer player
function GetTournamentScore(whichPlayer) end
function GetSaveBasicFilename() end
---@param whichTrigger trigger
---@param  whichPlayer player
---@param whichPlayerEvent playerevent
function TriggerRegisterPlayerEvent(whichTrigger,  whichPlayer, whichPlayerEvent) end
function GetTriggerPlayer() end
---@param whichTrigger trigger
---@param whichPlayer player
---@param whichPlayerUnitEvent playerunitevent
---@param filter boolexpr
function TriggerRegisterPlayerUnitEvent(whichTrigger, whichPlayer, whichPlayerUnitEvent, filter) end
function GetLevelingUnit() end
function GetLearningUnit() end
function GetLearnedSkill() end
function GetLearnedSkillLevel() end
function GetRevivableUnit() end
function GetRevivingUnit() end
function GetAttacker() end
function GetRescuer() end
function GetDyingUnit() end
function GetKillingUnit() end
function GetDecayingUnit() end
function GetConstructingStructure() end
function GetCancelledStructure() end
function GetConstructedStructure() end
function GetResearchingUnit() end
function GetResearched() end
function GetTrainedUnitType() end
function GetTrainedUnit() end
function GetDetectedUnit() end
function GetSummoningUnit() end
function GetSummonedUnit() end
function GetTransportUnit() end
function GetLoadedUnit() end
function GetSellingUnit() end
function GetSoldUnit() end
function GetBuyingUnit() end
function GetSoldItem() end
function GetChangingUnit() end
function GetChangingUnitPrevOwner() end
function GetManipulatingUnit() end
function GetManipulatedItem() end
function GetOrderedUnit() end
function GetIssuedOrderId() end
function GetOrderPointX() end
function GetOrderPointY() end
function GetOrderPointLoc() end
function GetOrderTarget() end
function GetOrderTargetDestructable() end
function GetOrderTargetItem() end
function GetOrderTargetUnit() end
function GetSpellAbilityUnit() end
function GetSpellAbilityId() end
function GetSpellAbility() end
function GetSpellTargetLoc() end
function GetSpellTargetX() end
function GetSpellTargetY() end
function GetSpellTargetDestructable() end
function GetSpellTargetItem() end
function GetSpellTargetUnit() end
---@param whichTrigger trigger
---@param whichPlayer player
---@param whichAlliance alliancetype
function TriggerRegisterPlayerAllianceChange(whichTrigger, whichPlayer, whichAlliance) end
---@param whichTrigger trigger
---@param whichPlayer player
---@param whichState playerstate
---@param opcode limitop
---@param limitval real
function TriggerRegisterPlayerStateEvent(whichTrigger, whichPlayer, whichState, opcode, limitval) end
function GetEventPlayerState() end
---@param whichTrigger trigger
---@param whichPlayer player
---@param chatMessageToDetect string
---@param exactMatchOnly boolean
function TriggerRegisterPlayerChatEvent(whichTrigger, whichPlayer, chatMessageToDetect, exactMatchOnly) end
function GetEventPlayerChatString() end
function GetEventPlayerChatStringMatched() end
---@param whichTrigger trigger
---@param whichWidget widget
function TriggerRegisterDeathEvent(whichTrigger, whichWidget) end
function GetTriggerUnit() end
---@param whichTrigger trigger
---@param whichUnit unit
---@param whichState unitstate
---@param opcode limitop
---@param limitval real
function TriggerRegisterUnitStateEvent(whichTrigger, whichUnit, whichState, opcode, limitval) end
function GetEventUnitState() end
---@param whichTrigger trigger
---@param whichUnit unit
---@param whichEvent unitevent
function TriggerRegisterUnitEvent(whichTrigger, whichUnit, whichEvent) end
function GetEventDamage() end
function GetEventDamageSource() end
function GetEventDetectingPlayer() end
---@param whichTrigger trigger
---@param whichUnit unit
---@param whichEvent unitevent
---@param filter boolexpr
function TriggerRegisterFilterUnitEvent(whichTrigger, whichUnit, whichEvent, filter) end
function GetEventTargetUnit() end
---@param whichTrigger trigger
---@param whichUnit unit
---@param range real
---@param filter boolexpr
function TriggerRegisterUnitInRange(whichTrigger, whichUnit, range, filter) end
---@param whichTrigger trigger
---@param condition boolexpr
function TriggerAddCondition(whichTrigger, condition) end
---@param whichTrigger trigger
---@param whichCondition triggercondition
function TriggerRemoveCondition(whichTrigger, whichCondition) end
---@param whichTrigger trigger
function TriggerClearConditions(whichTrigger) end
---@param whichTrigger trigger
---@param actionFunc code
function TriggerAddAction(whichTrigger, actionFunc) end
---@param whichTrigger trigger
---@param whichAction triggeraction
function TriggerRemoveAction(whichTrigger, whichAction) end
---@param whichTrigger trigger
function TriggerClearActions(whichTrigger) end
---@param timeout real
function TriggerSleepAction(timeout) end
---@param s sound
---@param offset real
function TriggerWaitForSound(s, offset) end
---@param whichTrigger trigger
function TriggerEvaluate(whichTrigger) end
---@param whichTrigger trigger
function TriggerExecute(whichTrigger) end
---@param whichTrigger trigger
function TriggerExecuteWait(whichTrigger) end
function TriggerSyncStart() end
function TriggerSyncReady() end
---@param whichWidget widget
function GetWidgetLife(whichWidget) end
---@param whichWidget widget
---@param newLife real
function SetWidgetLife(whichWidget, newLife) end
---@param whichWidget widget
function GetWidgetX(whichWidget) end
---@param whichWidget widget
function GetWidgetY(whichWidget) end
function GetTriggerWidget() end
---@param objectid integer
---@param x real
---@param y real
---@param face real
---@param scale real
---@param variation integer
function CreateDestructable(objectid, x, y, face, scale, variation) end
---@param objectid integer
---@param x real
---@param y real
---@param z real
---@param face real
---@param scale real
---@param variation integer
function CreateDestructableZ(objectid, x, y, z, face, scale, variation) end
---@param objectid integer
---@param x real
---@param y real
---@param face real
---@param scale real
---@param variation integer
function CreateDeadDestructable(objectid, x, y, face, scale, variation) end
---@param objectid integer
---@param x real
---@param y real
---@param z real
---@param face real
---@param scale real
---@param variation integer
function CreateDeadDestructableZ(objectid, x, y, z, face, scale, variation) end
---@param d destructable
function RemoveDestructable(d) end
---@param d destructable
function KillDestructable(d) end
---@param d destructable
---@param flag boolean
function SetDestructableInvulnerable(d, flag) end
---@param d destructable
function IsDestructableInvulnerable(d) end
---@param r rect
---@param filter boolexpr
---@param actionFunc code
function EnumDestructablesInRect(r, filter, actionFunc) end
---@param d destructable
function GetDestructableTypeId(d) end
---@param d destructable
function GetDestructableX(d) end
---@param d destructable
function GetDestructableY(d) end
---@param d destructable
---@param life real
function SetDestructableLife(d, life) end
---@param d destructable
function GetDestructableLife(d) end
---@param d destructable
---@param max real
function SetDestructableMaxLife(d, max) end
---@param d destructable
function GetDestructableMaxLife(d) end
---@param d destructable
---@param life real
---@param birth boolean
function DestructableRestoreLife(d, life, birth) end
---@param d destructable
---@param whichAnimation string
function QueueDestructableAnimation(d, whichAnimation) end
---@param d destructable
---@param whichAnimation string
function SetDestructableAnimation(d, whichAnimation) end
---@param d destructable
---@param speedFactor real
function SetDestructableAnimationSpeed(d, speedFactor) end
---@param d destructable
---@param flag boolean
function ShowDestructable(d, flag) end
---@param d destructable
function GetDestructableOccluderHeight(d) end
---@param d destructable
---@param height real
function SetDestructableOccluderHeight(d, height) end
---@param d destructable
function GetDestructableName(d) end
function GetTriggerDestructable() end
---@param itemid integer
---@param x real
---@param y real
function CreateItem(itemid, x, y) end
---@param whichItem item
function RemoveItem(whichItem) end
---@param whichItem item
function GetItemPlayer(whichItem) end
---@param i item
function GetItemTypeId(i) end
---@param i item
function GetItemX(i) end
---@param i item
function GetItemY(i) end
---@param i item
---@param x real
---@param y real
function SetItemPosition(i, x, y) end
---@param whichItem item
---@param flag boolean
function SetItemDropOnDeath(whichItem, flag) end
---@param i item
---@param flag boolean
function SetItemDroppable(i, flag) end
---@param i item
---@param flag boolean
function SetItemPawnable(i, flag) end
---@param whichItem item
---@param whichPlayer player
---@param changeColor boolean
function SetItemPlayer(whichItem, whichPlayer, changeColor) end
---@param whichItem item
---@param flag boolean
function SetItemInvulnerable(whichItem, flag) end
---@param whichItem item
function IsItemInvulnerable(whichItem) end
---@param whichItem item
---@param show boolean
function SetItemVisible(whichItem, show) end
---@param whichItem item
function IsItemVisible(whichItem) end
---@param whichItem item
function IsItemOwned(whichItem) end
---@param whichItem item
function IsItemPowerup(whichItem) end
---@param whichItem item
function IsItemSellable(whichItem) end
---@param whichItem item
function IsItemPawnable(whichItem) end
---@param itemId integer
function IsItemIdPowerup(itemId) end
---@param itemId integer
function IsItemIdSellable(itemId) end
---@param itemId integer
function IsItemIdPawnable(itemId) end
---@param r rect
---@param filter boolexpr
---@param actionFunc code
function EnumItemsInRect(r, filter, actionFunc) end
---@param whichItem item
function GetItemLevel(whichItem) end
---@param whichItem item
function GetItemType(whichItem) end
---@param whichItem item
---@param unitId integer
function SetItemDropID(whichItem, unitId) end
---@param whichItem item
function GetItemName(whichItem) end
---@param whichItem item
function GetItemCharges(whichItem) end
---@param whichItem item
---@param charges integer
function SetItemCharges(whichItem, charges) end
---@param whichItem item
function GetItemUserData(whichItem) end
---@param whichItem item
---@param data integer
function SetItemUserData(whichItem, data) end
---@param id player
---@param unitid integer
---@param x real
---@param y real
---@param face real
function CreateUnit(id, unitid, x, y, face) end
---@param whichPlayer player
---@param unitname string
---@param x real
---@param y real
---@param face real
function CreateUnitByName(whichPlayer, unitname, x, y, face) end
---@param id player
---@param unitid integer
---@param whichLocation location
---@param face real
function CreateUnitAtLoc(id, unitid, whichLocation, face) end
---@param id player
---@param unitname string
---@param whichLocation location
---@param face real
function CreateUnitAtLocByName(id, unitname, whichLocation, face) end
---@param whichPlayer player
---@param unitid integer
---@param x real
---@param y real
---@param face real
function CreateCorpse(whichPlayer, unitid, x, y, face) end
---@param whichUnit unit
function KillUnit(whichUnit) end
---@param whichUnit unit
function RemoveUnit(whichUnit) end
---@param whichUnit unit
---@param show boolean
function ShowUnit(whichUnit, show) end
---@param whichUnit unit
---@param whichUnitState unitstate
---@param newVal real
function SetUnitState(whichUnit, whichUnitState, newVal) end
---@param whichUnit unit
---@param newX real
function SetUnitX(whichUnit, newX) end
---@param whichUnit unit
---@param newY real
function SetUnitY(whichUnit, newY) end
---@param whichUnit unit
---@param newX real
---@param newY real
function SetUnitPosition(whichUnit, newX, newY) end
---@param whichUnit unit
---@param whichLocation location
function SetUnitPositionLoc(whichUnit, whichLocation) end
---@param whichUnit unit
---@param facingAngle real
function SetUnitFacing(whichUnit, facingAngle) end
---@param whichUnit unit
---@param facingAngle real
---@param duration real
function SetUnitFacingTimed(whichUnit, facingAngle, duration) end
---@param whichUnit unit
---@param newSpeed real
function SetUnitMoveSpeed(whichUnit, newSpeed) end
---@param whichUnit unit
---@param newHeight real
---@param rate real
function SetUnitFlyHeight(whichUnit, newHeight, rate) end
---@param whichUnit unit
---@param newTurnSpeed real
function SetUnitTurnSpeed(whichUnit, newTurnSpeed) end
---@param whichUnit unit
---@param newPropWindowAngle real
function SetUnitPropWindow(whichUnit, newPropWindowAngle) end
---@param whichUnit unit
---@param newAcquireRange real
function SetUnitAcquireRange(whichUnit, newAcquireRange) end
---@param whichUnit unit
---@param creepGuard boolean
function SetUnitCreepGuard(whichUnit, creepGuard) end
---@param whichUnit unit
function GetUnitAcquireRange(whichUnit) end
---@param whichUnit unit
function GetUnitTurnSpeed(whichUnit) end
---@param whichUnit unit
function GetUnitPropWindow(whichUnit) end
---@param whichUnit unit
function GetUnitFlyHeight(whichUnit) end
---@param whichUnit unit
function GetUnitDefaultAcquireRange(whichUnit) end
---@param whichUnit unit
function GetUnitDefaultTurnSpeed(whichUnit) end
---@param whichUnit unit
function GetUnitDefaultPropWindow(whichUnit) end
---@param whichUnit unit
function GetUnitDefaultFlyHeight(whichUnit) end
---@param whichUnit unit
---@param whichPlayer player
---@param changeColor boolean
function SetUnitOwner(whichUnit, whichPlayer, changeColor) end
---@param whichUnit unit
---@param whichColor playercolor
function SetUnitColor(whichUnit, whichColor) end
---@param whichUnit unit
---@param scaleX real
---@param scaleY real
---@param scaleZ real
function SetUnitScale(whichUnit, scaleX, scaleY, scaleZ) end
---@param whichUnit unit
---@param timeScale real
function SetUnitTimeScale(whichUnit, timeScale) end
---@param whichUnit unit
---@param blendTime real
function SetUnitBlendTime(whichUnit, blendTime) end
---@param whichUnit unit
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetUnitVertexColor(whichUnit, red, green, blue, alpha) end
---@param whichUnit unit
---@param whichAnimation string
function QueueUnitAnimation(whichUnit, whichAnimation) end
---@param whichUnit unit
---@param whichAnimation string
function SetUnitAnimation(whichUnit, whichAnimation) end
---@param whichUnit unit
---@param whichAnimation integer
function SetUnitAnimationByIndex(whichUnit, whichAnimation) end
---@param whichUnit unit
---@param whichAnimation string
---@param rarity raritycontrol
function SetUnitAnimationWithRarity(whichUnit, whichAnimation, rarity) end
---@param whichUnit unit
---@param animProperties string
---@param add boolean
function AddUnitAnimationProperties(whichUnit, animProperties, add) end
---@param whichUnit unit
---@param whichBone string
---@param lookAtTarget unit
---@param offsetX real
---@param offsetY real
---@param offsetZ real
function SetUnitLookAt(whichUnit, whichBone, lookAtTarget, offsetX, offsetY, offsetZ) end
---@param whichUnit unit
function ResetUnitLookAt(whichUnit) end
---@param whichUnit unit
---@param byWhichPlayer player
---@param flag boolean
function SetUnitRescuable(whichUnit, byWhichPlayer, flag) end
---@param whichUnit unit
---@param range real
function SetUnitRescueRange(whichUnit, range) end
---@param whichHero unit
---@param newStr integer
---@param permanent boolean
function SetHeroStr(whichHero, newStr, permanent) end
---@param whichHero unit
---@param newAgi integer
---@param permanent boolean
function SetHeroAgi(whichHero, newAgi, permanent) end
---@param whichHero unit
---@param newInt integer
---@param permanent boolean
function SetHeroInt(whichHero, newInt, permanent) end
---@param whichHero unit
---@param includeBonuses boolean
function GetHeroStr(whichHero, includeBonuses) end
---@param whichHero unit
---@param includeBonuses boolean
function GetHeroAgi(whichHero, includeBonuses) end
---@param whichHero unit
---@param includeBonuses boolean
function GetHeroInt(whichHero, includeBonuses) end
---@param whichHero unit
---@param howManyLevels integer
function UnitStripHeroLevel(whichHero, howManyLevels) end
---@param whichHero unit
function GetHeroXP(whichHero) end
---@param whichHero unit
---@param newXpVal integer
---@param showEyeCandy  boolean
function SetHeroXP(whichHero, newXpVal, showEyeCandy) end
---@param whichHero unit
function GetHeroSkillPoints(whichHero) end
---@param whichHero unit
---@param skillPointDelta integer
function UnitModifySkillPoints(whichHero, skillPointDelta) end
---@param whichHero unit
---@param xpToAdd integer
---@param showEyeCandy boolean
function AddHeroXP(whichHero, xpToAdd, showEyeCandy) end
---@param whichHero unit
---@param level integer
---@param showEyeCandy  boolean
function SetHeroLevel(whichHero, level, showEyeCandy) end
---@param whichHero unit
function GetHeroLevel(whichHero) end
---@param whichUnit unit
function GetUnitLevel(whichUnit) end
---@param whichHero unit
function GetHeroProperName(whichHero) end
---@param whichHero unit
---@param flag boolean
function SuspendHeroXP(whichHero, flag) end
---@param whichHero unit
function IsSuspendedXP(whichHero) end
---@param whichHero unit
---@param abilcode integer
function SelectHeroSkill(whichHero, abilcode) end
---@param whichUnit unit
---@param abilcode integer
function GetUnitAbilityLevel(whichUnit, abilcode) end
---@param whichUnit unit
---@param abilcode integer
function DecUnitAbilityLevel(whichUnit, abilcode) end
---@param whichUnit unit
---@param abilcode integer
function IncUnitAbilityLevel(whichUnit, abilcode) end
---@param whichUnit unit
---@param abilcode integer
---@param level integer
function SetUnitAbilityLevel(whichUnit, abilcode, level) end
---@param whichHero unit
---@param x real
---@param y real
---@param doEyecandy boolean
function ReviveHero(whichHero, x, y, doEyecandy) end
---@param whichHero unit
---@param loc location
---@param doEyecandy boolean
function ReviveHeroLoc(whichHero, loc, doEyecandy) end
---@param whichUnit unit
---@param exploded boolean
function SetUnitExploded(whichUnit, exploded) end
---@param whichUnit unit
---@param flag boolean
function SetUnitInvulnerable(whichUnit, flag) end
---@param whichUnit unit
---@param flag boolean
function PauseUnit(whichUnit, flag) end
---@param whichHero unit
function IsUnitPaused(whichHero) end
---@param whichUnit unit
---@param flag boolean
function SetUnitPathing(whichUnit, flag) end
function ClearSelection() end
---@param whichUnit unit
---@param flag boolean
function SelectUnit(whichUnit, flag) end
---@param whichUnit unit
function GetUnitPointValue(whichUnit) end
---@param unitType integer
function GetUnitPointValueByType(unitType) end
---@param whichUnit unit
---@param whichItem item
function UnitAddItem(whichUnit, whichItem) end
---@param whichUnit unit
---@param itemId integer
function UnitAddItemById(whichUnit, itemId) end
---@param whichUnit unit
---@param itemId integer
---@param itemSlot integer
function UnitAddItemToSlotById(whichUnit, itemId, itemSlot) end
---@param whichUnit unit
---@param whichItem item
function UnitRemoveItem(whichUnit, whichItem) end
---@param whichUnit unit
---@param itemSlot integer
function UnitRemoveItemFromSlot(whichUnit, itemSlot) end
---@param whichUnit unit
---@param whichItem item
function UnitHasItem(whichUnit, whichItem) end
---@param whichUnit unit
---@param itemSlot integer
function UnitItemInSlot(whichUnit, itemSlot) end
---@param whichUnit unit
function UnitInventorySize(whichUnit) end
---@param whichUnit unit
---@param whichItem item
---@param x real
---@param y real
function UnitDropItemPoint(whichUnit, whichItem, x, y) end
---@param whichUnit unit
---@param whichItem item
---@param slot integer
function UnitDropItemSlot(whichUnit, whichItem, slot) end
---@param whichUnit unit
---@param whichItem item
---@param target widget
function UnitDropItemTarget(whichUnit, whichItem, target) end
---@param whichUnit unit
---@param whichItem item
function UnitUseItem(whichUnit, whichItem) end
---@param whichUnit unit
---@param whichItem item
---@param x real
---@param y real
function UnitUseItemPoint(whichUnit, whichItem, x, y) end
---@param whichUnit unit
---@param whichItem item
---@param target widget
function UnitUseItemTarget(whichUnit, whichItem, target) end
---@param whichUnit unit
function GetUnitX(whichUnit) end
---@param whichUnit unit
function GetUnitY(whichUnit) end
---@param whichUnit unit
function GetUnitLoc(whichUnit) end
---@param whichUnit unit
function GetUnitFacing(whichUnit) end
---@param whichUnit unit
function GetUnitMoveSpeed(whichUnit) end
---@param whichUnit unit
function GetUnitDefaultMoveSpeed(whichUnit) end
---@param whichUnit unit
---@param whichUnitState unitstate
function GetUnitState(whichUnit, whichUnitState) end
---@param whichUnit unit
function GetOwningPlayer(whichUnit) end
---@param whichUnit unit
function GetUnitTypeId(whichUnit) end
---@param whichUnit unit
function GetUnitRace(whichUnit) end
---@param whichUnit unit
function GetUnitName(whichUnit) end
---@param whichUnit unit
function GetUnitFoodUsed(whichUnit) end
---@param whichUnit unit
function GetUnitFoodMade(whichUnit) end
---@param unitId integer
function GetFoodMade(unitId) end
---@param unitId integer
function GetFoodUsed(unitId) end
---@param whichUnit unit
---@param useFood boolean
function SetUnitUseFood(whichUnit, useFood) end
---@param whichUnit unit
function GetUnitRallyPoint(whichUnit) end
---@param whichUnit unit
function GetUnitRallyUnit(whichUnit) end
---@param whichUnit unit
function GetUnitRallyDestructable(whichUnit) end
---@param whichUnit unit
---@param whichGroup group
function IsUnitInGroup(whichUnit, whichGroup) end
---@param whichUnit unit
---@param whichForce force
function IsUnitInForce(whichUnit, whichForce) end
---@param whichUnit unit
---@param whichPlayer player
function IsUnitOwnedByPlayer(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function IsUnitAlly(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function IsUnitEnemy(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function IsUnitVisible(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function IsUnitDetected(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function IsUnitInvisible(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function IsUnitFogged(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function IsUnitMasked(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichPlayer player
function IsUnitSelected(whichUnit, whichPlayer) end
---@param whichUnit unit
---@param whichRace race
function IsUnitRace(whichUnit, whichRace) end
---@param whichUnit unit
---@param whichUnitType unittype
function IsUnitType(whichUnit, whichUnitType) end
---@param whichUnit unit
---@param whichSpecifiedUnit unit
function IsUnit(whichUnit, whichSpecifiedUnit) end
---@param whichUnit unit
---@param otherUnit unit
---@param distance real
function IsUnitInRange(whichUnit, otherUnit, distance) end
---@param whichUnit unit
---@param x real
---@param y real
---@param distance real
function IsUnitInRangeXY(whichUnit, x, y, distance) end
---@param whichUnit unit
---@param whichLocation location
---@param distance real
function IsUnitInRangeLoc(whichUnit, whichLocation, distance) end
---@param whichUnit unit
function IsUnitHidden(whichUnit) end
---@param whichUnit unit
function IsUnitIllusion(whichUnit) end
---@param whichUnit unit
---@param whichTransport unit
function IsUnitInTransport(whichUnit, whichTransport) end
---@param whichUnit unit
function IsUnitLoaded(whichUnit) end
---@param unitId integer
function IsHeroUnitId(unitId) end
---@param unitId integer
---@param whichUnitType unittype
function IsUnitIdType(unitId, whichUnitType) end
---@param whichUnit unit
---@param whichPlayer player
---@param share boolean
function UnitShareVision(whichUnit, whichPlayer, share) end
---@param whichUnit unit
---@param suspend boolean
function UnitSuspendDecay(whichUnit, suspend) end
---@param whichUnit unit
---@param whichUnitType unittype
function UnitAddType(whichUnit, whichUnitType) end
---@param whichUnit unit
---@param whichUnitType unittype
function UnitRemoveType(whichUnit, whichUnitType) end
---@param whichUnit unit
---@param abilityId integer
function UnitAddAbility(whichUnit, abilityId) end
---@param whichUnit unit
---@param abilityId integer
function UnitRemoveAbility(whichUnit, abilityId) end
---@param whichUnit unit
---@param permanent boolean
---@param abilityId integer
function UnitMakeAbilityPermanent(whichUnit, permanent, abilityId) end
---@param whichUnit unit
---@param removePositive boolean
---@param removeNegative boolean
function UnitRemoveBuffs(whichUnit, removePositive, removeNegative) end
---@param whichUnit unit
---@param removePositive boolean
---@param removeNegative boolean
---@param magic boolean
---@param physical boolean
---@param timedLife boolean
---@param aura boolean
---@param autoDispel boolean
function UnitRemoveBuffsEx(whichUnit, removePositive, removeNegative, magic, physical, timedLife, aura, autoDispel) end
---@param whichUnit unit
---@param removePositive boolean
---@param removeNegative boolean
---@param magic boolean
---@param physical boolean
---@param timedLife boolean
---@param aura boolean
---@param autoDispel boolean
function UnitHasBuffsEx(whichUnit, removePositive, removeNegative, magic, physical, timedLife, aura, autoDispel) end
---@param whichUnit unit
---@param removePositive boolean
---@param removeNegative boolean
---@param magic boolean
---@param physical boolean
---@param timedLife boolean
---@param aura boolean
---@param autoDispel boolean
function UnitCountBuffsEx(whichUnit, removePositive, removeNegative, magic, physical, timedLife, aura, autoDispel) end
---@param whichUnit unit
---@param add boolean
function UnitAddSleep(whichUnit, add) end
---@param whichUnit unit
function UnitCanSleep(whichUnit) end
---@param whichUnit unit
---@param add boolean
function UnitAddSleepPerm(whichUnit, add) end
---@param whichUnit unit
function UnitCanSleepPerm(whichUnit) end
---@param whichUnit unit
function UnitIsSleeping(whichUnit) end
---@param whichUnit unit
function UnitWakeUp(whichUnit) end
---@param whichUnit unit
---@param buffId integer
---@param duration real
function UnitApplyTimedLife(whichUnit, buffId, duration) end
---@param whichUnit unit
---@param flag boolean
function UnitIgnoreAlarm(whichUnit, flag) end
---@param whichUnit unit
function UnitIgnoreAlarmToggled(whichUnit) end
---@param whichUnit unit
function UnitResetCooldown(whichUnit) end
---@param whichUnit unit
---@param constructionPercentage integer
function UnitSetConstructionProgress(whichUnit, constructionPercentage) end
---@param whichUnit unit
---@param upgradePercentage integer
function UnitSetUpgradeProgress(whichUnit, upgradePercentage) end
---@param whichUnit unit
---@param flag boolean
function UnitPauseTimedLife(whichUnit, flag) end
---@param whichUnit unit
---@param flag boolean
function UnitSetUsesAltIcon(whichUnit, flag) end
---@param whichUnit unit
---@param delay real
---@param radius real
---@param x real
---@param y real
---@param amount real
---@param attack boolean
---@param ranged boolean
---@param attackType attacktype
---@param damageType damagetype
---@param weaponType weapontype
function UnitDamagePoint(whichUnit, delay, radius, x, y, amount, attack, ranged, attackType, damageType, weaponType) end
---@param whichUnit unit
---@param target widget
---@param amount real
---@param attack boolean
---@param ranged boolean
---@param attackType attacktype
---@param damageType damagetype
---@param weaponType weapontype
function UnitDamageTarget(whichUnit, target, amount, attack, ranged, attackType, damageType, weaponType) end
---@param whichUnit unit
---@param order string
function IssueImmediateOrder(whichUnit, order) end
---@param whichUnit unit
---@param order integer
function IssueImmediateOrderById(whichUnit, order) end
---@param whichUnit unit
---@param order string
---@param x real
---@param y real
function IssuePointOrder(whichUnit, order, x, y) end
---@param whichUnit unit
---@param order string
---@param whichLocation location
function IssuePointOrderLoc(whichUnit, order, whichLocation) end
---@param whichUnit unit
---@param order integer
---@param x real
---@param y real
function IssuePointOrderById(whichUnit, order, x, y) end
---@param whichUnit unit
---@param order integer
---@param whichLocation location
function IssuePointOrderByIdLoc(whichUnit, order, whichLocation) end
---@param whichUnit unit
---@param order string
---@param targetWidget widget
function IssueTargetOrder(whichUnit, order, targetWidget) end
---@param whichUnit unit
---@param order integer
---@param targetWidget widget
function IssueTargetOrderById(whichUnit, order, targetWidget) end
---@param whichUnit unit
---@param order string
---@param x real
---@param y real
---@param instantTargetWidget widget
function IssueInstantPointOrder(whichUnit, order, x, y, instantTargetWidget) end
---@param whichUnit unit
---@param order integer
---@param x real
---@param y real
---@param instantTargetWidget widget
function IssueInstantPointOrderById(whichUnit, order, x, y, instantTargetWidget) end
---@param whichUnit unit
---@param order string
---@param targetWidget widget
---@param instantTargetWidget widget
function IssueInstantTargetOrder(whichUnit, order, targetWidget, instantTargetWidget) end
---@param whichUnit unit
---@param order integer
---@param targetWidget widget
---@param instantTargetWidget widget
function IssueInstantTargetOrderById(whichUnit, order, targetWidget, instantTargetWidget) end
---@param whichPeon unit
---@param unitToBuild string
---@param x real
---@param y real
function IssueBuildOrder(whichPeon, unitToBuild, x, y) end
---@param whichPeon unit
---@param unitId integer
---@param x real
---@param y real
function IssueBuildOrderById(whichPeon, unitId, x, y) end
---@param forWhichPlayer player
---@param neutralStructure unit
---@param unitToBuild string
function IssueNeutralImmediateOrder(forWhichPlayer, neutralStructure, unitToBuild) end
---@param forWhichPlayer player
---@paramuneutralStructure nit
---@param unitId integer
function IssueNeutralImmediateOrderById(forWhichPlayer,uneutralStructure, unitId) end
---@param forWhichPlayer player
---@paramuneutralStructure nit
---@param unitToBuild string
---@param x real
---@param y real
function IssueNeutralPointOrder(forWhichPlayer,uneutralStructure, unitToBuild, x, y) end
---@param forWhichPlayer player
---@paramuneutralStructure nit
---@param unitId integer
---@param x real
---@param y real
function IssueNeutralPointOrderById(forWhichPlayer,uneutralStructure, unitId, x, y) end
---@param forWhichPlayer player
---@paramuneutralStructure nit
---@param unitToBuild string
---@param target widget
function IssueNeutralTargetOrder(forWhichPlayer,uneutralStructure, unitToBuild, target) end
---@param forWhichPlayer player
---@paramuneutralStructure nit
---@param unitId integer
---@param target widget
function IssueNeutralTargetOrderById(forWhichPlayer,uneutralStructure, unitId, target) end
---@param whichUnit unit
function GetUnitCurrentOrder(whichUnit) end
---@param whichUnit unit
---@param amount integer
function SetResourceAmount(whichUnit, amount) end
---@param whichUnit unit
---@param amount integer
function AddResourceAmount(whichUnit, amount) end
---@param whichUnit unit
function GetResourceAmount(whichUnit) end
---@param waygate unit
function WaygateGetDestinationX(waygate) end
---@param waygate unit
function WaygateGetDestinationY(waygate) end
---@param waygate unit
---@param x real
---@param y real
function WaygateSetDestination(waygate, x, y) end
---@param waygate unit
---@param activate boolean
function WaygateActivate(waygate, activate) end
---@param waygate unit
function WaygateIsActive(waygate) end
---@param itemId integer
---@param currentStock integer
---@param stockMax integer
function AddItemToAllStock(itemId, currentStock, stockMax) end
---@param whichUnit unit
---@param itemId integer
---@param currentStock integer
---@param stockMax integer
function AddItemToStock(whichUnit, itemId, currentStock, stockMax) end
---@param unitId integer
---@param currentStock integer
---@param stockMax integer
function AddUnitToAllStock(unitId, currentStock, stockMax) end
---@param whichUnit unit
---@param unitId integer
---@param currentStock integer
---@param stockMax integer
function AddUnitToStock(whichUnit, unitId, currentStock, stockMax) end
---@param itemId integer
function RemoveItemFromAllStock(itemId) end
---@param whichUnit unit
---@param itemId integer
function RemoveItemFromStock(whichUnit, itemId) end
---@param unitId integer
function RemoveUnitFromAllStock(unitId) end
---@param whichUnit unit
---@param unitId integer
function RemoveUnitFromStock(whichUnit, unitId) end
---@param slots integer
function SetAllItemTypeSlots(slots) end
---@param slots integer
function SetAllUnitTypeSlots(slots) end
---@param whichUnit unit
---@param slots integer
function SetItemTypeSlots(whichUnit, slots) end
---@param whichUnit unit
---@param slots integer
function SetUnitTypeSlots(whichUnit, slots) end
---@param whichUnit unit
function GetUnitUserData(whichUnit) end
---@param whichUnit unit
---@param data integer
function SetUnitUserData(whichUnit, data) end
---@param number integer
function Player(number) end
function GetLocalPlayer() end
---@param whichPlayer player
---@param otherPlayer player
function IsPlayerAlly(whichPlayer, otherPlayer) end
---@param whichPlayer player
---@param otherPlayer player
function IsPlayerEnemy(whichPlayer, otherPlayer) end
---@param whichPlayer player
---@param whichForce force
function IsPlayerInForce(whichPlayer, whichForce) end
---@param whichPlayer player
function IsPlayerObserver(whichPlayer) end
---@param x real
---@param y real
---@param whichPlayer player
function IsVisibleToPlayer(x, y, whichPlayer) end
---@param whichLocation location
---@param whichPlayer player
function IsLocationVisibleToPlayer(whichLocation, whichPlayer) end
---@param x real
---@param y real
---@param whichPlayer player
function IsFoggedToPlayer(x, y, whichPlayer) end
---@param whichLocation location
---@param whichPlayer player
function IsLocationFoggedToPlayer(whichLocation, whichPlayer) end
---@param x real
---@param y real
---@param whichPlayer player
function IsMaskedToPlayer(x, y, whichPlayer) end
---@param whichLocation location
---@param whichPlayer player
function IsLocationMaskedToPlayer(whichLocation, whichPlayer) end
---@param whichPlayer player
function GetPlayerRace(whichPlayer) end
---@param whichPlayer player
function GetPlayerId(whichPlayer) end
---@param whichPlayer player
---@param includeIncomplete boolean
function GetPlayerUnitCount(whichPlayer, includeIncomplete) end
---@param whichPlayer player
---@param unitName string
---@param includeIncomplete boolean
---@param includeUpgrades boolean
function GetPlayerTypedUnitCount(whichPlayer, unitName, includeIncomplete, includeUpgrades) end
---@param whichPlayer player
---@param includeIncomplete boolean
function GetPlayerStructureCount(whichPlayer, includeIncomplete) end
---@param whichPlayer player
---@param whichPlayerState playerstate
function GetPlayerState(whichPlayer, whichPlayerState) end
---@param whichPlayer player
---@param whichPlayerScore playerscore
function GetPlayerScore(whichPlayer, whichPlayerScore) end
---@param sourcePlayer player
---@param otherPlayer player
---@param whichAllianceSetting alliancetype
function GetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting) end
---@param whichPlayer player
function GetPlayerHandicap(whichPlayer) end
---@param whichPlayer player
function GetPlayerHandicapXP(whichPlayer) end
---@param whichPlayer player
---@param handicap real
function SetPlayerHandicap(whichPlayer, handicap) end
---@param whichPlayer player
---@param handicap real
function SetPlayerHandicapXP(whichPlayer, handicap) end
---@param whichPlayer player
---@param techid integer
---@param maximum integer
function SetPlayerTechMaxAllowed(whichPlayer, techid, maximum) end
---@param whichPlayer player
---@param techid integer
function GetPlayerTechMaxAllowed(whichPlayer, techid) end
---@param whichPlayer player
---@param techid integer
---@param levels integer
function AddPlayerTechResearched(whichPlayer, techid, levels) end
---@param whichPlayer player
---@param techid integer
---@param setToLevel integer
function SetPlayerTechResearched(whichPlayer, techid, setToLevel) end
---@param whichPlayer player
---@param techid integer
---@param specificonly boolean
function GetPlayerTechResearched(whichPlayer, techid, specificonly) end
---@param whichPlayer player
---@param techid integer
---@param specificonly boolean
function GetPlayerTechCount(whichPlayer, techid, specificonly) end
---@param whichPlayer player
---@param newOwner integer
function SetPlayerUnitsOwner(whichPlayer, newOwner) end
---@param whichPlayer player
---@param toWhichPlayers force
---@param flag boolean
function CripplePlayer(whichPlayer, toWhichPlayers, flag) end
---@param whichPlayer player
---@param abilid integer
---@param avail boolean
function SetPlayerAbilityAvailable(whichPlayer, abilid, avail) end
---@param whichPlayer player
---@param whichPlayerState playerstate
---@param value integer
function SetPlayerState(whichPlayer, whichPlayerState, value) end
---@param whichPlayer player
---@param gameResult playergameresult
function RemovePlayer(whichPlayer, gameResult) end
---@param whichPlayer player
function CachePlayerHeroData(whichPlayer) end
---@param forWhichPlayer player
---@param whichState fogstate
---@param where rect
---@param useSharedVision boolean
function SetFogStateRect(forWhichPlayer, whichState, where, useSharedVision) end
---@param forWhichPlayer player
---@param whichState fogstate
---@param centerx real
---@param centerY real
---@param radius real
---@param useSharedVision boolean
function SetFogStateRadius(forWhichPlayer, whichState, centerx, centerY, radius, useSharedVision) end
---@param forWhichPlayer player
---@param whichState fogstate
---@param center location
---@param radius real
---@param useSharedVision boolean
function SetFogStateRadiusLoc(forWhichPlayer, whichState, center, radius, useSharedVision) end
---@param enable boolean
function FogMaskEnable(enable) end
function IsFogMaskEnabled() end
---@param enable boolean
function FogEnable(enable) end
function IsFogEnabled() end
---@param forWhichPlayer player
---@param whichState fogstate
---@param where rect
---@param useSharedVision boolean
---@param afterUnits boolean
function CreateFogModifierRect(forWhichPlayer, whichState, where, useSharedVision, afterUnits) end
---@param forWhichPlayer player
---@param whichState fogstate
---@param centerx real
---@param centerY real
---@param radius real
---@param useSharedVision boolean
---@param afterUnits boolean
function CreateFogModifierRadius(forWhichPlayer, whichState, centerx, centerY, radius, useSharedVision, afterUnits) end
---@param forWhichPlayer player
---@param whichState fogstate
---@param center location
---@param radius real
---@param useSharedVision boolean
---@param afterUnits boolean
function CreateFogModifierRadiusLoc(forWhichPlayer, whichState, center, radius, useSharedVision, afterUnits) end
---@param whichFogModifier fogmodifier
function DestroyFogModifier(whichFogModifier) end
---@param whichFogModifier fogmodifier
function FogModifierStart(whichFogModifier) end
---@param whichFogModifier fogmodifier
function FogModifierStop(whichFogModifier) end
function VersionGet() end
---@param whichVersion version
function VersionCompatible(whichVersion) end
---@param whichVersion version
function VersionSupported(whichVersion) end
---@param doScoreScreen boolean
function EndGame(doScoreScreen) end
---@param newLevel string
---@param doScoreScreen boolean
function ChangeLevel(newLevel, doScoreScreen) end
---@param doScoreScreen boolean
function RestartGame(doScoreScreen) end
function ReloadGame() end
---@param r race
function SetCampaignMenuRace(r) end
---@param campaignIndex integer
function SetCampaignMenuRaceEx(campaignIndex) end
function ForceCampaignSelectScreen() end
---@param saveFileName string
---@param doScoreScreen boolean
function LoadGame(saveFileName, doScoreScreen) end
---@param saveFileName string
function SaveGame(saveFileName) end
---@param sourceDirName string
---@param destDirName string
function RenameSaveDirectory(sourceDirName, destDirName) end
---@param sourceDirName string
function RemoveSaveDirectory(sourceDirName) end
---@param sourceSaveName string
---@param destSaveName string
function CopySaveGame(sourceSaveName, destSaveName) end
---@param saveName string
function SaveGameExists(saveName) end
function SyncSelections() end
---@param whichFloatGameState fgamestate
---@param value real
function SetFloatGameState(whichFloatGameState, value) end
---@param whichFloatGameState fgamestate
function GetFloatGameState(whichFloatGameState) end
---@param whichIntegerGameState igamestate
---@param value integer
function SetIntegerGameState(whichIntegerGameState, value) end
---@param whichIntegerGameState igamestate
function GetIntegerGameState(whichIntegerGameState) end
---@param cleared boolean
function SetTutorialCleared(cleared) end
---@param campaignNumber integer
---@param missionNumber integer
---@param available boolean
function SetMissionAvailable(campaignNumber, missionNumber, available) end
---@param campaignNumber integer
---@param available boolean
function SetCampaignAvailable(campaignNumber, available) end
---@param campaignNumber integer
---@param available boolean
function SetOpCinematicAvailable(campaignNumber, available) end
---@param campaignNumber integer
---@param available boolean
function SetEdCinematicAvailable(campaignNumber, available) end
function GetDefaultDifficulty() end
---@param g gamedifficulty
function SetDefaultDifficulty(g) end
---@param whichButton integer
---@param visible boolean
function SetCustomCampaignButtonVisible(whichButton, visible) end
---@param whichButton integer
function GetCustomCampaignButtonVisible(whichButton) end
function DoNotSaveReplay() end
function DialogCreate() end
---@param whichDialog dialog
function DialogDestroy(whichDialog) end
---@param whichDialog dialog
function DialogClear(whichDialog) end
---@param whichDialog dialog
---@param messageText string
function DialogSetMessage(whichDialog, messageText) end
---@param whichDialog dialog
---@param buttonText string
---@param hotkey integer
function DialogAddButton(whichDialog, buttonText, hotkey) end
---@param whichDialog dialog
---@param doScoreScreen boolean
---@param buttonText string
---@param hotkey integer
function DialogAddQuitButton(whichDialog, doScoreScreen, buttonText, hotkey) end
---@param whichPlayer player
---@param whichDialog dialog
---@param flag boolean
function DialogDisplay(whichPlayer, whichDialog, flag) end
function ReloadGameCachesFromDisk() end
---@param campaignFile string
function InitGameCache(campaignFile) end
---@param whichCache gamecache
function SaveGameCache(whichCache) end
---@param cache gamecache
---@param missionKey string
---@param key string
---@param value integer
function StoreInteger(cache, missionKey, key, value) end
---@param cache gamecache
---@param missionKey string
---@param key string
---@param value real
function StoreReal(cache, missionKey, key, value) end
---@param cache gamecache
---@param missionKey string
---@param key string
---@param value boolean
function StoreBoolean(cache, missionKey, key, value) end
---@param cache gamecache
---@param missionKey string
---@param key string
---@param whichUnit unit
function StoreUnit(cache, missionKey, key, whichUnit) end
---@param cache gamecache
---@param missionKey string
---@param key string
---@param value string
function StoreString(cache, missionKey, key, value) end
---@param cache gamecache
---@param missionKey string
---@param key string
function SyncStoredInteger(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function SyncStoredReal(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function SyncStoredBoolean(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function SyncStoredUnit(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function SyncStoredString(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function HaveStoredInteger(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function HaveStoredReal(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function HaveStoredBoolean(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function HaveStoredUnit(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function HaveStoredString(cache, missionKey, key) end
---@param cache gamecache
function FlushGameCache(cache) end
---@param cache gamecache
---@param missionKey string
function FlushStoredMission(cache, missionKey) end
---@param cache gamecache
---@param missionKey string
---@param key string
function FlushStoredInteger(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function FlushStoredReal(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function FlushStoredBoolean(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function FlushStoredUnit(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function FlushStoredString(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function GetStoredInteger(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function GetStoredReal(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function GetStoredBoolean(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
function GetStoredString(cache, missionKey, key) end
---@param cache gamecache
---@param missionKey string
---@param key string
---@param forWhichPlayer player
---@param x real
---@param y real
---@param facing real
function RestoreUnit(cache, missionKey, key, forWhichPlayer, x, y, facing) end
function InitHashtable() end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param value integer
function SaveInteger(table, parentKey, childKey, value) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param value real
function SaveReal(table, parentKey, childKey, value) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param value boolean
function SaveBoolean(table, parentKey, childKey, value) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param value string
function SaveStr(table, parentKey, childKey, value) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichPlayer player
function SavePlayerHandle(table, parentKey, childKey, whichPlayer) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichWidget widget
function SaveWidgetHandle(table, parentKey, childKey, whichWidget) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichDestructable destructable
function SaveDestructableHandle(table, parentKey, childKey, whichDestructable) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichItem item
function SaveItemHandle(table, parentKey, childKey, whichItem) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichUnit unit
function SaveUnitHandle(table, parentKey, childKey, whichUnit) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichAbility ability
function SaveAbilityHandle(table, parentKey, childKey, whichAbility) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTimer timer
function SaveTimerHandle(table, parentKey, childKey, whichTimer) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTrigger trigger
function SaveTriggerHandle(table, parentKey, childKey, whichTrigger) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTriggercondition triggercondition
function SaveTriggerConditionHandle(table, parentKey, childKey, whichTriggercondition) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTriggeraction triggeraction
function SaveTriggerActionHandle(table, parentKey, childKey, whichTriggeraction) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichEvent event
function SaveTriggerEventHandle(table, parentKey, childKey, whichEvent) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichForce force
function SaveForceHandle(table, parentKey, childKey, whichForce) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichGroup group
function SaveGroupHandle(table, parentKey, childKey, whichGroup) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichLocation location
function SaveLocationHandle(table, parentKey, childKey, whichLocation) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichRect rect
function SaveRectHandle(table, parentKey, childKey, whichRect) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichBoolexpr boolexpr
function SaveBooleanExprHandle(table, parentKey, childKey, whichBoolexpr) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichSound sound
function SaveSoundHandle(table, parentKey, childKey, whichSound) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichEffect effect
function SaveEffectHandle(table, parentKey, childKey, whichEffect) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichUnitpool unitpool
function SaveUnitPoolHandle(table, parentKey, childKey, whichUnitpool) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichItempool itempool
function SaveItemPoolHandle(table, parentKey, childKey, whichItempool) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichQuest quest
function SaveQuestHandle(table, parentKey, childKey, whichQuest) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichQuestitem questitem
function SaveQuestItemHandle(table, parentKey, childKey, whichQuestitem) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichDefeatcondition defeatcondition
function SaveDefeatConditionHandle(table, parentKey, childKey, whichDefeatcondition) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTimerdialog timerdialog
function SaveTimerDialogHandle(table, parentKey, childKey, whichTimerdialog) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichLeaderboard leaderboard
function SaveLeaderboardHandle(table, parentKey, childKey, whichLeaderboard) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichMultiboard multiboard
function SaveMultiboardHandle(table, parentKey, childKey, whichMultiboard) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichMultiboarditem multiboarditem
function SaveMultiboardItemHandle(table, parentKey, childKey, whichMultiboarditem) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTrackable trackable
function SaveTrackableHandle(table, parentKey, childKey, whichTrackable) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichDialog dialog
function SaveDialogHandle(table, parentKey, childKey, whichDialog) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichButton button
function SaveButtonHandle(table, parentKey, childKey, whichButton) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTexttag texttag
function SaveTextTagHandle(table, parentKey, childKey, whichTexttag) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichLightning lightning
function SaveLightningHandle(table, parentKey, childKey, whichLightning) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichImage image
function SaveImageHandle(table, parentKey, childKey, whichImage) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichUbersplat ubersplat
function SaveUbersplatHandle(table, parentKey, childKey, whichUbersplat) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichRegion region
function SaveRegionHandle(table, parentKey, childKey, whichRegion) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichFogState fogstate
function SaveFogStateHandle(table, parentKey, childKey, whichFogState) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichFogModifier fogmodifier
function SaveFogModifierHandle(table, parentKey, childKey, whichFogModifier) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichAgent agent
function SaveAgentHandle(table, parentKey, childKey, whichAgent) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichHashtable hashtable
function SaveHashtableHandle(table, parentKey, childKey, whichHashtable) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
---@param whichFrameHandle framehandle
function SaveFrameHandle(table, parentKey, childKey, whichFrameHandle) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadInteger(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadReal(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadBoolean(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadStr(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadPlayerHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadWidgetHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadDestructableHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadItemHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadUnitHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadAbilityHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadTimerHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadTriggerHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadTriggerConditionHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadTriggerActionHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadTriggerEventHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadForceHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadGroupHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadLocationHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadRectHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadBooleanExprHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadSoundHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadEffectHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadUnitPoolHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadItemPoolHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadQuestHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadQuestItemHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadDefeatConditionHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadTimerDialogHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadLeaderboardHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadMultiboardHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadMultiboardItemHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadTrackableHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadDialogHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadButtonHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadTextTagHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadLightningHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadImageHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadUbersplatHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadRegionHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadFogStateHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadFogModifierHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadHashtableHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function LoadFrameHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function HaveSavedInteger(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function HaveSavedReal(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function HaveSavedBoolean(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function HaveSavedString(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function HaveSavedHandle(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function RemoveSavedInteger(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function RemoveSavedReal(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function RemoveSavedBoolean(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function RemoveSavedString(table, parentKey, childKey) end
---@param table hashtable
---@param parentKey integer
---@param childKey integer
function RemoveSavedHandle(table, parentKey, childKey) end
---@param table hashtable
function FlushParentHashtable(table) end
---@param table hashtable
---@param parentKey integer
function FlushChildHashtable(table, parentKey) end
---@param lowBound integer
---@param highBound integer
function GetRandomInt(lowBound, highBound) end
---@param lowBound real
---@param highBound real
function GetRandomReal(lowBound, highBound) end
function CreateUnitPool() end
---@param whichPool unitpool
function DestroyUnitPool(whichPool) end
---@param whichPool unitpool
---@param unitId integer
---@param weight real
function UnitPoolAddUnitType(whichPool, unitId, weight) end
---@param whichPool unitpool
---@param unitId integer
function UnitPoolRemoveUnitType(whichPool, unitId) end
---@param whichPool unitpool
---@param forWhichPlayer player
---@param x real
---@param y real
---@param facing real
function PlaceRandomUnit(whichPool, forWhichPlayer, x, y, facing) end
function CreateItemPool() end
---@param whichItemPool itempool
function DestroyItemPool(whichItemPool) end
---@param whichItemPool itempool
---@param itemId integer
---@param weight real
function ItemPoolAddItemType(whichItemPool, itemId, weight) end
---@param whichItemPool itempool
---@param itemId integer
function ItemPoolRemoveItemType(whichItemPool, itemId) end
---@param whichItemPool itempool
---@param x real
---@param y real
function PlaceRandomItem(whichItemPool, x, y) end
---@param level integer
function ChooseRandomCreep(level) end
function ChooseRandomNPBuilding() end
---@param level integer
function ChooseRandomItem(level) end
---@param whichType itemtype
---@param level integer
function ChooseRandomItemEx(whichType, level) end
---@param seed integer
function SetRandomSeed(seed) end
---@param a real
---@param b real
---@param c real
---@param d real
---@param e real
function SetTerrainFog(a, b, c, d, e) end
function ResetTerrainFog() end
---@param a real
---@param b real
---@param c real
---@param d real
---@param e real
function SetUnitFog(a, b, c, d, e) end
---@param style integer
---@param zstart real
---@param zend real
---@param density real
---@param red real
---@param green real
---@param blue real
function SetTerrainFogEx(style, zstart, zend, density, red, green, blue) end
---@param toPlayer player
---@param x real
---@param y real
---@param message string
function DisplayTextToPlayer(toPlayer, x, y, message) end
---@param toPlayer player
---@param x real
---@param y real
---@param duration real
---@param message string
function DisplayTimedTextToPlayer(toPlayer, x, y, duration, message) end
---@param toPlayer player
---@param x real
---@param y real
---@param duration real
---@param message string
function DisplayTimedTextFromPlayer(toPlayer, x, y, duration, message) end
function ClearTextMessages() end
---@param terrainDNCFile string
---@param unitDNCFile string
function SetDayNightModels(terrainDNCFile, unitDNCFile) end
---@param skyModelFile string
function SetSkyModel(skyModelFile) end
---@param b boolean
function EnableUserControl(b) end
---@param b boolean
function EnableUserUI(b) end
---@param b boolean
function SuspendTimeOfDay(b) end
---@param r real
function SetTimeOfDayScale(r) end
function GetTimeOfDayScale() end
---@param flag boolean
---@param fadeDuration real
function ShowInterface(flag, fadeDuration) end
---@param flag boolean
function PauseGame(flag) end
---@param whichUnit unit
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function UnitAddIndicator(whichUnit, red, green, blue, alpha) end
---@param whichWidget widget
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function AddIndicator(whichWidget, red, green, blue, alpha) end
---@param x real
---@param y real
---@param duration real
function PingMinimap(x, y, duration) end
---@param x real
---@param y real
---@param duration real
---@param red integer
---@param green integer
---@param blue integer
---@param extraEffects boolean
function PingMinimapEx(x, y, duration, red, green, blue, extraEffects) end
---@param flag boolean
function EnableOcclusion(flag) end
---@param introText string
function SetIntroShotText(introText) end
---@param introModelPath string
function SetIntroShotModel(introModelPath) end
---@param b boolean
function EnableWorldFogBoundary(b) end
---@param modelName string
function PlayModelCinematic(modelName) end
---@param movieName string
function PlayCinematic(movieName) end
---@param key string
function ForceUIKey(key) end
function ForceUICancel() end
function DisplayLoadDialog() end
---@param iconPath string
function SetAltMinimapIcon(iconPath) end
---@param flag boolean
function DisableRestartMission(flag) end
function CreateTextTag() end
---@param t texttag
function DestroyTextTag(t) end
---@param t texttag
---@param s string
---@param height real
function SetTextTagText(t, s, height) end
---@param t texttag
---@param x real
---@param y real
---@param heightOffset real
function SetTextTagPos(t, x, y, heightOffset) end
---@param t texttag
---@param whichUnit unit
---@param heightOffset real
function SetTextTagPosUnit(t, whichUnit, heightOffset) end
---@param t texttag
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetTextTagColor(t, red, green, blue, alpha) end
---@param t texttag
---@param xvel real
---@param yvel real
function SetTextTagVelocity(t, xvel, yvel) end
---@param t texttag
---@param flag boolean
function SetTextTagVisibility(t, flag) end
---@param t texttag
---@param flag boolean
function SetTextTagSuspended(t, flag) end
---@param t texttag
---@param flag boolean
function SetTextTagPermanent(t, flag) end
---@param t texttag
---@param age real
function SetTextTagAge(t, age) end
---@param t texttag
---@param lifespan real
function SetTextTagLifespan(t, lifespan) end
---@param t texttag
---@param fadepoint real
function SetTextTagFadepoint(t, fadepoint) end
---@param reserved integer
function SetReservedLocalHeroButtons(reserved) end
function GetAllyColorFilterState() end
---@param state integer
function SetAllyColorFilterState(state) end
function GetCreepCampFilterState() end
---@param state boolean
function SetCreepCampFilterState(state) end
---@param enableAlly boolean
---@param enableCreep boolean
function EnableMinimapFilterButtons(enableAlly, enableCreep) end
---@param state boolean
---@param ui boolean
function EnableDragSelect(state, ui) end
---@param state boolean
---@param ui boolean
function EnablePreSelect(state, ui) end
---@param state boolean
---@param ui boolean
function EnableSelect(state, ui) end
---@param trackableModelPath string
---@param x real
---@param y real
---@param facing real
function CreateTrackable(trackableModelPath, x, y, facing) end
function CreateQuest() end
---@param whichQuest quest
function DestroyQuest(whichQuest) end
---@param whichQuest quest
---@param title string
function QuestSetTitle(whichQuest, title) end
---@param whichQuest quest
---@param description string
function QuestSetDescription(whichQuest, description) end
---@param whichQuest quest
---@param iconPath string
function QuestSetIconPath(whichQuest, iconPath) end
---@param whichQuest quest
---@param required boolean
function QuestSetRequired(whichQuest, required) end
---@param whichQuest quest
---@param completed boolean
function QuestSetCompleted(whichQuest, completed) end
---@param whichQuest quest
---@param discovered boolean
function QuestSetDiscovered(whichQuest, discovered) end
---@param whichQuest quest
---@param failed boolean
function QuestSetFailed(whichQuest, failed) end
---@param whichQuest quest
---@param enabled boolean
function QuestSetEnabled(whichQuest, enabled) end
---@param whichQuest quest
function IsQuestRequired(whichQuest) end
---@param whichQuest quest
function IsQuestCompleted(whichQuest) end
---@param whichQuest quest
function IsQuestDiscovered(whichQuest) end
---@param whichQuest quest
function IsQuestFailed(whichQuest) end
---@param whichQuest quest
function IsQuestEnabled(whichQuest) end
---@param whichQuest quest
function QuestCreateItem(whichQuest) end
---@param whichQuestItem questitem
---@param description string
function QuestItemSetDescription(whichQuestItem, description) end
---@param whichQuestItem questitem
---@param completed boolean
function QuestItemSetCompleted(whichQuestItem, completed) end
---@param whichQuestItem questitem
function IsQuestItemCompleted(whichQuestItem) end
function CreateDefeatCondition() end
---@param whichCondition defeatcondition
function DestroyDefeatCondition(whichCondition) end
---@param whichCondition defeatcondition
---@param description string
function DefeatConditionSetDescription(whichCondition, description) end
function FlashQuestDialogButton() end
function ForceQuestDialogUpdate() end
---@param t timer
function CreateTimerDialog(t) end
---@param whichDialog timerdialog
function DestroyTimerDialog(whichDialog) end
---@param whichDialog timerdialog
---@param title string
function TimerDialogSetTitle(whichDialog, title) end
---@param whichDialog timerdialog
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function TimerDialogSetTitleColor(whichDialog, red, green, blue, alpha) end
---@param whichDialog timerdialog
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function TimerDialogSetTimeColor(whichDialog, red, green, blue, alpha) end
---@param whichDialog timerdialog
---@param speedMultFactor real
function TimerDialogSetSpeed(whichDialog, speedMultFactor) end
---@param whichDialog timerdialog
---@param display boolean
function TimerDialogDisplay(whichDialog, display) end
---@param whichDialog timerdialog
function IsTimerDialogDisplayed(whichDialog) end
---@param whichDialog timerdialog
---@param timeRemaining real
function TimerDialogSetRealTimeRemaining(whichDialog, timeRemaining) end
function CreateLeaderboard() end
---@param lb leaderboard
function DestroyLeaderboard(lb) end
---@param lb leaderboard
---@param show boolean
function LeaderboardDisplay(lb, show) end
---@param lb leaderboard
function IsLeaderboardDisplayed(lb) end
---@param lb leaderboard
function LeaderboardGetItemCount(lb) end
---@param lb leaderboard
---@param count integer
function LeaderboardSetSizeByItemCount(lb, count) end
---@param lb leaderboard
---@param label string
---@param value integer
---@param p player
function LeaderboardAddItem(lb, label, value, p) end
---@param lb leaderboard
---@param index integer
function LeaderboardRemoveItem(lb, index) end
---@param lb leaderboard
---@param p player
function LeaderboardRemovePlayerItem(lb, p) end
---@param lb leaderboard
function LeaderboardClear(lb) end
---@param lb leaderboard
---@param ascending boolean
function LeaderboardSortItemsByValue(lb, ascending) end
---@param lb leaderboard
---@param ascending boolean
function LeaderboardSortItemsByPlayer(lb, ascending) end
---@param lb leaderboard
---@param ascending boolean
function LeaderboardSortItemsByLabel(lb, ascending) end
---@param lb leaderboard
---@param p player
function LeaderboardHasPlayerItem(lb, p) end
---@param lb leaderboard
---@param p player
function LeaderboardGetPlayerIndex(lb, p) end
---@param lb leaderboard
---@param label string
function LeaderboardSetLabel(lb, label) end
---@param lb leaderboard
function LeaderboardGetLabelText(lb) end
---@param toPlayer player
---@param lb leaderboard
function PlayerSetLeaderboard(toPlayer, lb) end
---@param toPlayer player
function PlayerGetLeaderboard(toPlayer) end
---@param lb leaderboard
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function LeaderboardSetLabelColor(lb, red, green, blue, alpha) end
---@param lb leaderboard
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function LeaderboardSetValueColor(lb, red, green, blue, alpha) end
---@param lb leaderboard
---@param showLabel boolean
---@param showNames boolean
---@param showValues boolean
---@param showIcons boolean
function LeaderboardSetStyle(lb, showLabel, showNames, showValues, showIcons) end
---@param lb leaderboard
---@param whichItem integer
---@param val integer
function LeaderboardSetItemValue(lb, whichItem, val) end
---@param lb leaderboard
---@param whichItem integer
---@param val string
function LeaderboardSetItemLabel(lb, whichItem, val) end
---@param lb leaderboard
---@param whichItem integer
---@param showLabel boolean
---@param showValue boolean
---@param showIcon boolean
function LeaderboardSetItemStyle(lb, whichItem, showLabel, showValue, showIcon) end
---@param lb leaderboard
---@param whichItem integer
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function LeaderboardSetItemLabelColor(lb, whichItem, red, green, blue, alpha) end
---@param lb leaderboard
---@param whichItem integer
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function LeaderboardSetItemValueColor(lb, whichItem, red, green, blue, alpha) end
function CreateMultiboard() end
---@param lb multiboard
function DestroyMultiboard(lb) end
---@param lb multiboard
---@param show boolean
function MultiboardDisplay(lb, show) end
---@param lb multiboard
function IsMultiboardDisplayed(lb) end
---@param lb multiboard
---@param minimize boolean
function MultiboardMinimize(lb, minimize) end
---@param lb multiboard
function IsMultiboardMinimized(lb) end
---@param lb multiboard
function MultiboardClear(lb) end
---@param lb multiboard
---@param label string
function MultiboardSetTitleText(lb, label) end
---@param lb multiboard
function MultiboardGetTitleText(lb) end
---@param lb multiboard
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function MultiboardSetTitleTextColor(lb, red, green, blue, alpha) end
---@param lb multiboard
function MultiboardGetRowCount(lb) end
---@param lb multiboard
function MultiboardGetColumnCount(lb) end
---@param lb multiboard
---@param count integer
function MultiboardSetColumnCount(lb, count) end
---@param lb multiboard
---@param count integer
function MultiboardSetRowCount(lb, count) end
---@param lb multiboard
---@param showValues boolean
---@param showIcons boolean
function MultiboardSetItemsStyle(lb, showValues, showIcons) end
---@param lb multiboard
---@param value string
function MultiboardSetItemsValue(lb, value) end
---@param lb multiboard
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function MultiboardSetItemsValueColor(lb, red, green, blue, alpha) end
---@param lb multiboard
---@param width real
function MultiboardSetItemsWidth(lb, width) end
---@param lb multiboard
---@param iconPath string
function MultiboardSetItemsIcon(lb, iconPath) end
---@param lb multiboard
---@param row integer
---@param column integer
function MultiboardGetItem(lb, row, column) end
---@param mbi multiboarditem
function MultiboardReleaseItem(mbi) end
---@param mbi multiboarditem
---@param showValue boolean
---@param showIcon boolean
function MultiboardSetItemStyle(mbi, showValue, showIcon) end
---@param mbi multiboarditem
---@param val string
function MultiboardSetItemValue(mbi, val) end
---@param mbi multiboarditem
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function MultiboardSetItemValueColor(mbi, red, green, blue, alpha) end
---@param mbi multiboarditem
---@param width real
function MultiboardSetItemWidth(mbi, width) end
---@param mbi multiboarditem
---@param iconFileName string
function MultiboardSetItemIcon(mbi, iconFileName) end
---@param flag boolean
function MultiboardSuppressDisplay(flag) end
---@param x real
---@param y real
function SetCameraPosition(x, y) end
---@param x real
---@param y real
function SetCameraQuickPosition(x, y) end
---@param x1 real
---@param y1 real
---@param x2 real
---@param y2 real
---@param x3 real
---@param y3 real
---@param x4 real
---@param y4 real
function SetCameraBounds(x1, y1, x2, y2, x3, y3, x4, y4) end
function StopCamera() end
---@param duration real
function ResetToGameCamera(duration) end
---@param x real
---@param y real
function PanCameraTo(x, y) end
---@param x real
---@param y real
---@param duration real
function PanCameraToTimed(x, y, duration) end
---@param x real
---@param y real
---@param zOffsetDest real
function PanCameraToWithZ(x, y, zOffsetDest) end
---@param x real
---@param y real
---@param zOffsetDest real
---@param duration real
function PanCameraToTimedWithZ(x, y, zOffsetDest, duration) end
---@param cameraModelFile string
function SetCinematicCamera(cameraModelFile) end
---@param x real
---@param y real
---@param radiansToSweep real
---@param duration real
function SetCameraRotateMode(x, y, radiansToSweep, duration) end
---@param whichField camerafield
---@param value real
---@param duration real
function SetCameraField(whichField, value, duration) end
---@param whichField camerafield
---@param offset real
---@param duration real
function AdjustCameraField(whichField, offset, duration) end
---@param whichUnit unit
---@param xoffset real
---@param yoffset real
---@param inheritOrientation boolean
function SetCameraTargetController(whichUnit, xoffset, yoffset, inheritOrientation) end
---@param whichUnit unit
---@param xoffset real
---@param yoffset real
function SetCameraOrientController(whichUnit, xoffset, yoffset) end
function CreateCameraSetup() end
---@param whichSetup camerasetup
---@param whichField camerafield
---@param value real
---@param duration real
function CameraSetupSetField(whichSetup, whichField, value, duration) end
---@param whichSetup camerasetup
---@param whichField camerafield
function CameraSetupGetField(whichSetup, whichField) end
---@param whichSetup camerasetup
---@param x real
---@param y real
---@param duration real
function CameraSetupSetDestPosition(whichSetup, x, y, duration) end
---@param whichSetup camerasetup
function CameraSetupGetDestPositionLoc(whichSetup) end
---@param whichSetup camerasetup
function CameraSetupGetDestPositionX(whichSetup) end
---@param whichSetup camerasetup
function CameraSetupGetDestPositionY(whichSetup) end
---@param whichSetup camerasetup
---@param doPan boolean
---@param panTimed boolean
function CameraSetupApply(whichSetup, doPan, panTimed) end
---@param whichSetup camerasetup
---@param zDestOffset real
function CameraSetupApplyWithZ(whichSetup, zDestOffset) end
---@param whichSetup camerasetup
---@param doPan boolean
---@param forceDuration real
function CameraSetupApplyForceDuration(whichSetup, doPan, forceDuration) end
---@param whichSetup camerasetup
---@param zDestOffset real
---@param forceDuration real
function CameraSetupApplyForceDurationWithZ(whichSetup, zDestOffset, forceDuration) end
---@param mag real
---@param velocity real
function CameraSetTargetNoise(mag, velocity) end
---@param mag real
---@param velocity real
function CameraSetSourceNoise(mag, velocity) end
---@param mag real
---@param velocity real
---@param vertOnly boolean
function CameraSetTargetNoiseEx(mag, velocity, vertOnly) end
---@param mag real
---@param velocity real
---@param vertOnly boolean
function CameraSetSourceNoiseEx(mag, velocity, vertOnly) end
---@param factor real
function CameraSetSmoothingFactor(factor) end
---@param filename string
function SetCineFilterTexture(filename) end
---@param whichMode blendmode
function SetCineFilterBlendMode(whichMode) end
---@param whichFlags texmapflags
function SetCineFilterTexMapFlags(whichFlags) end
---@param minu real
---@param minv real
---@param maxu real
---@param maxv real
function SetCineFilterStartUV(minu, minv, maxu, maxv) end
---@param minu real
---@param minv real
---@param maxu real
---@param maxv real
function SetCineFilterEndUV(minu, minv, maxu, maxv) end
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetCineFilterStartColor(red, green, blue, alpha) end
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetCineFilterEndColor(red, green, blue, alpha) end
---@param duration real
function SetCineFilterDuration(duration) end
---@param flag boolean
function DisplayCineFilter(flag) end
function IsCineFilterDisplayed() end
---@param portraitUnitId integer
---@param color playercolor
---@param speakerTitle string
---@param text string
---@param sceneDuration real
---@param voiceoverDuration real
function SetCinematicScene(portraitUnitId, color, speakerTitle, text, sceneDuration, voiceoverDuration) end
function EndCinematicScene() end
---@param flag boolean
function ForceCinematicSubtitles(flag) end
---@param whichMargin integer
function GetCameraMargin(whichMargin) end
function GetCameraBoundMinX() end
function GetCameraBoundMinY() end
function GetCameraBoundMaxX() end
function GetCameraBoundMaxY() end
---@param whichField camerafield
function GetCameraField(whichField) end
function GetCameraTargetPositionX() end
function GetCameraTargetPositionY() end
function GetCameraTargetPositionZ() end
function GetCameraTargetPositionLoc() end
function GetCameraEyePositionX() end
function GetCameraEyePositionY() end
function GetCameraEyePositionZ() end
function GetCameraEyePositionLoc() end
---@param environmentName string
function NewSoundEnvironment(environmentName) end
---@param fileName string
---@param looping boolean
---@param is3D boolean
---@param stopwhenoutofrange boolean
---@param fadeInRate integer
---@param fadeOutRate integer
---@param eaxSetting string
function CreateSound(fileName, looping, is3D, stopwhenoutofrange, fadeInRate, fadeOutRate, eaxSetting) end
---@param fileName string
---@param looping boolean
---@param is3D boolean
---@param stopwhenoutofrange boolean
---@param fadeInRate integer
---@param fadeOutRate integer
---@param SLKEntryName string
function CreateSoundFilenameWithLabel(fileName, looping, is3D, stopwhenoutofrange, fadeInRate, fadeOutRate, SLKEntryName) end
---@param soundLabel string
---@param looping boolean
---@param is3D boolean
---@param stopwhenoutofrange boolean
---@param fadeInRate integer
---@param fadeOutRate integer
function CreateSoundFromLabel(soundLabel, looping, is3D, stopwhenoutofrange, fadeInRate, fadeOutRate) end
---@param soundLabel string
---@param fadeInRate integer
---@param fadeOutRate integer
function CreateMIDISound(soundLabel, fadeInRate, fadeOutRate) end
---@param soundHandle sound
---@param soundLabel string
function SetSoundParamsFromLabel(soundHandle, soundLabel) end
---@param soundHandle sound
---@param cutoff real
function SetSoundDistanceCutoff(soundHandle, cutoff) end
---@param soundHandle sound
---@param channel integer
function SetSoundChannel(soundHandle, channel) end
---@param soundHandle sound
---@param volume integer
function SetSoundVolume(soundHandle, volume) end
---@param soundHandle sound
---@param pitch real
function SetSoundPitch(soundHandle, pitch) end
---@param soundHandle sound
---@param millisecs integer
function SetSoundPlayPosition(soundHandle, millisecs) end
---@param soundHandle sound
---@param minDist real
---@param maxDist real
function SetSoundDistances(soundHandle, minDist, maxDist) end
---@param soundHandle sound
---@param inside real
---@param outside real
---@param outsideVolume integer
function SetSoundConeAngles(soundHandle, inside, outside, outsideVolume) end
---@param soundHandle sound
---@param x real
---@param y real
---@param z real
function SetSoundConeOrientation(soundHandle, x, y, z) end
---@param soundHandle sound
---@param x real
---@param y real
---@param z real
function SetSoundPosition(soundHandle, x, y, z) end
---@param soundHandle sound
---@param x real
---@param y real
---@param z real
function SetSoundVelocity(soundHandle, x, y, z) end
---@param soundHandle sound
---@param whichUnit unit
function AttachSoundToUnit(soundHandle, whichUnit) end
---@param soundHandle sound
function StartSound(soundHandle) end
---@param soundHandle sound
---@param killWhenDone boolean
---@param fadeOut boolean
function StopSound(soundHandle, killWhenDone, fadeOut) end
---@param soundHandle sound
function KillSoundWhenDone(soundHandle) end
---@param musicName string
---@param random boolean
---@param index integer
function SetMapMusic(musicName, random, index) end
function ClearMapMusic() end
---@param musicName string
function PlayMusic(musicName) end
---@param musicName string
---@param frommsecs integer
---@param fadeinmsecs integer
function PlayMusicEx(musicName, frommsecs, fadeinmsecs) end
---@param fadeOut boolean
function StopMusic(fadeOut) end
function ResumeMusic() end
---@param musicFileName string
function PlayThematicMusic(musicFileName) end
---@param musicFileName string
---@param frommsecs integer
function PlayThematicMusicEx(musicFileName, frommsecs) end
function EndThematicMusic() end
---@param volume integer
function SetMusicVolume(volume) end
---@param millisecs integer
function SetMusicPlayPosition(millisecs) end
---@param millisecs integer
function SetThematicMusicPlayPosition(millisecs) end
---@param soundHandle sound
---@param duration integer
function SetSoundDuration(soundHandle, duration) end
---@param soundHandle sound
function GetSoundDuration(soundHandle) end
---@param musicFileName string
function GetSoundFileDuration(musicFileName) end
---@param vgroup volumegroup
---@param scale real
function VolumeGroupSetVolume(vgroup, scale) end
function VolumeGroupReset() end
---@param soundHandle sound
function GetSoundIsPlaying(soundHandle) end
---@param soundHandle sound
function GetSoundIsLoading(soundHandle) end
---@param soundHandle sound
---@param byPosition boolean
---@param rectwidth real
---@param rectheight real
function RegisterStackedSound(soundHandle, byPosition, rectwidth, rectheight) end
---@param soundHandle sound
---@param byPosition boolean
---@param rectwidth real
---@param rectheight real
function UnregisterStackedSound(soundHandle, byPosition, rectwidth, rectheight) end
---@param where rect
---@param effectID integer
function AddWeatherEffect(where, effectID) end
---@param whichEffect weathereffect
function RemoveWeatherEffect(whichEffect) end
---@param whichEffect weathereffect
---@param enable boolean
function EnableWeatherEffect(whichEffect, enable) end
---@param x real
---@param y real
---@param radius real
---@param depth real
---@param duration integer
---@param permanent boolean
function TerrainDeformCrater(x, y, radius, depth, duration, permanent) end
---@param x real
---@param y real
---@param radius real
---@param depth real
---@param duration integer
---@param count integer
---@param spaceWaves real
---@param timeWaves real
---@param radiusStartPct real
---@param limitNeg boolean
function TerrainDeformRipple(x, y, radius, depth, duration, count, spaceWaves, timeWaves, radiusStartPct, limitNeg) end
---@param x real
---@param y real
---@param dirX real
---@param dirY real
---@param distance real
---@param speed real
---@param radius real
---@param depth real
---@param trailTime integer
---@param count integer
function TerrainDeformWave(x, y, dirX, dirY, distance, speed, radius, depth, trailTime, count) end
---@param x real
---@param y real
---@param radius real
---@param minDelta real
---@param maxDelta real
---@param duration integer
---@param updateInterval integer
function TerrainDeformRandom(x, y, radius, minDelta, maxDelta, duration, updateInterval) end
---@param deformation terraindeformation
---@param duration integer
function TerrainDeformStop(deformation, duration) end
function TerrainDeformStopAll() end
---@param modelName string
---@param x real
---@param y real
function AddSpecialEffect(modelName, x, y) end
---@param modelName string
---@param where location
function AddSpecialEffectLoc(modelName, where) end
---@param modelName string
---@param targetWidget widget
---@param attachPointName string
function AddSpecialEffectTarget(modelName, targetWidget, attachPointName) end
---@param whichEffect effect
function DestroyEffect(whichEffect) end
---@param abilityString string
---@param t effecttype
---@param x real
---@param y real
function AddSpellEffect(abilityString, t, x, y) end
---@param abilityString string
---@param t effecttype
---@paramlwhere ocation
function AddSpellEffectLoc(abilityString, t,lwhere) end
---@param abilityId integer
---@param t effecttype
---@paramrx eal
---@param y real
function AddSpellEffectById(abilityId, t,rx, y) end
---@param abilityId integer
---@param t effecttype
---@paramlwhere ocation
function AddSpellEffectByIdLoc(abilityId, t,lwhere) end
---@param modelName string
---@param t effecttype
---@param targetWidget widget
---@param attachPoint string
function AddSpellEffectTarget(modelName, t, targetWidget, attachPoint) end
---@param abilityId integer
---@param t effecttype
---@param targetWidget widget
---@param attachPoint string
function AddSpellEffectTargetById(abilityId, t, targetWidget, attachPoint) end
---@param codeName string
---@param checkVisibility boolean
---@param x1 real
---@param y1 real
---@param x2 real
---@param y2 real
function AddLightning(codeName, checkVisibility, x1, y1, x2, y2) end
---@param codeName string
---@param checkVisibility boolean
---@param x1 real
---@param y1 real
---@param z1 real
---@param x2 real
---@param y2 real
---@param z2 real
function AddLightningEx(codeName, checkVisibility, x1, y1, z1, x2, y2, z2) end
---@param whichBolt lightning
function DestroyLightning(whichBolt) end
---@param whichBolt lightning
---@param checkVisibility boolean
---@param x1 real
---@param y1 real
---@param x2 real
---@param y2 real
function MoveLightning(whichBolt, checkVisibility, x1, y1, x2, y2) end
---@param whichBolt lightning
---@param checkVisibility boolean
---@param x1 real
---@param y1 real
---@param z1 real
---@param x2 real
---@param y2 real
---@param z2 real
function MoveLightningEx(whichBolt, checkVisibility, x1, y1, z1, x2, y2, z2) end
---@param whichBolt lightning
function GetLightningColorA(whichBolt) end
---@param whichBolt lightning
function GetLightningColorR(whichBolt) end
---@param whichBolt lightning
function GetLightningColorG(whichBolt) end
---@param whichBolt lightning
function GetLightningColorB(whichBolt) end
---@param whichBolt lightning
---@param r real
---@param g real
---@param b real
---@param a real
function SetLightningColor(whichBolt, r, g, b, a) end
---@param abilityString string
---@param t effecttype
---@param index integer
function GetAbilityEffect(abilityString, t, index) end
---@param abilityId integer
---@param t effecttype
---@param index integer
function GetAbilityEffectById(abilityId, t, index) end
---@param abilityString string
---@param t soundtype
function GetAbilitySound(abilityString, t) end
---@param abilityId integer
---@param t soundtype
function GetAbilitySoundById(abilityId, t) end
---@param x real
---@param y real
function GetTerrainCliffLevel(x, y) end
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetWaterBaseColor(red, green, blue, alpha) end
---@param val boolean
function SetWaterDeforms(val) end
---@param x real
---@param y real
function GetTerrainType(x, y) end
---@param x real
---@param y real
function GetTerrainVariance(x, y) end
---@param x real
---@param y real
---@param terrainType integer
---@param variation integer
---@param area integer
---@param shape integer
function SetTerrainType(x, y, terrainType, variation, area, shape) end
---@param x real
---@param y real
---@param t pathingtype
function IsTerrainPathable(x, y, t) end
---@param x real
---@param y real
---@param t pathingtype
---@param flag boolean
function SetTerrainPathable(x, y, t, flag) end
---@param file string
---@param sizeX real
---@param sizeY real
---@param sizeZ real
---@param posX real
---@param posY real
---@param posZ real
---@param originX real
---@param originY real
---@param originZ real
---@param imageType integer
function CreateImage(file, sizeX, sizeY, sizeZ, posX, posY, posZ, originX, originY, originZ, imageType) end
---@param whichImage image
function DestroyImage(whichImage) end
---@param whichImage image
---@param flag boolean
function ShowImage(whichImage, flag) end
---@param whichImage image
---@param flag boolean
---@param height real
function SetImageConstantHeight(whichImage, flag, height) end
---@param whichImage image
---@param x real
---@param y real
---@param z real
function SetImagePosition(whichImage, x, y, z) end
---@param whichImage image
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetImageColor(whichImage, red, green, blue, alpha) end
---@param whichImage image
---@param flag boolean
function SetImageRender(whichImage, flag) end
---@param whichImage image
---@param flag boolean
function SetImageRenderAlways(whichImage, flag) end
---@param whichImage image
---@param flag boolean
---@param useWaterAlpha boolean
function SetImageAboveWater(whichImage, flag, useWaterAlpha) end
---@param whichImage image
---@param imageType integer
function SetImageType(whichImage, imageType) end
---@param x real
---@param y real
---@param name string
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
---@param forcePaused boolean
---@param noBirthTime boolean
function CreateUbersplat(x, y, name, red, green, blue, alpha, forcePaused, noBirthTime) end
---@param whichSplat ubersplat
function DestroyUbersplat(whichSplat) end
---@param whichSplat ubersplat
function ResetUbersplat(whichSplat) end
---@param whichSplat ubersplat
function FinishUbersplat(whichSplat) end
---@param whichSplat ubersplat
---@param flag boolean
function ShowUbersplat(whichSplat, flag) end
---@param whichSplat ubersplat
---@param flag boolean
function SetUbersplatRender(whichSplat, flag) end
---@param whichSplat ubersplat
---@param flag boolean
function SetUbersplatRenderAlways(whichSplat, flag) end
---@param whichPlayer player
---@param x real
---@param y real
---@param radius real
---@param addBlight boolean
function SetBlight(whichPlayer, x, y, radius, addBlight) end
---@param whichPlayer player
---@param r rect
---@param addBlight boolean
function SetBlightRect(whichPlayer, r, addBlight) end
---@param whichPlayer player
---@param x real
---@param y real
---@param addBlight boolean
function SetBlightPoint(whichPlayer, x, y, addBlight) end
---@param whichPlayer player
---@param whichLocation location
---@param radius real
---@param addBlight boolean
function SetBlightLoc(whichPlayer, whichLocation, radius, addBlight) end
---@param id player
---@param x real
---@param y real
---@param face real
function CreateBlightedGoldmine(id, x, y, face) end
---@param x real
---@param y real
function IsPointBlighted(x, y) end
---@param x real
---@param y real
---@param radius real
---@param doodadID integer
---@param nearestOnly boolean
---@param animName string
---@param animRandom boolean
function SetDoodadAnimation(x, y, radius, doodadID, nearestOnly, animName, animRandom) end
---@param r rect
---@param doodadID integer
---@param animName string
---@param animRandom boolean
function SetDoodadAnimationRect(r, doodadID, animName, animRandom) end
---@param num player
---@param script string
function StartMeleeAI(num, script) end
---@param num player
---@param script string
function StartCampaignAI(num, script) end
---@param num player
---@param command integer
---@param data integer
function CommandAI(num, command, data) end
---@param p player
---@param pause boolean
function PauseCompAI(p, pause) end
---@param num player
function GetAIDifficulty(num) end
---@param hUnit unit
function RemoveGuardPosition(hUnit) end
---@param hUnit unit
function RecycleGuardPosition(hUnit) end
---@param num player
function RemoveAllGuardPositions(num) end
---@param cheatStr string
function Cheat(cheatStr) end
function IsNoVictoryCheat() end
function IsNoDefeatCheat() end
---@param filename string
function Preload(filename) end
---@param timeout real
function PreloadEnd(timeout) end
function PreloadStart() end
function PreloadRefresh() end
function PreloadEndEx() end
function PreloadGenClear() end
function PreloadGenStart() end
---@param filename string
function PreloadGenEnd(filename) end
---@param filename string
function Preloader(filename) end
---@param testType string
function AutomationSetTestType(testType) end
---@param testName string
function AutomationTestStart(testName) end
function AutomationTestEnd() end
function AutomationTestingFinished() end
function BlzGetTriggerPlayerMouseX() end
function BlzGetTriggerPlayerMouseY() end
function BlzGetTriggerPlayerMousePosition() end
function BlzGetTriggerPlayerMouseButton() end
---@param abilCode integer
---@param tooltip string
---@param level integer
function BlzSetAbilityTooltip(abilCode, tooltip, level) end
---@param abilCode integer
---@param tooltip string
---@param level integer
function BlzSetAbilityActivatedTooltip(abilCode, tooltip, level) end
---@param abilCode integer
---@param extendedTooltip string
---@param level integer
function BlzSetAbilityExtendedTooltip(abilCode, extendedTooltip, level) end
---@param abilCode integer
---@param extendedTooltip string
---@param level integer
function BlzSetAbilityActivatedExtendedTooltip(abilCode, extendedTooltip, level) end
---@param abilCode integer
---@param researchTooltip string
---@param level integer
function BlzSetAbilityResearchTooltip(abilCode, researchTooltip, level) end
---@param abilCode integer
---@param researchExtendedTooltip string
---@param level integer
function BlzSetAbilityResearchExtendedTooltip(abilCode, researchExtendedTooltip, level) end
---@param abilCode integer
---@param level integer
function BlzGetAbilityTooltip(abilCode, level) end
---@param abilCode integer
---@param level integer
function BlzGetAbilityActivatedTooltip(abilCode, level) end
---@param abilCode integer
---@param level integer
function BlzGetAbilityExtendedTooltip(abilCode, level) end
---@param abilCode integer
---@param level integer
function BlzGetAbilityActivatedExtendedTooltip(abilCode, level) end
---@param abilCode integer
---@param level integer
function BlzGetAbilityResearchTooltip(abilCode, level) end
---@param abilCode integer
---@param level integer
function BlzGetAbilityResearchExtendedTooltip(abilCode, level) end
---@param abilCode integer
---@param iconPath string
function BlzSetAbilityIcon(abilCode, iconPath) end
---@param abilCode integer
function BlzGetAbilityIcon(abilCode) end
---@param abilCode integer
---@param iconPath string
function BlzSetAbilityActivatedIcon(abilCode, iconPath) end
---@param abilCode integer
function BlzGetAbilityActivatedIcon(abilCode) end
---@param abilCode integer
function BlzGetAbilityPosX(abilCode) end
---@param abilCode integer
function BlzGetAbilityPosY(abilCode) end
---@param abilCode integer
---@param x integer
function BlzSetAbilityPosX(abilCode, x) end
---@param abilCode integer
---@param y integer
function BlzSetAbilityPosY(abilCode, y) end
---@param abilCode integer
function BlzGetAbilityActivatedPosX(abilCode) end
---@param abilCode integer
function BlzGetAbilityActivatedPosY(abilCode) end
---@param abilCode integer
---@param x integer
function BlzSetAbilityActivatedPosX(abilCode, x) end
---@param abilCode integer
---@param y integer
function BlzSetAbilityActivatedPosY(abilCode, y) end
---@param whichUnit unit
function BlzGetUnitMaxHP(whichUnit) end
---@param whichUnit unit
---@param hp integer
function BlzSetUnitMaxHP(whichUnit, hp) end
---@param whichUnit unit
function BlzGetUnitMaxMana(whichUnit) end
---@param whichUnit unit
---@param mana integer
function BlzSetUnitMaxMana(whichUnit, mana) end
---@param whichItem item
---@param name string
function BlzSetItemName(whichItem, name) end
---@param whichItem item
---@param description string
function BlzSetItemDescription(whichItem, description) end
---@param whichItem item
function BlzGetItemDescription(whichItem) end
---@param whichItem item
---@param tooltip string
function BlzSetItemTooltip(whichItem, tooltip) end
---@param whichItem item
function BlzGetItemTooltip(whichItem) end
---@param whichItem item
---@param extendedTooltip string
function BlzSetItemExtendedTooltip(whichItem, extendedTooltip) end
---@param whichItem item
function BlzGetItemExtendedTooltip(whichItem) end
---@param whichItem item
---@param iconPath string
function BlzSetItemIconPath(whichItem, iconPath) end
---@param whichItem item
function BlzGetItemIconPath(whichItem) end
---@param whichUnit unit
---@param name string
function BlzSetUnitName(whichUnit, name) end
---@param whichUnit unit
---@param heroProperName string
function BlzSetHeroProperName(whichUnit, heroProperName) end
---@param whichUnit unit
---@param weaponIndex integer
function BlzGetUnitBaseDamage(whichUnit, weaponIndex) end
---@param whichUnit unit
---@param baseDamage integer
---@param weaponIndex integer
function BlzSetUnitBaseDamage(whichUnit, baseDamage, weaponIndex) end
---@param whichUnit unit
---@param weaponIndex integer
function BlzGetUnitDiceNumber(whichUnit, weaponIndex) end
---@param whichUnit unit
---@param diceNumber integer
---@param weaponIndex integer
function BlzSetUnitDiceNumber(whichUnit, diceNumber, weaponIndex) end
---@param whichUnit unit
---@param weaponIndex integer
function BlzGetUnitDiceSides(whichUnit, weaponIndex) end
---@param whichUnit unit
---@param diceSides integer
---@param weaponIndex integer
function BlzSetUnitDiceSides(whichUnit, diceSides, weaponIndex) end
---@param whichUnit unit
---@param weaponIndex integer
function BlzGetUnitAttackCooldown(whichUnit, weaponIndex) end
---@param whichUnit unit
---@param cooldown real
---@param weaponIndex integer
function BlzSetUnitAttackCooldown(whichUnit, cooldown, weaponIndex) end
---@param whichEffect effect
---@param whichPlayer player
function BlzSetSpecialEffectColorByPlayer(whichEffect, whichPlayer) end
---@param whichEffect effect
---@param r integer
---@param g integer
---@param b integer
function BlzSetSpecialEffectColor(whichEffect, r, g, b) end
---@param whichEffect effect
---@param alpha integer
function BlzSetSpecialEffectAlpha(whichEffect, alpha) end
---@param whichEffect effect
---@param scale real
function BlzSetSpecialEffectScale(whichEffect, scale) end
---@param whichEffect effect
---@param x real
---@param y real
---@param z real
function BlzSetSpecialEffectPosition(whichEffect, x, y, z) end
---@param whichEffect effect
---@param height real
function BlzSetSpecialEffectHeight(whichEffect, height) end
---@param whichEffect effect
---@param timeScale real
function BlzSetSpecialEffectTimeScale(whichEffect, timeScale) end
---@param whichEffect effect
---@param time real
function BlzSetSpecialEffectTime(whichEffect, time) end
---@param whichEffect effect
---@param yaw real
---@param pitch real
---@param roll real
function BlzSetSpecialEffectOrientation(whichEffect, yaw, pitch, roll) end
---@param whichEffect effect
---@param yaw real
function BlzSetSpecialEffectYaw(whichEffect, yaw) end
---@param whichEffect effect
---@param pitch real
function BlzSetSpecialEffectPitch(whichEffect, pitch) end
---@param whichEffect effect
---@param roll real
function BlzSetSpecialEffectRoll(whichEffect, roll) end
---@param whichEffect effect
---@param x real
function BlzSetSpecialEffectX(whichEffect, x) end
---@param whichEffect effect
---@param y real
function BlzSetSpecialEffectY(whichEffect, y) end
---@param whichEffect effect
---@param z real
function BlzSetSpecialEffectZ(whichEffect, z) end
---@param whichEffect effect
---@param loc location
function BlzSetSpecialEffectPositionLoc(whichEffect, loc) end
---@param whichEffect effect
function BlzGetLocalSpecialEffectX(whichEffect) end
---@param whichEffect effect
function BlzGetLocalSpecialEffectY(whichEffect) end
---@param whichEffect effect
function BlzGetLocalSpecialEffectZ(whichEffect) end
---@param whichEffect effect
function BlzSpecialEffectClearSubAnimations(whichEffect) end
---@param whichEffect effect
---@param whichSubAnim subanimtype
function BlzSpecialEffectRemoveSubAnimation(whichEffect, whichSubAnim) end
---@param whichEffect effect
---@param whichSubAnim subanimtype
function BlzSpecialEffectAddSubAnimation(whichEffect, whichSubAnim) end
---@param whichEffect effect
---@param whichAnim animtype
function BlzPlaySpecialEffect(whichEffect, whichAnim) end
---@param whichEffect effect
---@param whichAnim animtype
---@param timeScale real
function BlzPlaySpecialEffectWithTimeScale(whichEffect, whichAnim, timeScale) end
---@param whichAnim animtype
function BlzGetAnimName(whichAnim) end
---@param whichUnit unit
function BlzGetUnitArmor(whichUnit) end
---@param whichUnit unit
---@param armorAmount real
function BlzSetUnitArmor(whichUnit, armorAmount) end
---@param whichUnit unit
---@param abilId integer
---@param flag boolean
function BlzUnitHideAbility(whichUnit, abilId, flag) end
---@param whichUnit unit
---@param abilId integer
---@param flag boolean
---@param hideUI boolean
function BlzUnitDisableAbility(whichUnit, abilId, flag, hideUI) end
---@param whichUnit unit
function BlzUnitCancelTimedLife(whichUnit) end
---@param whichUnit unit
function BlzIsUnitSelectable(whichUnit) end
---@param whichUnit unit
function BlzIsUnitInvulnerable(whichUnit) end
---@param whichUnit unit
function BlzUnitInterruptAttack(whichUnit) end
---@param whichUnit unit
function BlzGetUnitCollisionSize(whichUnit) end
---@param abilId integer
---@param level integer
function BlzGetAbilityManaCost(abilId, level) end
---@param abilId integer
---@param level integer
function BlzGetAbilityCooldown(abilId, level) end
---@param whichUnit unit
---@param abilId integer
---@param level integer
---@param cooldown real
function BlzSetUnitAbilityCooldown(whichUnit, abilId, level, cooldown) end
---@param whichUnit unit
---@param abilId integer
---@param level integer
function BlzGetUnitAbilityCooldown(whichUnit, abilId, level) end
---@param whichUnit unit
---@param abilId integer
function BlzGetUnitAbilityCooldownRemaining(whichUnit, abilId) end
---@param whichUnit unit
---@param abilCode integer
function BlzEndUnitAbilityCooldown(whichUnit, abilCode) end
---@param whichUnit unit
---@param abilId integer
---@param level integer
function BlzGetUnitAbilityManaCost(whichUnit, abilId, level) end
---@param whichUnit unit
---@param abilId integer
---@param level integer
---@param manaCost integer
function BlzSetUnitAbilityManaCost(whichUnit, abilId, level, manaCost) end
---@param whichUnit unit
function BlzGetLocalUnitZ(whichUnit) end
---@param whichPlayer player
---@param techid integer
---@param levels integer
function BlzDecPlayerTechResearched(whichPlayer, techid, levels) end
---@param damage real
function BlzSetEventDamage(damage) end
function BlzGetEventDamageTarget() end
function BlzGetEventAttackType() end
function BlzGetEventDamageType() end
function BlzGetEventWeaponType() end
---@param attackType attacktype
function BlzSetEventAttackType(attackType) end
---@param damageType damagetype
function BlzSetEventDamageType(damageType) end
---@param weaponType weapontype
function BlzSetEventWeaponType(weaponType) end
---@param dataType integer
---@param whichPlayer player
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 integer
---@param param5 integer
---@param param6 integer
function RequestExtraIntegerData(dataType, whichPlayer, param1, param2, param3, param4, param5, param6) end
---@param dataType integer
---@param whichPlayer player
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 integer
---@param param5 integer
---@param param6 integer
function RequestExtraBooleanData(dataType, whichPlayer, param1, param2, param3, param4, param5, param6) end
---@param dataType integer
---@param whichPlayer player
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 integer
---@param param5 integer
---@param param6 integer
function RequestExtraStringData(dataType, whichPlayer, param1, param2, param3, param4, param5, param6) end
---@param dataType integer
---@param whichPlayer player
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 integer
---@param param5 integer
---@param param6 integer
function RequestExtraRealData(dataType, whichPlayer, param1, param2, param3, param4, param5, param6) end
---@param whichUnit unit
function BlzGetUnitZ(whichUnit) end
---@param enableSelection boolean
---@param enableSelectionCircle boolean
function BlzEnableSelections(enableSelection, enableSelectionCircle) end
function BlzIsSelectionEnabled() end
function BlzIsSelectionCircleEnabled() end
---@param whichSetup camerasetup
---@param doPan boolean
---@param forcedDuration real
---@param easeInDuration real
---@param easeOutDuration real
---@param smoothFactor real
function BlzCameraSetupApplyForceDurationSmooth(whichSetup, doPan, forcedDuration, easeInDuration, easeOutDuration, smoothFactor) end
---@param enable boolean
function BlzEnableTargetIndicator(enable) end
function BlzIsTargetIndicatorEnabled() end
---@param frameType originframetype
---@param index integer
function BlzGetOriginFrame(frameType, index) end
---@param enable boolean
function BlzEnableUIAutoPosition(enable) end
---@param enable boolean
function BlzHideOriginFrames(enable) end
---@param a integer
---@param r integer
---@param g integer
---@param b integer
function BlzConvertColor(a, r, g, b) end
---@param TOCFile string
function BlzLoadTOCFile(TOCFile) end
---@param name string
---@param owner framehandle
---@param priority integer
---@param createContext integer
function BlzCreateFrame(name, owner, priority, createContext) end
---@param name string
---@param owner framehandle
---@param createContext integer
function BlzCreateSimpleFrame(name, owner, createContext) end
---@param typeName string
---@param name string
---@param owner framehandle
---@param inherits string
---@param createContext integer
function BlzCreateFrameByType(typeName, name, owner, inherits, createContext) end
---@param frame framehandle
function BlzDestroyFrame(frame) end
---@param frame framehandle
---@param point framepointtype
---@param relative framehandle
---@param relativePoint framepointtype
---@param x real
---@param y real
function BlzFrameSetPoint(frame, point, relative, relativePoint, x, y) end
---@param frame framehandle
---@param point framepointtype
---@param x real
---@param y real
function BlzFrameSetAbsPoint(frame, point, x, y) end
---@param frame framehandle
function BlzFrameClearAllPoints(frame) end
---@param frame framehandle
---@param relative framehandle
function BlzFrameSetAllPoints(frame, relative) end
---@param frame framehandle
---@param visible boolean
function BlzFrameSetVisible(frame, visible) end
---@param frame framehandle
function BlzFrameIsVisible(frame) end
---@param name string
---@param createContext integer
function BlzGetFrameByName(name, createContext) end
---@param frame framehandle
function BlzFrameGetName(frame) end
---@param frame framehandle
function BlzFrameClick(frame) end
---@param frame framehandle
---@param text string
function BlzFrameSetText(frame, text) end
---@param frame framehandle
function BlzFrameGetText(frame) end
---@param frame framehandle
---@param size integer
function BlzFrameSetTextSizeLimit(frame, size) end
---@param frame framehandle
function BlzFrameGetTextSizeLimit(frame) end
---@param frame framehandle
---@param color integer
function BlzFrameSetTextColor(frame, color) end
---@param frame framehandle
---@param flag boolean
function BlzFrameSetFocus(frame, flag) end
---@param frame framehandle
---@param modelFile string
---@param cameraIndex integer
function BlzFrameSetModel(frame, modelFile, cameraIndex) end
---@param frame framehandle
---@param enabled boolean
function BlzFrameSetEnable(frame, enabled) end
---@param frame framehandle
function BlzFrameGetEnable(frame) end
---@param frame framehandle
---@param alpha integer
function BlzFrameSetAlpha(frame, alpha) end
---@param frame framehandle
function BlzFrameGetAlpha(frame) end
---@param frame framehandle
---@param primaryProp integer
---@param flags integer
function BlzFrameSetSpriteAnimate(frame, primaryProp, flags) end
---@param frame framehandle
---@param texFile string
---@param flag integer
---@param blend boolean
function BlzFrameSetTexture(frame, texFile, flag, blend) end
---@param frame framehandle
---@param scale real
function BlzFrameSetScale(frame, scale) end
---@param frame framehandle
---@param tooltip framehandle
function BlzFrameSetTooltip(frame, tooltip) end
---@param frame framehandle
---@param enable boolean
function BlzFrameCageMouse(frame, enable) end
---@param frame framehandle
---@param value real
function BlzFrameSetValue(frame, value) end
---@param frame framehandle
function BlzFrameGetValue(frame) end
---@param frame framehandle
---@param minValue real
---@param maxValue real
function BlzFrameSetMinMaxValue(frame, minValue, maxValue) end
---@param frame framehandle
---@param stepSize real
function BlzFrameSetStepSize(frame, stepSize) end
---@param frame framehandle
---@param width real
---@param height real
function BlzFrameSetSize(frame, width, height) end
---@param frame framehandle
---@param color integer
function BlzFrameSetVertexColor(frame, color) end
---@param frame framehandle
---@param level integer
function BlzFrameSetLevel(frame, level) end
---@param frame framehandle
---@param parent framehandle
function BlzFrameSetParent(frame, parent) end
---@param frame framehandle
function BlzFrameGetParent(frame) end
---@param frame framehandle
function BlzFrameGetHeight(frame) end
---@param frame framehandle
function BlzFrameGetWidth(frame) end
---@param frame framehandle
---@param fileName string
---@param height real
---@param flags integer
function BlzFrameSetFont(frame, fileName, height, flags) end
---@param frame framehandle
---@param vert textaligntype
---@param horz textaligntype
function BlzFrameSetTextAlignment(frame, vert, horz) end
---@param whichTrigger trigger
---@param frame framehandle
---@param eventId frameeventtype
function BlzTriggerRegisterFrameEvent(whichTrigger, frame, eventId) end
function BlzGetTriggerFrame() end
function BlzGetTriggerFrameEvent() end
---@param whichTrigger trigger
---@param whichPlayer player
---@param prefix string
---@param fromServer boolean
function BlzTriggerRegisterPlayerSyncEvent(whichTrigger, whichPlayer, prefix, fromServer) end
---@param prefix string
---@param data string
function BlzSendSyncData(prefix, data) end
function BlzGetTriggerSyncPrefix() end
function BlzGetTriggerSyncData() end
---@param whichTrigger trigger
---@param whichPlayer player
---@param key oskeytype
---@param metaKey integer
---@param keyDown boolean
function BlzTriggerRegisterPlayerKeyEvent(whichTrigger, whichPlayer, key, metaKey, keyDown) end
function BlzGetTriggerPlayerKey() end
function BlzGetTriggerPlayerMetaKey() end
function BlzGetTriggerPlayerIsKeyDown() end
---@param enable boolean
function BlzEnableCursor(enable) end
---@param x integer
---@param y integer
function BlzSetMousePos(x, y) end
function BlzGetLocalClientWidth() end
function BlzGetLocalClientHeight() end
function BlzIsLocalClientActive() end
function BlzGetMouseFocusUnit() end
---@param texFile string
function BlzChangeMinimapTerrainTex(texFile) end
function BlzGetLocale() end
---@param whichEffect effect
function BlzGetSpecialEffectScale(whichEffect) end
---@param whichEffect effect
---@param x real
---@param y real
---@param z real
function BlzSetSpecialEffectMatrixScale(whichEffect, x, y, z) end
---@param whichEffect effect
function BlzResetSpecialEffectMatrix(whichEffect) end
---@param whichUnit unit
---@param abilId integer
function BlzGetUnitAbility(whichUnit, abilId) end
---@param whichUnit unit
---@param index integer
function BlzGetUnitAbilityByIndex(whichUnit, index) end
---@param whichPlayer player
---@param recipient integer
---@param message string
function BlzDisplayChatMessage(whichPlayer, recipient, message) end
---@param whichUnit unit
---@param flag boolean
function BlzPauseUnitEx(whichUnit, flag) end
---@param x integer
---@param y integer
function BlzBitOr(x, y) end
---@param x integer
---@param y integer
function BlzBitAnd(x, y) end
---@param x integer
---@param y integer
function BlzBitXor(x, y) end
---@param whichAbility ability
---@param whichField abilitybooleanfield
function BlzGetAbilityBooleanField(whichAbility, whichField) end
---@param whichAbility ability
---@param whichField abilityintegerfield
function BlzGetAbilityIntegerField(whichAbility, whichField) end
---@param whichAbility ability
---@param whichField abilityfloatfield
function BlzGetAbilityRealField(whichAbility, whichField) end
---@param whichAbility ability
---@param whichField abilitystringfield
function BlzGetAbilityStringField(whichAbility, whichField) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelfield
---@param level integer
function BlzGetAbilityBooleanLevelField(whichAbility, whichField, level) end
---@param whichAbility ability
---@param whichField abilityintegerlevelfield
---@param level integer
function BlzGetAbilityIntegerLevelField(whichAbility, whichField, level) end
---@param whichAbility ability
---@param whichField abilityfloatlevelfield
---@param level integer
function BlzGetAbilityRealLevelField(whichAbility, whichField, level) end
---@param whichAbility ability
---@param whichField abilitystringlevelfield
---@param level integer
function BlzGetAbilityStringLevelField(whichAbility, whichField, level) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelarrayfield
---@param level integer
---@param index integer
function BlzGetAbilityBooleanLevelArrayField(whichAbility, whichField, level, index) end
---@param whichAbility ability
---@param whichField abilityintegerlevelarrayfield
---@param level integer
---@param index integer
function BlzGetAbilityIntegerLevelArrayField(whichAbility, whichField, level, index) end
---@param whichAbility ability
---@param whichField abilityfloatlevelarrayfield
---@param level integer
---@param index integer
function BlzGetAbilityRealLevelArrayField(whichAbility, whichField, level, index) end
---@param whichAbility ability
---@param whichField abilitystringlevelarrayfield
---@param level integer
---@param index integer
function BlzGetAbilityStringLevelArrayField(whichAbility, whichField, level, index) end
---@param whichAbility ability
---@param whichField abilitybooleanfield
---@param value boolean
function BlzSetAbilityBooleanField(whichAbility, whichField, value) end
---@param whichAbility ability
---@param whichField abilityintegerfield
---@param value integer
function BlzSetAbilityIntegerField(whichAbility, whichField, value) end
---@param whichAbility ability
---@param whichField abilityfloatfield
---@param value real
function BlzSetAbilityRealField(whichAbility, whichField, value) end
---@param whichAbility ability
---@param whichField abilitystringfield
---@param value string
function BlzSetAbilityStringField(whichAbility, whichField, value) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelfield
---@param level integer
---@param value boolean
function BlzSetAbilityBooleanLevelField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityintegerlevelfield
---@param level integer
---@param value integer
function BlzSetAbilityIntegerLevelField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityfloatlevelfield
---@param level integer
---@param value real
function BlzSetAbilityRealLevelField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitystringlevelfield
---@param level integer
---@param value string
function BlzSetAbilityStringLevelField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelarrayfield
---@param level integer
---@param index integer
---@param value boolean
function BlzSetAbilityBooleanLevelArrayField(whichAbility, whichField, level, index, value) end
---@param whichAbility ability
---@param whichField abilityintegerlevelarrayfield
---@param level integer
---@param index integer
---@param value integer
function BlzSetAbilityIntegerLevelArrayField(whichAbility, whichField, level, index, value) end
---@param whichAbility ability
---@param whichField abilityfloatlevelarrayfield
---@param level integer
---@param index integer
---@param value real
function BlzSetAbilityRealLevelArrayField(whichAbility, whichField, level, index, value) end
---@param whichAbility ability
---@param whichField abilitystringlevelarrayfield
---@param level integer
---@param index integer
---@param value string
function BlzSetAbilityStringLevelArrayField(whichAbility, whichField, level, index, value) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelarrayfield
---@param level integer
---@param value boolean
function BlzAddAbilityBooleanLevelArrayField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityintegerlevelarrayfield
---@param level integer
---@param value integer
function BlzAddAbilityIntegerLevelArrayField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityfloatlevelarrayfield
---@param level integer
---@param value real
function BlzAddAbilityRealLevelArrayField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitystringlevelarrayfield
---@param level integer
---@param value string
function BlzAddAbilityStringLevelArrayField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitybooleanlevelarrayfield
---@param level integer
---@param value boolean
function BlzRemoveAbilityBooleanLevelArrayField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityintegerlevelarrayfield
---@param level integer
---@param value integer
function BlzRemoveAbilityIntegerLevelArrayField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilityfloatlevelarrayfield
---@param level integer
---@param value real
function BlzRemoveAbilityRealLevelArrayField(whichAbility, whichField, level, value) end
---@param whichAbility ability
---@param whichField abilitystringlevelarrayfield
---@param level integer
---@param value string
function BlzRemoveAbilityStringLevelArrayField(whichAbility, whichField, level, value) end
---@param whichItem item
---@param index integer
function BlzGetItemAbilityByIndex(whichItem, index) end
---@param whichItem item
---@param abilCode integer
function BlzGetItemAbility(whichItem, abilCode) end
---@param whichItem item
---@param abilCode integer
function BlzItemAddAbility(whichItem, abilCode) end
---@param whichItem item
---@param whichField itembooleanfield
function BlzGetItemBooleanField(whichItem, whichField) end
---@param whichItem item
---@param whichField itemintegerfield
function BlzGetItemIntegerField(whichItem, whichField) end
---@param whichItem item
---@param whichField itemfloatfield
function BlzGetItemRealField(whichItem, whichField) end
---@param whichItem item
---@param whichField itemstringfield
function BlzGetItemStringField(whichItem, whichField) end
---@param whichItem item
---@param whichField itembooleanfield
---@param value boolean
function BlzSetItemBooleanField(whichItem, whichField, value) end
---@param whichItem item
---@param whichField itemintegerfield
---@param value integer
function BlzSetItemIntegerField(whichItem, whichField, value) end
---@param whichItem item
---@param whichField itemfloatfield
---@param value real
function BlzSetItemRealField(whichItem, whichField, value) end
---@param whichItem item
---@param whichField itemstringfield
---@param value string
function BlzSetItemStringField(whichItem, whichField, value) end
---@param whichItem item
---@param abilCode integer
function BlzItemRemoveAbility(whichItem, abilCode) end
---@param whichUnit unit
---@param whichField unitbooleanfield
function BlzGetUnitBooleanField(whichUnit, whichField) end
---@param whichUnit unit
---@param whichField unitintegerfield
function BlzGetUnitIntegerField(whichUnit, whichField) end
---@param whichUnit unit
---@param whichField unitfloatfield
function BlzGetUnitRealField(whichUnit, whichField) end
---@param whichUnit unit
---@param whichField unitstringfield
function BlzGetUnitStringField(whichUnit, whichField) end
---@param whichUnit unit
---@param whichField unitbooleanfield
---@param value boolean
function BlzSetUnitBooleanField(whichUnit, whichField, value) end
---@param whichUnit unit
---@param whichField unitintegerfield
---@param value integer
function BlzSetUnitIntegerField(whichUnit, whichField, value) end
---@param whichUnit unit
---@param whichField unitfloatfield
---@param value real
function BlzSetUnitRealField(whichUnit, whichField, value) end
---@param whichUnit unit
---@param whichField unitstringfield
---@param value string
function BlzSetUnitStringField(whichUnit, whichField, value) end
---@param whichUnit unit
---@param whichField unitweaponbooleanfield
---@param index integer
function BlzGetUnitWeaponBooleanField(whichUnit, whichField, index) end
---@param whichUnit unit
---@param whichField unitweaponintegerfield
---@param index integer
function BlzGetUnitWeaponIntegerField(whichUnit, whichField, index) end
---@param whichUnit unit
---@param whichField unitweaponfloatfield
---@param index integer
function BlzGetUnitWeaponRealField(whichUnit, whichField, index) end
---@param whichUnit unit
---@param whichField unitweaponstringfield
---@param index integer
function BlzGetUnitWeaponStringField(whichUnit, whichField, index) end
---@param whichUnit unit
---@param whichField unitweaponbooleanfield
---@param index integer
---@param value boolean
function BlzSetUnitWeaponBooleanField(whichUnit, whichField, index, value) end
---@param whichUnit unit
---@param whichField unitweaponintegerfield
---@param index integer
---@param value integer
function BlzSetUnitWeaponIntegerField(whichUnit, whichField, index, value) end
---@param whichUnit unit
---@param whichField unitweaponfloatfield
---@param index integer
---@param value real
function BlzSetUnitWeaponRealField(whichUnit, whichField, index, value) end
---@param whichUnit unit
---@param whichField unitweaponstringfield
---@param index integer
---@param value string
function BlzSetUnitWeaponStringField(whichUnit, whichField, index, value) end

bj_PI = 3.14159
bj_E = 2.71828
bj_CELLWIDTH = 128.0
bj_CLIFFHEIGHT = 128.0
bj_UNIT_FACING = 270.0
bj_RADTODEG = 180.0/bj_PI
bj_DEGTORAD = bj_PI/180.0
bj_TEXT_DELAY_QUEST = 20.00
bj_TEXT_DELAY_QUESTUPDATE = 20.00
bj_TEXT_DELAY_QUESTDONE = 20.00
bj_TEXT_DELAY_QUESTFAILED = 20.00
bj_TEXT_DELAY_QUESTREQUIREMENT = 20.00
bj_TEXT_DELAY_MISSIONFAILED = 20.00
bj_TEXT_DELAY_ALWAYSHINT = 12.00
bj_TEXT_DELAY_HINT = 12.00
bj_TEXT_DELAY_SECRET = 10.00
bj_TEXT_DELAY_UNITACQUIRED = 15.00
bj_TEXT_DELAY_UNITAVAILABLE = 10.00
bj_TEXT_DELAY_ITEMACQUIRED = 10.00
bj_TEXT_DELAY_WARNING = 12.00
bj_QUEUE_DELAY_QUEST = 5.00
bj_QUEUE_DELAY_HINT = 5.00
bj_QUEUE_DELAY_SECRET = 3.00
bj_HANDICAP_EASY = 60.00
bj_GAME_STARTED_THRESHOLD = 0.01
bj_WAIT_FOR_COND_MIN_INTERVAL = 0.10
bj_POLLED_WAIT_INTERVAL = 0.10
bj_POLLED_WAIT_SKIP_THRESHOLD = 2.00
bj_MAX_INVENTORY = 6
bj_MAX_PLAYERS = GetBJMaxPlayers()
bj_PLAYER_NEUTRAL_VICTIM = GetBJPlayerNeutralVictim()
bj_PLAYER_NEUTRAL_EXTRA = GetBJPlayerNeutralExtra()
bj_MAX_PLAYER_SLOTS = GetBJMaxPlayerSlots()
bj_MAX_SKELETONS = 25
bj_MAX_STOCK_ITEM_SLOTS = 11
bj_MAX_STOCK_UNIT_SLOTS = 11
bj_MAX_ITEM_LEVEL = 10
bj_TOD_DAWN = 6.00
bj_TOD_DUSK = 18.00
bj_MELEE_STARTING_TOD = 8.00
bj_MELEE_STARTING_GOLD_V0 = 750
bj_MELEE_STARTING_GOLD_V1 = 500
bj_MELEE_STARTING_LUMBER_V0 = 200
bj_MELEE_STARTING_LUMBER_V1 = 150
bj_MELEE_STARTING_HERO_TOKENS = 1
bj_MELEE_HERO_LIMIT = 3
bj_MELEE_HERO_TYPE_LIMIT = 1
bj_MELEE_MINE_SEARCH_RADIUS = 2000
bj_MELEE_CLEAR_UNITS_RADIUS = 1500
bj_MELEE_CRIPPLE_TIMEOUT = 120.00
bj_MELEE_CRIPPLE_MSG_DURATION = 20.00
bj_MELEE_MAX_TWINKED_HEROES_V0 = 3
bj_MELEE_MAX_TWINKED_HEROES_V1 = 1
bj_CREEP_ITEM_DELAY = 0.50
bj_STOCK_RESTOCK_INITIAL_DELAY = 120
bj_STOCK_RESTOCK_INTERVAL = 30
bj_STOCK_MAX_ITERATIONS = 20
bj_MAX_DEST_IN_REGION_EVENTS = 64
bj_CAMERA_MIN_FARZ = 100
bj_CAMERA_DEFAULT_DISTANCE = 1650
bj_CAMERA_DEFAULT_FARZ = 5000
bj_CAMERA_DEFAULT_AOA = 304
bj_CAMERA_DEFAULT_FOV = 70
bj_CAMERA_DEFAULT_ROLL = 0
bj_CAMERA_DEFAULT_ROTATION = 90
bj_RESCUE_PING_TIME = 2.00
bj_NOTHING_SOUND_DURATION = 5.00
bj_TRANSMISSION_PING_TIME = 1.00
bj_TRANSMISSION_IND_RED = 255
bj_TRANSMISSION_IND_BLUE = 255
bj_TRANSMISSION_IND_GREEN = 255
bj_TRANSMISSION_IND_ALPHA = 255
bj_TRANSMISSION_PORT_HANGTIME = 1.50
bj_CINEMODE_INTERFACEFADE = 0.50
bj_CINEMODE_GAMESPEED = MAP_SPEED_NORMAL
bj_CINEMODE_VOLUME_UNITMOVEMENT = 0.40
bj_CINEMODE_VOLUME_UNITSOUNDS = 0.00
bj_CINEMODE_VOLUME_COMBAT = 0.40
bj_CINEMODE_VOLUME_SPELLS = 0.40
bj_CINEMODE_VOLUME_UI = 0.00
bj_CINEMODE_VOLUME_MUSIC = 0.55
bj_CINEMODE_VOLUME_AMBIENTSOUNDS = 1.00
bj_CINEMODE_VOLUME_FIRE = 0.60
bj_SPEECH_VOLUME_UNITMOVEMENT = 0.25
bj_SPEECH_VOLUME_UNITSOUNDS = 0.00
bj_SPEECH_VOLUME_COMBAT = 0.25
bj_SPEECH_VOLUME_SPELLS = 0.25
bj_SPEECH_VOLUME_UI = 0.00
bj_SPEECH_VOLUME_MUSIC = 0.55
bj_SPEECH_VOLUME_AMBIENTSOUNDS = 1.00
bj_SPEECH_VOLUME_FIRE = 0.60
bj_SMARTPAN_TRESHOLD_PAN = 500
bj_SMARTPAN_TRESHOLD_SNAP = 3500
bj_MAX_QUEUED_TRIGGERS = 100
bj_QUEUED_TRIGGER_TIMEOUT = 180.00
bj_CAMPAIGN_INDEX_T = 0
bj_CAMPAIGN_INDEX_H = 1
bj_CAMPAIGN_INDEX_U = 2
bj_CAMPAIGN_INDEX_O = 3
bj_CAMPAIGN_INDEX_N = 4
bj_CAMPAIGN_INDEX_XN = 5
bj_CAMPAIGN_INDEX_XH = 6
bj_CAMPAIGN_INDEX_XU = 7
bj_CAMPAIGN_INDEX_XO = 8
bj_CAMPAIGN_OFFSET_T = 0
bj_CAMPAIGN_OFFSET_H = 1
bj_CAMPAIGN_OFFSET_U = 2
bj_CAMPAIGN_OFFSET_O = 3
bj_CAMPAIGN_OFFSET_N = 4
bj_CAMPAIGN_OFFSET_XN = 0
bj_CAMPAIGN_OFFSET_XH = 1
bj_CAMPAIGN_OFFSET_XU = 2
bj_CAMPAIGN_OFFSET_XO = 3
bj_MISSION_INDEX_T00 = bj_CAMPAIGN_OFFSET_T * 1000 + 0
bj_MISSION_INDEX_T01 = bj_CAMPAIGN_OFFSET_T * 1000 + 1
bj_MISSION_INDEX_H00 = bj_CAMPAIGN_OFFSET_H * 1000 + 0
bj_MISSION_INDEX_H01 = bj_CAMPAIGN_OFFSET_H * 1000 + 1
bj_MISSION_INDEX_H02 = bj_CAMPAIGN_OFFSET_H * 1000 + 2
bj_MISSION_INDEX_H03 = bj_CAMPAIGN_OFFSET_H * 1000 + 3
bj_MISSION_INDEX_H04 = bj_CAMPAIGN_OFFSET_H * 1000 + 4
bj_MISSION_INDEX_H05 = bj_CAMPAIGN_OFFSET_H * 1000 + 5
bj_MISSION_INDEX_H06 = bj_CAMPAIGN_OFFSET_H * 1000 + 6
bj_MISSION_INDEX_H07 = bj_CAMPAIGN_OFFSET_H * 1000 + 7
bj_MISSION_INDEX_H08 = bj_CAMPAIGN_OFFSET_H * 1000 + 8
bj_MISSION_INDEX_H09 = bj_CAMPAIGN_OFFSET_H * 1000 + 9
bj_MISSION_INDEX_H10 = bj_CAMPAIGN_OFFSET_H * 1000 + 10
bj_MISSION_INDEX_H11 = bj_CAMPAIGN_OFFSET_H * 1000 + 11
bj_MISSION_INDEX_U00 = bj_CAMPAIGN_OFFSET_U * 1000 + 0
bj_MISSION_INDEX_U01 = bj_CAMPAIGN_OFFSET_U * 1000 + 1
bj_MISSION_INDEX_U02 = bj_CAMPAIGN_OFFSET_U * 1000 + 2
bj_MISSION_INDEX_U03 = bj_CAMPAIGN_OFFSET_U * 1000 + 3
bj_MISSION_INDEX_U05 = bj_CAMPAIGN_OFFSET_U * 1000 + 4
bj_MISSION_INDEX_U07 = bj_CAMPAIGN_OFFSET_U * 1000 + 5
bj_MISSION_INDEX_U08 = bj_CAMPAIGN_OFFSET_U * 1000 + 6
bj_MISSION_INDEX_U09 = bj_CAMPAIGN_OFFSET_U * 1000 + 7
bj_MISSION_INDEX_U10 = bj_CAMPAIGN_OFFSET_U * 1000 + 8
bj_MISSION_INDEX_U11 = bj_CAMPAIGN_OFFSET_U * 1000 + 9
bj_MISSION_INDEX_O00 = bj_CAMPAIGN_OFFSET_O * 1000 + 0
bj_MISSION_INDEX_O01 = bj_CAMPAIGN_OFFSET_O * 1000 + 1
bj_MISSION_INDEX_O02 = bj_CAMPAIGN_OFFSET_O * 1000 + 2
bj_MISSION_INDEX_O03 = bj_CAMPAIGN_OFFSET_O * 1000 + 3
bj_MISSION_INDEX_O04 = bj_CAMPAIGN_OFFSET_O * 1000 + 4
bj_MISSION_INDEX_O05 = bj_CAMPAIGN_OFFSET_O * 1000 + 5
bj_MISSION_INDEX_O06 = bj_CAMPAIGN_OFFSET_O * 1000 + 6
bj_MISSION_INDEX_O07 = bj_CAMPAIGN_OFFSET_O * 1000 + 7
bj_MISSION_INDEX_O08 = bj_CAMPAIGN_OFFSET_O * 1000 + 8
bj_MISSION_INDEX_O09 = bj_CAMPAIGN_OFFSET_O * 1000 + 9
bj_MISSION_INDEX_O10 = bj_CAMPAIGN_OFFSET_O * 1000 + 10
bj_MISSION_INDEX_N00 = bj_CAMPAIGN_OFFSET_N * 1000 + 0
bj_MISSION_INDEX_N01 = bj_CAMPAIGN_OFFSET_N * 1000 + 1
bj_MISSION_INDEX_N02 = bj_CAMPAIGN_OFFSET_N * 1000 + 2
bj_MISSION_INDEX_N03 = bj_CAMPAIGN_OFFSET_N * 1000 + 3
bj_MISSION_INDEX_N04 = bj_CAMPAIGN_OFFSET_N * 1000 + 4
bj_MISSION_INDEX_N05 = bj_CAMPAIGN_OFFSET_N * 1000 + 5
bj_MISSION_INDEX_N06 = bj_CAMPAIGN_OFFSET_N * 1000 + 6
bj_MISSION_INDEX_N07 = bj_CAMPAIGN_OFFSET_N * 1000 + 7
bj_MISSION_INDEX_N08 = bj_CAMPAIGN_OFFSET_N * 1000 + 8
bj_MISSION_INDEX_N09 = bj_CAMPAIGN_OFFSET_N * 1000 + 9
bj_MISSION_INDEX_XN00 = bj_CAMPAIGN_OFFSET_XN * 1000 + 0
bj_MISSION_INDEX_XN01 = bj_CAMPAIGN_OFFSET_XN * 1000 + 1
bj_MISSION_INDEX_XN02 = bj_CAMPAIGN_OFFSET_XN * 1000 + 2
bj_MISSION_INDEX_XN03 = bj_CAMPAIGN_OFFSET_XN * 1000 + 3
bj_MISSION_INDEX_XN04 = bj_CAMPAIGN_OFFSET_XN * 1000 + 4
bj_MISSION_INDEX_XN05 = bj_CAMPAIGN_OFFSET_XN * 1000 + 5
bj_MISSION_INDEX_XN06 = bj_CAMPAIGN_OFFSET_XN * 1000 + 6
bj_MISSION_INDEX_XN07 = bj_CAMPAIGN_OFFSET_XN * 1000 + 7
bj_MISSION_INDEX_XN08 = bj_CAMPAIGN_OFFSET_XN * 1000 + 8
bj_MISSION_INDEX_XN09 = bj_CAMPAIGN_OFFSET_XN * 1000 + 9
bj_MISSION_INDEX_XN10 = bj_CAMPAIGN_OFFSET_XN * 1000 + 10
bj_MISSION_INDEX_XH00 = bj_CAMPAIGN_OFFSET_XH * 1000 + 0
bj_MISSION_INDEX_XH01 = bj_CAMPAIGN_OFFSET_XH * 1000 + 1
bj_MISSION_INDEX_XH02 = bj_CAMPAIGN_OFFSET_XH * 1000 + 2
bj_MISSION_INDEX_XH03 = bj_CAMPAIGN_OFFSET_XH * 1000 + 3
bj_MISSION_INDEX_XH04 = bj_CAMPAIGN_OFFSET_XH * 1000 + 4
bj_MISSION_INDEX_XH05 = bj_CAMPAIGN_OFFSET_XH * 1000 + 5
bj_MISSION_INDEX_XH06 = bj_CAMPAIGN_OFFSET_XH * 1000 + 6
bj_MISSION_INDEX_XH07 = bj_CAMPAIGN_OFFSET_XH * 1000 + 7
bj_MISSION_INDEX_XH08 = bj_CAMPAIGN_OFFSET_XH * 1000 + 8
bj_MISSION_INDEX_XH09 = bj_CAMPAIGN_OFFSET_XH * 1000 + 9
bj_MISSION_INDEX_XU00 = bj_CAMPAIGN_OFFSET_XU * 1000 + 0
bj_MISSION_INDEX_XU01 = bj_CAMPAIGN_OFFSET_XU * 1000 + 1
bj_MISSION_INDEX_XU02 = bj_CAMPAIGN_OFFSET_XU * 1000 + 2
bj_MISSION_INDEX_XU03 = bj_CAMPAIGN_OFFSET_XU * 1000 + 3
bj_MISSION_INDEX_XU04 = bj_CAMPAIGN_OFFSET_XU * 1000 + 4
bj_MISSION_INDEX_XU05 = bj_CAMPAIGN_OFFSET_XU * 1000 + 5
bj_MISSION_INDEX_XU06 = bj_CAMPAIGN_OFFSET_XU * 1000 + 6
bj_MISSION_INDEX_XU07 = bj_CAMPAIGN_OFFSET_XU * 1000 + 7
bj_MISSION_INDEX_XU08 = bj_CAMPAIGN_OFFSET_XU * 1000 + 8
bj_MISSION_INDEX_XU09 = bj_CAMPAIGN_OFFSET_XU * 1000 + 9
bj_MISSION_INDEX_XU10 = bj_CAMPAIGN_OFFSET_XU * 1000 + 10
bj_MISSION_INDEX_XU11 = bj_CAMPAIGN_OFFSET_XU * 1000 + 11
bj_MISSION_INDEX_XU12 = bj_CAMPAIGN_OFFSET_XU * 1000 + 12
bj_MISSION_INDEX_XU13 = bj_CAMPAIGN_OFFSET_XU * 1000 + 13
bj_MISSION_INDEX_XO00 = bj_CAMPAIGN_OFFSET_XO * 1000 + 0
bj_MISSION_INDEX_XO01 = bj_CAMPAIGN_OFFSET_XO * 1000 + 1
bj_MISSION_INDEX_XO02 = bj_CAMPAIGN_OFFSET_XO * 1000 + 2
bj_MISSION_INDEX_XO03 = bj_CAMPAIGN_OFFSET_XO * 1000 + 3
bj_CINEMATICINDEX_TOP = 0
bj_CINEMATICINDEX_HOP = 1
bj_CINEMATICINDEX_HED = 2
bj_CINEMATICINDEX_OOP = 3
bj_CINEMATICINDEX_OED = 4
bj_CINEMATICINDEX_UOP = 5
bj_CINEMATICINDEX_UED = 6
bj_CINEMATICINDEX_NOP = 7
bj_CINEMATICINDEX_NED = 8
bj_CINEMATICINDEX_XOP = 9
bj_CINEMATICINDEX_XED = 10
bj_ALLIANCE_UNALLIED = 0
bj_ALLIANCE_UNALLIED_VISION = 1
bj_ALLIANCE_ALLIED = 2
bj_ALLIANCE_ALLIED_VISION = 3
bj_ALLIANCE_ALLIED_UNITS = 4
bj_ALLIANCE_ALLIED_ADVUNITS = 5
bj_ALLIANCE_NEUTRAL = 6
bj_ALLIANCE_NEUTRAL_VISION = 7
bj_KEYEVENTTYPE_DEPRESS = 0
bj_KEYEVENTTYPE_RELEASE = 1
bj_KEYEVENTKEY_LEFT = 0
bj_KEYEVENTKEY_RIGHT = 1
bj_KEYEVENTKEY_DOWN = 2
bj_KEYEVENTKEY_UP = 3
bj_MOUSEEVENTTYPE_DOWN = 0
bj_MOUSEEVENTTYPE_UP = 1
bj_MOUSEEVENTTYPE_MOVE = 2
bj_TIMETYPE_ADD = 0
bj_TIMETYPE_SET = 1
bj_TIMETYPE_SUB = 2
bj_CAMERABOUNDS_ADJUST_ADD = 0
bj_CAMERABOUNDS_ADJUST_SUB = 1
bj_QUESTTYPE_REQ_DISCOVERED = 0
bj_QUESTTYPE_REQ_UNDISCOVERED = 1
bj_QUESTTYPE_OPT_DISCOVERED = 2
bj_QUESTTYPE_OPT_UNDISCOVERED = 3
bj_QUESTMESSAGE_DISCOVERED = 0
bj_QUESTMESSAGE_UPDATED = 1
bj_QUESTMESSAGE_COMPLETED = 2
bj_QUESTMESSAGE_FAILED = 3
bj_QUESTMESSAGE_REQUIREMENT = 4
bj_QUESTMESSAGE_MISSIONFAILED = 5
bj_QUESTMESSAGE_ALWAYSHINT = 6
bj_QUESTMESSAGE_HINT = 7
bj_QUESTMESSAGE_SECRET = 8
bj_QUESTMESSAGE_UNITACQUIRED = 9
bj_QUESTMESSAGE_UNITAVAILABLE = 10
bj_QUESTMESSAGE_ITEMACQUIRED = 11
bj_QUESTMESSAGE_WARNING = 12
bj_SORTTYPE_SORTBYVALUE = 0
bj_SORTTYPE_SORTBYPLAYER = 1
bj_SORTTYPE_SORTBYLABEL = 2
bj_CINEFADETYPE_FADEIN = 0
bj_CINEFADETYPE_FADEOUT = 1
bj_CINEFADETYPE_FADEOUTIN = 2
bj_REMOVEBUFFS_POSITIVE = 0
bj_REMOVEBUFFS_NEGATIVE = 1
bj_REMOVEBUFFS_ALL = 2
bj_REMOVEBUFFS_NONTLIFE = 3
bj_BUFF_POLARITY_POSITIVE = 0
bj_BUFF_POLARITY_NEGATIVE = 1
bj_BUFF_POLARITY_EITHER = 2
bj_BUFF_RESIST_MAGIC = 0
bj_BUFF_RESIST_PHYSICAL = 1
bj_BUFF_RESIST_EITHER = 2
bj_BUFF_RESIST_BOTH = 3
bj_HEROSTAT_STR = 0
bj_HEROSTAT_AGI = 1
bj_HEROSTAT_INT = 2
bj_MODIFYMETHOD_ADD = 0
bj_MODIFYMETHOD_SUB = 1
bj_MODIFYMETHOD_SET = 2
bj_UNIT_STATE_METHOD_ABSOLUTE = 0
bj_UNIT_STATE_METHOD_RELATIVE = 1
bj_UNIT_STATE_METHOD_DEFAULTS = 2
bj_UNIT_STATE_METHOD_MAXIMUM = 3
bj_GATEOPERATION_CLOSE = 0
bj_GATEOPERATION_OPEN = 1
bj_GATEOPERATION_DESTROY = 2
bj_GAMECACHE_BOOLEAN = 0
bj_GAMECACHE_INTEGER = 1
bj_GAMECACHE_REAL = 2
bj_GAMECACHE_UNIT = 3
bj_GAMECACHE_STRING = 4
bj_HASHTABLE_BOOLEAN = 0
bj_HASHTABLE_INTEGER = 1
bj_HASHTABLE_REAL = 2
bj_HASHTABLE_STRING = 3
bj_HASHTABLE_HANDLE = 4
bj_ITEM_STATUS_HIDDEN = 0
bj_ITEM_STATUS_OWNED = 1
bj_ITEM_STATUS_INVULNERABLE = 2
bj_ITEM_STATUS_POWERUP = 3
bj_ITEM_STATUS_SELLABLE = 4
bj_ITEM_STATUS_PAWNABLE = 5
bj_ITEMCODE_STATUS_POWERUP = 0
bj_ITEMCODE_STATUS_SELLABLE = 1
bj_ITEMCODE_STATUS_PAWNABLE = 2
bj_MINIMAPPINGSTYLE_SIMPLE = 0
bj_MINIMAPPINGSTYLE_FLASHY = 1
bj_MINIMAPPINGSTYLE_ATTACK = 2
bj_CORPSE_MAX_DEATH_TIME = 8.00
bj_CORPSETYPE_FLESH = 0
bj_CORPSETYPE_BONE = 1
bj_ELEVATOR_BLOCKER_CODE = 'DTep'
bj_ELEVATOR_CODE01 = 'DTrf'
bj_ELEVATOR_CODE02 = 'DTrx'
bj_ELEVATOR_WALL_TYPE_ALL = 0
bj_ELEVATOR_WALL_TYPE_EAST = 1
bj_ELEVATOR_WALL_TYPE_NORTH = 2
bj_ELEVATOR_WALL_TYPE_SOUTH = 3
bj_ELEVATOR_WALL_TYPE_WEST = 4
bj_FORCE_ALL_PLAYERS = nil
bj_FORCE_PLAYER = {}
bj_MELEE_MAX_TWINKED_HEROES = 0
bj_mapInitialPlayableArea = nil
bj_mapInitialCameraBounds = nil
bj_forLoopAIndex = 0
bj_forLoopBIndex = 0
bj_forLoopAIndexEnd = 0
bj_forLoopBIndexEnd = 0
bj_slotControlReady = false
bj_slotControlUsed = {}
bj_slotControl = {}
bj_gameStartedTimer = nil
bj_gameStarted = false
bj_volumeGroupsTimer = CreateTimer()
bj_isSinglePlayer = false
bj_dncSoundsDay = nil
bj_dncSoundsNight = nil
bj_dayAmbientSound = nil
bj_nightAmbientSound = nil
bj_dncSoundsDawn = nil
bj_dncSoundsDusk = nil
bj_dawnSound = nil
bj_duskSound = nil
bj_useDawnDuskSounds = true
bj_dncIsDaytime = false
bj_rescueSound = nil
bj_questDiscoveredSound = nil
bj_questUpdatedSound = nil
bj_questCompletedSound = nil
bj_questFailedSound = nil
bj_questHintSound = nil
bj_questSecretSound = nil
bj_questItemAcquiredSound = nil
bj_questWarningSound = nil
bj_victoryDialogSound = nil
bj_defeatDialogSound = nil
bj_stockItemPurchased = nil
bj_stockUpdateTimer = nil
bj_stockAllowedPermanent = {}
bj_stockAllowedCharged = {}
bj_stockAllowedArtifact = {}
bj_stockPickedItemLevel = 0
bj_meleeVisibilityTrained = nil
bj_meleeVisibilityIsDay = true
bj_meleeGrantHeroItems = false
bj_meleeNearestMineToLoc = nil
bj_meleeNearestMine = nil
bj_meleeNearestMineDist = 0.00
bj_meleeGameOver = false
bj_meleeDefeated = {}
bj_meleeVictoried = {}
bj_ghoul = {}
bj_crippledTimer = {}
bj_crippledTimerWindows = {}
bj_playerIsCrippled = {}
bj_playerIsExposed = {}
bj_finishSoonAllExposed = false
bj_finishSoonTimerDialog = nil
bj_meleeTwinkedHeroes = {}
bj_rescueUnitBehavior = nil
bj_rescueChangeColorUnit = true
bj_rescueChangeColorBldg = true
bj_cineSceneEndingTimer = nil
bj_cineSceneLastSound = nil
bj_cineSceneBeingSkipped = nil
bj_cineModePriorSpeed = MAP_SPEED_NORMAL
bj_cineModePriorFogSetting = false
bj_cineModePriorMaskSetting = false
bj_cineModeAlreadyIn = false
bj_cineModePriorDawnDusk = false
bj_cineModeSavedSeed = 0
bj_cineFadeFinishTimer = nil
bj_cineFadeContinueTimer = nil
bj_cineFadeContinueRed = 0
bj_cineFadeContinueGreen = 0
bj_cineFadeContinueBlue = 0
bj_cineFadeContinueTrans = 0
bj_cineFadeContinueDuration = 0
bj_cineFadeContinueTex = ""
bj_queuedExecTotal = 0
bj_queuedExecTriggers = {}
bj_queuedExecUseConds = {}
bj_queuedExecTimeoutTimer = CreateTimer()
bj_queuedExecTimeout = nil
bj_destInRegionDiesCount = 0
bj_destInRegionDiesTrig = nil
bj_groupCountUnits = 0
bj_forceCountPlayers = 0
bj_groupEnumTypeId = 0
bj_groupEnumOwningPlayer = nil
bj_groupAddGroupDest = nil
bj_groupRemoveGroupDest = nil
bj_groupRandomConsidered = 0
bj_groupRandomCurrentPick = nil
bj_groupLastCreatedDest = nil
bj_randomSubGroupGroup = nil
bj_randomSubGroupWant = 0
bj_randomSubGroupTotal = 0
bj_randomSubGroupChance = 0
bj_destRandomConsidered = 0
bj_destRandomCurrentPick = nil
bj_elevatorWallBlocker = nil
bj_elevatorNeighbor = nil
bj_itemRandomConsidered = 0
bj_itemRandomCurrentPick = nil
bj_forceRandomConsidered = 0
bj_forceRandomCurrentPick = nil
bj_makeUnitRescuableUnit = nil
bj_makeUnitRescuableFlag = true
bj_pauseAllUnitsFlag = true
bj_enumDestructableCenter = nil
bj_enumDestructableRadius = 0
bj_setPlayerTargetColor = nil
bj_isUnitGroupDeadResult = true
bj_isUnitGroupEmptyResult = true
bj_isUnitGroupInRectResult = true
bj_isUnitGroupInRectRect = nil
bj_changeLevelShowScores = false
bj_changeLevelMapName = nil
bj_suspendDecayFleshGroup = CreateGroup()
bj_suspendDecayBoneGroup = CreateGroup()
bj_delayedSuspendDecayTimer = CreateTimer()
bj_delayedSuspendDecayTrig = nil
bj_livingPlayerUnitsTypeId = 0
bj_lastDyingWidget = nil
bj_randDistCount = 0
bj_randDistID = {}
bj_randDistChance = {}
bj_lastCreatedUnit = nil
bj_lastCreatedItem = nil
bj_lastRemovedItem = nil
bj_lastHauntedGoldMine = nil
bj_lastCreatedDestructable = nil
bj_lastCreatedGroup = CreateGroup()
bj_lastCreatedFogModifier = nil
bj_lastCreatedEffect = nil
bj_lastCreatedWeatherEffect = nil
bj_lastCreatedTerrainDeformation = nil
bj_lastCreatedQuest = nil
bj_lastCreatedQuestItem = nil
bj_lastCreatedDefeatCondition = nil
bj_lastStartedTimer = CreateTimer()
bj_lastCreatedTimerDialog = nil
bj_lastCreatedLeaderboard = nil
bj_lastCreatedMultiboard = nil
bj_lastPlayedSound = nil
bj_lastPlayedMusic = ""
bj_lastTransmissionDuration = 0
bj_lastCreatedGameCache = nil
bj_lastCreatedHashtable = nil
bj_lastLoadedUnit = nil
bj_lastCreatedButton = nil
bj_lastReplacedUnit = nil
bj_lastCreatedTextTag = nil
bj_lastCreatedLightning = nil
bj_lastCreatedImage = nil
bj_lastCreatedUbersplat = nil
filterIssueHauntOrderAtLocBJ = nil
filterEnumDestructablesInCircleBJ = nil
filterGetUnitsInRectOfPlayer = nil
filterGetUnitsOfTypeIdAll = nil
filterGetUnitsOfPlayerAndTypeId = nil
filterMeleeTrainedUnitIsHeroBJ = nil
filterLivingPlayerUnitsOfTypeId = nil
bj_wantDestroyGroup = false
bj_lastInstObjFuncSuccessful = true
FALSE = false
TRUE = true
JASS_MAX_ARRAY_SIZE = 32768
PLAYER_NEUTRAL_PASSIVE = GetPlayerNeutralPassive()
PLAYER_NEUTRAL_AGGRESSIVE = GetPlayerNeutralAggressive()
PLAYER_COLOR_RED = ConvertPlayerColor(0)
PLAYER_COLOR_BLUE = ConvertPlayerColor(1)
PLAYER_COLOR_CYAN = ConvertPlayerColor(2)
PLAYER_COLOR_PURPLE = ConvertPlayerColor(3)
PLAYER_COLOR_YELLOW = ConvertPlayerColor(4)
PLAYER_COLOR_ORANGE = ConvertPlayerColor(5)
PLAYER_COLOR_GREEN = ConvertPlayerColor(6)
PLAYER_COLOR_PINK = ConvertPlayerColor(7)
PLAYER_COLOR_LIGHT_GRAY = ConvertPlayerColor(8)
PLAYER_COLOR_LIGHT_BLUE = ConvertPlayerColor(9)
PLAYER_COLOR_AQUA = ConvertPlayerColor(10)
PLAYER_COLOR_BROWN = ConvertPlayerColor(11)
PLAYER_COLOR_MAROON = ConvertPlayerColor(12)
PLAYER_COLOR_NAVY = ConvertPlayerColor(13)
PLAYER_COLOR_TURQUOISE = ConvertPlayerColor(14)
PLAYER_COLOR_VIOLET = ConvertPlayerColor(15)
PLAYER_COLOR_WHEAT = ConvertPlayerColor(16)
PLAYER_COLOR_PEACH = ConvertPlayerColor(17)
PLAYER_COLOR_MINT = ConvertPlayerColor(18)
PLAYER_COLOR_LAVENDER = ConvertPlayerColor(19)
PLAYER_COLOR_COAL = ConvertPlayerColor(20)
PLAYER_COLOR_SNOW = ConvertPlayerColor(21)
PLAYER_COLOR_EMERALD = ConvertPlayerColor(22)
PLAYER_COLOR_PEANUT = ConvertPlayerColor(23)
RACE_HUMAN = ConvertRace(1)
RACE_ORC = ConvertRace(2)
RACE_UNDEAD = ConvertRace(3)
RACE_NIGHTELF = ConvertRace(4)
RACE_DEMON = ConvertRace(5)
RACE_OTHER = ConvertRace(7)
PLAYER_GAME_RESULT_VICTORY = ConvertPlayerGameResult(0)
PLAYER_GAME_RESULT_DEFEAT = ConvertPlayerGameResult(1)
PLAYER_GAME_RESULT_TIE = ConvertPlayerGameResult(2)
PLAYER_GAME_RESULT_NEUTRAL = ConvertPlayerGameResult(3)
ALLIANCE_PASSIVE = ConvertAllianceType(0)
ALLIANCE_HELP_REQUEST = ConvertAllianceType(1)
ALLIANCE_HELP_RESPONSE = ConvertAllianceType(2)
ALLIANCE_SHARED_XP = ConvertAllianceType(3)
ALLIANCE_SHARED_SPELLS = ConvertAllianceType(4)
ALLIANCE_SHARED_VISION = ConvertAllianceType(5)
ALLIANCE_SHARED_CONTROL = ConvertAllianceType(6)
ALLIANCE_SHARED_ADVANCED_CONTROL = ConvertAllianceType(7)
ALLIANCE_RESCUABLE = ConvertAllianceType(8)
ALLIANCE_SHARED_VISION_FORCED = ConvertAllianceType(9)
VERSION_REIGN_OF_CHAOS = ConvertVersion(0)
VERSION_FROZEN_THRONE = ConvertVersion(1)
ATTACK_TYPE_NORMAL = ConvertAttackType(0)
ATTACK_TYPE_MELEE = ConvertAttackType(1)
ATTACK_TYPE_PIERCE = ConvertAttackType(2)
ATTACK_TYPE_SIEGE = ConvertAttackType(3)
ATTACK_TYPE_MAGIC = ConvertAttackType(4)
ATTACK_TYPE_CHAOS = ConvertAttackType(5)
ATTACK_TYPE_HERO = ConvertAttackType(6)
DAMAGE_TYPE_UNKNOWN = ConvertDamageType(0)
DAMAGE_TYPE_NORMAL = ConvertDamageType(4)
DAMAGE_TYPE_ENHANCED = ConvertDamageType(5)
DAMAGE_TYPE_FIRE = ConvertDamageType(8)
DAMAGE_TYPE_COLD = ConvertDamageType(9)
DAMAGE_TYPE_LIGHTNING = ConvertDamageType(10)
DAMAGE_TYPE_POISON = ConvertDamageType(11)
DAMAGE_TYPE_DISEASE = ConvertDamageType(12)
DAMAGE_TYPE_DIVINE = ConvertDamageType(13)
DAMAGE_TYPE_MAGIC = ConvertDamageType(14)
DAMAGE_TYPE_SONIC = ConvertDamageType(15)
DAMAGE_TYPE_ACID = ConvertDamageType(16)
DAMAGE_TYPE_FORCE = ConvertDamageType(17)
DAMAGE_TYPE_DEATH = ConvertDamageType(18)
DAMAGE_TYPE_MIND = ConvertDamageType(19)
DAMAGE_TYPE_PLANT = ConvertDamageType(20)
DAMAGE_TYPE_DEFENSIVE = ConvertDamageType(21)
DAMAGE_TYPE_DEMOLITION = ConvertDamageType(22)
DAMAGE_TYPE_SLOW_POISON = ConvertDamageType(23)
DAMAGE_TYPE_SPIRIT_LINK = ConvertDamageType(24)
DAMAGE_TYPE_SHADOW_STRIKE = ConvertDamageType(25)
DAMAGE_TYPE_UNIVERSAL = ConvertDamageType(26)
WEAPON_TYPE_WHOKNOWS = ConvertWeaponType(0)
WEAPON_TYPE_METAL_LIGHT_CHOP = ConvertWeaponType(1)
WEAPON_TYPE_METAL_MEDIUM_CHOP = ConvertWeaponType(2)
WEAPON_TYPE_METAL_HEAVY_CHOP = ConvertWeaponType(3)
WEAPON_TYPE_METAL_LIGHT_SLICE = ConvertWeaponType(4)
WEAPON_TYPE_METAL_MEDIUM_SLICE = ConvertWeaponType(5)
WEAPON_TYPE_METAL_HEAVY_SLICE = ConvertWeaponType(6)
WEAPON_TYPE_METAL_MEDIUM_BASH = ConvertWeaponType(7)
WEAPON_TYPE_METAL_HEAVY_BASH = ConvertWeaponType(8)
WEAPON_TYPE_METAL_MEDIUM_STAB = ConvertWeaponType(9)
WEAPON_TYPE_METAL_HEAVY_STAB = ConvertWeaponType(10)
WEAPON_TYPE_WOOD_LIGHT_SLICE = ConvertWeaponType(11)
WEAPON_TYPE_WOOD_MEDIUM_SLICE = ConvertWeaponType(12)
WEAPON_TYPE_WOOD_HEAVY_SLICE = ConvertWeaponType(13)
WEAPON_TYPE_WOOD_LIGHT_BASH = ConvertWeaponType(14)
WEAPON_TYPE_WOOD_MEDIUM_BASH = ConvertWeaponType(15)
WEAPON_TYPE_WOOD_HEAVY_BASH = ConvertWeaponType(16)
WEAPON_TYPE_WOOD_LIGHT_STAB = ConvertWeaponType(17)
WEAPON_TYPE_WOOD_MEDIUM_STAB = ConvertWeaponType(18)
WEAPON_TYPE_CLAW_LIGHT_SLICE = ConvertWeaponType(19)
WEAPON_TYPE_CLAW_MEDIUM_SLICE = ConvertWeaponType(20)
WEAPON_TYPE_CLAW_HEAVY_SLICE = ConvertWeaponType(21)
WEAPON_TYPE_AXE_MEDIUM_CHOP = ConvertWeaponType(22)
WEAPON_TYPE_ROCK_HEAVY_BASH = ConvertWeaponType(23)
PATHING_TYPE_ANY = ConvertPathingType(0)
PATHING_TYPE_WALKABILITY = ConvertPathingType(1)
PATHING_TYPE_FLYABILITY = ConvertPathingType(2)
PATHING_TYPE_BUILDABILITY = ConvertPathingType(3)
PATHING_TYPE_PEONHARVESTPATHING = ConvertPathingType(4)
PATHING_TYPE_BLIGHTPATHING = ConvertPathingType(5)
PATHING_TYPE_FLOATABILITY = ConvertPathingType(6)
PATHING_TYPE_AMPHIBIOUSPATHING = ConvertPathingType(7)
MOUSE_BUTTON_TYPE_LEFT = ConvertMouseButtonType(1)
MOUSE_BUTTON_TYPE_MIDDLE = ConvertMouseButtonType(2)
MOUSE_BUTTON_TYPE_RIGHT = ConvertMouseButtonType(3)
ANIM_TYPE_BIRTH = ConvertAnimType(0)
ANIM_TYPE_DEATH = ConvertAnimType(1)
ANIM_TYPE_DECAY = ConvertAnimType(2)
ANIM_TYPE_DISSIPATE = ConvertAnimType(3)
ANIM_TYPE_STAND = ConvertAnimType(4)
ANIM_TYPE_WALK = ConvertAnimType(5)
ANIM_TYPE_ATTACK = ConvertAnimType(6)
ANIM_TYPE_MORPH = ConvertAnimType(7)
ANIM_TYPE_SLEEP = ConvertAnimType(8)
ANIM_TYPE_SPELL = ConvertAnimType(9)
ANIM_TYPE_PORTRAIT = ConvertAnimType(10)
SUBANIM_TYPE_ROOTED = ConvertSubAnimType(11)
SUBANIM_TYPE_ALTERNATE_EX = ConvertSubAnimType(12)
SUBANIM_TYPE_LOOPING = ConvertSubAnimType(13)
SUBANIM_TYPE_SLAM = ConvertSubAnimType(14)
SUBANIM_TYPE_THROW = ConvertSubAnimType(15)
SUBANIM_TYPE_SPIKED = ConvertSubAnimType(16)
SUBANIM_TYPE_FAST = ConvertSubAnimType(17)
SUBANIM_TYPE_SPIN = ConvertSubAnimType(18)
SUBANIM_TYPE_READY = ConvertSubAnimType(19)
SUBANIM_TYPE_CHANNEL = ConvertSubAnimType(20)
SUBANIM_TYPE_DEFEND = ConvertSubAnimType(21)
SUBANIM_TYPE_VICTORY = ConvertSubAnimType(22)
SUBANIM_TYPE_TURN = ConvertSubAnimType(23)
SUBANIM_TYPE_LEFT = ConvertSubAnimType(24)
SUBANIM_TYPE_RIGHT = ConvertSubAnimType(25)
SUBANIM_TYPE_FIRE = ConvertSubAnimType(26)
SUBANIM_TYPE_FLESH = ConvertSubAnimType(27)
SUBANIM_TYPE_HIT = ConvertSubAnimType(28)
SUBANIM_TYPE_WOUNDED = ConvertSubAnimType(29)
SUBANIM_TYPE_LIGHT = ConvertSubAnimType(30)
SUBANIM_TYPE_MODERATE = ConvertSubAnimType(31)
SUBANIM_TYPE_SEVERE = ConvertSubAnimType(32)
SUBANIM_TYPE_CRITICAL = ConvertSubAnimType(33)
SUBANIM_TYPE_COMPLETE = ConvertSubAnimType(34)
SUBANIM_TYPE_GOLD = ConvertSubAnimType(35)
SUBANIM_TYPE_LUMBER = ConvertSubAnimType(36)
SUBANIM_TYPE_WORK = ConvertSubAnimType(37)
SUBANIM_TYPE_TALK = ConvertSubAnimType(38)
SUBANIM_TYPE_FIRST = ConvertSubAnimType(39)
SUBANIM_TYPE_SECOND = ConvertSubAnimType(40)
SUBANIM_TYPE_THIRD = ConvertSubAnimType(41)
SUBANIM_TYPE_FOURTH = ConvertSubAnimType(42)
SUBANIM_TYPE_FIFTH = ConvertSubAnimType(43)
SUBANIM_TYPE_ONE = ConvertSubAnimType(44)
SUBANIM_TYPE_TWO = ConvertSubAnimType(45)
SUBANIM_TYPE_THREE = ConvertSubAnimType(46)
SUBANIM_TYPE_FOUR = ConvertSubAnimType(47)
SUBANIM_TYPE_FIVE = ConvertSubAnimType(48)
SUBANIM_TYPE_SMALL = ConvertSubAnimType(49)
SUBANIM_TYPE_MEDIUM = ConvertSubAnimType(50)
SUBANIM_TYPE_LARGE = ConvertSubAnimType(51)
SUBANIM_TYPE_UPGRADE = ConvertSubAnimType(52)
SUBANIM_TYPE_DRAIN = ConvertSubAnimType(53)
SUBANIM_TYPE_FILL = ConvertSubAnimType(54)
SUBANIM_TYPE_CHAINLIGHTNING = ConvertSubAnimType(55)
SUBANIM_TYPE_EATTREE = ConvertSubAnimType(56)
SUBANIM_TYPE_PUKE = ConvertSubAnimType(57)
SUBANIM_TYPE_FLAIL = ConvertSubAnimType(58)
SUBANIM_TYPE_OFF = ConvertSubAnimType(59)
SUBANIM_TYPE_SWIM = ConvertSubAnimType(60)
SUBANIM_TYPE_ENTANGLE = ConvertSubAnimType(61)
SUBANIM_TYPE_BERSERK = ConvertSubAnimType(62)
RACE_PREF_HUMAN = ConvertRacePref(1)
RACE_PREF_ORC = ConvertRacePref(2)
RACE_PREF_NIGHTELF = ConvertRacePref(4)
RACE_PREF_UNDEAD = ConvertRacePref(8)
RACE_PREF_DEMON = ConvertRacePref(16)
RACE_PREF_RANDOM = ConvertRacePref(32)
RACE_PREF_USER_SELECTABLE = ConvertRacePref(64)
MAP_CONTROL_USER = ConvertMapControl(0)
MAP_CONTROL_COMPUTER = ConvertMapControl(1)
MAP_CONTROL_RESCUABLE = ConvertMapControl(2)
MAP_CONTROL_NEUTRAL = ConvertMapControl(3)
MAP_CONTROL_CREEP = ConvertMapControl(4)
MAP_CONTROL_NONE = ConvertMapControl(5)
GAME_TYPE_MELEE = ConvertGameType(1)
GAME_TYPE_FFA = ConvertGameType(2)
GAME_TYPE_USE_MAP_SETTINGS = ConvertGameType(4)
GAME_TYPE_BLIZ = ConvertGameType(8)
GAME_TYPE_ONE_ON_ONE = ConvertGameType(16)
GAME_TYPE_TWO_TEAM_PLAY = ConvertGameType(32)
GAME_TYPE_THREE_TEAM_PLAY = ConvertGameType(64)
GAME_TYPE_FOUR_TEAM_PLAY = ConvertGameType(128)
MAP_FOG_HIDE_TERRAIN = ConvertMapFlag(1)
MAP_FOG_MAP_EXPLORED = ConvertMapFlag(2)
MAP_FOG_ALWAYS_VISIBLE = ConvertMapFlag(4)
MAP_USE_HANDICAPS = ConvertMapFlag(8)
MAP_OBSERVERS = ConvertMapFlag(16)
MAP_OBSERVERS_ON_DEATH = ConvertMapFlag(32)
MAP_FIXED_COLORS = ConvertMapFlag(128)
MAP_LOCK_RESOURCE_TRADING = ConvertMapFlag(256)
MAP_RESOURCE_TRADING_ALLIES_ONLY = ConvertMapFlag(512)
MAP_LOCK_ALLIANCE_CHANGES = ConvertMapFlag(1024)
MAP_ALLIANCE_CHANGES_HIDDEN = ConvertMapFlag(2048)
MAP_CHEATS = ConvertMapFlag(4096)
MAP_CHEATS_HIDDEN = ConvertMapFlag(8192)
MAP_LOCK_SPEED = ConvertMapFlag(8192*2)
MAP_LOCK_RANDOM_SEED = ConvertMapFlag(8192*4)
MAP_SHARED_ADVANCED_CONTROL = ConvertMapFlag(8192*8)
MAP_RANDOM_HERO = ConvertMapFlag(8192*16)
MAP_RANDOM_RACES = ConvertMapFlag(8192*32)
MAP_RELOADED = ConvertMapFlag(8192*64)
MAP_PLACEMENT_RANDOM = ConvertPlacement(0)   -- random among all slots
MAP_PLACEMENT_FIXED = ConvertPlacement(1)   -- player 0 in start loc 0...
MAP_PLACEMENT_USE_MAP_SETTINGS = ConvertPlacement(2)   -- whatever was specified by the script
MAP_PLACEMENT_TEAMS_TOGETHER = ConvertPlacement(3)   -- random with allies next to each other
MAP_LOC_PRIO_LOW = ConvertStartLocPrio(0)
MAP_LOC_PRIO_HIGH = ConvertStartLocPrio(1)
MAP_LOC_PRIO_NOT = ConvertStartLocPrio(2)
MAP_DENSITY_NONE = ConvertMapDensity(0)
MAP_DENSITY_LIGHT = ConvertMapDensity(1)
MAP_DENSITY_MEDIUM = ConvertMapDensity(2)
MAP_DENSITY_HEAVY = ConvertMapDensity(3)
MAP_DIFFICULTY_EASY = ConvertGameDifficulty(0)
MAP_DIFFICULTY_NORMAL = ConvertGameDifficulty(1)
MAP_DIFFICULTY_HARD = ConvertGameDifficulty(2)
MAP_DIFFICULTY_INSANE = ConvertGameDifficulty(3)
MAP_SPEED_SLOWEST = ConvertGameSpeed(0)
MAP_SPEED_SLOW = ConvertGameSpeed(1)
MAP_SPEED_NORMAL = ConvertGameSpeed(2)
MAP_SPEED_FAST = ConvertGameSpeed(3)
MAP_SPEED_FASTEST = ConvertGameSpeed(4)
PLAYER_SLOT_STATE_EMPTY = ConvertPlayerSlotState(0)
PLAYER_SLOT_STATE_PLAYING = ConvertPlayerSlotState(1)
PLAYER_SLOT_STATE_LEFT = ConvertPlayerSlotState(2)
SOUND_VOLUMEGROUP_UNITMOVEMENT = ConvertVolumeGroup(0)
SOUND_VOLUMEGROUP_UNITSOUNDS = ConvertVolumeGroup(1)
SOUND_VOLUMEGROUP_COMBAT = ConvertVolumeGroup(2)
SOUND_VOLUMEGROUP_SPELLS = ConvertVolumeGroup(3)
SOUND_VOLUMEGROUP_UI = ConvertVolumeGroup(4)
SOUND_VOLUMEGROUP_MUSIC = ConvertVolumeGroup(5)
SOUND_VOLUMEGROUP_AMBIENTSOUNDS = ConvertVolumeGroup(6)
SOUND_VOLUMEGROUP_FIRE = ConvertVolumeGroup(7)
GAME_STATE_DIVINE_INTERVENTION = ConvertIGameState(0)
GAME_STATE_DISCONNECTED = ConvertIGameState(1)
GAME_STATE_TIME_OF_DAY = ConvertFGameState(2)
PLAYER_STATE_GAME_RESULT = ConvertPlayerState(0)
PLAYER_STATE_RESOURCE_GOLD = ConvertPlayerState(1)
PLAYER_STATE_RESOURCE_LUMBER = ConvertPlayerState(2)
PLAYER_STATE_RESOURCE_HERO_TOKENS = ConvertPlayerState(3)
PLAYER_STATE_RESOURCE_FOOD_CAP = ConvertPlayerState(4)
PLAYER_STATE_RESOURCE_FOOD_USED = ConvertPlayerState(5)
PLAYER_STATE_FOOD_CAP_CEILING = ConvertPlayerState(6)
PLAYER_STATE_GIVES_BOUNTY = ConvertPlayerState(7)
PLAYER_STATE_ALLIED_VICTORY = ConvertPlayerState(8)
PLAYER_STATE_PLACED = ConvertPlayerState(9)
PLAYER_STATE_OBSERVER_ON_DEATH = ConvertPlayerState(10)
PLAYER_STATE_OBSERVER = ConvertPlayerState(11)
PLAYER_STATE_UNFOLLOWABLE = ConvertPlayerState(12)
PLAYER_STATE_GOLD_UPKEEP_RATE = ConvertPlayerState(13)
PLAYER_STATE_LUMBER_UPKEEP_RATE = ConvertPlayerState(14)
PLAYER_STATE_GOLD_GATHERED = ConvertPlayerState(15)
PLAYER_STATE_LUMBER_GATHERED = ConvertPlayerState(16)
PLAYER_STATE_NO_CREEP_SLEEP = ConvertPlayerState(25)
UNIT_STATE_LIFE = ConvertUnitState(0)
UNIT_STATE_MAX_LIFE = ConvertUnitState(1)
UNIT_STATE_MANA = ConvertUnitState(2)
UNIT_STATE_MAX_MANA = ConvertUnitState(3)
AI_DIFFICULTY_NEWBIE = ConvertAIDifficulty(0)
AI_DIFFICULTY_NORMAL = ConvertAIDifficulty(1)
AI_DIFFICULTY_INSANE = ConvertAIDifficulty(2)
PLAYER_SCORE_UNITS_TRAINED = ConvertPlayerScore(0)
PLAYER_SCORE_UNITS_KILLED = ConvertPlayerScore(1)
PLAYER_SCORE_STRUCT_BUILT = ConvertPlayerScore(2)
PLAYER_SCORE_STRUCT_RAZED = ConvertPlayerScore(3)
PLAYER_SCORE_TECH_PERCENT = ConvertPlayerScore(4)
PLAYER_SCORE_FOOD_MAXPROD = ConvertPlayerScore(5)
PLAYER_SCORE_FOOD_MAXUSED = ConvertPlayerScore(6)
PLAYER_SCORE_HEROES_KILLED = ConvertPlayerScore(7)
PLAYER_SCORE_ITEMS_GAINED = ConvertPlayerScore(8)
PLAYER_SCORE_MERCS_HIRED = ConvertPlayerScore(9)
PLAYER_SCORE_GOLD_MINED_TOTAL = ConvertPlayerScore(10)
PLAYER_SCORE_GOLD_MINED_UPKEEP = ConvertPlayerScore(11)
PLAYER_SCORE_GOLD_LOST_UPKEEP = ConvertPlayerScore(12)
PLAYER_SCORE_GOLD_LOST_TAX = ConvertPlayerScore(13)
PLAYER_SCORE_GOLD_GIVEN = ConvertPlayerScore(14)
PLAYER_SCORE_GOLD_RECEIVED = ConvertPlayerScore(15)
PLAYER_SCORE_LUMBER_TOTAL = ConvertPlayerScore(16)
PLAYER_SCORE_LUMBER_LOST_UPKEEP = ConvertPlayerScore(17)
PLAYER_SCORE_LUMBER_LOST_TAX = ConvertPlayerScore(18)
PLAYER_SCORE_LUMBER_GIVEN = ConvertPlayerScore(19)
PLAYER_SCORE_LUMBER_RECEIVED = ConvertPlayerScore(20)
PLAYER_SCORE_UNIT_TOTAL = ConvertPlayerScore(21)
PLAYER_SCORE_HERO_TOTAL = ConvertPlayerScore(22)
PLAYER_SCORE_RESOURCE_TOTAL = ConvertPlayerScore(23)
PLAYER_SCORE_TOTAL = ConvertPlayerScore(24)
EVENT_GAME_VICTORY = ConvertGameEvent(0)
EVENT_GAME_END_LEVEL = ConvertGameEvent(1)
EVENT_GAME_VARIABLE_LIMIT = ConvertGameEvent(2)
EVENT_GAME_STATE_LIMIT = ConvertGameEvent(3)
EVENT_GAME_TIMER_EXPIRED = ConvertGameEvent(4)
EVENT_GAME_ENTER_REGION = ConvertGameEvent(5)
EVENT_GAME_LEAVE_REGION = ConvertGameEvent(6)
EVENT_GAME_TRACKABLE_HIT = ConvertGameEvent(7)
EVENT_GAME_TRACKABLE_TRACK = ConvertGameEvent(8)
EVENT_GAME_SHOW_SKILL = ConvertGameEvent(9)
EVENT_GAME_BUILD_SUBMENU = ConvertGameEvent(10)
EVENT_PLAYER_STATE_LIMIT = ConvertPlayerEvent(11)
EVENT_PLAYER_ALLIANCE_CHANGED = ConvertPlayerEvent(12)
EVENT_PLAYER_DEFEAT = ConvertPlayerEvent(13)
EVENT_PLAYER_VICTORY = ConvertPlayerEvent(14)
EVENT_PLAYER_LEAVE = ConvertPlayerEvent(15)
EVENT_PLAYER_CHAT = ConvertPlayerEvent(16)
EVENT_PLAYER_END_CINEMATIC = ConvertPlayerEvent(17)
EVENT_PLAYER_UNIT_ATTACKED = ConvertPlayerUnitEvent(18)
EVENT_PLAYER_UNIT_RESCUED = ConvertPlayerUnitEvent(19)
EVENT_PLAYER_UNIT_DEATH = ConvertPlayerUnitEvent(20)
EVENT_PLAYER_UNIT_DECAY = ConvertPlayerUnitEvent(21)
EVENT_PLAYER_UNIT_DETECTED = ConvertPlayerUnitEvent(22)
EVENT_PLAYER_UNIT_HIDDEN = ConvertPlayerUnitEvent(23)
EVENT_PLAYER_UNIT_SELECTED = ConvertPlayerUnitEvent(24)
EVENT_PLAYER_UNIT_DESELECTED = ConvertPlayerUnitEvent(25)
EVENT_PLAYER_UNIT_CONSTRUCT_START = ConvertPlayerUnitEvent(26)
EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL = ConvertPlayerUnitEvent(27)
EVENT_PLAYER_UNIT_CONSTRUCT_FINISH = ConvertPlayerUnitEvent(28)
EVENT_PLAYER_UNIT_UPGRADE_START = ConvertPlayerUnitEvent(29)
EVENT_PLAYER_UNIT_UPGRADE_CANCEL = ConvertPlayerUnitEvent(30)
EVENT_PLAYER_UNIT_UPGRADE_FINISH = ConvertPlayerUnitEvent(31)
EVENT_PLAYER_UNIT_TRAIN_START = ConvertPlayerUnitEvent(32)
EVENT_PLAYER_UNIT_TRAIN_CANCEL = ConvertPlayerUnitEvent(33)
EVENT_PLAYER_UNIT_TRAIN_FINISH = ConvertPlayerUnitEvent(34)
EVENT_PLAYER_UNIT_RESEARCH_START = ConvertPlayerUnitEvent(35)
EVENT_PLAYER_UNIT_RESEARCH_CANCEL = ConvertPlayerUnitEvent(36)
EVENT_PLAYER_UNIT_RESEARCH_FINISH = ConvertPlayerUnitEvent(37)
EVENT_PLAYER_UNIT_ISSUED_ORDER = ConvertPlayerUnitEvent(38)
EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER = ConvertPlayerUnitEvent(39)
EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER = ConvertPlayerUnitEvent(40)
EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER = ConvertPlayerUnitEvent(40)    -- for compat
EVENT_PLAYER_HERO_LEVEL = ConvertPlayerUnitEvent(41)
EVENT_PLAYER_HERO_SKILL = ConvertPlayerUnitEvent(42)
EVENT_PLAYER_HERO_REVIVABLE = ConvertPlayerUnitEvent(43)
EVENT_PLAYER_HERO_REVIVE_START = ConvertPlayerUnitEvent(44)
EVENT_PLAYER_HERO_REVIVE_CANCEL = ConvertPlayerUnitEvent(45)
EVENT_PLAYER_HERO_REVIVE_FINISH = ConvertPlayerUnitEvent(46)
EVENT_PLAYER_UNIT_SUMMON = ConvertPlayerUnitEvent(47)
EVENT_PLAYER_UNIT_DROP_ITEM = ConvertPlayerUnitEvent(48)
EVENT_PLAYER_UNIT_PICKUP_ITEM = ConvertPlayerUnitEvent(49)
EVENT_PLAYER_UNIT_USE_ITEM = ConvertPlayerUnitEvent(50)
EVENT_PLAYER_UNIT_LOADED = ConvertPlayerUnitEvent(51)
EVENT_PLAYER_UNIT_DAMAGED = ConvertPlayerUnitEvent(308)
EVENT_PLAYER_UNIT_DAMAGING = ConvertPlayerUnitEvent(315)
EVENT_UNIT_DAMAGED = ConvertUnitEvent(52)
EVENT_UNIT_DAMAGING = ConvertUnitEvent(314)
EVENT_UNIT_DEATH = ConvertUnitEvent(53)
EVENT_UNIT_DECAY = ConvertUnitEvent(54)
EVENT_UNIT_DETECTED = ConvertUnitEvent(55)
EVENT_UNIT_HIDDEN = ConvertUnitEvent(56)
EVENT_UNIT_SELECTED = ConvertUnitEvent(57)
EVENT_UNIT_DESELECTED = ConvertUnitEvent(58)
EVENT_UNIT_STATE_LIMIT = ConvertUnitEvent(59)
EVENT_UNIT_ACQUIRED_TARGET = ConvertUnitEvent(60)
EVENT_UNIT_TARGET_IN_RANGE = ConvertUnitEvent(61)
EVENT_UNIT_ATTACKED = ConvertUnitEvent(62)
EVENT_UNIT_RESCUED = ConvertUnitEvent(63)
EVENT_UNIT_CONSTRUCT_CANCEL = ConvertUnitEvent(64)
EVENT_UNIT_CONSTRUCT_FINISH = ConvertUnitEvent(65)
EVENT_UNIT_UPGRADE_START = ConvertUnitEvent(66)
EVENT_UNIT_UPGRADE_CANCEL = ConvertUnitEvent(67)
EVENT_UNIT_UPGRADE_FINISH = ConvertUnitEvent(68)
EVENT_UNIT_TRAIN_START = ConvertUnitEvent(69)
EVENT_UNIT_TRAIN_CANCEL = ConvertUnitEvent(70)
EVENT_UNIT_TRAIN_FINISH = ConvertUnitEvent(71)
EVENT_UNIT_RESEARCH_START = ConvertUnitEvent(72)
EVENT_UNIT_RESEARCH_CANCEL = ConvertUnitEvent(73)
EVENT_UNIT_RESEARCH_FINISH = ConvertUnitEvent(74)
EVENT_UNIT_ISSUED_ORDER = ConvertUnitEvent(75)
EVENT_UNIT_ISSUED_POINT_ORDER = ConvertUnitEvent(76)
EVENT_UNIT_ISSUED_TARGET_ORDER = ConvertUnitEvent(77)
EVENT_UNIT_HERO_LEVEL = ConvertUnitEvent(78)
EVENT_UNIT_HERO_SKILL = ConvertUnitEvent(79)
EVENT_UNIT_HERO_REVIVABLE = ConvertUnitEvent(80)
EVENT_UNIT_HERO_REVIVE_START = ConvertUnitEvent(81)
EVENT_UNIT_HERO_REVIVE_CANCEL = ConvertUnitEvent(82)
EVENT_UNIT_HERO_REVIVE_FINISH = ConvertUnitEvent(83)
EVENT_UNIT_SUMMON = ConvertUnitEvent(84)
EVENT_UNIT_DROP_ITEM = ConvertUnitEvent(85)
EVENT_UNIT_PICKUP_ITEM = ConvertUnitEvent(86)
EVENT_UNIT_USE_ITEM = ConvertUnitEvent(87)
EVENT_UNIT_LOADED = ConvertUnitEvent(88)
EVENT_WIDGET_DEATH = ConvertWidgetEvent(89)
EVENT_DIALOG_BUTTON_CLICK = ConvertDialogEvent(90)
EVENT_DIALOG_CLICK = ConvertDialogEvent(91)
EVENT_GAME_LOADED = ConvertGameEvent(256)
EVENT_GAME_TOURNAMENT_FINISH_SOON = ConvertGameEvent(257)
EVENT_GAME_TOURNAMENT_FINISH_NOW = ConvertGameEvent(258)
EVENT_GAME_SAVE = ConvertGameEvent(259)
EVENT_GAME_CUSTOM_UI_FRAME = ConvertGameEvent(310)
EVENT_PLAYER_ARROW_LEFT_DOWN = ConvertPlayerEvent(261)
EVENT_PLAYER_ARROW_LEFT_UP = ConvertPlayerEvent(262)
EVENT_PLAYER_ARROW_RIGHT_DOWN = ConvertPlayerEvent(263)
EVENT_PLAYER_ARROW_RIGHT_UP = ConvertPlayerEvent(264)
EVENT_PLAYER_ARROW_DOWN_DOWN = ConvertPlayerEvent(265)
EVENT_PLAYER_ARROW_DOWN_UP = ConvertPlayerEvent(266)
EVENT_PLAYER_ARROW_UP_DOWN = ConvertPlayerEvent(267)
EVENT_PLAYER_ARROW_UP_UP = ConvertPlayerEvent(268)
EVENT_PLAYER_MOUSE_DOWN = ConvertPlayerEvent(305)
EVENT_PLAYER_MOUSE_UP = ConvertPlayerEvent(306)
EVENT_PLAYER_MOUSE_MOVE = ConvertPlayerEvent(307)
EVENT_PLAYER_SYNC_DATA = ConvertPlayerEvent(309)
EVENT_PLAYER_KEY = ConvertPlayerEvent(311)
EVENT_PLAYER_KEY_DOWN = ConvertPlayerEvent(312)
EVENT_PLAYER_KEY_UP = ConvertPlayerEvent(313)
EVENT_PLAYER_UNIT_SELL = ConvertPlayerUnitEvent(269)
EVENT_PLAYER_UNIT_CHANGE_OWNER = ConvertPlayerUnitEvent(270)
EVENT_PLAYER_UNIT_SELL_ITEM = ConvertPlayerUnitEvent(271)
EVENT_PLAYER_UNIT_SPELL_CHANNEL = ConvertPlayerUnitEvent(272)
EVENT_PLAYER_UNIT_SPELL_CAST = ConvertPlayerUnitEvent(273)
EVENT_PLAYER_UNIT_SPELL_EFFECT = ConvertPlayerUnitEvent(274)
EVENT_PLAYER_UNIT_SPELL_FINISH = ConvertPlayerUnitEvent(275)
EVENT_PLAYER_UNIT_SPELL_ENDCAST = ConvertPlayerUnitEvent(276)
EVENT_PLAYER_UNIT_PAWN_ITEM = ConvertPlayerUnitEvent(277)
EVENT_UNIT_SELL = ConvertUnitEvent(286)
EVENT_UNIT_CHANGE_OWNER = ConvertUnitEvent(287)
EVENT_UNIT_SELL_ITEM = ConvertUnitEvent(288)
EVENT_UNIT_SPELL_CHANNEL = ConvertUnitEvent(289)
EVENT_UNIT_SPELL_CAST = ConvertUnitEvent(290)
EVENT_UNIT_SPELL_EFFECT = ConvertUnitEvent(291)
EVENT_UNIT_SPELL_FINISH = ConvertUnitEvent(292)
EVENT_UNIT_SPELL_ENDCAST = ConvertUnitEvent(293)
EVENT_UNIT_PAWN_ITEM = ConvertUnitEvent(294)
LESS_THAN = ConvertLimitOp(0)
LESS_THAN_OR_EQUAL = ConvertLimitOp(1)
EQUAL = ConvertLimitOp(2)
GREATER_THAN_OR_EQUAL = ConvertLimitOp(3)
GREATER_THAN = ConvertLimitOp(4)
NOT_EQUAL = ConvertLimitOp(5)
UNIT_TYPE_HERO = ConvertUnitType(0)
UNIT_TYPE_DEAD = ConvertUnitType(1)
UNIT_TYPE_STRUCTURE = ConvertUnitType(2)
UNIT_TYPE_FLYING = ConvertUnitType(3)
UNIT_TYPE_GROUND = ConvertUnitType(4)
UNIT_TYPE_ATTACKS_FLYING = ConvertUnitType(5)
UNIT_TYPE_ATTACKS_GROUND = ConvertUnitType(6)
UNIT_TYPE_MELEE_ATTACKER = ConvertUnitType(7)
UNIT_TYPE_RANGED_ATTACKER = ConvertUnitType(8)
UNIT_TYPE_GIANT = ConvertUnitType(9)
UNIT_TYPE_SUMMONED = ConvertUnitType(10)
UNIT_TYPE_STUNNED = ConvertUnitType(11)
UNIT_TYPE_PLAGUED = ConvertUnitType(12)
UNIT_TYPE_SNARED = ConvertUnitType(13)
UNIT_TYPE_UNDEAD = ConvertUnitType(14)
UNIT_TYPE_MECHANICAL = ConvertUnitType(15)
UNIT_TYPE_PEON = ConvertUnitType(16)
UNIT_TYPE_SAPPER = ConvertUnitType(17)
UNIT_TYPE_TOWNHALL = ConvertUnitType(18)
UNIT_TYPE_ANCIENT = ConvertUnitType(19)
UNIT_TYPE_TAUREN = ConvertUnitType(20)
UNIT_TYPE_POISONED = ConvertUnitType(21)
UNIT_TYPE_POLYMORPHED = ConvertUnitType(22)
UNIT_TYPE_SLEEPING = ConvertUnitType(23)
UNIT_TYPE_RESISTANT = ConvertUnitType(24)
UNIT_TYPE_ETHEREAL = ConvertUnitType(25)
UNIT_TYPE_MAGIC_IMMUNE = ConvertUnitType(26)
ITEM_TYPE_PERMANENT = ConvertItemType(0)
ITEM_TYPE_CHARGED = ConvertItemType(1)
ITEM_TYPE_POWERUP = ConvertItemType(2)
ITEM_TYPE_ARTIFACT = ConvertItemType(3)
ITEM_TYPE_PURCHASABLE = ConvertItemType(4)
ITEM_TYPE_CAMPAIGN = ConvertItemType(5)
ITEM_TYPE_MISCELLANEOUS = ConvertItemType(6)
ITEM_TYPE_UNKNOWN = ConvertItemType(7)
ITEM_TYPE_ANY = ConvertItemType(8)
ITEM_TYPE_TOME = ConvertItemType(2)
CAMERA_FIELD_TARGET_DISTANCE = ConvertCameraField(0)
CAMERA_FIELD_FARZ = ConvertCameraField(1)
CAMERA_FIELD_ANGLE_OF_ATTACK = ConvertCameraField(2)
CAMERA_FIELD_FIELD_OF_VIEW = ConvertCameraField(3)
CAMERA_FIELD_ROLL = ConvertCameraField(4)
CAMERA_FIELD_ROTATION = ConvertCameraField(5)
CAMERA_FIELD_ZOFFSET = ConvertCameraField(6)
CAMERA_FIELD_NEARZ = ConvertCameraField(7)
CAMERA_FIELD_LOCAL_PITCH = ConvertCameraField(8)
CAMERA_FIELD_LOCAL_YAW = ConvertCameraField(9)
CAMERA_FIELD_LOCAL_ROLL = ConvertCameraField(10)
BLEND_MODE_NONE = ConvertBlendMode(0)
BLEND_MODE_DONT_CARE = ConvertBlendMode(0)
BLEND_MODE_KEYALPHA = ConvertBlendMode(1)
BLEND_MODE_BLEND = ConvertBlendMode(2)
BLEND_MODE_ADDITIVE = ConvertBlendMode(3)
BLEND_MODE_MODULATE = ConvertBlendMode(4)
BLEND_MODE_MODULATE_2X = ConvertBlendMode(5)
RARITY_FREQUENT = ConvertRarityControl(0)
RARITY_RARE = ConvertRarityControl(1)
TEXMAP_FLAG_NONE = ConvertTexMapFlags(0)
TEXMAP_FLAG_WRAP_U = ConvertTexMapFlags(1)
TEXMAP_FLAG_WRAP_V = ConvertTexMapFlags(2)
TEXMAP_FLAG_WRAP_UV = ConvertTexMapFlags(3)
FOG_OF_WAR_MASKED = ConvertFogState(1)
FOG_OF_WAR_FOGGED = ConvertFogState(2)
FOG_OF_WAR_VISIBLE = ConvertFogState(4)
CAMERA_MARGIN_LEFT = 0
CAMERA_MARGIN_RIGHT = 1
CAMERA_MARGIN_TOP = 2
CAMERA_MARGIN_BOTTOM = 3
EFFECT_TYPE_EFFECT = ConvertEffectType(0)
EFFECT_TYPE_TARGET = ConvertEffectType(1)
EFFECT_TYPE_CASTER = ConvertEffectType(2)
EFFECT_TYPE_SPECIAL = ConvertEffectType(3)
EFFECT_TYPE_AREA_EFFECT = ConvertEffectType(4)
EFFECT_TYPE_MISSILE = ConvertEffectType(5)
EFFECT_TYPE_LIGHTNING = ConvertEffectType(6)
SOUND_TYPE_EFFECT = ConvertSoundType(0)
SOUND_TYPE_EFFECT_LOOPED = ConvertSoundType(1)
ORIGIN_FRAME_GAME_UI = ConvertOriginFrameType(0)
ORIGIN_FRAME_COMMAND_BUTTON = ConvertOriginFrameType(1)
ORIGIN_FRAME_HERO_BAR = ConvertOriginFrameType(2)
ORIGIN_FRAME_HERO_BUTTON = ConvertOriginFrameType(3)
ORIGIN_FRAME_HERO_HP_BAR = ConvertOriginFrameType(4)
ORIGIN_FRAME_HERO_MANA_BAR = ConvertOriginFrameType(5)
ORIGIN_FRAME_HERO_BUTTON_INDICATOR = ConvertOriginFrameType(6)
ORIGIN_FRAME_ITEM_BUTTON = ConvertOriginFrameType(7)
ORIGIN_FRAME_MINIMAP = ConvertOriginFrameType(8)
ORIGIN_FRAME_MINIMAP_BUTTON = ConvertOriginFrameType(9)
ORIGIN_FRAME_SYSTEM_BUTTON = ConvertOriginFrameType(10)
ORIGIN_FRAME_TOOLTIP = ConvertOriginFrameType(11)
ORIGIN_FRAME_UBERTOOLTIP = ConvertOriginFrameType(12)
ORIGIN_FRAME_CHAT_MSG = ConvertOriginFrameType(13)
ORIGIN_FRAME_UNIT_MSG = ConvertOriginFrameType(14)
ORIGIN_FRAME_TOP_MSG = ConvertOriginFrameType(15)
ORIGIN_FRAME_PORTRAIT = ConvertOriginFrameType(16)
ORIGIN_FRAME_WORLD_FRAME = ConvertOriginFrameType(17)
FRAMEPOINT_TOPLEFT = ConvertFramePointType(0)
FRAMEPOINT_TOP = ConvertFramePointType(1)
FRAMEPOINT_TOPRIGHT = ConvertFramePointType(2)
FRAMEPOINT_LEFT = ConvertFramePointType(3)
FRAMEPOINT_CENTER = ConvertFramePointType(4)
FRAMEPOINT_RIGHT = ConvertFramePointType(5)
FRAMEPOINT_BOTTOMLEFT = ConvertFramePointType(6)
FRAMEPOINT_BOTTOM = ConvertFramePointType(7)
FRAMEPOINT_BOTTOMRIGHT = ConvertFramePointType(8)
TEXT_JUSTIFY_TOP = ConvertTextAlignType(0)
TEXT_JUSTIFY_MIDDLE = ConvertTextAlignType(1)
TEXT_JUSTIFY_BOTTOM = ConvertTextAlignType(2)
TEXT_JUSTIFY_LEFT = ConvertTextAlignType(3)
TEXT_JUSTIFY_CENTER = ConvertTextAlignType(4)
TEXT_JUSTIFY_RIGHT = ConvertTextAlignType(5)
FRAMEEVENT_CONTROL_CLICK = ConvertFrameEventType(1)
FRAMEEVENT_MOUSE_ENTER = ConvertFrameEventType(2)
FRAMEEVENT_MOUSE_LEAVE = ConvertFrameEventType(3)
FRAMEEVENT_MOUSE_UP = ConvertFrameEventType(4)
FRAMEEVENT_MOUSE_DOWN = ConvertFrameEventType(5)
FRAMEEVENT_MOUSE_WHEEL = ConvertFrameEventType(6)
FRAMEEVENT_CHECKBOX_CHECKED = ConvertFrameEventType(7)
FRAMEEVENT_CHECKBOX_UNCHECKED = ConvertFrameEventType(8)
FRAMEEVENT_EDITBOX_TEXT_CHANGED = ConvertFrameEventType(9)
FRAMEEVENT_POPUPMENU_ITEM_CHANGED = ConvertFrameEventType(10)
FRAMEEVENT_MOUSE_DOUBLECLICK = ConvertFrameEventType(11)
FRAMEEVENT_SPRITE_ANIM_UPDATE = ConvertFrameEventType(12)
FRAMEEVENT_SLIDER_VALUE_CHANGED = ConvertFrameEventType(13)
FRAMEEVENT_DIALOG_CANCEL = ConvertFrameEventType(14)
FRAMEEVENT_DIALOG_ACCEPT = ConvertFrameEventType(15)
FRAMEEVENT_EDITBOX_ENTER = ConvertFrameEventType(16)
OSKEY_BACKSPACE = ConvertOsKeyType(0x08)
OSKEY_TAB = ConvertOsKeyType(0x09)
OSKEY_CLEAR = ConvertOsKeyType(0x0C)
OSKEY_RETURN = ConvertOsKeyType(0x0D)
OSKEY_SHIFT = ConvertOsKeyType(0x10)
OSKEY_CONTROL = ConvertOsKeyType(0x11)
OSKEY_ALT = ConvertOsKeyType(0x12)
OSKEY_PAUSE = ConvertOsKeyType(0x13)
OSKEY_CAPSLOCK = ConvertOsKeyType(0x14)
OSKEY_KANA = ConvertOsKeyType(0x15)
OSKEY_HANGUL = ConvertOsKeyType(0x15)
OSKEY_JUNJA = ConvertOsKeyType(0x17)
OSKEY_FINAL = ConvertOsKeyType(0x18)
OSKEY_HANJA = ConvertOsKeyType(0x19)
OSKEY_KANJI = ConvertOsKeyType(0x19)
OSKEY_ESCAPE = ConvertOsKeyType(0x1B)
OSKEY_CONVERT = ConvertOsKeyType(0x1C)
OSKEY_NONCONVERT = ConvertOsKeyType(0x1D)
OSKEY_ACCEPT = ConvertOsKeyType(0x1E)
OSKEY_MODECHANGE = ConvertOsKeyType(0x1F)
OSKEY_SPACE = ConvertOsKeyType(0x20)
OSKEY_PAGEUP = ConvertOsKeyType(0x21)
OSKEY_PAGEDOWN = ConvertOsKeyType(0x22)
OSKEY_END = ConvertOsKeyType(0x23)
OSKEY_HOME = ConvertOsKeyType(0x24)
OSKEY_LEFT = ConvertOsKeyType(0x25)
OSKEY_UP = ConvertOsKeyType(0x26)
OSKEY_RIGHT = ConvertOsKeyType(0x27)
OSKEY_DOWN = ConvertOsKeyType(0x28)
OSKEY_SELECT = ConvertOsKeyType(0x29)
OSKEY_PRINT = ConvertOsKeyType(0x2A)
OSKEY_EXECUTE = ConvertOsKeyType(0x2B)
OSKEY_PRINTSCREEN = ConvertOsKeyType(0x2C)
OSKEY_INSERT = ConvertOsKeyType(0x2D)
OSKEY_DELETE = ConvertOsKeyType(0x2E)
OSKEY_HELP = ConvertOsKeyType(0x2F)
OSKEY_0 = ConvertOsKeyType(0x30)
OSKEY_1 = ConvertOsKeyType(0x31)
OSKEY_2 = ConvertOsKeyType(0x32)
OSKEY_3 = ConvertOsKeyType(0x33)
OSKEY_4 = ConvertOsKeyType(0x34)
OSKEY_5 = ConvertOsKeyType(0x35)
OSKEY_6 = ConvertOsKeyType(0x36)
OSKEY_7 = ConvertOsKeyType(0x37)
OSKEY_8 = ConvertOsKeyType(0x38)
OSKEY_9 = ConvertOsKeyType(0x39)
OSKEY_A = ConvertOsKeyType(0x41)
OSKEY_B = ConvertOsKeyType(0x42)
OSKEY_C = ConvertOsKeyType(0x43)
OSKEY_D = ConvertOsKeyType(0x44)
OSKEY_E = ConvertOsKeyType(0x45)
OSKEY_F = ConvertOsKeyType(0x46)
OSKEY_G = ConvertOsKeyType(0x47)
OSKEY_H = ConvertOsKeyType(0x48)
OSKEY_I = ConvertOsKeyType(0x49)
OSKEY_J = ConvertOsKeyType(0x4A)
OSKEY_K = ConvertOsKeyType(0x4B)
OSKEY_L = ConvertOsKeyType(0x4C)
OSKEY_M = ConvertOsKeyType(0x4D)
OSKEY_N = ConvertOsKeyType(0x4E)
OSKEY_O = ConvertOsKeyType(0x4F)
OSKEY_P = ConvertOsKeyType(0x50)
OSKEY_Q = ConvertOsKeyType(0x51)
OSKEY_R = ConvertOsKeyType(0x52)
OSKEY_S = ConvertOsKeyType(0x53)
OSKEY_T = ConvertOsKeyType(0x54)
OSKEY_U = ConvertOsKeyType(0x55)
OSKEY_V = ConvertOsKeyType(0x56)
OSKEY_W = ConvertOsKeyType(0x57)
OSKEY_X = ConvertOsKeyType(0x58)
OSKEY_Y = ConvertOsKeyType(0x59)
OSKEY_Z = ConvertOsKeyType(0x5A)
OSKEY_LMETA = ConvertOsKeyType(0x5B)
OSKEY_RMETA = ConvertOsKeyType(0x5C)
OSKEY_APPS = ConvertOsKeyType(0x5D)
OSKEY_SLEEP = ConvertOsKeyType(0x5F)
OSKEY_NUMPAD0 = ConvertOsKeyType(0x60)
OSKEY_NUMPAD1 = ConvertOsKeyType(0x61)
OSKEY_NUMPAD2 = ConvertOsKeyType(0x62)
OSKEY_NUMPAD3 = ConvertOsKeyType(0x63)
OSKEY_NUMPAD4 = ConvertOsKeyType(0x64)
OSKEY_NUMPAD5 = ConvertOsKeyType(0x65)
OSKEY_NUMPAD6 = ConvertOsKeyType(0x66)
OSKEY_NUMPAD7 = ConvertOsKeyType(0x67)
OSKEY_NUMPAD8 = ConvertOsKeyType(0x68)
OSKEY_NUMPAD9 = ConvertOsKeyType(0x69)
OSKEY_MULTIPLY = ConvertOsKeyType(0x6A)
OSKEY_ADD = ConvertOsKeyType(0x6B)
OSKEY_SEPARATOR = ConvertOsKeyType(0x6C)
OSKEY_SUBTRACT = ConvertOsKeyType(0x6D)
OSKEY_DECIMAL = ConvertOsKeyType(0x6E)
OSKEY_DIVIDE = ConvertOsKeyType(0x6F)
OSKEY_F1 = ConvertOsKeyType(0x70)
OSKEY_F2 = ConvertOsKeyType(0x71)
OSKEY_F3 = ConvertOsKeyType(0x72)
OSKEY_F4 = ConvertOsKeyType(0x73)
OSKEY_F5 = ConvertOsKeyType(0x74)
OSKEY_F6 = ConvertOsKeyType(0x75)
OSKEY_F7 = ConvertOsKeyType(0x76)
OSKEY_F8 = ConvertOsKeyType(0x77)
OSKEY_F9 = ConvertOsKeyType(0x78)
OSKEY_F10 = ConvertOsKeyType(0x79)
OSKEY_F11 = ConvertOsKeyType(0x7A)
OSKEY_F12 = ConvertOsKeyType(0x7B)
OSKEY_F13 = ConvertOsKeyType(0x7C)
OSKEY_F14 = ConvertOsKeyType(0x7D)
OSKEY_F15 = ConvertOsKeyType(0x7E)
OSKEY_F16 = ConvertOsKeyType(0x7F)
OSKEY_F17 = ConvertOsKeyType(0x80)
OSKEY_F18 = ConvertOsKeyType(0x81)
OSKEY_F19 = ConvertOsKeyType(0x82)
OSKEY_F20 = ConvertOsKeyType(0x83)
OSKEY_F21 = ConvertOsKeyType(0x84)
OSKEY_F22 = ConvertOsKeyType(0x85)
OSKEY_F23 = ConvertOsKeyType(0x86)
OSKEY_F24 = ConvertOsKeyType(0x87)
OSKEY_NUMLOCK = ConvertOsKeyType(0x90)
OSKEY_SCROLLLOCK = ConvertOsKeyType(0x91)
OSKEY_OEM_NEC_EQUAL = ConvertOsKeyType(0x92)
OSKEY_OEM_FJ_JISHO = ConvertOsKeyType(0x92)
OSKEY_OEM_FJ_MASSHOU = ConvertOsKeyType(0x93)
OSKEY_OEM_FJ_TOUROKU = ConvertOsKeyType(0x94)
OSKEY_OEM_FJ_LOYA = ConvertOsKeyType(0x95)
OSKEY_OEM_FJ_ROYA = ConvertOsKeyType(0x96)
OSKEY_LSHIFT = ConvertOsKeyType(0xA0)
OSKEY_RSHIFT = ConvertOsKeyType(0xA1)
OSKEY_LCONTROL = ConvertOsKeyType(0xA2)
OSKEY_RCONTROL = ConvertOsKeyType(0xA3)
OSKEY_LALT = ConvertOsKeyType(0xA4)
OSKEY_RALT = ConvertOsKeyType(0xA5)
OSKEY_BROWSER_BACK = ConvertOsKeyType(0xA6)
OSKEY_BROWSER_FORWARD = ConvertOsKeyType(0xA7)
OSKEY_BROWSER_REFRESH = ConvertOsKeyType(0xA8)
OSKEY_BROWSER_STOP = ConvertOsKeyType(0xA9)
OSKEY_BROWSER_SEARCH = ConvertOsKeyType(0xAA)
OSKEY_BROWSER_FAVORITES = ConvertOsKeyType(0xAB)
OSKEY_BROWSER_HOME = ConvertOsKeyType(0xAC)
OSKEY_VOLUME_MUTE = ConvertOsKeyType(0xAD)
OSKEY_VOLUME_DOWN = ConvertOsKeyType(0xAE)
OSKEY_VOLUME_UP = ConvertOsKeyType(0xAF)
OSKEY_MEDIA_NEXT_TRACK = ConvertOsKeyType(0xB0)
OSKEY_MEDIA_PREV_TRACK = ConvertOsKeyType(0xB1)
OSKEY_MEDIA_STOP = ConvertOsKeyType(0xB2)
OSKEY_MEDIA_PLAY_PAUSE = ConvertOsKeyType(0xB3)
OSKEY_LAUNCH_MAIL = ConvertOsKeyType(0xB4)
OSKEY_LAUNCH_MEDIA_SELECT = ConvertOsKeyType(0xB5)
OSKEY_LAUNCH_APP1 = ConvertOsKeyType(0xB6)
OSKEY_LAUNCH_APP2 = ConvertOsKeyType(0xB7)
OSKEY_OEM_1 = ConvertOsKeyType(0xBA)
OSKEY_OEM_PLUS = ConvertOsKeyType(0xBB)
OSKEY_OEM_COMMA = ConvertOsKeyType(0xBC)
OSKEY_OEM_MINUS = ConvertOsKeyType(0xBD)
OSKEY_OEM_PERIOD = ConvertOsKeyType(0xBE)
OSKEY_OEM_2 = ConvertOsKeyType(0xBF)
OSKEY_OEM_3 = ConvertOsKeyType(0xC0)
OSKEY_OEM_4 = ConvertOsKeyType(0xDB)
OSKEY_OEM_5 = ConvertOsKeyType(0xDC)
OSKEY_OEM_6 = ConvertOsKeyType(0xDD)
OSKEY_OEM_7 = ConvertOsKeyType(0xDE)
OSKEY_OEM_8 = ConvertOsKeyType(0xDF)
OSKEY_OEM_AX = ConvertOsKeyType(0xE1)
OSKEY_OEM_102 = ConvertOsKeyType(0xE2)
OSKEY_ICO_HELP = ConvertOsKeyType(0xE3)
OSKEY_ICO_00 = ConvertOsKeyType(0xE4)
OSKEY_PROCESSKEY = ConvertOsKeyType(0xE5)
OSKEY_ICO_CLEAR = ConvertOsKeyType(0xE6)
OSKEY_PACKET = ConvertOsKeyType(0xE7)
OSKEY_OEM_RESET = ConvertOsKeyType(0xE9)
OSKEY_OEM_JUMP = ConvertOsKeyType(0xEA)
OSKEY_OEM_PA1 = ConvertOsKeyType(0xEB)
OSKEY_OEM_PA2 = ConvertOsKeyType(0xEC)
OSKEY_OEM_PA3 = ConvertOsKeyType(0xED)
OSKEY_OEM_WSCTRL = ConvertOsKeyType(0xEE)
OSKEY_OEM_CUSEL = ConvertOsKeyType(0xEF)
OSKEY_OEM_ATTN = ConvertOsKeyType(0xF0)
OSKEY_OEM_FINISH = ConvertOsKeyType(0xF1)
OSKEY_OEM_COPY = ConvertOsKeyType(0xF2)
OSKEY_OEM_AUTO = ConvertOsKeyType(0xF3)
OSKEY_OEM_ENLW = ConvertOsKeyType(0xF4)
OSKEY_OEM_BACKTAB = ConvertOsKeyType(0xF5)
OSKEY_ATTN = ConvertOsKeyType(0xF6)
OSKEY_CRSEL = ConvertOsKeyType(0xF7)
OSKEY_EXSEL = ConvertOsKeyType(0xF8)
OSKEY_EREOF = ConvertOsKeyType(0xF9)
OSKEY_PLAY = ConvertOsKeyType(0xFA)
OSKEY_ZOOM = ConvertOsKeyType(0xFB)
OSKEY_NONAME = ConvertOsKeyType(0xFC)
OSKEY_PA1 = ConvertOsKeyType(0xFD)
OSKEY_OEM_CLEAR = ConvertOsKeyType(0xFE)
ABILITY_IF_BUTTON_POSITION_NORMAL_X = ConvertAbilityIntegerField('abpx')
ABILITY_IF_BUTTON_POSITION_NORMAL_Y = ConvertAbilityIntegerField('abpy')
ABILITY_IF_BUTTON_POSITION_ACTIVATED_X = ConvertAbilityIntegerField('aubx')
ABILITY_IF_BUTTON_POSITION_ACTIVATED_Y = ConvertAbilityIntegerField('auby')
ABILITY_IF_BUTTON_POSITION_RESEARCH_X = ConvertAbilityIntegerField('arpx')
ABILITY_IF_BUTTON_POSITION_RESEARCH_Y = ConvertAbilityIntegerField('arpy')
ABILITY_IF_MISSILE_SPEED = ConvertAbilityIntegerField('amsp')
ABILITY_IF_TARGET_ATTACHMENTS = ConvertAbilityIntegerField('atac')
ABILITY_IF_CASTER_ATTACHMENTS = ConvertAbilityIntegerField('acac')
ABILITY_IF_PRIORITY = ConvertAbilityIntegerField('apri')
ABILITY_IF_LEVELS = ConvertAbilityIntegerField('alev')
ABILITY_IF_REQUIRED_LEVEL = ConvertAbilityIntegerField('arlv')
ABILITY_IF_LEVEL_SKIP_REQUIREMENT = ConvertAbilityIntegerField('alsk')
ABILITY_BF_HERO_ABILITY = ConvertAbilityBooleanField('aher') -- Get only
ABILITY_BF_ITEM_ABILITY = ConvertAbilityBooleanField('aite')
ABILITY_BF_CHECK_DEPENDENCIES = ConvertAbilityBooleanField('achd')
ABILITY_RF_ARF_MISSILE_ARC = ConvertAbilityRealField('amac')
ABILITY_SF_NAME = ConvertAbilityStringField('anam') -- Get Only
ABILITY_SF_ICON_ACTIVATED = ConvertAbilityStringField('auar')
ABILITY_SF_ICON_RESEARCH = ConvertAbilityStringField('arar')
ABILITY_SF_EFFECT_SOUND = ConvertAbilityStringField('aefs')
ABILITY_SF_EFFECT_SOUND_LOOPING = ConvertAbilityStringField('aefl')
ABILITY_ILF_MANA_COST = ConvertAbilityIntegerLevelField('amcs')
ABILITY_ILF_NUMBER_OF_WAVES = ConvertAbilityIntegerLevelField('Hbz1')
ABILITY_ILF_NUMBER_OF_SHARDS = ConvertAbilityIntegerLevelField('Hbz3')
ABILITY_ILF_NUMBER_OF_UNITS_TELEPORTED = ConvertAbilityIntegerLevelField('Hmt1')
ABILITY_ILF_SUMMONED_UNIT_COUNT_HWE2 = ConvertAbilityIntegerLevelField('Hwe2')
ABILITY_ILF_NUMBER_OF_IMAGES = ConvertAbilityIntegerLevelField('Omi1')
ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_UAN1 = ConvertAbilityIntegerLevelField('Uan1')
ABILITY_ILF_MORPHING_FLAGS = ConvertAbilityIntegerLevelField('Eme2')
ABILITY_ILF_STRENGTH_BONUS_NRG5 = ConvertAbilityIntegerLevelField('Nrg5')
ABILITY_ILF_DEFENSE_BONUS_NRG6 = ConvertAbilityIntegerLevelField('Nrg6')
ABILITY_ILF_NUMBER_OF_TARGETS_HIT = ConvertAbilityIntegerLevelField('Ocl2')
ABILITY_ILF_DETECTION_TYPE_OFS1 = ConvertAbilityIntegerLevelField('Ofs1')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_OSF2 = ConvertAbilityIntegerLevelField('Osf2')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_EFN1 = ConvertAbilityIntegerLevelField('Efn1')
ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_HRE1 = ConvertAbilityIntegerLevelField('Hre1')
ABILITY_ILF_STACK_FLAGS = ConvertAbilityIntegerLevelField('Hca4')
ABILITY_ILF_MINIMUM_NUMBER_OF_UNITS = ConvertAbilityIntegerLevelField('Ndp2')
ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_NDP3 = ConvertAbilityIntegerLevelField('Ndp3')
ABILITY_ILF_NUMBER_OF_UNITS_CREATED_NRC2 = ConvertAbilityIntegerLevelField('Nrc2')
ABILITY_ILF_SHIELD_LIFE = ConvertAbilityIntegerLevelField('Ams3')
ABILITY_ILF_MANA_LOSS_AMS4 = ConvertAbilityIntegerLevelField('Ams4')
ABILITY_ILF_GOLD_PER_INTERVAL_BGM1 = ConvertAbilityIntegerLevelField('Bgm1')
ABILITY_ILF_MAX_NUMBER_OF_MINERS = ConvertAbilityIntegerLevelField('Bgm3')
ABILITY_ILF_CARGO_CAPACITY = ConvertAbilityIntegerLevelField('Car1')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3 = ConvertAbilityIntegerLevelField('Dev3')
ABILITY_ILF_MAX_CREEP_LEVEL_DEV1 = ConvertAbilityIntegerLevelField('Dev1')
ABILITY_ILF_GOLD_PER_INTERVAL_EGM1 = ConvertAbilityIntegerLevelField('Egm1')
ABILITY_ILF_DEFENSE_REDUCTION = ConvertAbilityIntegerLevelField('Fae1')
ABILITY_ILF_DETECTION_TYPE_FLA1 = ConvertAbilityIntegerLevelField('Fla1')
ABILITY_ILF_FLARE_COUNT = ConvertAbilityIntegerLevelField('Fla3')
ABILITY_ILF_MAX_GOLD = ConvertAbilityIntegerLevelField('Gld1')
ABILITY_ILF_MINING_CAPACITY = ConvertAbilityIntegerLevelField('Gld3')
ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_GYD1 = ConvertAbilityIntegerLevelField('Gyd1')
ABILITY_ILF_DAMAGE_TO_TREE = ConvertAbilityIntegerLevelField('Har1')
ABILITY_ILF_LUMBER_CAPACITY = ConvertAbilityIntegerLevelField('Har2')
ABILITY_ILF_GOLD_CAPACITY = ConvertAbilityIntegerLevelField('Har3')
ABILITY_ILF_DEFENSE_INCREASE_INF2 = ConvertAbilityIntegerLevelField('Inf2')
ABILITY_ILF_INTERACTION_TYPE = ConvertAbilityIntegerLevelField('Neu2')
ABILITY_ILF_GOLD_COST_NDT1 = ConvertAbilityIntegerLevelField('Ndt1')
ABILITY_ILF_LUMBER_COST_NDT2 = ConvertAbilityIntegerLevelField('Ndt2')
ABILITY_ILF_DETECTION_TYPE_NDT3 = ConvertAbilityIntegerLevelField('Ndt3')
ABILITY_ILF_STACKING_TYPE_POI4 = ConvertAbilityIntegerLevelField('Poi4')
ABILITY_ILF_STACKING_TYPE_POA5 = ConvertAbilityIntegerLevelField('Poa5')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_PLY1 = ConvertAbilityIntegerLevelField('Ply1')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_POS1 = ConvertAbilityIntegerLevelField('Pos1')
ABILITY_ILF_MOVEMENT_UPDATE_FREQUENCY_PRG1 = ConvertAbilityIntegerLevelField('Prg1')
ABILITY_ILF_ATTACK_UPDATE_FREQUENCY_PRG2 = ConvertAbilityIntegerLevelField('Prg2')
ABILITY_ILF_MANA_LOSS_PRG6 = ConvertAbilityIntegerLevelField('Prg6')
ABILITY_ILF_UNITS_SUMMONED_TYPE_ONE = ConvertAbilityIntegerLevelField('Rai1')
ABILITY_ILF_UNITS_SUMMONED_TYPE_TWO = ConvertAbilityIntegerLevelField('Rai2')
ABILITY_ILF_MAX_UNITS_SUMMONED = ConvertAbilityIntegerLevelField('Ucb5')
ABILITY_ILF_ALLOW_WHEN_FULL_REJ3 = ConvertAbilityIntegerLevelField('Rej3')
ABILITY_ILF_MAXIMUM_UNITS_CHARGED_TO_CASTER = ConvertAbilityIntegerLevelField('Rpb5')
ABILITY_ILF_MAXIMUM_UNITS_AFFECTED = ConvertAbilityIntegerLevelField('Rpb6')
ABILITY_ILF_DEFENSE_INCREASE_ROA2 = ConvertAbilityIntegerLevelField('Roa2')
ABILITY_ILF_MAX_UNITS_ROA7 = ConvertAbilityIntegerLevelField('Roa7')
ABILITY_ILF_ROOTED_WEAPONS = ConvertAbilityIntegerLevelField('Roo1')
ABILITY_ILF_UPROOTED_WEAPONS = ConvertAbilityIntegerLevelField('Roo2')
ABILITY_ILF_UPROOTED_DEFENSE_TYPE = ConvertAbilityIntegerLevelField('Roo4')
ABILITY_ILF_ACCUMULATION_STEP = ConvertAbilityIntegerLevelField('Sal2')
ABILITY_ILF_NUMBER_OF_OWLS = ConvertAbilityIntegerLevelField('Esn4')
ABILITY_ILF_STACKING_TYPE_SPO4 = ConvertAbilityIntegerLevelField('Spo4')
ABILITY_ILF_NUMBER_OF_UNITS = ConvertAbilityIntegerLevelField('Sod1')
ABILITY_ILF_SPIDER_CAPACITY = ConvertAbilityIntegerLevelField('Spa1')
ABILITY_ILF_INTERVALS_BEFORE_CHANGING_TREES = ConvertAbilityIntegerLevelField('Wha2')
ABILITY_ILF_AGILITY_BONUS = ConvertAbilityIntegerLevelField('Iagi')
ABILITY_ILF_INTELLIGENCE_BONUS = ConvertAbilityIntegerLevelField('Iint')
ABILITY_ILF_STRENGTH_BONUS_ISTR = ConvertAbilityIntegerLevelField('Istr')
ABILITY_ILF_ATTACK_BONUS = ConvertAbilityIntegerLevelField('Iatt')
ABILITY_ILF_DEFENSE_BONUS_IDEF = ConvertAbilityIntegerLevelField('Idef')
ABILITY_ILF_SUMMON_1_AMOUNT = ConvertAbilityIntegerLevelField('Isn1')
ABILITY_ILF_SUMMON_2_AMOUNT = ConvertAbilityIntegerLevelField('Isn2')
ABILITY_ILF_EXPERIENCE_GAINED = ConvertAbilityIntegerLevelField('Ixpg')
ABILITY_ILF_HIT_POINTS_GAINED_IHPG = ConvertAbilityIntegerLevelField('Ihpg')
ABILITY_ILF_MANA_POINTS_GAINED_IMPG = ConvertAbilityIntegerLevelField('Impg')
ABILITY_ILF_HIT_POINTS_GAINED_IHP2 = ConvertAbilityIntegerLevelField('Ihp2')
ABILITY_ILF_MANA_POINTS_GAINED_IMP2 = ConvertAbilityIntegerLevelField('Imp2')
ABILITY_ILF_DAMAGE_BONUS_DICE = ConvertAbilityIntegerLevelField('Idic')
ABILITY_ILF_ARMOR_PENALTY_IARP = ConvertAbilityIntegerLevelField('Iarp')
ABILITY_ILF_ENABLED_ATTACK_INDEX_IOB5 = ConvertAbilityIntegerLevelField('Iob5')
ABILITY_ILF_LEVELS_GAINED = ConvertAbilityIntegerLevelField('Ilev')
ABILITY_ILF_MAX_LIFE_GAINED = ConvertAbilityIntegerLevelField('Ilif')
ABILITY_ILF_MAX_MANA_GAINED = ConvertAbilityIntegerLevelField('Iman')
ABILITY_ILF_GOLD_GIVEN = ConvertAbilityIntegerLevelField('Igol')
ABILITY_ILF_LUMBER_GIVEN = ConvertAbilityIntegerLevelField('Ilum')
ABILITY_ILF_DETECTION_TYPE_IFA1 = ConvertAbilityIntegerLevelField('Ifa1')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_ICRE = ConvertAbilityIntegerLevelField('Icre')
ABILITY_ILF_MOVEMENT_SPEED_BONUS = ConvertAbilityIntegerLevelField('Imvb')
ABILITY_ILF_HIT_POINTS_REGENERATED_PER_SECOND = ConvertAbilityIntegerLevelField('Ihpr')
ABILITY_ILF_SIGHT_RANGE_BONUS = ConvertAbilityIntegerLevelField('Isib')
ABILITY_ILF_DAMAGE_PER_DURATION = ConvertAbilityIntegerLevelField('Icfd')
ABILITY_ILF_MANA_USED_PER_SECOND = ConvertAbilityIntegerLevelField('Icfm')
ABILITY_ILF_EXTRA_MANA_REQUIRED = ConvertAbilityIntegerLevelField('Icfx')
ABILITY_ILF_DETECTION_RADIUS_IDET = ConvertAbilityIntegerLevelField('Idet')
ABILITY_ILF_MANA_LOSS_PER_UNIT_IDIM = ConvertAbilityIntegerLevelField('Idim')
ABILITY_ILF_DAMAGE_TO_SUMMONED_UNITS_IDID = ConvertAbilityIntegerLevelField('Idid')
ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_IREC = ConvertAbilityIntegerLevelField('Irec')
ABILITY_ILF_DELAY_AFTER_DEATH_SECONDS = ConvertAbilityIntegerLevelField('Ircd')
ABILITY_ILF_RESTORED_LIFE = ConvertAbilityIntegerLevelField('irc2')
ABILITY_ILF_RESTORED_MANA__1_FOR_CURRENT = ConvertAbilityIntegerLevelField('irc3')
ABILITY_ILF_HIT_POINTS_RESTORED = ConvertAbilityIntegerLevelField('Ihps')
ABILITY_ILF_MANA_POINTS_RESTORED = ConvertAbilityIntegerLevelField('Imps')
ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_ITPM = ConvertAbilityIntegerLevelField('Itpm')
ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_CAD1 = ConvertAbilityIntegerLevelField('Cad1')
ABILITY_ILF_TERRAIN_DEFORMATION_DURATION_MS = ConvertAbilityIntegerLevelField('Wrs3')
ABILITY_ILF_MAXIMUM_UNITS = ConvertAbilityIntegerLevelField('Uds1')
ABILITY_ILF_DETECTION_TYPE_DET1 = ConvertAbilityIntegerLevelField('Det1')
ABILITY_ILF_GOLD_COST_PER_STRUCTURE = ConvertAbilityIntegerLevelField('Nsp1')
ABILITY_ILF_LUMBER_COST_PER_USE = ConvertAbilityIntegerLevelField('Nsp2')
ABILITY_ILF_DETECTION_TYPE_NSP3 = ConvertAbilityIntegerLevelField('Nsp3')
ABILITY_ILF_NUMBER_OF_SWARM_UNITS = ConvertAbilityIntegerLevelField('Uls1')
ABILITY_ILF_MAX_SWARM_UNITS_PER_TARGET = ConvertAbilityIntegerLevelField('Uls3')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NBA2 = ConvertAbilityIntegerLevelField('Nba2')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1 = ConvertAbilityIntegerLevelField('Nch1')
ABILITY_ILF_ATTACKS_PREVENTED = ConvertAbilityIntegerLevelField('Nsi1')
ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_EFK3 = ConvertAbilityIntegerLevelField('Efk3')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_ESV1 = ConvertAbilityIntegerLevelField('Esv1')
ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_EXH1 = ConvertAbilityIntegerLevelField('exh1')
ABILITY_ILF_ITEM_CAPACITY = ConvertAbilityIntegerLevelField('inv1')
ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_SPL2 = ConvertAbilityIntegerLevelField('spl2')
ABILITY_ILF_ALLOW_WHEN_FULL_IRL3 = ConvertAbilityIntegerLevelField('irl3')
ABILITY_ILF_MAXIMUM_DISPELLED_UNITS = ConvertAbilityIntegerLevelField('idc3')
ABILITY_ILF_NUMBER_OF_LURES = ConvertAbilityIntegerLevelField('imo1')
ABILITY_ILF_NEW_TIME_OF_DAY_HOUR = ConvertAbilityIntegerLevelField('ict1')
ABILITY_ILF_NEW_TIME_OF_DAY_MINUTE = ConvertAbilityIntegerLevelField('ict2')
ABILITY_ILF_NUMBER_OF_UNITS_CREATED_MEC1 = ConvertAbilityIntegerLevelField('mec1')
ABILITY_ILF_MINIMUM_SPELLS = ConvertAbilityIntegerLevelField('spb3')
ABILITY_ILF_MAXIMUM_SPELLS = ConvertAbilityIntegerLevelField('spb4')
ABILITY_ILF_DISABLED_ATTACK_INDEX = ConvertAbilityIntegerLevelField('gra3')
ABILITY_ILF_ENABLED_ATTACK_INDEX_GRA4 = ConvertAbilityIntegerLevelField('gra4')
ABILITY_ILF_MAXIMUM_ATTACKS = ConvertAbilityIntegerLevelField('gra5')
ABILITY_ILF_BUILDING_TYPES_ALLOWED_NPR1 = ConvertAbilityIntegerLevelField('Npr1')
ABILITY_ILF_BUILDING_TYPES_ALLOWED_NSA1 = ConvertAbilityIntegerLevelField('Nsa1')
ABILITY_ILF_ATTACK_MODIFICATION = ConvertAbilityIntegerLevelField('Iaa1')
ABILITY_ILF_SUMMONED_UNIT_COUNT_NPA5 = ConvertAbilityIntegerLevelField('Npa5')
ABILITY_ILF_UPGRADE_LEVELS = ConvertAbilityIntegerLevelField('Igl1')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NDO2 = ConvertAbilityIntegerLevelField('Ndo2')
ABILITY_ILF_BEASTS_PER_SECOND = ConvertAbilityIntegerLevelField('Nst1')
ABILITY_ILF_TARGET_TYPE = ConvertAbilityIntegerLevelField('Ncl2')
ABILITY_ILF_OPTIONS = ConvertAbilityIntegerLevelField('Ncl3')
ABILITY_ILF_ARMOR_PENALTY_NAB3 = ConvertAbilityIntegerLevelField('Nab3')
ABILITY_ILF_WAVE_COUNT_NHS6 = ConvertAbilityIntegerLevelField('Nhs6')
ABILITY_ILF_MAX_CREEP_LEVEL_NTM3 = ConvertAbilityIntegerLevelField('Ntm3')
ABILITY_ILF_MISSILE_COUNT = ConvertAbilityIntegerLevelField('Ncs3')
ABILITY_ILF_SPLIT_ATTACK_COUNT = ConvertAbilityIntegerLevelField('Nlm3')
ABILITY_ILF_GENERATION_COUNT = ConvertAbilityIntegerLevelField('Nlm6')
ABILITY_ILF_ROCK_RING_COUNT = ConvertAbilityIntegerLevelField('Nvc1')
ABILITY_ILF_WAVE_COUNT_NVC2 = ConvertAbilityIntegerLevelField('Nvc2')
ABILITY_ILF_PREFER_HOSTILES_TAU1 = ConvertAbilityIntegerLevelField('Tau1')
ABILITY_ILF_PREFER_FRIENDLIES_TAU2 = ConvertAbilityIntegerLevelField('Tau2')
ABILITY_ILF_MAX_UNITS_TAU3 = ConvertAbilityIntegerLevelField('Tau3')
ABILITY_ILF_NUMBER_OF_PULSES = ConvertAbilityIntegerLevelField('Tau4')
ABILITY_ILF_SUMMONED_UNIT_TYPE_HWE1 = ConvertAbilityIntegerLevelField('Hwe1')
ABILITY_ILF_SUMMONED_UNIT_UIN4 = ConvertAbilityIntegerLevelField('Uin4')
ABILITY_ILF_SUMMONED_UNIT_OSF1 = ConvertAbilityIntegerLevelField('Osf1')
ABILITY_ILF_SUMMONED_UNIT_TYPE_EFNU = ConvertAbilityIntegerLevelField('Efnu')
ABILITY_ILF_SUMMONED_UNIT_TYPE_NBAU = ConvertAbilityIntegerLevelField('Nbau')
ABILITY_ILF_SUMMONED_UNIT_TYPE_NTOU = ConvertAbilityIntegerLevelField('Ntou')
ABILITY_ILF_SUMMONED_UNIT_TYPE_ESVU = ConvertAbilityIntegerLevelField('Esvu')
ABILITY_ILF_SUMMONED_UNIT_TYPES = ConvertAbilityIntegerLevelField('Nef1')
ABILITY_ILF_SUMMONED_UNIT_TYPE_NDOU = ConvertAbilityIntegerLevelField('Ndou')
ABILITY_ILF_ALTERNATE_FORM_UNIT_EMEU = ConvertAbilityIntegerLevelField('Emeu')
ABILITY_ILF_PLAGUE_WARD_UNIT_TYPE = ConvertAbilityIntegerLevelField('Aplu')
ABILITY_ILF_ALLOWED_UNIT_TYPE_BTL1 = ConvertAbilityIntegerLevelField('Btl1')
ABILITY_ILF_NEW_UNIT_TYPE = ConvertAbilityIntegerLevelField('Cha1')
ABILITY_ILF_RESULTING_UNIT_TYPE_ENT1 = ConvertAbilityIntegerLevelField('ent1')
ABILITY_ILF_CORPSE_UNIT_TYPE = ConvertAbilityIntegerLevelField('Gydu')
ABILITY_ILF_ALLOWED_UNIT_TYPE_LOA1 = ConvertAbilityIntegerLevelField('Loa1')
ABILITY_ILF_UNIT_TYPE_FOR_LIMIT_CHECK = ConvertAbilityIntegerLevelField('Raiu')
ABILITY_ILF_WARD_UNIT_TYPE_STAU = ConvertAbilityIntegerLevelField('Stau')
ABILITY_ILF_EFFECT_ABILITY = ConvertAbilityIntegerLevelField('Iobu')
ABILITY_ILF_CONVERSION_UNIT = ConvertAbilityIntegerLevelField('Ndc2')
ABILITY_ILF_UNIT_TO_PRESERVE = ConvertAbilityIntegerLevelField('Nsl1')
ABILITY_ILF_UNIT_TYPE_ALLOWED = ConvertAbilityIntegerLevelField('Chl1')
ABILITY_ILF_SWARM_UNIT_TYPE = ConvertAbilityIntegerLevelField('Ulsu')
ABILITY_ILF_RESULTING_UNIT_TYPE_COAU = ConvertAbilityIntegerLevelField('coau')
ABILITY_ILF_UNIT_TYPE_EXHU = ConvertAbilityIntegerLevelField('exhu')
ABILITY_ILF_WARD_UNIT_TYPE_HWDU = ConvertAbilityIntegerLevelField('hwdu')
ABILITY_ILF_LURE_UNIT_TYPE = ConvertAbilityIntegerLevelField('imou')
ABILITY_ILF_UNIT_TYPE_IPMU = ConvertAbilityIntegerLevelField('ipmu')
ABILITY_ILF_FACTORY_UNIT_ID = ConvertAbilityIntegerLevelField('Nsyu')
ABILITY_ILF_SPAWN_UNIT_ID_NFYU = ConvertAbilityIntegerLevelField('Nfyu')
ABILITY_ILF_DESTRUCTIBLE_ID = ConvertAbilityIntegerLevelField('Nvcu')
ABILITY_ILF_UPGRADE_TYPE = ConvertAbilityIntegerLevelField('Iglu')
ABILITY_RLF_CASTING_TIME = ConvertAbilityRealLevelField('acas')
ABILITY_RLF_DURATION_NORMAL = ConvertAbilityRealLevelField('adur')
ABILITY_RLF_DURATION_HERO = ConvertAbilityRealLevelField('ahdu')
ABILITY_RLF_COOLDOWN = ConvertAbilityRealLevelField('acdn')
ABILITY_RLF_AREA_OF_EFFECT = ConvertAbilityRealLevelField('aare')
ABILITY_RLF_CAST_RANGE = ConvertAbilityRealLevelField('aran')
ABILITY_RLF_DAMAGE_HBZ2 = ConvertAbilityRealLevelField('Hbz2')
ABILITY_RLF_BUILDING_REDUCTION_HBZ4 = ConvertAbilityRealLevelField('Hbz4')
ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5 = ConvertAbilityRealLevelField('Hbz5')
ABILITY_RLF_MAXIMUM_DAMAGE_PER_WAVE = ConvertAbilityRealLevelField('Hbz6')
ABILITY_RLF_MANA_REGENERATION_INCREASE = ConvertAbilityRealLevelField('Hab1')
ABILITY_RLF_CASTING_DELAY = ConvertAbilityRealLevelField('Hmt2')
ABILITY_RLF_DAMAGE_PER_SECOND_OWW1 = ConvertAbilityRealLevelField('Oww1')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_OWW2 = ConvertAbilityRealLevelField('Oww2')
ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE = ConvertAbilityRealLevelField('Ocr1')
ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2 = ConvertAbilityRealLevelField('Ocr2')
ABILITY_RLF_DAMAGE_BONUS_OCR3 = ConvertAbilityRealLevelField('Ocr3')
ABILITY_RLF_CHANCE_TO_EVADE_OCR4 = ConvertAbilityRealLevelField('Ocr4')
ABILITY_RLF_DAMAGE_DEALT_PERCENT_OMI2 = ConvertAbilityRealLevelField('Omi2')
ABILITY_RLF_DAMAGE_TAKEN_PERCENT_OMI3 = ConvertAbilityRealLevelField('Omi3')
ABILITY_RLF_ANIMATION_DELAY = ConvertAbilityRealLevelField('Omi4')
ABILITY_RLF_TRANSITION_TIME = ConvertAbilityRealLevelField('Owk1')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OWK2 = ConvertAbilityRealLevelField('Owk2')
ABILITY_RLF_BACKSTAB_DAMAGE = ConvertAbilityRealLevelField('Owk3')
ABILITY_RLF_AMOUNT_HEALED_DAMAGED_UDC1 = ConvertAbilityRealLevelField('Udc1')
ABILITY_RLF_LIFE_CONVERTED_TO_MANA = ConvertAbilityRealLevelField('Udp1')
ABILITY_RLF_LIFE_CONVERTED_TO_LIFE = ConvertAbilityRealLevelField('Udp2')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_UAU1 = ConvertAbilityRealLevelField('Uau1')
ABILITY_RLF_LIFE_REGENERATION_INCREASE_PERCENT = ConvertAbilityRealLevelField('Uau2')
ABILITY_RLF_CHANCE_TO_EVADE_EEV1 = ConvertAbilityRealLevelField('Eev1')
ABILITY_RLF_DAMAGE_PER_INTERVAL = ConvertAbilityRealLevelField('Eim1')
ABILITY_RLF_MANA_DRAINED_PER_SECOND_EIM2 = ConvertAbilityRealLevelField('Eim2')
ABILITY_RLF_BUFFER_MANA_REQUIRED = ConvertAbilityRealLevelField('Eim3')
ABILITY_RLF_MAX_MANA_DRAINED = ConvertAbilityRealLevelField('Emb1')
ABILITY_RLF_BOLT_DELAY = ConvertAbilityRealLevelField('Emb2')
ABILITY_RLF_BOLT_LIFETIME = ConvertAbilityRealLevelField('Emb3')
ABILITY_RLF_ALTITUDE_ADJUSTMENT_DURATION = ConvertAbilityRealLevelField('Eme3')
ABILITY_RLF_LANDING_DELAY_TIME = ConvertAbilityRealLevelField('Eme4')
ABILITY_RLF_ALTERNATE_FORM_HIT_POINT_BONUS = ConvertAbilityRealLevelField('Eme5')
ABILITY_RLF_MOVE_SPEED_BONUS_INFO_PANEL_ONLY = ConvertAbilityRealLevelField('Ncr5')
ABILITY_RLF_ATTACK_SPEED_BONUS_INFO_PANEL_ONLY = ConvertAbilityRealLevelField('Ncr6')
ABILITY_RLF_LIFE_REGENERATION_RATE_PER_SECOND = ConvertAbilityRealLevelField('ave5')
ABILITY_RLF_STUN_DURATION_USL1 = ConvertAbilityRealLevelField('Usl1')
ABILITY_RLF_ATTACK_DAMAGE_STOLEN_PERCENT = ConvertAbilityRealLevelField('Uav1')
ABILITY_RLF_DAMAGE_UCS1 = ConvertAbilityRealLevelField('Ucs1')
ABILITY_RLF_MAX_DAMAGE_UCS2 = ConvertAbilityRealLevelField('Ucs2')
ABILITY_RLF_DISTANCE_UCS3 = ConvertAbilityRealLevelField('Ucs3')
ABILITY_RLF_FINAL_AREA_UCS4 = ConvertAbilityRealLevelField('Ucs4')
ABILITY_RLF_DAMAGE_UIN1 = ConvertAbilityRealLevelField('Uin1')
ABILITY_RLF_DURATION = ConvertAbilityRealLevelField('Uin2')
ABILITY_RLF_IMPACT_DELAY = ConvertAbilityRealLevelField('Uin3')
ABILITY_RLF_DAMAGE_PER_TARGET_OCL1 = ConvertAbilityRealLevelField('Ocl1')
ABILITY_RLF_DAMAGE_REDUCTION_PER_TARGET = ConvertAbilityRealLevelField('Ocl3')
ABILITY_RLF_EFFECT_DELAY_OEQ1 = ConvertAbilityRealLevelField('Oeq1')
ABILITY_RLF_DAMAGE_PER_SECOND_TO_BUILDINGS = ConvertAbilityRealLevelField('Oeq2')
ABILITY_RLF_UNITS_SLOWED_PERCENT = ConvertAbilityRealLevelField('Oeq3')
ABILITY_RLF_FINAL_AREA_OEQ4 = ConvertAbilityRealLevelField('Oeq4')
ABILITY_RLF_DAMAGE_PER_SECOND_EER1 = ConvertAbilityRealLevelField('Eer1')
ABILITY_RLF_DAMAGE_DEALT_TO_ATTACKERS = ConvertAbilityRealLevelField('Eah1')
ABILITY_RLF_LIFE_HEALED = ConvertAbilityRealLevelField('Etq1')
ABILITY_RLF_HEAL_INTERVAL = ConvertAbilityRealLevelField('Etq2')
ABILITY_RLF_BUILDING_REDUCTION_ETQ3 = ConvertAbilityRealLevelField('Etq3')
ABILITY_RLF_INITIAL_IMMUNITY_DURATION = ConvertAbilityRealLevelField('Etq4')
ABILITY_RLF_MAX_LIFE_DRAINED_PER_SECOND_PERCENT = ConvertAbilityRealLevelField('Udd1')
ABILITY_RLF_BUILDING_REDUCTION_UDD2 = ConvertAbilityRealLevelField('Udd2')
ABILITY_RLF_ARMOR_DURATION = ConvertAbilityRealLevelField('Ufa1')
ABILITY_RLF_ARMOR_BONUS_UFA2 = ConvertAbilityRealLevelField('Ufa2')
ABILITY_RLF_AREA_OF_EFFECT_DAMAGE = ConvertAbilityRealLevelField('Ufn1')
ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2 = ConvertAbilityRealLevelField('Ufn2')
ABILITY_RLF_DAMAGE_BONUS_HFA1 = ConvertAbilityRealLevelField('Hfa1')
ABILITY_RLF_DAMAGE_DEALT_ESF1 = ConvertAbilityRealLevelField('Esf1')
ABILITY_RLF_DAMAGE_INTERVAL_ESF2 = ConvertAbilityRealLevelField('Esf2')
ABILITY_RLF_BUILDING_REDUCTION_ESF3 = ConvertAbilityRealLevelField('Esf3')
ABILITY_RLF_DAMAGE_BONUS_PERCENT = ConvertAbilityRealLevelField('Ear1')
ABILITY_RLF_DEFENSE_BONUS_HAV1 = ConvertAbilityRealLevelField('Hav1')
ABILITY_RLF_HIT_POINT_BONUS = ConvertAbilityRealLevelField('Hav2')
ABILITY_RLF_DAMAGE_BONUS_HAV3 = ConvertAbilityRealLevelField('Hav3')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_HAV4 = ConvertAbilityRealLevelField('Hav4')
ABILITY_RLF_CHANCE_TO_BASH = ConvertAbilityRealLevelField('Hbh1')
ABILITY_RLF_DAMAGE_MULTIPLIER_HBH2 = ConvertAbilityRealLevelField('Hbh2')
ABILITY_RLF_DAMAGE_BONUS_HBH3 = ConvertAbilityRealLevelField('Hbh3')
ABILITY_RLF_CHANCE_TO_MISS_HBH4 = ConvertAbilityRealLevelField('Hbh4')
ABILITY_RLF_DAMAGE_HTB1 = ConvertAbilityRealLevelField('Htb1')
ABILITY_RLF_AOE_DAMAGE = ConvertAbilityRealLevelField('Htc1')
ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_HTC2 = ConvertAbilityRealLevelField('Htc2')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HTC3 = ConvertAbilityRealLevelField('Htc3')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HTC4 = ConvertAbilityRealLevelField('Htc4')
ABILITY_RLF_ARMOR_BONUS_HAD1 = ConvertAbilityRealLevelField('Had1')
ABILITY_RLF_AMOUNT_HEALED_DAMAGED_HHB1 = ConvertAbilityRealLevelField('Hhb1')
ABILITY_RLF_EXTRA_DAMAGE_HCA1 = ConvertAbilityRealLevelField('Hca1')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_HCA2 = ConvertAbilityRealLevelField('Hca2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_HCA3 = ConvertAbilityRealLevelField('Hca3')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OAE1 = ConvertAbilityRealLevelField('Oae1')
ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2 = ConvertAbilityRealLevelField('Oae2')
ABILITY_RLF_REINCARNATION_DELAY = ConvertAbilityRealLevelField('Ore1')
ABILITY_RLF_DAMAGE_OSH1 = ConvertAbilityRealLevelField('Osh1')
ABILITY_RLF_MAXIMUM_DAMAGE_OSH2 = ConvertAbilityRealLevelField('Osh2')
ABILITY_RLF_DISTANCE_OSH3 = ConvertAbilityRealLevelField('Osh3')
ABILITY_RLF_FINAL_AREA_OSH4 = ConvertAbilityRealLevelField('Osh4')
ABILITY_RLF_GRAPHIC_DELAY_NFD1 = ConvertAbilityRealLevelField('Nfd1')
ABILITY_RLF_GRAPHIC_DURATION_NFD2 = ConvertAbilityRealLevelField('Nfd2')
ABILITY_RLF_DAMAGE_NFD3 = ConvertAbilityRealLevelField('Nfd3')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_AMS1 = ConvertAbilityRealLevelField('Ams1')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_AMS2 = ConvertAbilityRealLevelField('Ams2')
ABILITY_RLF_AURA_DURATION = ConvertAbilityRealLevelField('Apl1')
ABILITY_RLF_DAMAGE_PER_SECOND_APL2 = ConvertAbilityRealLevelField('Apl2')
ABILITY_RLF_DURATION_OF_PLAGUE_WARD = ConvertAbilityRealLevelField('Apl3')
ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED = ConvertAbilityRealLevelField('Oar1')
ABILITY_RLF_ATTACK_DAMAGE_INCREASE_AKB1 = ConvertAbilityRealLevelField('Akb1')
ABILITY_RLF_MANA_LOSS_ADM1 = ConvertAbilityRealLevelField('Adm1')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_ADM2 = ConvertAbilityRealLevelField('Adm2')
ABILITY_RLF_EXPANSION_AMOUNT = ConvertAbilityRealLevelField('Bli1')
ABILITY_RLF_INTERVAL_DURATION_BGM2 = ConvertAbilityRealLevelField('Bgm2')
ABILITY_RLF_RADIUS_OF_MINING_RING = ConvertAbilityRealLevelField('Bgm4')
ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_BLO1 = ConvertAbilityRealLevelField('Blo1')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_BLO2 = ConvertAbilityRealLevelField('Blo2')
ABILITY_RLF_SCALING_FACTOR = ConvertAbilityRealLevelField('Blo3')
ABILITY_RLF_HIT_POINTS_PER_SECOND_CAN1 = ConvertAbilityRealLevelField('Can1')
ABILITY_RLF_MAX_HIT_POINTS = ConvertAbilityRealLevelField('Can2')
ABILITY_RLF_DAMAGE_PER_SECOND_DEV2 = ConvertAbilityRealLevelField('Dev2')
ABILITY_RLF_MOVEMENT_UPDATE_FREQUENCY_CHD1 = ConvertAbilityRealLevelField('Chd1')
ABILITY_RLF_ATTACK_UPDATE_FREQUENCY_CHD2 = ConvertAbilityRealLevelField('Chd2')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_CHD3 = ConvertAbilityRealLevelField('Chd3')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_CRI1 = ConvertAbilityRealLevelField('Cri1')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_CRI2 = ConvertAbilityRealLevelField('Cri2')
ABILITY_RLF_DAMAGE_REDUCTION_CRI3 = ConvertAbilityRealLevelField('Cri3')
ABILITY_RLF_CHANCE_TO_MISS_CRS = ConvertAbilityRealLevelField('Crs1')
ABILITY_RLF_FULL_DAMAGE_RADIUS_DDA1 = ConvertAbilityRealLevelField('Dda1')
ABILITY_RLF_FULL_DAMAGE_AMOUNT_DDA2 = ConvertAbilityRealLevelField('Dda2')
ABILITY_RLF_PARTIAL_DAMAGE_RADIUS = ConvertAbilityRealLevelField('Dda3')
ABILITY_RLF_PARTIAL_DAMAGE_AMOUNT = ConvertAbilityRealLevelField('Dda4')
ABILITY_RLF_BUILDING_DAMAGE_FACTOR_SDS1 = ConvertAbilityRealLevelField('Sds1')
ABILITY_RLF_MAX_DAMAGE_UCO5 = ConvertAbilityRealLevelField('Uco5')
ABILITY_RLF_MOVE_SPEED_BONUS_UCO6 = ConvertAbilityRealLevelField('Uco6')
ABILITY_RLF_DAMAGE_TAKEN_PERCENT_DEF1 = ConvertAbilityRealLevelField('Def1')
ABILITY_RLF_DAMAGE_DEALT_PERCENT_DEF2 = ConvertAbilityRealLevelField('Def2')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_DEF3 = ConvertAbilityRealLevelField('Def3')
ABILITY_RLF_ATTACK_SPEED_FACTOR_DEF4 = ConvertAbilityRealLevelField('Def4')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_DEF5 = ConvertAbilityRealLevelField('Def5')
ABILITY_RLF_CHANCE_TO_DEFLECT = ConvertAbilityRealLevelField('Def6')
ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_PIERCING = ConvertAbilityRealLevelField('Def7')
ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_SPELLS = ConvertAbilityRealLevelField('Def8')
ABILITY_RLF_RIP_DELAY = ConvertAbilityRealLevelField('Eat1')
ABILITY_RLF_EAT_DELAY = ConvertAbilityRealLevelField('Eat2')
ABILITY_RLF_HIT_POINTS_GAINED_EAT3 = ConvertAbilityRealLevelField('Eat3')
ABILITY_RLF_AIR_UNIT_LOWER_DURATION = ConvertAbilityRealLevelField('Ens1')
ABILITY_RLF_AIR_UNIT_HEIGHT = ConvertAbilityRealLevelField('Ens2')
ABILITY_RLF_MELEE_ATTACK_RANGE = ConvertAbilityRealLevelField('Ens3')
ABILITY_RLF_INTERVAL_DURATION_EGM2 = ConvertAbilityRealLevelField('Egm2')
ABILITY_RLF_EFFECT_DELAY_FLA2 = ConvertAbilityRealLevelField('Fla2')
ABILITY_RLF_MINING_DURATION = ConvertAbilityRealLevelField('Gld2')
ABILITY_RLF_RADIUS_OF_GRAVESTONES = ConvertAbilityRealLevelField('Gyd2')
ABILITY_RLF_RADIUS_OF_CORPSES = ConvertAbilityRealLevelField('Gyd3')
ABILITY_RLF_HIT_POINTS_GAINED_HEA1 = ConvertAbilityRealLevelField('Hea1')
ABILITY_RLF_DAMAGE_INCREASE_PERCENT_INF1 = ConvertAbilityRealLevelField('Inf1')
ABILITY_RLF_AUTOCAST_RANGE = ConvertAbilityRealLevelField('Inf3')
ABILITY_RLF_LIFE_REGEN_RATE = ConvertAbilityRealLevelField('Inf4')
ABILITY_RLF_GRAPHIC_DELAY_LIT1 = ConvertAbilityRealLevelField('Lit1')
ABILITY_RLF_GRAPHIC_DURATION_LIT2 = ConvertAbilityRealLevelField('Lit2')
ABILITY_RLF_DAMAGE_PER_SECOND_LSH1 = ConvertAbilityRealLevelField('Lsh1')
ABILITY_RLF_MANA_GAINED = ConvertAbilityRealLevelField('Mbt1')
ABILITY_RLF_HIT_POINTS_GAINED_MBT2 = ConvertAbilityRealLevelField('Mbt2')
ABILITY_RLF_AUTOCAST_REQUIREMENT = ConvertAbilityRealLevelField('Mbt3')
ABILITY_RLF_WATER_HEIGHT = ConvertAbilityRealLevelField('Mbt4')
ABILITY_RLF_ACTIVATION_DELAY_MIN1 = ConvertAbilityRealLevelField('Min1')
ABILITY_RLF_INVISIBILITY_TRANSITION_TIME = ConvertAbilityRealLevelField('Min2')
ABILITY_RLF_ACTIVATION_RADIUS = ConvertAbilityRealLevelField('Neu1')
ABILITY_RLF_AMOUNT_REGENERATED = ConvertAbilityRealLevelField('Arm1')
ABILITY_RLF_DAMAGE_PER_SECOND_POI1 = ConvertAbilityRealLevelField('Poi1')
ABILITY_RLF_ATTACK_SPEED_FACTOR_POI2 = ConvertAbilityRealLevelField('Poi2')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POI3 = ConvertAbilityRealLevelField('Poi3')
ABILITY_RLF_EXTRA_DAMAGE_POA1 = ConvertAbilityRealLevelField('Poa1')
ABILITY_RLF_DAMAGE_PER_SECOND_POA2 = ConvertAbilityRealLevelField('Poa2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_POA3 = ConvertAbilityRealLevelField('Poa3')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POA4 = ConvertAbilityRealLevelField('Poa4')
ABILITY_RLF_DAMAGE_AMPLIFICATION = ConvertAbilityRealLevelField('Pos2')
ABILITY_RLF_CHANCE_TO_STOMP_PERCENT = ConvertAbilityRealLevelField('War1')
ABILITY_RLF_DAMAGE_DEALT_WAR2 = ConvertAbilityRealLevelField('War2')
ABILITY_RLF_FULL_DAMAGE_RADIUS_WAR3 = ConvertAbilityRealLevelField('War3')
ABILITY_RLF_HALF_DAMAGE_RADIUS_WAR4 = ConvertAbilityRealLevelField('War4')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_PRG3 = ConvertAbilityRealLevelField('Prg3')
ABILITY_RLF_UNIT_PAUSE_DURATION = ConvertAbilityRealLevelField('Prg4')
ABILITY_RLF_HERO_PAUSE_DURATION = ConvertAbilityRealLevelField('Prg5')
ABILITY_RLF_HIT_POINTS_GAINED_REJ1 = ConvertAbilityRealLevelField('Rej1')
ABILITY_RLF_MANA_POINTS_GAINED_REJ2 = ConvertAbilityRealLevelField('Rej2')
ABILITY_RLF_MINIMUM_LIFE_REQUIRED = ConvertAbilityRealLevelField('Rpb3')
ABILITY_RLF_MINIMUM_MANA_REQUIRED = ConvertAbilityRealLevelField('Rpb4')
ABILITY_RLF_REPAIR_COST_RATIO = ConvertAbilityRealLevelField('Rep1')
ABILITY_RLF_REPAIR_TIME_RATIO = ConvertAbilityRealLevelField('Rep2')
ABILITY_RLF_POWERBUILD_COST = ConvertAbilityRealLevelField('Rep3')
ABILITY_RLF_POWERBUILD_RATE = ConvertAbilityRealLevelField('Rep4')
ABILITY_RLF_NAVAL_RANGE_BONUS = ConvertAbilityRealLevelField('Rep5')
ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1 = ConvertAbilityRealLevelField('Roa1')
ABILITY_RLF_LIFE_REGENERATION_RATE = ConvertAbilityRealLevelField('Roa3')
ABILITY_RLF_MANA_REGEN = ConvertAbilityRealLevelField('Roa4')
ABILITY_RLF_DAMAGE_INCREASE = ConvertAbilityRealLevelField('Nbr1')
ABILITY_RLF_SALVAGE_COST_RATIO = ConvertAbilityRealLevelField('Sal1')
ABILITY_RLF_IN_FLIGHT_SIGHT_RADIUS = ConvertAbilityRealLevelField('Esn1')
ABILITY_RLF_HOVERING_SIGHT_RADIUS = ConvertAbilityRealLevelField('Esn2')
ABILITY_RLF_HOVERING_HEIGHT = ConvertAbilityRealLevelField('Esn3')
ABILITY_RLF_DURATION_OF_OWLS = ConvertAbilityRealLevelField('Esn5')
ABILITY_RLF_FADE_DURATION = ConvertAbilityRealLevelField('Shm1')
ABILITY_RLF_DAY_NIGHT_DURATION = ConvertAbilityRealLevelField('Shm2')
ABILITY_RLF_ACTION_DURATION = ConvertAbilityRealLevelField('Shm3')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SLO1 = ConvertAbilityRealLevelField('Slo1')
ABILITY_RLF_ATTACK_SPEED_FACTOR_SLO2 = ConvertAbilityRealLevelField('Slo2')
ABILITY_RLF_DAMAGE_PER_SECOND_SPO1 = ConvertAbilityRealLevelField('Spo1')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SPO2 = ConvertAbilityRealLevelField('Spo2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_SPO3 = ConvertAbilityRealLevelField('Spo3')
ABILITY_RLF_ACTIVATION_DELAY_STA1 = ConvertAbilityRealLevelField('Sta1')
ABILITY_RLF_DETECTION_RADIUS_STA2 = ConvertAbilityRealLevelField('Sta2')
ABILITY_RLF_DETONATION_RADIUS = ConvertAbilityRealLevelField('Sta3')
ABILITY_RLF_STUN_DURATION_STA4 = ConvertAbilityRealLevelField('Sta4')
ABILITY_RLF_ATTACK_SPEED_BONUS_PERCENT = ConvertAbilityRealLevelField('Uhf1')
ABILITY_RLF_DAMAGE_PER_SECOND_UHF2 = ConvertAbilityRealLevelField('Uhf2')
ABILITY_RLF_LUMBER_PER_INTERVAL = ConvertAbilityRealLevelField('Wha1')
ABILITY_RLF_ART_ATTACHMENT_HEIGHT = ConvertAbilityRealLevelField('Wha3')
ABILITY_RLF_TELEPORT_AREA_WIDTH = ConvertAbilityRealLevelField('Wrp1')
ABILITY_RLF_TELEPORT_AREA_HEIGHT = ConvertAbilityRealLevelField('Wrp2')
ABILITY_RLF_LIFE_STOLEN_PER_ATTACK = ConvertAbilityRealLevelField('Ivam')
ABILITY_RLF_DAMAGE_BONUS_IDAM = ConvertAbilityRealLevelField('Idam')
ABILITY_RLF_CHANCE_TO_HIT_UNITS_PERCENT = ConvertAbilityRealLevelField('Iob2')
ABILITY_RLF_CHANCE_TO_HIT_HEROS_PERCENT = ConvertAbilityRealLevelField('Iob3')
ABILITY_RLF_CHANCE_TO_HIT_SUMMONS_PERCENT = ConvertAbilityRealLevelField('Iob4')
ABILITY_RLF_DELAY_FOR_TARGET_EFFECT = ConvertAbilityRealLevelField('Idel')
ABILITY_RLF_DAMAGE_DEALT_PERCENT_OF_NORMAL = ConvertAbilityRealLevelField('Iild')
ABILITY_RLF_DAMAGE_RECEIVED_MULTIPLIER = ConvertAbilityRealLevelField('Iilw')
ABILITY_RLF_MANA_REGENERATION_BONUS_AS_FRACTION_OF_NORMAL = ConvertAbilityRealLevelField('Imrp')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_ISPI = ConvertAbilityRealLevelField('Ispi')
ABILITY_RLF_DAMAGE_PER_SECOND_IDPS = ConvertAbilityRealLevelField('Idps')
ABILITY_RLF_ATTACK_DAMAGE_INCREASE_CAC1 = ConvertAbilityRealLevelField('Cac1')
ABILITY_RLF_DAMAGE_PER_SECOND_COR1 = ConvertAbilityRealLevelField('Cor1')
ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1 = ConvertAbilityRealLevelField('Isx1')
ABILITY_RLF_DAMAGE_WRS1 = ConvertAbilityRealLevelField('Wrs1')
ABILITY_RLF_TERRAIN_DEFORMATION_AMPLITUDE = ConvertAbilityRealLevelField('Wrs2')
ABILITY_RLF_DAMAGE_CTC1 = ConvertAbilityRealLevelField('Ctc1')
ABILITY_RLF_EXTRA_DAMAGE_TO_TARGET = ConvertAbilityRealLevelField('Ctc2')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_CTC3 = ConvertAbilityRealLevelField('Ctc3')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_CTC4 = ConvertAbilityRealLevelField('Ctc4')
ABILITY_RLF_DAMAGE_CTB1 = ConvertAbilityRealLevelField('Ctb1')
ABILITY_RLF_CASTING_DELAY_SECONDS = ConvertAbilityRealLevelField('Uds2')
ABILITY_RLF_MANA_LOSS_PER_UNIT_DTN1 = ConvertAbilityRealLevelField('Dtn1')
ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_DTN2 = ConvertAbilityRealLevelField('Dtn2')
ABILITY_RLF_TRANSITION_TIME_SECONDS = ConvertAbilityRealLevelField('Ivs1')
ABILITY_RLF_MANA_DRAINED_PER_SECOND_NMR1 = ConvertAbilityRealLevelField('Nmr1')
ABILITY_RLF_CHANCE_TO_REDUCE_DAMAGE_PERCENT = ConvertAbilityRealLevelField('Ssk1')
ABILITY_RLF_MINIMUM_DAMAGE = ConvertAbilityRealLevelField('Ssk2')
ABILITY_RLF_IGNORED_DAMAGE = ConvertAbilityRealLevelField('Ssk3')
ABILITY_RLF_FULL_DAMAGE_DEALT = ConvertAbilityRealLevelField('Hfs1')
ABILITY_RLF_FULL_DAMAGE_INTERVAL = ConvertAbilityRealLevelField('Hfs2')
ABILITY_RLF_HALF_DAMAGE_DEALT = ConvertAbilityRealLevelField('Hfs3')
ABILITY_RLF_HALF_DAMAGE_INTERVAL = ConvertAbilityRealLevelField('Hfs4')
ABILITY_RLF_BUILDING_REDUCTION_HFS5 = ConvertAbilityRealLevelField('Hfs5')
ABILITY_RLF_MAXIMUM_DAMAGE_HFS6 = ConvertAbilityRealLevelField('Hfs6')
ABILITY_RLF_MANA_PER_HIT_POINT = ConvertAbilityRealLevelField('Nms1')
ABILITY_RLF_DAMAGE_ABSORBED_PERCENT = ConvertAbilityRealLevelField('Nms2')
ABILITY_RLF_WAVE_DISTANCE = ConvertAbilityRealLevelField('Uim1')
ABILITY_RLF_WAVE_TIME_SECONDS = ConvertAbilityRealLevelField('Uim2')
ABILITY_RLF_DAMAGE_DEALT_UIM3 = ConvertAbilityRealLevelField('Uim3')
ABILITY_RLF_AIR_TIME_SECONDS_UIM4 = ConvertAbilityRealLevelField('Uim4')
ABILITY_RLF_UNIT_RELEASE_INTERVAL_SECONDS = ConvertAbilityRealLevelField('Uls2')
ABILITY_RLF_DAMAGE_RETURN_FACTOR = ConvertAbilityRealLevelField('Uls4')
ABILITY_RLF_DAMAGE_RETURN_THRESHOLD = ConvertAbilityRealLevelField('Uls5')
ABILITY_RLF_RETURNED_DAMAGE_FACTOR = ConvertAbilityRealLevelField('Uts1')
ABILITY_RLF_RECEIVED_DAMAGE_FACTOR = ConvertAbilityRealLevelField('Uts2')
ABILITY_RLF_DEFENSE_BONUS_UTS3 = ConvertAbilityRealLevelField('Uts3')
ABILITY_RLF_DAMAGE_BONUS_NBA1 = ConvertAbilityRealLevelField('Nba1')
ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NBA3 = ConvertAbilityRealLevelField('Nba3')
ABILITY_RLF_MANA_PER_SUMMONED_HITPOINT = ConvertAbilityRealLevelField('Cmg2')
ABILITY_RLF_CHARGE_FOR_CURRENT_LIFE = ConvertAbilityRealLevelField('Cmg3')
ABILITY_RLF_HIT_POINTS_DRAINED = ConvertAbilityRealLevelField('Ndr1')
ABILITY_RLF_MANA_POINTS_DRAINED = ConvertAbilityRealLevelField('Ndr2')
ABILITY_RLF_DRAIN_INTERVAL_SECONDS = ConvertAbilityRealLevelField('Ndr3')
ABILITY_RLF_LIFE_TRANSFERRED_PER_SECOND = ConvertAbilityRealLevelField('Ndr4')
ABILITY_RLF_MANA_TRANSFERRED_PER_SECOND = ConvertAbilityRealLevelField('Ndr5')
ABILITY_RLF_BONUS_LIFE_FACTOR = ConvertAbilityRealLevelField('Ndr6')
ABILITY_RLF_BONUS_LIFE_DECAY = ConvertAbilityRealLevelField('Ndr7')
ABILITY_RLF_BONUS_MANA_FACTOR = ConvertAbilityRealLevelField('Ndr8')
ABILITY_RLF_BONUS_MANA_DECAY = ConvertAbilityRealLevelField('Ndr9')
ABILITY_RLF_CHANCE_TO_MISS_PERCENT = ConvertAbilityRealLevelField('Nsi2')
ABILITY_RLF_MOVEMENT_SPEED_MODIFIER = ConvertAbilityRealLevelField('Nsi3')
ABILITY_RLF_ATTACK_SPEED_MODIFIER = ConvertAbilityRealLevelField('Nsi4')
ABILITY_RLF_DAMAGE_PER_SECOND_TDG1 = ConvertAbilityRealLevelField('Tdg1')
ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_TDG2 = ConvertAbilityRealLevelField('Tdg2')
ABILITY_RLF_MEDIUM_DAMAGE_PER_SECOND = ConvertAbilityRealLevelField('Tdg3')
ABILITY_RLF_SMALL_DAMAGE_RADIUS_TDG4 = ConvertAbilityRealLevelField('Tdg4')
ABILITY_RLF_SMALL_DAMAGE_PER_SECOND = ConvertAbilityRealLevelField('Tdg5')
ABILITY_RLF_AIR_TIME_SECONDS_TSP1 = ConvertAbilityRealLevelField('Tsp1')
ABILITY_RLF_MINIMUM_HIT_INTERVAL_SECONDS = ConvertAbilityRealLevelField('Tsp2')
ABILITY_RLF_DAMAGE_PER_SECOND_NBF5 = ConvertAbilityRealLevelField('Nbf5')
ABILITY_RLF_MAXIMUM_RANGE = ConvertAbilityRealLevelField('Ebl1')
ABILITY_RLF_MINIMUM_RANGE = ConvertAbilityRealLevelField('Ebl2')
ABILITY_RLF_DAMAGE_PER_TARGET_EFK1 = ConvertAbilityRealLevelField('Efk1')
ABILITY_RLF_MAXIMUM_TOTAL_DAMAGE = ConvertAbilityRealLevelField('Efk2')
ABILITY_RLF_MAXIMUM_SPEED_ADJUSTMENT = ConvertAbilityRealLevelField('Efk4')
ABILITY_RLF_DECAYING_DAMAGE = ConvertAbilityRealLevelField('Esh1')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_ESH2 = ConvertAbilityRealLevelField('Esh2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_ESH3 = ConvertAbilityRealLevelField('Esh3')
ABILITY_RLF_DECAY_POWER = ConvertAbilityRealLevelField('Esh4')
ABILITY_RLF_INITIAL_DAMAGE_ESH5 = ConvertAbilityRealLevelField('Esh5')
ABILITY_RLF_MAXIMUM_LIFE_ABSORBED = ConvertAbilityRealLevelField('abs1')
ABILITY_RLF_MAXIMUM_MANA_ABSORBED = ConvertAbilityRealLevelField('abs2')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_BSK1 = ConvertAbilityRealLevelField('bsk1')
ABILITY_RLF_ATTACK_SPEED_INCREASE_BSK2 = ConvertAbilityRealLevelField('bsk2')
ABILITY_RLF_DAMAGE_TAKEN_INCREASE = ConvertAbilityRealLevelField('bsk3')
ABILITY_RLF_LIFE_PER_UNIT = ConvertAbilityRealLevelField('dvm1')
ABILITY_RLF_MANA_PER_UNIT = ConvertAbilityRealLevelField('dvm2')
ABILITY_RLF_LIFE_PER_BUFF = ConvertAbilityRealLevelField('dvm3')
ABILITY_RLF_MANA_PER_BUFF = ConvertAbilityRealLevelField('dvm4')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_DVM5 = ConvertAbilityRealLevelField('dvm5')
ABILITY_RLF_DAMAGE_BONUS_FAK1 = ConvertAbilityRealLevelField('fak1')
ABILITY_RLF_MEDIUM_DAMAGE_FACTOR_FAK2 = ConvertAbilityRealLevelField('fak2')
ABILITY_RLF_SMALL_DAMAGE_FACTOR_FAK3 = ConvertAbilityRealLevelField('fak3')
ABILITY_RLF_FULL_DAMAGE_RADIUS_FAK4 = ConvertAbilityRealLevelField('fak4')
ABILITY_RLF_HALF_DAMAGE_RADIUS_FAK5 = ConvertAbilityRealLevelField('fak5')
ABILITY_RLF_EXTRA_DAMAGE_PER_SECOND = ConvertAbilityRealLevelField('liq1')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_LIQ2 = ConvertAbilityRealLevelField('liq2')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_LIQ3 = ConvertAbilityRealLevelField('liq3')
ABILITY_RLF_MAGIC_DAMAGE_FACTOR = ConvertAbilityRealLevelField('mim1')
ABILITY_RLF_UNIT_DAMAGE_PER_MANA_POINT = ConvertAbilityRealLevelField('mfl1')
ABILITY_RLF_HERO_DAMAGE_PER_MANA_POINT = ConvertAbilityRealLevelField('mfl2')
ABILITY_RLF_UNIT_MAXIMUM_DAMAGE = ConvertAbilityRealLevelField('mfl3')
ABILITY_RLF_HERO_MAXIMUM_DAMAGE = ConvertAbilityRealLevelField('mfl4')
ABILITY_RLF_DAMAGE_COOLDOWN = ConvertAbilityRealLevelField('mfl5')
ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_SPL1 = ConvertAbilityRealLevelField('spl1')
ABILITY_RLF_LIFE_REGENERATED = ConvertAbilityRealLevelField('irl1')
ABILITY_RLF_MANA_REGENERATED = ConvertAbilityRealLevelField('irl2')
ABILITY_RLF_MANA_LOSS_PER_UNIT_IDC1 = ConvertAbilityRealLevelField('idc1')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_IDC2 = ConvertAbilityRealLevelField('idc2')
ABILITY_RLF_ACTIVATION_DELAY_IMO2 = ConvertAbilityRealLevelField('imo2')
ABILITY_RLF_LURE_INTERVAL_SECONDS = ConvertAbilityRealLevelField('imo3')
ABILITY_RLF_DAMAGE_BONUS_ISR1 = ConvertAbilityRealLevelField('isr1')
ABILITY_RLF_DAMAGE_REDUCTION_ISR2 = ConvertAbilityRealLevelField('isr2')
ABILITY_RLF_DAMAGE_BONUS_IPV1 = ConvertAbilityRealLevelField('ipv1')
ABILITY_RLF_LIFE_STEAL_AMOUNT = ConvertAbilityRealLevelField('ipv2')
ABILITY_RLF_LIFE_RESTORED_FACTOR = ConvertAbilityRealLevelField('ast1')
ABILITY_RLF_MANA_RESTORED_FACTOR = ConvertAbilityRealLevelField('ast2')
ABILITY_RLF_ATTACH_DELAY = ConvertAbilityRealLevelField('gra1')
ABILITY_RLF_REMOVE_DELAY = ConvertAbilityRealLevelField('gra2')
ABILITY_RLF_HERO_REGENERATION_DELAY = ConvertAbilityRealLevelField('Nsa2')
ABILITY_RLF_UNIT_REGENERATION_DELAY = ConvertAbilityRealLevelField('Nsa3')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_NSA4 = ConvertAbilityRealLevelField('Nsa4')
ABILITY_RLF_HIT_POINTS_PER_SECOND_NSA5 = ConvertAbilityRealLevelField('Nsa5')
ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_IXS1 = ConvertAbilityRealLevelField('Ixs1')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_IXS2 = ConvertAbilityRealLevelField('Ixs2')
ABILITY_RLF_SUMMONED_UNIT_DURATION = ConvertAbilityRealLevelField('Npa6')
ABILITY_RLF_SHIELD_COOLDOWN_TIME = ConvertAbilityRealLevelField('Nse1')
ABILITY_RLF_DAMAGE_PER_SECOND_NDO1 = ConvertAbilityRealLevelField('Ndo1')
ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NDO3 = ConvertAbilityRealLevelField('Ndo3')
ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_FLK1 = ConvertAbilityRealLevelField('flk1')
ABILITY_RLF_SMALL_DAMAGE_RADIUS_FLK2 = ConvertAbilityRealLevelField('flk2')
ABILITY_RLF_FULL_DAMAGE_AMOUNT_FLK3 = ConvertAbilityRealLevelField('flk3')
ABILITY_RLF_MEDIUM_DAMAGE_AMOUNT = ConvertAbilityRealLevelField('flk4')
ABILITY_RLF_SMALL_DAMAGE_AMOUNT = ConvertAbilityRealLevelField('flk5')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HBN1 = ConvertAbilityRealLevelField('Hbn1')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HBN2 = ConvertAbilityRealLevelField('Hbn2')
ABILITY_RLF_MAX_MANA_DRAINED_UNITS = ConvertAbilityRealLevelField('fbk1')
ABILITY_RLF_DAMAGE_RATIO_UNITS_PERCENT = ConvertAbilityRealLevelField('fbk2')
ABILITY_RLF_MAX_MANA_DRAINED_HEROS = ConvertAbilityRealLevelField('fbk3')
ABILITY_RLF_DAMAGE_RATIO_HEROS_PERCENT = ConvertAbilityRealLevelField('fbk4')
ABILITY_RLF_SUMMONED_DAMAGE = ConvertAbilityRealLevelField('fbk5')
ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_NCA1 = ConvertAbilityRealLevelField('nca1')
ABILITY_RLF_INITIAL_DAMAGE_PXF1 = ConvertAbilityRealLevelField('pxf1')
ABILITY_RLF_DAMAGE_PER_SECOND_PXF2 = ConvertAbilityRealLevelField('pxf2')
ABILITY_RLF_DAMAGE_PER_SECOND_MLS1 = ConvertAbilityRealLevelField('mls1')
ABILITY_RLF_BEAST_COLLISION_RADIUS = ConvertAbilityRealLevelField('Nst2')
ABILITY_RLF_DAMAGE_AMOUNT_NST3 = ConvertAbilityRealLevelField('Nst3')
ABILITY_RLF_DAMAGE_RADIUS = ConvertAbilityRealLevelField('Nst4')
ABILITY_RLF_DAMAGE_DELAY = ConvertAbilityRealLevelField('Nst5')
ABILITY_RLF_FOLLOW_THROUGH_TIME = ConvertAbilityRealLevelField('Ncl1')
ABILITY_RLF_ART_DURATION = ConvertAbilityRealLevelField('Ncl4')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NAB1 = ConvertAbilityRealLevelField('Nab1')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NAB2 = ConvertAbilityRealLevelField('Nab2')
ABILITY_RLF_PRIMARY_DAMAGE = ConvertAbilityRealLevelField('Nab4')
ABILITY_RLF_SECONDARY_DAMAGE = ConvertAbilityRealLevelField('Nab5')
ABILITY_RLF_DAMAGE_INTERVAL_NAB6 = ConvertAbilityRealLevelField('Nab6')
ABILITY_RLF_GOLD_COST_FACTOR = ConvertAbilityRealLevelField('Ntm1')
ABILITY_RLF_LUMBER_COST_FACTOR = ConvertAbilityRealLevelField('Ntm2')
ABILITY_RLF_MOVE_SPEED_BONUS_NEG1 = ConvertAbilityRealLevelField('Neg1')
ABILITY_RLF_DAMAGE_BONUS_NEG2 = ConvertAbilityRealLevelField('Neg2')
ABILITY_RLF_DAMAGE_AMOUNT_NCS1 = ConvertAbilityRealLevelField('Ncs1')
ABILITY_RLF_DAMAGE_INTERVAL_NCS2 = ConvertAbilityRealLevelField('Ncs2')
ABILITY_RLF_MAX_DAMAGE_NCS4 = ConvertAbilityRealLevelField('Ncs4')
ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NCS5 = ConvertAbilityRealLevelField('Ncs5')
ABILITY_RLF_EFFECT_DURATION = ConvertAbilityRealLevelField('Ncs6')
ABILITY_RLF_SPAWN_INTERVAL_NSY1 = ConvertAbilityRealLevelField('Nsy1')
ABILITY_RLF_SPAWN_UNIT_DURATION = ConvertAbilityRealLevelField('Nsy3')
ABILITY_RLF_SPAWN_UNIT_OFFSET = ConvertAbilityRealLevelField('Nsy4')
ABILITY_RLF_LEASH_RANGE_NSY5 = ConvertAbilityRealLevelField('Nsy5')
ABILITY_RLF_SPAWN_INTERVAL_NFY1 = ConvertAbilityRealLevelField('Nfy1')
ABILITY_RLF_LEASH_RANGE_NFY2 = ConvertAbilityRealLevelField('Nfy2')
ABILITY_RLF_CHANCE_TO_DEMOLISH = ConvertAbilityRealLevelField('Nde1')
ABILITY_RLF_DAMAGE_MULTIPLIER_BUILDINGS = ConvertAbilityRealLevelField('Nde2')
ABILITY_RLF_DAMAGE_MULTIPLIER_UNITS = ConvertAbilityRealLevelField('Nde3')
ABILITY_RLF_DAMAGE_MULTIPLIER_HEROES = ConvertAbilityRealLevelField('Nde4')
ABILITY_RLF_BONUS_DAMAGE_MULTIPLIER = ConvertAbilityRealLevelField('Nic1')
ABILITY_RLF_DEATH_DAMAGE_FULL_AMOUNT = ConvertAbilityRealLevelField('Nic2')
ABILITY_RLF_DEATH_DAMAGE_FULL_AREA = ConvertAbilityRealLevelField('Nic3')
ABILITY_RLF_DEATH_DAMAGE_HALF_AMOUNT = ConvertAbilityRealLevelField('Nic4')
ABILITY_RLF_DEATH_DAMAGE_HALF_AREA = ConvertAbilityRealLevelField('Nic5')
ABILITY_RLF_DEATH_DAMAGE_DELAY = ConvertAbilityRealLevelField('Nic6')
ABILITY_RLF_DAMAGE_AMOUNT_NSO1 = ConvertAbilityRealLevelField('Nso1')
ABILITY_RLF_DAMAGE_PERIOD = ConvertAbilityRealLevelField('Nso2')
ABILITY_RLF_DAMAGE_PENALTY = ConvertAbilityRealLevelField('Nso3')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NSO4 = ConvertAbilityRealLevelField('Nso4')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NSO5 = ConvertAbilityRealLevelField('Nso5')
ABILITY_RLF_SPLIT_DELAY = ConvertAbilityRealLevelField('Nlm2')
ABILITY_RLF_MAX_HITPOINT_FACTOR = ConvertAbilityRealLevelField('Nlm4')
ABILITY_RLF_LIFE_DURATION_SPLIT_BONUS = ConvertAbilityRealLevelField('Nlm5')
ABILITY_RLF_WAVE_INTERVAL = ConvertAbilityRealLevelField('Nvc3')
ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NVC4 = ConvertAbilityRealLevelField('Nvc4')
ABILITY_RLF_FULL_DAMAGE_AMOUNT_NVC5 = ConvertAbilityRealLevelField('Nvc5')
ABILITY_RLF_HALF_DAMAGE_FACTOR = ConvertAbilityRealLevelField('Nvc6')
ABILITY_RLF_INTERVAL_BETWEEN_PULSES = ConvertAbilityRealLevelField('Tau5')
ABILITY_BLF_PERCENT_BONUS_HAB2 = ConvertAbilityBooleanLevelField('Hab2')
ABILITY_BLF_USE_TELEPORT_CLUSTERING_HMT3 = ConvertAbilityBooleanLevelField('Hmt3')
ABILITY_BLF_NEVER_MISS_OCR5 = ConvertAbilityBooleanLevelField('Ocr5')
ABILITY_BLF_EXCLUDE_ITEM_DAMAGE = ConvertAbilityBooleanLevelField('Ocr6')
ABILITY_BLF_BACKSTAB_DAMAGE = ConvertAbilityBooleanLevelField('Owk4')
ABILITY_BLF_INHERIT_UPGRADES_UAN3 = ConvertAbilityBooleanLevelField('Uan3')
ABILITY_BLF_MANA_CONVERSION_AS_PERCENT = ConvertAbilityBooleanLevelField('Udp3')
ABILITY_BLF_LIFE_CONVERSION_AS_PERCENT = ConvertAbilityBooleanLevelField('Udp4')
ABILITY_BLF_LEAVE_TARGET_ALIVE = ConvertAbilityBooleanLevelField('Udp5')
ABILITY_BLF_PERCENT_BONUS_UAU3 = ConvertAbilityBooleanLevelField('Uau3')
ABILITY_BLF_DAMAGE_IS_PERCENT_RECEIVED = ConvertAbilityBooleanLevelField('Eah2')
ABILITY_BLF_MELEE_BONUS = ConvertAbilityBooleanLevelField('Ear2')
ABILITY_BLF_RANGED_BONUS = ConvertAbilityBooleanLevelField('Ear3')
ABILITY_BLF_FLAT_BONUS = ConvertAbilityBooleanLevelField('Ear4')
ABILITY_BLF_NEVER_MISS_HBH5 = ConvertAbilityBooleanLevelField('Hbh5')
ABILITY_BLF_PERCENT_BONUS_HAD2 = ConvertAbilityBooleanLevelField('Had2')
ABILITY_BLF_CAN_DEACTIVATE = ConvertAbilityBooleanLevelField('Hds1')
ABILITY_BLF_RAISED_UNITS_ARE_INVULNERABLE = ConvertAbilityBooleanLevelField('Hre2')
ABILITY_BLF_PERCENTAGE_OAR2 = ConvertAbilityBooleanLevelField('Oar2')
ABILITY_BLF_SUMMON_BUSY_UNITS = ConvertAbilityBooleanLevelField('Btl2')
ABILITY_BLF_CREATES_BLIGHT = ConvertAbilityBooleanLevelField('Bli2')
ABILITY_BLF_EXPLODES_ON_DEATH = ConvertAbilityBooleanLevelField('Sds6')
ABILITY_BLF_ALWAYS_AUTOCAST_FAE2 = ConvertAbilityBooleanLevelField('Fae2')
ABILITY_BLF_REGENERATE_ONLY_AT_NIGHT = ConvertAbilityBooleanLevelField('Mbt5')
ABILITY_BLF_SHOW_SELECT_UNIT_BUTTON = ConvertAbilityBooleanLevelField('Neu3')
ABILITY_BLF_SHOW_UNIT_INDICATOR = ConvertAbilityBooleanLevelField('Neu4')
ABILITY_BLF_CHARGE_OWNING_PLAYER = ConvertAbilityBooleanLevelField('Ans6')
ABILITY_BLF_PERCENTAGE_ARM2 = ConvertAbilityBooleanLevelField('Arm2')
ABILITY_BLF_TARGET_IS_INVULNERABLE = ConvertAbilityBooleanLevelField('Pos3')
ABILITY_BLF_TARGET_IS_MAGIC_IMMUNE = ConvertAbilityBooleanLevelField('Pos4')
ABILITY_BLF_KILL_ON_CASTER_DEATH = ConvertAbilityBooleanLevelField('Ucb6')
ABILITY_BLF_NO_TARGET_REQUIRED_REJ4 = ConvertAbilityBooleanLevelField('Rej4')
ABILITY_BLF_ACCEPTS_GOLD = ConvertAbilityBooleanLevelField('Rtn1')
ABILITY_BLF_ACCEPTS_LUMBER = ConvertAbilityBooleanLevelField('Rtn2')
ABILITY_BLF_PREFER_HOSTILES_ROA5 = ConvertAbilityBooleanLevelField('Roa5')
ABILITY_BLF_PREFER_FRIENDLIES_ROA6 = ConvertAbilityBooleanLevelField('Roa6')
ABILITY_BLF_ROOTED_TURNING = ConvertAbilityBooleanLevelField('Roo3')
ABILITY_BLF_ALWAYS_AUTOCAST_SLO3 = ConvertAbilityBooleanLevelField('Slo3')
ABILITY_BLF_HIDE_BUTTON = ConvertAbilityBooleanLevelField('Ihid')
ABILITY_BLF_USE_TELEPORT_CLUSTERING_ITP2 = ConvertAbilityBooleanLevelField('Itp2')
ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS = ConvertAbilityBooleanLevelField('Eth1')
ABILITY_BLF_DOES_NOT_BLOCK_BUILDINGS = ConvertAbilityBooleanLevelField('Eth2')
ABILITY_BLF_AUTO_ACQUIRE_ATTACK_TARGETS = ConvertAbilityBooleanLevelField('Gho1')
ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS_GHO2 = ConvertAbilityBooleanLevelField('Gho2')
ABILITY_BLF_DO_NOT_BLOCK_BUILDINGS = ConvertAbilityBooleanLevelField('Gho3')
ABILITY_BLF_INCLUDE_RANGED_DAMAGE = ConvertAbilityBooleanLevelField('Ssk4')
ABILITY_BLF_INCLUDE_MELEE_DAMAGE = ConvertAbilityBooleanLevelField('Ssk5')
ABILITY_BLF_MOVE_TO_PARTNER = ConvertAbilityBooleanLevelField('coa2')
ABILITY_BLF_CAN_BE_DISPELLED = ConvertAbilityBooleanLevelField('cyc1')
ABILITY_BLF_IGNORE_FRIENDLY_BUFFS = ConvertAbilityBooleanLevelField('dvm6')
ABILITY_BLF_DROP_ITEMS_ON_DEATH = ConvertAbilityBooleanLevelField('inv2')
ABILITY_BLF_CAN_USE_ITEMS = ConvertAbilityBooleanLevelField('inv3')
ABILITY_BLF_CAN_GET_ITEMS = ConvertAbilityBooleanLevelField('inv4')
ABILITY_BLF_CAN_DROP_ITEMS = ConvertAbilityBooleanLevelField('inv5')
ABILITY_BLF_REPAIRS_ALLOWED = ConvertAbilityBooleanLevelField('liq4')
ABILITY_BLF_CASTER_ONLY_SPLASH = ConvertAbilityBooleanLevelField('mfl6')
ABILITY_BLF_NO_TARGET_REQUIRED_IRL4 = ConvertAbilityBooleanLevelField('irl4')
ABILITY_BLF_DISPEL_ON_ATTACK = ConvertAbilityBooleanLevelField('irl5')
ABILITY_BLF_AMOUNT_IS_RAW_VALUE = ConvertAbilityBooleanLevelField('ipv3')
ABILITY_BLF_SHARED_SPELL_COOLDOWN = ConvertAbilityBooleanLevelField('spb2')
ABILITY_BLF_SLEEP_ONCE = ConvertAbilityBooleanLevelField('sla1')
ABILITY_BLF_ALLOW_ON_ANY_PLAYER_SLOT = ConvertAbilityBooleanLevelField('sla2')
ABILITY_BLF_DISABLE_OTHER_ABILITIES = ConvertAbilityBooleanLevelField('Ncl5')
ABILITY_BLF_ALLOW_BOUNTY = ConvertAbilityBooleanLevelField('Ntm4')
ABILITY_SLF_ICON_NORMAL = ConvertAbilityStringLevelField('aart')
ABILITY_SLF_CASTER = ConvertAbilityStringLevelField('acat')
ABILITY_SLF_TARGET = ConvertAbilityStringLevelField('atat')
ABILITY_SLF_SPECIAL = ConvertAbilityStringLevelField('asat')
ABILITY_SLF_EFFECT = ConvertAbilityStringLevelField('aeat')
ABILITY_SLF_AREA_EFFECT = ConvertAbilityStringLevelField('aaea')
ABILITY_SLF_LIGHTNING_EFFECTS = ConvertAbilityStringLevelField('alig')
ABILITY_SLF_MISSILE_ART = ConvertAbilityStringLevelField('amat')
ABILITY_SLF_TOOLTIP_LEARN = ConvertAbilityStringLevelField('aret')
ABILITY_SLF_TOOLTIP_LEARN_EXTENDED = ConvertAbilityStringLevelField('arut')
ABILITY_SLF_TOOLTIP_NORMAL = ConvertAbilityStringLevelField('atp1')
ABILITY_SLF_TOOLTIP_TURN_OFF = ConvertAbilityStringLevelField('aut1')
ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED = ConvertAbilityStringLevelField('aub1')
ABILITY_SLF_TOOLTIP_TURN_OFF_EXTENDED = ConvertAbilityStringLevelField('auu1')
ABILITY_SLF_NORMAL_FORM_UNIT_EME1 = ConvertAbilityStringLevelField('Eme1')
ABILITY_SLF_SPAWNED_UNITS = ConvertAbilityStringLevelField('Ndp1')
ABILITY_SLF_ABILITY_FOR_UNIT_CREATION = ConvertAbilityStringLevelField('Nrc1')
ABILITY_SLF_NORMAL_FORM_UNIT_MIL1 = ConvertAbilityStringLevelField('Mil1')
ABILITY_SLF_ALTERNATE_FORM_UNIT_MIL2 = ConvertAbilityStringLevelField('Mil2')
ABILITY_SLF_BASE_ORDER_ID_ANS5 = ConvertAbilityStringLevelField('Ans5')
ABILITY_SLF_MORPH_UNITS_GROUND = ConvertAbilityStringLevelField('Ply2')
ABILITY_SLF_MORPH_UNITS_AIR = ConvertAbilityStringLevelField('Ply3')
ABILITY_SLF_MORPH_UNITS_AMPHIBIOUS = ConvertAbilityStringLevelField('Ply4')
ABILITY_SLF_MORPH_UNITS_WATER = ConvertAbilityStringLevelField('Ply5')
ABILITY_SLF_UNIT_TYPE_ONE = ConvertAbilityStringLevelField('Rai3')
ABILITY_SLF_UNIT_TYPE_TWO = ConvertAbilityStringLevelField('Rai4')
ABILITY_SLF_UNIT_TYPE_SOD2 = ConvertAbilityStringLevelField('Sod2')
ABILITY_SLF_SUMMON_1_UNIT_TYPE = ConvertAbilityStringLevelField('Ist1')
ABILITY_SLF_SUMMON_2_UNIT_TYPE = ConvertAbilityStringLevelField('Ist2')
ABILITY_SLF_RACE_TO_CONVERT = ConvertAbilityStringLevelField('Ndc1')
ABILITY_SLF_PARTNER_UNIT_TYPE = ConvertAbilityStringLevelField('coa1')
ABILITY_SLF_PARTNER_UNIT_TYPE_ONE = ConvertAbilityStringLevelField('dcp1')
ABILITY_SLF_PARTNER_UNIT_TYPE_TWO = ConvertAbilityStringLevelField('dcp2')
ABILITY_SLF_REQUIRED_UNIT_TYPE = ConvertAbilityStringLevelField('tpi1')
ABILITY_SLF_CONVERTED_UNIT_TYPE = ConvertAbilityStringLevelField('tpi2')
ABILITY_SLF_SPELL_LIST = ConvertAbilityStringLevelField('spb1')
ABILITY_SLF_BASE_ORDER_ID_SPB5 = ConvertAbilityStringLevelField('spb5')
ABILITY_SLF_BASE_ORDER_ID_NCL6 = ConvertAbilityStringLevelField('Ncl6')
ABILITY_SLF_ABILITY_UPGRADE_1 = ConvertAbilityStringLevelField('Neg3')
ABILITY_SLF_ABILITY_UPGRADE_2 = ConvertAbilityStringLevelField('Neg4')
ABILITY_SLF_ABILITY_UPGRADE_3 = ConvertAbilityStringLevelField('Neg5')
ABILITY_SLF_ABILITY_UPGRADE_4 = ConvertAbilityStringLevelField('Neg6')
ABILITY_SLF_SPAWN_UNIT_ID_NSY2 = ConvertAbilityStringLevelField('Nsy2')
ITEM_IF_LEVEL = ConvertItemIntegerField('ilev')
ITEM_IF_NUMBER_OF_CHARGES = ConvertItemIntegerField('iuse')
ITEM_IF_COOLDOWN_GROUP = ConvertItemIntegerField('icid')
ITEM_IF_MAX_HIT_POINTS = ConvertItemIntegerField('ihtp')
ITEM_IF_HIT_POINTS = ConvertItemIntegerField('ihpc')
ITEM_IF_PRIORITY = ConvertItemIntegerField('ipri')
ITEM_IF_ARMOR_TYPE = ConvertItemIntegerField('iarm')
ITEM_IF_TINTING_COLOR_RED = ConvertItemIntegerField('iclr')
ITEM_IF_TINTING_COLOR_GREEN = ConvertItemIntegerField('iclg')
ITEM_IF_TINTING_COLOR_BLUE = ConvertItemIntegerField('iclb')
ITEM_IF_TINTING_COLOR_ALPHA = ConvertItemIntegerField('ical')
ITEM_RF_SCALING_VALUE = ConvertItemRealField('isca')
ITEM_BF_DROPPED_WHEN_CARRIER_DIES = ConvertItemBooleanField('idrp')
ITEM_BF_CAN_BE_DROPPED = ConvertItemBooleanField('idro')
ITEM_BF_PERISHABLE = ConvertItemBooleanField('iper')
ITEM_BF_INCLUDE_AS_RANDOM_CHOICE = ConvertItemBooleanField('iprn')
ITEM_BF_USE_AUTOMATICALLY_WHEN_ACQUIRED = ConvertItemBooleanField('ipow')
ITEM_BF_CAN_BE_SOLD_TO_MERCHANTS = ConvertItemBooleanField('ipaw')
ITEM_BF_ACTIVELY_USED = ConvertItemBooleanField('iusa')
ITEM_SF_MODEL_USED = ConvertItemStringField('ifil')
UNIT_IF_DEFENSE_TYPE = ConvertUnitIntegerField('udty')
UNIT_IF_ARMOR_TYPE = ConvertUnitIntegerField('uarm')
UNIT_IF_LOOPING_FADE_IN_RATE = ConvertUnitIntegerField('ulfi')
UNIT_IF_LOOPING_FADE_OUT_RATE = ConvertUnitIntegerField('ulfo')
UNIT_IF_AGILITY = ConvertUnitIntegerField('uagc')
UNIT_IF_INTELLIGENCE = ConvertUnitIntegerField('uinc')
UNIT_IF_STRENGTH = ConvertUnitIntegerField('ustc')
UNIT_IF_AGILITY_PERMANENT = ConvertUnitIntegerField('uagm')
UNIT_IF_INTELLIGENCE_PERMANENT = ConvertUnitIntegerField('uinm')
UNIT_IF_STRENGTH_PERMANENT = ConvertUnitIntegerField('ustm')
UNIT_IF_AGILITY_WITH_BONUS = ConvertUnitIntegerField('uagb')
UNIT_IF_INTELLIGENCE_WITH_BONUS = ConvertUnitIntegerField('uinb')
UNIT_IF_STRENGTH_WITH_BONUS = ConvertUnitIntegerField('ustb')
UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE = ConvertUnitIntegerField('ubdi')
UNIT_IF_GOLD_BOUNTY_AWARDED_BASE = ConvertUnitIntegerField('ubba')
UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE = ConvertUnitIntegerField('ubsi')
UNIT_IF_LUMBER_BOUNTY_AWARDED_NUMBER_OF_DICE = ConvertUnitIntegerField('ulbd')
UNIT_IF_LUMBER_BOUNTY_AWARDED_BASE = ConvertUnitIntegerField('ulba')
UNIT_IF_LUMBER_BOUNTY_AWARDED_SIDES_PER_DIE = ConvertUnitIntegerField('ulbs')
UNIT_IF_LEVEL = ConvertUnitIntegerField('ulev')
UNIT_IF_FORMATION_RANK = ConvertUnitIntegerField('ufor')
UNIT_IF_ORIENTATION_INTERPOLATION = ConvertUnitIntegerField('uori')
UNIT_IF_ELEVATION_SAMPLE_POINTS = ConvertUnitIntegerField('uept')
UNIT_IF_TINTING_COLOR_RED = ConvertUnitIntegerField('uclr')
UNIT_IF_TINTING_COLOR_GREEN = ConvertUnitIntegerField('uclg')
UNIT_IF_TINTING_COLOR_BLUE = ConvertUnitIntegerField('uclb')
UNIT_IF_TINTING_COLOR_ALPHA = ConvertUnitIntegerField('ucal')
UNIT_IF_MOVE_TYPE = ConvertUnitIntegerField('umvt')
UNIT_IF_TARGETED_AS = ConvertUnitIntegerField('utar')
UNIT_IF_UNIT_CLASSIFICATION = ConvertUnitIntegerField('utyp')
UNIT_IF_HIT_POINTS_REGENERATION_TYPE = ConvertUnitIntegerField('uhrt')
UNIT_IF_PLACEMENT_PREVENTED_BY = ConvertUnitIntegerField('upar')
UNIT_IF_PRIMARY_ATTRIBUTE = ConvertUnitIntegerField('upra')
UNIT_RF_STRENGTH_PER_LEVEL = ConvertUnitRealField('ustp')
UNIT_RF_AGILITY_PER_LEVEL = ConvertUnitRealField('uagp')
UNIT_RF_INTELLIGENCE_PER_LEVEL = ConvertUnitRealField('uinp')
UNIT_RF_HIT_POINTS_REGENERATION_RATE = ConvertUnitRealField('uhpr')
UNIT_RF_MANA_REGENERATION = ConvertUnitRealField('umpr')
UNIT_RF_DEATH_TIME = ConvertUnitRealField('udtm')
UNIT_RF_FLY_HEIGHT = ConvertUnitRealField('ufyh')
UNIT_RF_TURN_RATE = ConvertUnitRealField('umvr')
UNIT_RF_ELEVATION_SAMPLE_RADIUS = ConvertUnitRealField('uerd')
UNIT_RF_FOG_OF_WAR_SAMPLE_RADIUS = ConvertUnitRealField('ufrd')
UNIT_RF_MAXIMUM_PITCH_ANGLE_DEGREES = ConvertUnitRealField('umxp')
UNIT_RF_MAXIMUM_ROLL_ANGLE_DEGREES = ConvertUnitRealField('umxr')
UNIT_RF_SCALING_VALUE = ConvertUnitRealField('usca')
UNIT_RF_ANIMATION_RUN_SPEED = ConvertUnitRealField('urun')
UNIT_RF_SELECTION_SCALE = ConvertUnitRealField('ussc')
UNIT_RF_SELECTION_CIRCLE_HEIGHT = ConvertUnitRealField('uslz')
UNIT_RF_SHADOW_IMAGE_HEIGHT = ConvertUnitRealField('ushh')
UNIT_RF_SHADOW_IMAGE_WIDTH = ConvertUnitRealField('ushw')
UNIT_RF_SHADOW_IMAGE_CENTER_X = ConvertUnitRealField('ushx')
UNIT_RF_SHADOW_IMAGE_CENTER_Y = ConvertUnitRealField('ushy')
UNIT_RF_ANIMATION_WALK_SPEED = ConvertUnitRealField('uwal')
UNIT_RF_DEFENSE = ConvertUnitRealField('udfc')
UNIT_RF_SIGHT_RADIUS = ConvertUnitRealField('usir')
UNIT_RF_PRIORITY = ConvertUnitRealField('upri')
UNIT_RF_SPEED = ConvertUnitRealField('umvc')
UNIT_RF_OCCLUDER_HEIGHT = ConvertUnitRealField('uocc')
UNIT_RF_HP = ConvertUnitRealField('uhpc')
UNIT_RF_MANA = ConvertUnitRealField('umpc')
UNIT_RF_ACQUISITION_RANGE = ConvertUnitRealField('uacq')
UNIT_RF_CAST_BACK_SWING = ConvertUnitRealField('ucbs')
UNIT_RF_CAST_POINT = ConvertUnitRealField('ucpt')
UNIT_RF_MINIMUM_ATTACK_RANGE = ConvertUnitRealField('uamn')
UNIT_BF_RAISABLE = ConvertUnitBooleanField('urai')
UNIT_BF_DECAYABLE = ConvertUnitBooleanField('udec')
UNIT_BF_IS_A_BUILDING = ConvertUnitBooleanField('ubdg')
UNIT_BF_USE_EXTENDED_LINE_OF_SIGHT = ConvertUnitBooleanField('ulos')
UNIT_BF_NEUTRAL_BUILDING_SHOWS_MINIMAP_ICON = ConvertUnitBooleanField('unbm')
UNIT_BF_HERO_HIDE_HERO_INTERFACE_ICON = ConvertUnitBooleanField('uhhb')
UNIT_BF_HERO_HIDE_HERO_MINIMAP_DISPLAY = ConvertUnitBooleanField('uhhm')
UNIT_BF_HERO_HIDE_HERO_DEATH_MESSAGE = ConvertUnitBooleanField('uhhd')
UNIT_BF_HIDE_MINIMAP_DISPLAY = ConvertUnitBooleanField('uhom')
UNIT_BF_SCALE_PROJECTILES = ConvertUnitBooleanField('uscb')
UNIT_BF_SELECTION_CIRCLE_ON_WATER = ConvertUnitBooleanField('usew')
UNIT_BF_HAS_WATER_SHADOW = ConvertUnitBooleanField('ushr')
UNIT_SF_NAME = ConvertUnitStringField('unam')
UNIT_SF_PROPER_NAMES = ConvertUnitStringField('upro')
UNIT_SF_GROUND_TEXTURE = ConvertUnitStringField('uubs')
UNIT_SF_SHADOW_IMAGE_UNIT = ConvertUnitStringField('ushu')
UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE = ConvertUnitWeaponIntegerField('ua1d')
UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE = ConvertUnitWeaponIntegerField('ua1b')
UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE = ConvertUnitWeaponIntegerField('ua1s')
UNIT_WEAPON_IF_ATTACK_MAXIMUM_NUMBER_OF_TARGETS = ConvertUnitWeaponIntegerField('utc1')
UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE = ConvertUnitWeaponIntegerField('ua1t')
UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND = ConvertUnitWeaponIntegerField('ucs1')
UNIT_WEAPON_IF_ATTACK_AREA_OF_EFFECT_TARGETS = ConvertUnitWeaponIntegerField('ua1p')
UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED = ConvertUnitWeaponIntegerField('ua1g')
UNIT_WEAPON_RF_ATTACK_BACKSWING_POINT = ConvertUnitWeaponRealField('ubs1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_POINT = ConvertUnitWeaponRealField('udp1')
UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN = ConvertUnitWeaponRealField('ua1c')
UNIT_WEAPON_RF_ATTACK_DAMAGE_LOSS_FACTOR = ConvertUnitWeaponRealField('udl1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_MEDIUM = ConvertUnitWeaponRealField('uhd1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL = ConvertUnitWeaponRealField('uqd1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_DISTANCE = ConvertUnitWeaponRealField('usd1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_RADIUS = ConvertUnitWeaponRealField('usr1')
UNIT_WEAPON_RF_ATTACK_PROJECTILE_SPEED = ConvertUnitWeaponRealField('ua1z')
UNIT_WEAPON_RF_ATTACK_PROJECTILE_ARC = ConvertUnitWeaponRealField('uma1')
UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_FULL_DAMAGE = ConvertUnitWeaponRealField('ua1f')
UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_MEDIUM_DAMAGE = ConvertUnitWeaponRealField('ua1h')
UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_SMALL_DAMAGE = ConvertUnitWeaponRealField('ua1q')
UNIT_WEAPON_RF_ATTACK_RANGE = ConvertUnitWeaponRealField('ua1r')
UNIT_WEAPON_BF_ATTACK_SHOW_UI = ConvertUnitWeaponBooleanField('uwu1')
UNIT_WEAPON_BF_ATTACKS_ENABLED = ConvertUnitWeaponBooleanField('uaen')
UNIT_WEAPON_BF_ATTACK_PROJECTILE_HOMING_ENABLED = ConvertUnitWeaponBooleanField('umh1')
UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART = ConvertUnitWeaponStringField('ua1m')
MOVE_TYPE_UNKNOWN = ConvertMoveType(0)
MOVE_TYPE_FOOT = ConvertMoveType(1)
MOVE_TYPE_FLY = ConvertMoveType(2)
MOVE_TYPE_HORSE = ConvertMoveType(4)
MOVE_TYPE_HOVER = ConvertMoveType(8)
MOVE_TYPE_FLOAT = ConvertMoveType(16)
MOVE_TYPE_AMPHIBIOUS = ConvertMoveType(32)
MOVE_TYPE_UNBUILDABLE = ConvertMoveType(64)
TARGET_FLAG_NONE = ConvertTargetFlag(1)
TARGET_FLAG_GROUND = ConvertTargetFlag(2)
TARGET_FLAG_AIR = ConvertTargetFlag(4)
TARGET_FLAG_STRUCTURE = ConvertTargetFlag(8)
TARGET_FLAG_WARD = ConvertTargetFlag(16)
TARGET_FLAG_ITEM = ConvertTargetFlag(32)
TARGET_FLAG_TREE = ConvertTargetFlag(64)
TARGET_FLAG_WALL = ConvertTargetFlag(128)
TARGET_FLAG_DEBRIS = ConvertTargetFlag(256)
TARGET_FLAG_DECORATION = ConvertTargetFlag(512)
TARGET_FLAG_BRIDGE = ConvertTargetFlag(1024)
DEFENSE_TYPE_LIGHT = ConvertDefenseType(0)
DEFENSE_TYPE_MEDIUM = ConvertDefenseType(1)
DEFENSE_TYPE_LARGE = ConvertDefenseType(2)
DEFENSE_TYPE_FORT = ConvertDefenseType(3)
DEFENSE_TYPE_NORMAL = ConvertDefenseType(4)
DEFENSE_TYPE_HERO = ConvertDefenseType(5)
DEFENSE_TYPE_DIVINE = ConvertDefenseType(6)
DEFENSE_TYPE_NONE = ConvertDefenseType(7)
HERO_ATTRIBUTE_STR = ConvertHeroAttribute(1)
HERO_ATTRIBUTE_INT = ConvertHeroAttribute(2)
HERO_ATTRIBUTE_AGI = ConvertHeroAttribute(3)
ARMOR_TYPE_WHOKNOWS = ConvertArmorType(0)
ARMOR_TYPE_FLESH = ConvertArmorType(1)
ARMOR_TYPE_METAL = ConvertArmorType(2)
ARMOR_TYPE_WOOD = ConvertArmorType(3)
ARMOR_TYPE_ETHREAL = ConvertArmorType(4)
ARMOR_TYPE_STONE = ConvertArmorType(5)
REGENERATION_TYPE_NONE = ConvertRegenType(0)
REGENERATION_TYPE_ALWAYS = ConvertRegenType(1)
REGENERATION_TYPE_BLIGHT = ConvertRegenType(2)
REGENERATION_TYPE_DAY = ConvertRegenType(3)
REGENERATION_TYPE_NIGHT = ConvertRegenType(4)
UNIT_CATEGORY_GIANT = ConvertUnitCategory(1)
UNIT_CATEGORY_UNDEAD = ConvertUnitCategory(2)
UNIT_CATEGORY_SUMMONED = ConvertUnitCategory(4)
UNIT_CATEGORY_MECHANICAL = ConvertUnitCategory(8)
UNIT_CATEGORY_PEON = ConvertUnitCategory(16)
UNIT_CATEGORY_SAPPER = ConvertUnitCategory(32)
UNIT_CATEGORY_TOWNHALL = ConvertUnitCategory(64)
UNIT_CATEGORY_ANCIENT = ConvertUnitCategory(128)
UNIT_CATEGORY_NEUTRAL = ConvertUnitCategory(256)
UNIT_CATEGORY_WARD = ConvertUnitCategory(512)
UNIT_CATEGORY_STANDON = ConvertUnitCategory(1024)
UNIT_CATEGORY_TAUREN = ConvertUnitCategory(2048)
PATHING_FLAG_UNWALKABLE = ConvertPathingFlag(2)
PATHING_FLAG_UNFLYABLE = ConvertPathingFlag(4)
PATHING_FLAG_UNBUILDABLE = ConvertPathingFlag(8)
PATHING_FLAG_UNPEONHARVEST = ConvertPathingFlag(16)
PATHING_FLAG_BLIGHTED = ConvertPathingFlag(32)
PATHING_FLAG_UNFLOATABLE = ConvertPathingFlag(64)
PATHING_FLAG_UNAMPHIBIOUS = ConvertPathingFlag(128)
PATHING_FLAG_UNITEMPLACABLE = ConvertPathingFlag(256)