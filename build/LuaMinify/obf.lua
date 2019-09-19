gg_rct_Region_000=nil;gg_cam_Camera_001=nil;gg_cam_Camera_002=nil;gg_snd_SubGroupSelectionChange1=
nil;gg_trg_Untitled_Trigger_001=nil;gg_dest_LTg2_2324=nil;function InitGlobals()
end;local fFeQcIM;requireMap={}requireCache={}
function require(s4)
if
requireCache[s4]==nil then requireCache[s4]=requireMap[s4]()end;return requireCache[s4]end
function tprint(FFG,a31jEAS)if not a31jEAS then a31jEAS=0 end
for LS4h,eux092_P in pairs(FFG)do formatting=
string.rep("  ",a31jEAS)..LS4h..": "
if
type(eux092_P)=="table"then print(formatting)tprint(eux092_P,a31jEAS+1)else print(formatting..
eux092_P)end end end
local JEHSHPh3=function()
local ZA9={focus={effects={{type='multiplyDamage',amount=1.2},{type='modifyMoveSpeed',amount=1.5}},vfx={model="Liberty.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNMarkOfFire.blp"},curshout={effects={{type='multiplyDamage',amount=0.6}},vfx={model="Abilities\\Spells\\Human\\slow\\slowtarget.mdl",attach="origin"},icon="ReplaceableTextures\\CommandButtons\\BTNBattleRoar.blp"},assist={effects={{type='multiplyIncomingDamage',amount=0.6}},icon="ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp"},stalwartshell={effects={{type='multiplyIncomingDamage',amount=0}},vfx={model="Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNDefend.blp"},flag={effects={{type='multiplyIncomingDamage',amount=0.9},{type='multiplyDamage',amount=1.1},{type='modifyMoveSpeed',amount=1.1}},vfx={model="Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl",attach="origin"},icon="ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"},armorpot={effects={{type='multiplyIncomingDamage',amount=0.7},{type='multiplyIncomingHealing',amount=1.3}},vfx={model="Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNPotionOfRestoration.blp"},hulkingpot={effects={{type='multiplyDamage',amount=1.2},{type='modifySize',amount=1.3}},icon="ReplaceableTextures\\CommandButtons\\BTNPotionRed.blp"},dampenpot={effects={{type='multiplyDamage',amount=0.8},{type='modifySize',amount=0.8}},icon="ReplaceableTextures\\CommandButtons\\BTNLesserInvulneralbility.blp"},accpot={effects={{type='modifyMoveSpeed',amount=2}},vfx={model="Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNAcidBomb.blp"},rejuvpot={effects={{type='heal',amount=30,tickrate=1}},vfx={model="Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNPotionOfClarity.blp",maxStacks=3},corrosivedecaydot={effects={{type='damage',amount=160,tickrate=1}},vfx={model="Abilities\\Spells\\Human\\Banish\\BanishTarget.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNPotionOfOmniscience.blp"},stun={effects={{type='stun'}},vfx={model="Abilities\\Spells\\Orc\\StasisTrap\\StasisTotemTarget.mdl",attach="overhead"},icon="ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower.blp"},firelance={effects={{type='stun'}},vfx={model="Abilities\\Spells\\Orc\\StasisTrap\\StasisTotemTarget.mdl",attach="overhead"},icon="ReplaceableTextures\\CommandButtons\\BTNFire.blp"},fireshell={effects={{type='stun'},{type='multiplyIncomingDamage',amount=0}},vfx={model="Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedTarget.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNCloakOfFlames.blp"},frostball={effects={{type='multiplyIncomingDamage',amount=0.9}},vfx={model="Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorTarget.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNFrostBolt.blp"},frostballslow={effects={{type='modifyMoveSpeed',amount=0.6}},vfx={model="Abilities\\Spells\\Items\\AIob\\AIobTarget.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNFrostBolt.blp"},frostnova={effects={{type='root'}},vfx={model="Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathTargetArt.mdl",attach="origin"},icon="ReplaceableTextures\\CommandButtons\\BTNFrostArmor.blp"},icicle={effects={{type='modifyMoveSpeed',amount=0.7}},vfx={model="Abilities\\Spells\\Items\\AIob\\AIobTarget.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNBreathOfFrost.blp"},blind={effects={{type='stun'}},vfx={model="Abilities\\Spells\\Other\\HowlOfTerror\\HowlTarget.mdl",attach="overhead"},removeOnDamage=true,icon="ReplaceableTextures\\CommandButtons\\BTNSentryWard.blp"}}local hWgmxm={}function registerBuff(UBg54E,gQGq)ZA9[UBg54E]=gQGq end
function addBuff(OyHc5FEv,Dn1Xi,_gGmBBE,rIX4)
local AI14eFhp=GetHandleId(Dn1Xi)
if hWgmxm[AI14eFhp]==nil then hWgmxm[AI14eFhp]={unit=Dn1Xi,buffs={}}end;local iW2O=0
if hWgmxm[AI14eFhp].buffs[_gGmBBE]~=nil then
iW2O=hWgmxm[AI14eFhp].buffs[_gGmBBE].stacks
DestroyTimer(hWgmxm[AI14eFhp].buffs[_gGmBBE].timer)removeBuff(Dn1Xi,_gGmBBE)end
hWgmxm[AI14eFhp].buffs[_gGmBBE]={source=OyHc5FEv,stacks=math.min(iW2O+1,
ZA9[_gGmBBE].maxStacks or 1)}
if
hWgmxm[AI14eFhp].buffs[_gGmBBE].stacks==
ZA9[_gGmBBE].maxStacks and ZA9[_gGmBBE].onMaxStacks~=nil then
local Gdp=ZA9[_gGmBBE].onMaxStacks(Dn1Xi,hWgmxm[AI14eFhp].buffs[_gGmBBE])if Gdp then return end end;if ZA9[_gGmBBE].vfx~=nil then
hWgmxm[AI14eFhp].buffs[_gGmBBE].effect=AddSpecialEffectTarget(ZA9[_gGmBBE].vfx.model,Dn1Xi,ZA9[_gGmBBE].vfx.attach)end
hWgmxm[AI14eFhp].buffs[_gGmBBE].timer=CreateTimer()
TimerStart(hWgmxm[AI14eFhp].buffs[_gGmBBE].timer,rIX4,false,function()
DestroyTimer(hWgmxm[AI14eFhp].buffs[_gGmBBE].timer)removeBuff(Dn1Xi,_gGmBBE)end)end
function removeBuff(nbqmx,IWQcC)local cvRh=GetHandleId(nbqmx)if hWgmxm[cvRh]==nil or
hWgmxm[cvRh].buffs==nil then return end;if
hWgmxm[cvRh].buffs[IWQcC].effect~=nil then
DestroyEffect(hWgmxm[cvRh].buffs[IWQcC].effect)end;hWgmxm[cvRh].buffs[IWQcC]=
nil end
function maybeRemoveBuffsOnDamage(W9yaJm,oJ1ec,LMMNWLk)local x6Ni=getBuffs(oJ1ec)
for Q2waXkyp,EG72 in pairs(x6Ni)do if ZA9[Q2waXkyp].removeOnDamage then
removeBuff(oJ1ec,Q2waXkyp)end end end
function hasBuff(mlTMZ,q)local xb6=GetHandleId(mlTMZ)return
hWgmxm[xb6]~=nil and
hWgmxm[xb6].buffs~=nil and hWgmxm[xb6].buffs[q]end
function getBuffStacks(yK,rHLz2GD)local BlW0RhJA=GetHandleId(yK)if hasBuff(yK,rHLz2GD)then return
hWgmxm[BlW0RhJA].buffs[rHLz2GD].stacks end;return 0 end;function getBuffs(Uy)local n=GetHandleId(Uy)return
hWgmxm[n]and hWgmxm[n].buffs or{}end
function getDamageModifier(TKu,M6kL)
local M7o_=getBuffs(TKu)local dk2X7J7=1
for jv,MW in pairs(M7o_)do local E2OQ=ZA9[jv].effects;for SnbfLb6,ay in pairs(E2OQ)do
if
ay.type=='multiplyDamage'then dk2X7J7=dk2X7J7*ay.amount*MW.stacks end end end;local M7o_=getBuffs(M6kL)
for W,WzM in pairs(M7o_)do local PSx=ZA9[W].effects
for IwnA,cW in pairs(PSx)do if cW.type==
'multiplyIncomingDamage'then
dk2X7J7=dk2X7J7*cW.amount*WzM.stacks end end end;return dk2X7J7 end
function getHealingModifier(PHpCof2,bUPpn4T2)local sode=getBuffs(PHpCof2)local G9zkKODk=1
for MGt,ld9GuG4t in pairs(sode)do
local KpCCA=ZA9[MGt].effects;for H6,hgsKvTz in pairs(KpCCA)do
if hgsKvTz.type=='multiplyHealing'then G9zkKODk=G9zkKODk*hgsKvTz.amount*
ld9GuG4t.stacks end end end;local sode=getBuffs(bUPpn4T2)
for zEt,Wjojpvg in pairs(sode)do local l2PqbWw=ZA9[zEt].effects;for EJTH9,qTB82 in
pairs(l2PqbWw)do
if qTB82.type=='multiplyIncomingHealing'then G9zkKODk=G9zkKODk*qTB82.amount*
Wjojpvg.stacks end end end;return G9zkKODk end;function getBuffInstances()return hWgmxm end
return
{BUFF_INFO=ZA9,registerBuff=registerBuff,addBuff=addBuff,removeBuff=removeBuff,hasBuff=hasBuff,getBuffStacks=getBuffStacks,getBuffs=getBuffs,getBuffInstances=getBuffInstances,getDamageModifier=getDamageModifier,getHealingModifier=getHealingModifier,maybeRemoveBuffsOnDamage=maybeRemoveBuffsOnDamage}end
local bb=function()local KL={}
function queueAnimation(EATFLbgY,FF,rh)local YcCR=GetHandleId(EATFLbgY)if KL[YcCR]~=nil then
DestroyTimer(KL[YcCR])end;local G3p2Yn=CreateTimer()KL[YcCR]=G3p2Yn
TimerStart(G3p2Yn,rh,false,function()
DestroyTimer(G3p2Yn)SetUnitAnimationByIndex(EATFLbgY,0)end)SetUnitAnimationByIndex(EATFLbgY,FF)end;return{queueAnimation=queueAnimation}end
local o5e6fP=function()local _jkkD9=require('src/hero.lua')
function onCameraTick()
local D=GetPlayerId(GetLocalPlayer())local _jkkD9=_jkkD9.getHero(D)
SetCameraQuickPosition(GetUnitX(_jkkD9),GetUnitY(_jkkD9))end;function init()end;return{init=init}end
local iq7ol=function()local DMn=require('src/buff.lua')
local GBzFRjVV=require('src/damage.lua')local pG4C8fDK=require('src/hero.lua')
local LLFUU=require('src/casttime.lua')local kdmQtj6=0.1;local Hc35_=0
function applyBuffs()local ubP=DMn.getBuffInstances()
for eN0UMW,lAG in pairs(ubP)do
local AvEtR8Y=lAG.unit;local rl3MMqfm=GetPlayerId(GetOwningPlayer(AvEtR8Y))
local nQj=pG4C8fDK.getHero(rl3MMqfm)local Eq8jDq=lAG.buffs;local LnQUN=GetUnitDefaultMoveSpeed(AvEtR8Y)local Gm1=
AvEtR8Y==nQj and LLFUU.isCasting(rl3MMqfm)
local Jp=false;local NwBqNl3C=GetUnitPointValue(AvEtR8Y)/100
for XuqjvYPF,Trh in
pairs(Eq8jDq)do local K=0;local uK=0;local s0FU=DMn.BUFF_INFO[XuqjvYPF].effects
for wQl,g in
pairs(s0FU)do if g.type=='modifyMoveSpeed'then
LnQUN=LnQUN*g.amount*Trh.stacks end;if g.type=='modifySize'then NwBqNl3C=NwBqNl3C*g.amount*
Trh.stacks end
if

g.type=='heal'and Hc35_% (1/kdmQtj6*g.tickrate)==0 then K=K+g.amount*Trh.stacks end
if g.type=='damage'and
Hc35_% (1/kdmQtj6*g.tickrate)==0 then uK=uK+g.amount*Trh.stacks end;if g.type=='stun'then Gm1=true end;if g.type=='root'then Jp=true end end
if K>0 then GBzFRjVV.heal(Trh.source,AvEtR8Y,K)end
if uK>0 then GBzFRjVV.dealDamage(Trh.source,AvEtR8Y,uK)end end;if Jp then SetUnitMoveSpeed(AvEtR8Y,0)else
SetUnitMoveSpeed(AvEtR8Y,LnQUN)end;PauseUnit(AvEtR8Y,Gm1)
SetUnitScale(AvEtR8Y,NwBqNl3C,NwBqNl3C,NwBqNl3C)end;Hc35_=Hc35_+1 end;function init()
TimerStart(CreateTimer(),kdmQtj6,true,applyBuffs)end;return{init=init}end
local eMV=function()local m4u=require('src/hero.lua')local StZ={}local C1NqzxY={}
local T1gVrYq=function(FKLmmhnQ,F82,wJ6tY_,TNg)if
StZ[FKLmmhnQ]~=nil then return false end;if wJ6tY_==nil then wJ6tY_=true end;if TNg==nil then
TNg=false end;if wJ6tY_==true then TNg=true end;local wO9T=CreateTimer()TimerStart(wO9T,F82,false,
nil)
StZ[FKLmmhnQ]={timer=wO9T,interruptable=wJ6tY_,canMove=TNg}
if not TNg then PauseUnit(m4u.getHero(FKLmmhnQ),true)end;TriggerSleepAction(F82)local QMcSUqdi=false
if
StZ[FKLmmhnQ]~=nil and
GetHandleId(StZ[FKLmmhnQ].timer)==GetHandleId(wO9T)then PauseUnit(m4u.getHero(FKLmmhnQ),false)
QMcSUqdi=true;StZ[FKLmmhnQ]=nil;DestroyTimer(wO9T)end;return QMcSUqdi end
local P5G=function(sKy2P9i)return StZ[sKy2P9i]~=nil end
local JC=function()if GetIssuedOrderId()==851973 then return end
local S=GetPlayerId(GetTriggerPlayer())stopCast(S,true)end
function stopCast(AD,AkxLdb66)local aUR=StZ[AD]if
aUR~=nil and(
(AkxLdb66 and aUR.interruptable==true)or not AkxLdb66)then PauseUnit(m4u.getHero(AD),false)StZ[AD]=nil
DestroyTimer(aUR.timer)end end
local PDA=function(c4)local ZNXs3Bwd=StZ[c4]if ZNXs3Bwd~=nil then
return TimerGetRemaining(ZNXs3Bwd.timer)end;return nil end
local K=function(Ginn)local h_pK=StZ[Ginn]
if h_pK~=nil then return TimerGetTimeout(h_pK.timer)end;return nil end
local qne5Stra=function()local LvBKFXR3=CreateTrigger()
TriggerRegisterAnyUnitEventBJ(LvBKFXR3,EVENT_PLAYER_UNIT_ISSUED_ORDER)
TriggerRegisterAnyUnitEventBJ(LvBKFXR3,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
TriggerRegisterAnyUnitEventBJ(LvBKFXR3,EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
TriggerRegisterAnyUnitEventBJ(LvBKFXR3,EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)TriggerAddAction(LvBKFXR3,JC)end
return{init=qne5Stra,cast=T1gVrYq,stopCast=stopCast,isCasting=P5G,getCastDurationRemaining=PDA,getCastDurationTotal=K}end
local WDTNkTD=function()local FP3j=require('src/items/backpack.lua')
local fe=require('src/items/equipment.lua')local ggnA={}local KaD2ExEO={}
local TpiFT={[FourCC("Hyuj")]={name='Yuji',storedId=1,id=FourCC("Hyuj"),spells={[1]='slash',[2]='throwingstar',[3]='dash',[4]='slashult',[5]='attack',[6]='stop',[7]='jab',[8]='focus',[9]='stun',[10]='blind'},baseHP=600},[FourCC("Hstm")]={name='Stormfist',storedId=2,id=FourCC("Hstm"),spells={[1]='punch',[5]='attack',[6]='stop'},baseHP=600},[FourCC("Hivn")]={name='Ivanov',storedId=3,id=FourCC("Hivn"),spells={[1]='rejuvpot',[2]='armorpot',[3]='cleansingpot',[4]='molecregen',[5]='attack',[6]='stop',[7]='corrosiveblast',[8]='accmist',[9]='hulkingpot',[10]='dampenpot',[11]='pocketgoo'},baseHP=600},[FourCC("Hazr")]={name='Azora',storedId=4,id=FourCC("Hazr"),spells={[1]='fireball',[2]='frostnova',[3]='firelance',[4]='meteor',[5]='attack',[6]='stop',[7]='firestorm',[8]='blink',[9]='icicle',[10]='phoenix',[11]='fireshell',[12]='frostballs'},baseHP=400},[FourCC("Htar")]={name='Tarcza',storedId=5,id=FourCC("Htar"),spells={[1]='whirlwind',[2]='boomerang',[3]='blitz',[4]='shieldcharge',[5]='attack',[6]='stop',[7]='stalwartshell',[8]='curshout',[9]='bulwark',[10]='flag',[11]='challenge'},baseHP=1000}}
local JCH=function()local Y=GetDyingUnit()local SMa=GetHeroLevel(Y)
TriggerSleepAction(5)for Bo=0,bj_MAX_PLAYERS,1 do
if Y==ggnA[Bo]then createHeroForPlayer(Bo,SMa)end end end;local sJ05I={}local HrLCim={}
function createHeroForPlayer(zF6ZPjQ,nNQG3)
DestroyTrigger(sJ05I[zF6ZPjQ])DestroyTrigger(HrLCim[zF6ZPjQ])
ggnA[zF6ZPjQ]=CreateUnit(Player(zF6ZPjQ),KaD2ExEO[zF6ZPjQ].id,
-150,-125,0)
if zF6ZPjQ==GetPlayerId(GetLocalPlayer())then
ClearSelection()SelectUnit(ggnA[zF6ZPjQ],true)
ResetToGameCamera(0)PanCameraToTimed(-150,-125,0)end;if nNQG3 ~=nil and nNQG3 ~=1 then
SetHeroLevel(ggnA[zF6ZPjQ],nNQG3,false)end end
local w=function(yW,efGM8UMy)
CameraSetupApplyForPlayer(true,efGM8UMy,Player(yW),0)end
local sUu7z=function()local KhH=GetPlayerId(GetTriggerPlayer())
local H4tXd=GetTriggerUnit()KaD2ExEO[KhH]=TpiFT[GetUnitTypeId(H4tXd)]
createHeroForPlayer(KhH)end
local M5oB=function(Nq6If)
CreateFogModifierRectBJ(true,Player(Nq6If),FOG_OF_WAR_VISIBLE,gg_rct_Region_000)local II=CreateTrigger()
TriggerRegisterTimerEvent(II,0.1,true)
TriggerAddAction(II,function()w(Nq6If,gg_cam_Camera_002)end)sJ05I[Nq6If]=II;local Y_tefq=CreateTrigger()
TriggerRegisterPlayerUnitEvent(Y_tefq,Player(Nq6If),EVENT_PLAYER_UNIT_SELECTED,
nil)TriggerAddAction(Y_tefq,sUu7z)HrLCim[Nq6If]=Y_tefq end
function onRepick()local i=GetPlayerId(GetTriggerPlayer())
fe.clear(i)FP3j.clear(i)RemoveUnit(ggnA[i])ggnA[i]=nil
KaD2ExEO[i]=nil;M5oB(i)end
local xIyIKo=function()local a3u=CreateTrigger()
TriggerRegisterAnyUnitEventBJ(a3u,EVENT_PLAYER_UNIT_DEATH)TriggerAddAction(a3u,JCH)local mzhB=CreateTrigger()for sTxVGmb=0,bj_MAX_PLAYERS,1 do
TriggerRegisterPlayerChatEvent(mzhB,Player(sTxVGmb),"-repick",false)end
TriggerAddAction(mzhB,onRepick)for GSIcq=0,bj_MAX_PLAYERS,1 do M5oB(GSIcq)end end;local f2x=function(Go)return ggnA[Go]end
local Nwl=function(DGf)for kgRX7X,JB in pairs(ggnA)do
if DGf==JB then return true end end;return false end
local Xpt_SQ=function(GGJhclKa)return KaD2ExEO[GGJhclKa]end
function restorePickedHero(KWahIz,X2kyW,pVlvW)
for QcKn_,jiM in pairs(TpiFT)do if jiM.storedId==X2kyW then KaD2ExEO[KWahIz]=jiM
createHeroForPlayer(KWahIz,pVlvW)return end end end
return{init=xIyIKo,getHero=f2x,isHero=Nwl,getPickedHero=Xpt_SQ,restorePickedHero=restorePickedHero}end
local Oejsws=function()
local YUdA=function(lx3cpJ)local Yx9=lx3cpJ.x;local Mn=lx3cpJ.y;if lx3cpJ.unit then
Yx9=GetUnitX(lx3cpJ.unit)Mn=GetUnitY(lx3cpJ.unit)end
local ut0=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),FourCC(lx3cpJ.model),Yx9,Mn,
lx3cpJ.facing or 0)if lx3cpJ.scale then
SetUnitScale(ut0,lx3cpJ.scale,lx3cpJ.scale,lx3cpJ.scale)end;if lx3cpJ.timeScale then
SetUnitTimeScale(ut0,lx3cpJ.timeScale)end;local ZFhlP6eg=CreateTimer()
TimerStart(ZFhlP6eg,lx3cpJ.duration,false,function()
KillUnit(ut0)DestroyTimer(ZFhlP6eg)end)end;return{createEffect=YUdA}end
local CkD73N0=function()local ExUgDG=require('src/buff.lua')
local jc4o42jz=require('src/threat.lua')
function createCombatText(jc,Ojz_,x)local Xtecl=BlzGetUnitCollisionSize(Ojz_)
local KVcYU=CreateTextTag()
SetTextTagText(KVcYU,I2S(S2I(jc)),TextTagSize2Height(Xtecl*0.04+6))SetTextTagPosUnit(KVcYU,Ojz_,10)
if x then
SetTextTagColor(KVcYU,0,100,0,0)else SetTextTagColor(KVcYU,100,0,0,0)end
SetTextTagVelocity(KVcYU,TextTagSpeed2Velocity(GetRandomReal(-100,100)),TextTagSpeed2Velocity(100))SetTextTagPermanent(KVcYU,false)
SetTextTagLifespan(KVcYU,0.5)SetTextTagFadepoint(KVcYU,0.01)end;function dealDamage(_,C,CJeG)
UnitDamageTargetBJ(_,C,CJeG,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)end
function heal(F43eMG,mCzjh4,lU)
local epQue9=BlzGetUnitRealField(mCzjh4,UNIT_RF_HP)
local cHUJrj=lU*ExUgDG.getHealingModifier(F43eMG,mCzjh4)local EI0x=epQue9+cHUJrj
BlzSetUnitRealField(mCzjh4,UNIT_RF_HP,EI0x)createCombatText(cHUJrj,mCzjh4,true)end
function onDamageTaken()local E=GetEventDamageSource()local lacOdjf9=GetTriggerUnit()
local R2h4lP4l=
GetEventDamage()*ExUgDG.getDamageModifier(E,lacOdjf9)BlzSetEventDamage(R2h4lP4l)
createCombatText(R2h4lP4l,lacOdjf9,false)jc4o42jz.addThreat(E,lacOdjf9,R2h4lP4l)
ExUgDG.maybeRemoveBuffsOnDamage(E,lacOdjf9,R2h4lP4l)end
function init()local Fh=CreateTrigger()for a2e9fa=0,bj_MAX_PLAYERS,1 do
TriggerRegisterPlayerUnitEvent(Fh,Player(a2e9fa),EVENT_PLAYER_UNIT_DAMAGED,
nil)end
TriggerAddAction(Fh,onDamageTaken)end;return{init=init,dealDamage=dealDamage,heal=heal}end
local PlwhaRKJ=function()local Rc9_ZID=require('src/hero.lua')
local H1HF2wD6=require('src/items/backpack.lua')local hBph=1
local bxNo9h=function()local ISg1=GetPlayerId(GetTriggerPlayer())
print(hBph)hBph=hBph+0.01 end
local Khst=function()print(hBph)hBph=hBph-0.01 end
local pUT=function()local Gh5UJya=CreateTrigger()
BlzTriggerRegisterPlayerKeyEvent(Gh5UJya,Player(0),OSKEY_1,0,true)TriggerAddAction(Gh5UJya,bxNo9h)local k=CreateTrigger()
BlzTriggerRegisterPlayerKeyEvent(k,Player(0),OSKEY_2,0,true)TriggerAddAction(k,Khst)end;return{init=pUT}end
local Caz4NM4Z=function()
local Z8Ue=function()collectgarbage("collect")collectgarbage("stop")end
local TXbmx=function()TimerStart(CreateTimer(),30,true,Z8Ue)end;return{init=TXbmx}end
local XVxxx=function()
local r=function()TriggerSleepAction(3)RemoveUnit(GetDyingUnit())end
local Pqgz415t=function()local McNxKV=CreateTrigger()
TriggerRegisterAnyUnitEventBJ(McNxKV,EVENT_PLAYER_UNIT_DEATH)TriggerAddAction(McNxKV,r)end;return{init=Pqgz415t}end
local hD=function()local WcwGYJh=require("src/spell.lua")
local gJt=require("src/hero.lua")local hCs8M=require("src/ui/backpack.lua")
local GkjCn_mq=require("src/ui/equipment.lua")
local T9sySp={[OSKEY_Q]=1,[OSKEY_W]=2,[OSKEY_E]=3,[OSKEY_R]=4,[OSKEY_A]=5,[OSKEY_D]=7,[OSKEY_F]=8,[OSKEY_Z]=9,[OSKEY_X]=10,[OSKEY_C]=11,[OSKEY_V]=12}
local DL0mMXM={OSKEY_Q,OSKEY_W,OSKEY_E,OSKEY_R,OSKEY_A,OSKEY_D,OSKEY_F,OSKEY_Z,OSKEY_X,OSKEY_C,OSKEY_V,OSKEY_B,OSKEY_O}
local o4Kvi75g=function()local DH6mUlGB=BlzGetTriggerPlayerKey()
local A4ZRczp=GetPlayerId(GetTriggerPlayer())if T9sySp[DH6mUlGB]then
WcwGYJh.castSpell(A4ZRczp,T9sySp[DH6mUlGB])return end
if DH6mUlGB==OSKEY_B then
hCs8M.toggle(A4ZRczp)GkjCn_mq.toggle(A4ZRczp)end end
local ELb=function()
SetCameraTargetControllerNoZForPlayer(GetTriggerPlayer(),gJt.getHero(GetPlayerId(GetTriggerPlayer())),0,0,false)end;local FV5=function()
ResetToGameCameraForPlayer(GetTriggerPlayer(),0)end
local sX=function()
local rUT=CreateTrigger()
for Kkl6fa=0,bj_MAX_PLAYER_SLOTS-1,1 do for t,H in pairs(DL0mMXM)do
BlzTriggerRegisterPlayerKeyEvent(rUT,Player(Kkl6fa),H,0,true)end end;TriggerAddAction(rUT,o4Kvi75g)local g=CreateTrigger()for glZrOuSo=0,
bj_MAX_PLAYER_SLOTS-1,1 do
BlzTriggerRegisterPlayerKeyEvent(g,Player(glZrOuSo),OSKEY_SPACE,0,true)end
TriggerAddAction(g,ELb)local JPi=CreateTrigger()for Zdzaj=0,bj_MAX_PLAYER_SLOTS-1,1 do
BlzTriggerRegisterPlayerKeyEvent(JPi,Player(Zdzaj),OSKEY_SPACE,0,false)end
TriggerAddAction(JPi,FV5)end;return{init=sX}end
local G5BuU5=function()
local UxRGyO9e={NORMAL={duration=5,color="|cffffffff",x=0,y=0},ERROR={duration=1,color="|cffff0000",x=0,y=0},SUCCESS={duration=3,color="|cff00ff00",x=0,y=0},INFO={duration=5,color="|cff00cccc",x=0,y=0}}
local fvj_L=function(_CPU89l,U,Kwxn,yp5DGSwX)
DisplayTimedTextToPlayer(Player(_CPU89l),Kwxn.x,Kwxn.y,yp5DGSwX or Kwxn.duration,Kwxn.color..U.."|r")end;return{TYPE=UxRGyO9e,log=fvj_L}end
local AfwsY=function()
local Sb1Mw7R=function()
DisplayTextToForce(GetPlayersAll(),GetPlayerName(GetTriggerPlayer()).." has left the game.")end
local fuF=function()local pA2=CreateTrigger()for M5lAedm=0,bj_MAX_PLAYER_SLOTS-1,1 do
TriggerRegisterPlayerEventLeave(pA2,Player(M5lAedm))end
TriggerAddAction(pA2,Sb1Mw7R)end;return{init=fuF}end
local T=function()local _uYRl2kj=require('src/hero.lua')
local tbN=require('src/keyboard.lua')local x=require('src/mouse.lua')
local m=require('src/projectile.lua')local VVQ=require('src/cleanup.lua')
local Jb=require('src/ui/main.lua')local q=require('src/leaver.lua')
local cpea=require('src/casttime.lua')local tjDBv=require('src/buffloop.lua')
local vmn7v=require('src/target.lua')local Au1mzs=require('src/damage.lua')
local u39i=require('src/party.lua')local Fdg7p=require('src/threat.lua')
local GD3AP=require('src/camera.lua')local jph00k=require('src/spawnpoint.lua')
local wE_4o=require('src/spell.lua')local F=require('src/gc.lua')
local bUO1NvT=require('src/saveload/save.lua')local K=require('src/saveload/load.lua')
local RQG=require('src/buffs/buffmanager.lua')local tVwI_N=require('src/spells/cooldowns.lua')
local Jkp2lGXG=require('src/items/backpack.lua')local ifcyuS=require('src/items/equipment.lua')
local V03W=require('src/items/itemmanager.lua')local R=require('src/bosses/bossmanager.lua')
local X6_=require('src/debug.lua')
local tN5u=function()_uYRl2kj.init()tbN.init()x.init()m.init()
VVQ.init()Jb.init()q.init()cpea.init()tjDBv.init()
vmn7v.init()Au1mzs.init()u39i.init()Fdg7p.init()
GD3AP.init()jph00k.init()wE_4o.init()F.init()
bUO1NvT.init()K.init()RQG.init()tVwI_N.init()Jkp2lGXG.init()
ifcyuS.init()V03W.init()R.init()X6_.init()end;TimerStart(CreateTimer(),0.0,false,tN5u)
collectgarbage("stop")end
local WZs=function()local Yqc0GWr=require('src/vector.lua')
local UC7=require('src/lib/sat.lua')
function isCollided(WbvvcjER,rOLxXC,w762p7sZ)rOLxXC=Yqc0GWr:new(rOLxXC)
local _7jt=BlzGetUnitCollisionSize(WbvvcjER)
local ORXyFQ=Yqc0GWr:new{x=GetUnitX(WbvvcjER),y=GetUnitY(WbvvcjER)}
local OL1oV=Yqc0GWr:new(rOLxXC):subtract(ORXyFQ)if OL1oV:magnitude()<=_7jt then return true end
local Q=OL1oV:normalize():multiply(_7jt):add(ORXyFQ):multiply(
-1):add(rOLxXC):magnitude()return Q<=w762p7sZ end
function isCollidedWithPolygon(HQvT5,dN)local B35igHj={}for Tcv_,lygY in pairs(dN)do
table.insert(B35igHj,UC7.Vector(lygY.x,lygY.y))end
local o8pPC2=UC7.Polygon(UC7.Vector(0,0),B35igHj)
local f7nUIW=UC7.Circle(UC7.Vector(GetUnitX(HQvT5),GetUnitY(HQvT5)),BlzGetUnitCollisionSize(HQvT5))local bDgD=UC7.Response()
local Kg8PhSq=UC7.testPolygonCircle(o8pPC2,f7nUIW,bDgD)return Kg8PhSq end
function getAllCollisions(HG,u)local m9i;if HG[1]and HG[1].x then
m9i=Location(HG[1].x,HG[1].y)else m9i=Location(HG.x,HG.y)end
local EqPMP=GetUnitsInRangeOfLocAll(1000,m9i)local JR={}
ForGroupBJ(EqPMP,function()local G1Cl6=GetEnumUnit()
if
GetUnitState(G1Cl6,UNIT_STATE_LIFE)>0 and not IsUnitHidden(G1Cl6)then
if
HG[1]and HG[1].x and isCollidedWithPolygon(G1Cl6,HG)or
isCollided(G1Cl6,HG,u)then table.insert(JR,G1Cl6)end end end)RemoveLocation(m9i)return JR end
return{isCollidedWithPolygon=isCollidedWithPolygon,getAllCollisions=getAllCollisions,isCollided=isCollided}end
local ITdz=function()local h=require('src/hero.lua')
local fYUikw=require('src/effect.lua')local W9qTCm=require('src/target.lua')local YlaSjEKp={}for MvWxr=0,bj_MAX_PLAYERS,1 do
YlaSjEKp[MvWxr]={x=0,y=0}end
local u_ogp8=function(HgY6)return YlaSjEKp[HgY6].x end;local K=function(Wc)return YlaSjEKp[Wc].y end
local ob=function()
local eQ5=BlzGetTriggerPlayerMousePosition()local kvR=GetPlayerId(GetTriggerPlayer())
YlaSjEKp[kvR].x=GetLocationX(eQ5)YlaSjEKp[kvR].y=GetLocationY(eQ5)end
local a3=function()local So=CreateTrigger()for Wi=0,bj_MAX_PLAYER_SLOTS-1,1 do
TriggerRegisterPlayerEvent(So,Player(Wi),EVENT_PLAYER_MOUSE_MOVE)end
TriggerAddAction(So,ob)end;return{getMouseX=u_ogp8,getMouseY=K,init=a3}end
local AjfoUo=function()local X1WM=require('src/log.lua')local OVBAVy={}local Joa=0;local NF0={}function addPlayerToParty(OeF,sawaLtSr)
OVBAVy[sawaLtSr]=OeF end
function removePlayerFromParty(KWeL)OVBAVy[KWeL]=nil end;function createParty()local K=Joa;Joa=Joa+1;return K end
function getPlayersInParty(rvhod9t,bfx5oN)local XDKTNXw={}
for RyTb,ImqF1v in
pairs(OVBAVy)do if ImqF1v==rvhod9t and RyTb~=bfx5oN then
table.insert(XDKTNXw,RyTb)end end;return XDKTNXw end;function getPlayerParty(K)return OVBAVy[K]end
function onInviteSent()
local Ru=GetPlayerId(GetTriggerPlayer())local Vy5qF=GetEventPlayerChatString()local rokDhenZ=
S2I(SubString(Vy5qF,7,StringLength(Vy5qF)))-1;if
getPlayerParty(rokDhenZ)~=nil then
X1WM.log(Ru,"That player is already in a party.",X1WM.TYPE.ERROR)return end
NF0[rokDhenZ]=Ru
X1WM.log(Ru,"You invited "..
GetPlayerName(Player(rokDhenZ)).." to join your party.",X1WM.TYPE.INFO)
X1WM.log(rokDhenZ,GetPlayerName(Player(Ru)).." invited you to join their party.",X1WM.TYPE.INFO)end
function onAcceptInvite()local td8OL=GetPlayerId(GetTriggerPlayer())if
NF0[td8OL]==nil then
X1WM.log(td8OL,"You have no invites pending.",X1WM.TYPE.ERROR)return end;local W=NF0[td8OL]
local CS=getPlayerParty(W)
if CS==nil then CS=createParty()addPlayerToParty(CS,W)end;addPlayerToParty(CS,td8OL)local i=getPlayersInParty(CS)for v2VylMn,Oi in
pairs(i)do
X1WM.log(Oi,GetPlayerName(Player(td8OL)).." joined the party.",X1WM.TYPE.INFO)end end
function init()local KwcrRu=CreateTrigger()for fqGD1rfW=0,bj_MAX_PLAYERS,1 do
TriggerRegisterPlayerChatEvent(KwcrRu,Player(fqGD1rfW),"-party",false)end
TriggerAddAction(KwcrRu,onInviteSent)local bgFJ=CreateTrigger()for K0=0,bj_MAX_PLAYERS,1 do
TriggerRegisterPlayerChatEvent(bgFJ,Player(K0),"-accept",true)end
TriggerAddAction(bgFJ,onAcceptInvite)
for _1To2=0,bj_MAX_PLAYERS-1,1 do for lkzs=0,bj_MAX_PLAYERS-1,1 do
SetPlayerAllianceStateBJ(Player(_1To2),Player(lkzs),bj_ALLIANCE_ALLIED_VISION)end end end
return{init=init,getPlayersInParty=getPlayersInParty,getPlayerParty=getPlayerParty}end
local Er9zidsB=function()local Hhwf3oO=require('src/vector.lua')
local Oh5=require('src/hero.lua')local LgQF=require('src/collision.lua')local emGbhJGH={}local e_Ev8OQ
local zBMvU6=function(BzNBgGvD,KIQCH,L4bw)
return BzNBgGvD+L4bw>=
KIQCH and BzNBgGvD-L4bw<=KIQCH end
local ZmbDgbg=function(XhBEPD)if XhBEPD.options.shouldRemove then
if XhBEPD.options.removeInsteadOfKill then
RemoveUnit(XhBEPD.unit)else KillUnit(XhBEPD.unit)end end
XhBEPD.toRemove=true;if XhBEPD.options.onDestroy then
XhBEPD.options.onDestroy(XhBEPD.unit)end end
local hMxy=function(Uq)
if Uq.toV~=nil then return Hhwf3oO:new(Uq.toV)elseif Uq.destUnit~=nil then return
Hhwf3oO:new{x=GetUnitX(Uq.destUnit),y=GetUnitY(Uq.destUnit)}else
local RmyiI_D=Uq.fromUnit and
Hhwf3oO:new{x=GetUnitX(Uq.fromUnit),y=GetUnitY(Uq.fromUnit)}or Uq.fromV;return
Hhwf3oO:fromAngle(Uq.toAngle):multiply(Uq.toRadius):add(RmyiI_D)end end
local hj3=function(w_2iiJwx)local RRESd=GetUnitX(w_2iiJwx.unit)
local S1qoVmFR=GetUnitY(w_2iiJwx.unit)local f2=Hhwf3oO:new{x=RRESd,y=S1qoVmFR}
local O3rHR=Hhwf3oO:new(f2):subtract(w_2iiJwx.options.fromV)local YU80=O3rHR:magnitude()
return w_2iiJwx.options.toRadius~=
w_2iiJwx.options.fromRadius and
zBMvU6(YU80,w_2iiJwx.options.toRadius,5)end
local M7q3pa8=function()local ARnO_0E=TimerGetElapsed(e_Ev8OQ)
for lqxbMC,qOk5Jm in pairs(emGbhJGH)do
local tpSe2fs=GetUnitX(qOk5Jm.unit)local AuVgc7=GetUnitY(qOk5Jm.unit)
local vxnB=Hhwf3oO:new{x=tpSe2fs,y=AuVgc7}local ZQOXXXd=Oh5.getHero(qOk5Jm.options.playerId)
local cyBmTv=LgQF.getAllCollisions(vxnB,
qOk5Jm.options.radius or 50)
for lqxbMC,Z in pairs(cyBmTv)do
if Z~=ZQOXXXd and qOk5Jm.toRemove~=true and
qOk5Jm.alreadyCollided[GetHandleId(Z)]~=true then
qOk5Jm.alreadyCollided[GetHandleId(Z)]=true;local Dw=false;if qOk5Jm.options.onCollide then
Dw=qOk5Jm.options.onCollide(Z)end;if Dw then ZmbDgbg(qOk5Jm)end end end;local _TKd0F=hMxy(qOk5Jm.options)
if qOk5Jm.toRemove then elseif
not qOk5Jm.options.permanent and
(
zBMvU6(tpSe2fs,_TKd0F.x,15)and zBMvU6(AuVgc7,_TKd0F.y,15)or hj3(qOk5Jm))then
ZmbDgbg(qOk5Jm)else local bsFpM;local h
if qOk5Jm.options.fromAngle~=nil then
local doBTofya=qOk5Jm.options.fromUnit and
Hhwf3oO:new{x=GetUnitX(qOk5Jm.options.fromUnit),y=GetUnitY(qOk5Jm.options.fromUnit)}or
qOk5Jm.options.fromV;local rNP=qOk5Jm.curRotation;local TL=qOk5Jm.curRadius
local Tzgj_W=rNP+

(qOk5Jm.options.speed* (
qOk5Jm.options.toAngle-qOk5Jm.options.fromAngle))/ (2*math.pi*TL)*ARnO_0E
local g0AS39=TL+
(
(qOk5Jm.options.toRadius-qOk5Jm.options.fromRadius)/
((2*math.pi*TL)/ (qOk5Jm.options.speed)))*ARnO_0E;qOk5Jm.curRadius=g0AS39;qOk5Jm.curRotation=Tzgj_W
bsFpM=Hhwf3oO:fromAngle(Tzgj_W):multiply(g0AS39):add(doBTofya)
h=Tzgj_W+math.pi/2*qOk5Jm.options.angleDir else
local t2=Hhwf3oO:new(_TKd0F):subtract(vxnB)
bsFpM=Hhwf3oO:new(t2):normalize():multiply(
qOk5Jm.options.speed*ARnO_0E)
if bsFpM:magnitude()>=t2:magnitude()then bsFpM=t2 end;bsFpM:add(vxnB)
h=Atan2(_TKd0F.y-qOk5Jm.options.fromV.y,
_TKd0F.x-qOk5Jm.options.fromV.x)end;SetUnitFacing(qOk5Jm.unit,bj_RADTODEG*h)
SetUnitX(qOk5Jm.unit,bsFpM.x)SetUnitY(qOk5Jm.unit,bsFpM.y)if qOk5Jm.options.onMove then
qOk5Jm.options.onMove(bsFpM.x,bsFpM.y)end end end;local Qh={}
for PDewNmM,GFlD in pairs(emGbhJGH)do if GFlD~=nil and GFlD.toRemove~=true then
table.insert(Qh,GFlD)end end;emGbhJGH=Qh end
local guEhw=function()e_Ev8OQ=CreateTimer()
TimerStart(e_Ev8OQ,0.03125,true,M7q3pa8)end
local sll=function(y3owm5E)local psHOEe2=hMxy(y3owm5E)
if y3owm5E.length~=nil then
local YyS=Hhwf3oO:new(psHOEe2):subtract(y3owm5E.fromV):normalize():multiply(y3owm5E.length):add(y3owm5E.fromV)psHOEe2=YyS;y3owm5E.toV=psHOEe2 end
local R1zT=y3owm5E.fromUnit and
Hhwf3oO:new{x=GetUnitX(y3owm5E.fromUnit),y=GetUnitY(y3owm5E.fromUnit)}or y3owm5E.fromV
if y3owm5E.projectile==nil then local o;local MY16y
if y3owm5E.fromAngle~=nil and
y3owm5E.fromRadius~=nil then
o=Hhwf3oO:fromAngle(y3owm5E.fromAngle):multiply(y3owm5E.fromRadius):add(R1zT)y3owm5E.radiusDir=
y3owm5E.fromRadius>y3owm5E.toRadius and-1 or 1
y3owm5E.angleDir=
y3owm5E.fromAngle>y3owm5E.toAngle and-1 or 1
MY16y=y3owm5E.fromAngle+math.pi/2*y3owm5E.angleDir else o=Hhwf3oO:new(R1zT)
MY16y=Atan2(psHOEe2.y-R1zT.y,psHOEe2.x-R1zT.x)end
y3owm5E.projectile=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),FourCC(y3owm5E.model),o.x,o.y,
bj_RADTODEG*MY16y)y3owm5E.shouldRemove=true else y3owm5E.shouldRemove=false end
local J2Df={unit=y3owm5E.projectile,options=y3owm5E,alreadyCollided={},curRadius=y3owm5E.fromRadius,curRotation=y3owm5E.fromAngle}table.insert(emGbhJGH,J2Df)return J2Df end;return{init=guEhw,createProjectile=sll,destroyProjectile=ZmbDgbg}end
local X=function()local ZBUghmX=require('src/spells/generic/heal.lua')
local ncK=require('src/spells/generic/attack.lua')local Deq=require('src/spells/generic/stop.lua')
local GH3wE=require('src/spells/azora/fireball.lua')local xZFv=require('src/spells/azora/frostnova.lua')
local bc0w4j=require('src/spells/azora/frostorb.lua')local OGMxal0=require('src/spells/azora/blink.lua')
local QlewVjkq=require('src/spells/azora/meteor.lua')local Q=require('src/spells/azora/firelance.lua')
local yI=require('src/spells/azora/phoenix.lua')local EDE3=require('src/spells/azora/fireshell.lua')
local FpWG11U=require('src/spells/azora/icicle.lua')local kRY46C=require('src/spells/azora/firestorm.lua')
local MvOaiq=require('src/spells/azora/frostballs.lua')local DUic_1K=require('src/spells/yuji/slash.lua')
local rVj9z4=require('src/spells/yuji/dash.lua')local mWkmCx=require('src/spells/yuji/throwingstar.lua')
local qQpo=require('src/spells/yuji/slashult.lua')local qXKzBXo0=require('src/spells/yuji/focus.lua')
local cJ=require('src/spells/yuji/jab.lua')local HI4G3oH=require('src/spells/yuji/stun.lua')
local ncWw=require('src/spells/yuji/blind.lua')local kdS=require('src/spells/stormfist/punch.lua')
local OS60=require('src/spells/tarcza/whirlwind.lua')local dl=require('src/spells/tarcza/curshout.lua')
local b2UK=require('src/spells/tarcza/shieldcharge.lua')local FC0yhp=require('src/spells/tarcza/stalwartshell.lua')
local lL30T=require('src/spells/tarcza/boomerang.lua')local zt=require('src/spells/tarcza/bulwark.lua')
local Ofgm3g=require('src/spells/tarcza/blitz.lua')local z6WE21dc=require('src/spells/tarcza/challenge.lua')
local rJg9H=require('src/spells/tarcza/flag.lua')local sNyznm3W=require('src/spells/ivanov/rejuvpot.lua')
local UU=require('src/spells/ivanov/armorpot.lua')local YBciOAz2=require('src/spells/ivanov/molecregen.lua')
local wJvNH=require('src/spells/ivanov/corrosiveblast.lua')local dOvZoN=require('src/spells/ivanov/accmist.lua')
local IP01vP=require('src/spells/ivanov/cleansingpot.lua')local DIoX3=require('src/spells/ivanov/hulkingpot.lua')
local sjXYan=require('src/spells/ivanov/dampenpot.lua')local KxB8fW=require('src/spells/ivanov/pocketgoo.lua')
local MJmyAd=require('src/hero.lua')local LU=require('src/spells/cooldowns.lua')
local uAbuU={heal=ZBUghmX,attack=ncK,stop=Deq,fireball=GH3wE,frostnova=xZFv,frostorb=bc0w4j,blink=OGMxal0,meteor=QlewVjkq,firelance=Q,phoenix=yI,fireshell=EDE3,icicle=FpWG11U,firestorm=kRY46C,frostballs=MvOaiq,slash=DUic_1K,dash=rVj9z4,throwingstar=mWkmCx,slashult=qQpo,focus=qXKzBXo0,jab=cJ,stun=HI4G3oH,blind=ncWw,punch=kdS,whirlwind=OS60,curshout=dl,shieldcharge=b2UK,stalwartshell=FC0yhp,boomerang=lL30T,bulwark=zt,blitz=Ofgm3g,challenge=z6WE21dc,flag=rJg9H,rejuvpot=sNyznm3W,armorpot=UU,molecregen=YBciOAz2,corrosiveblast=wJvNH,accmist=dOvZoN,cleansingpot=IP01vP,hulkingpot=DIoX3,dampenpot=sjXYan,pocketgoo=KxB8fW}local EF205E={}
local YFR5myC=function(a,i)local t=MJmyAd.getPickedHero(a)if t==nil then return nil end;return
uAbuU[t.spells[i]]end
local K1Lgio=function(TmE,xR)local LJ3E=MJmyAd.getPickedHero(TmE)
if LJ3E==nil then return nil end;return LJ3E.spells[xR]end
local KMu=function(Vjx,curjMDD)if IsUnitPaused(MJmyAd.getHero(Vjx))then return end;if
GetUnitState(MJmyAd.getHero(Vjx),UNIT_STATE_LIFE)<=0 then return end
local gBS9Zk=YFR5myC(Vjx,curjMDD)if gBS9Zk~=nil then gBS9Zk.cast(Vjx)end end
local PPqE=function(Xr,UPp)local hWpZC=YFR5myC(Xr,UPp)if hWpZC~=nil then return
LU.getRemainingCooldown(Xr,hWpZC.getSpellId())end;return 0 end
local sOE=function(bFF8,RXM)local Ieb1cGC=YFR5myC(bFF8,RXM)
if Ieb1cGC~=nil then
local Bf=Ieb1cGC.getSpellId()local hKJi2=LU.getTotalCooldown(bFF8,Bf)
local jW=LU.getRemainingCooldown(bFF8,Bf)if hKJi2 ~=0 then return jW/hKJi2 end end;return 1 end
local hf9m_U8=function(JkVK,oXM7)local z__Va=YFR5myC(JkVK,oXM7)
if z__Va~=nil then return z__Va.getIcon()end;return""end
local dTQ=function(uGbp,OXK0)local Ek3QueoD=K1Lgio(uGbp,OXK0)
if Ek3QueoD~=nil then return EF205E[Ek3QueoD]end;return""end
local k29Z4=function()
for g,m_l in pairs(uAbuU)do local LXmcB=m_l.getSpellName()
local l5Nd=m_l.getSpellCooldown()local sEMv=m_l.getSpellCasttime()
local VPX=m_l.getSpellTooltip()
EF205E[g]="|cff155ed4"..
LXmcB.."|r|n|n"..
"Cooldown: "..l5Nd.."s|n"..
"Cast time: "..sEMv.."s|n".."|n"..VPX end end
return{init=k29Z4,castSpell=KMu,getCooldown=PPqE,getCooldownPct=sOE,getIcon=hf9m_U8,getSpellTooltip=dTQ}end
local dR=function()local c=require('src/hero.lua')
local VGJdue=require('src/log.lua')local ztMtdy={}local rA={}local zHapMi=function(F)return ztMtdy[F]end;local Jmsve1Q=function(FN7)return
ztMtdy[FN7]~=nil end
local _B8W1YL=function()
local cpNryuPy=GetPlayerId(GetTriggerPlayer())if c.getHero(cpNryuPy)==nil then return end
local mVKRd8=GetTriggerUnit()if not rA[cpNryuPy]then ztMtdy[cpNryuPy]=mVKRd8 end;rA[cpNryuPy]=
nil
if mVKRd8 ~=c.getHero(cpNryuPy)then rA[cpNryuPy]=true;if cpNryuPy==
GetPlayerId(GetLocalPlayer())then ClearSelection()
SelectUnit(c.getHero(cpNryuPy),true)end end end
function init()local TBV0052=CreateTrigger()for cGBeq=0,bj_MAX_PLAYERS,1 do
TriggerRegisterPlayerUnitEvent(TBV0052,Player(cGBeq),EVENT_PLAYER_UNIT_SELECTED,
nil)end
TriggerAddAction(TBV0052,_B8W1YL)end;return{init=init,getTarget=zHapMi}end
local JFXtQwy=function()local PRXb=require('src/vector.lua')local t={}function getSpawnPoint(Jk3TbYo)return
t[GetUnitUserData(Jk3TbYo)]end
function storeUnit()
local Nm61D3Il=GetEnumUnit()if not BlzGetUnitBooleanField(Nm61D3Il,UNIT_BF_RAISABLE)then
return end;if GetOwningPlayer(Nm61D3Il)~=
Player(PLAYER_NEUTRAL_AGGRESSIVE)then return end
local Qjx7nk=#t+1;SetUnitUserData(Nm61D3Il,Qjx7nk)
t[Qjx7nk]=PRXb:new{x=GetUnitX(Nm61D3Il),y=GetUnitY(Nm61D3Il)}end;function init()
ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()),storeUnit)end
return{init=init,getSpawnPoint=getSpawnPoint}end
local uMV17h0=function()local ZfqIP={x=0,y=0}
local p4ZD2RW=function(o)if o>=0 then return o end;return-o end
function ZfqIP:new(QK5cr)QK5cr={x=QK5cr.x,y=QK5cr.y}
setmetatable(QK5cr,self)self.__index=self;return QK5cr end;function ZfqIP:fromAngle(e575)
return ZfqIP:new{x=Cos(e575),y=Sin(e575)}end;function ZfqIP:add(OP)self.x=self.x+OP.x;self.y=
self.y+OP.y;return self end
function ZfqIP:subtract(HxUqj4B)self.x=
self.x-HxUqj4B.x;self.y=self.y-HxUqj4B.y;return self end;function ZfqIP:multiply(dryo7a)self.x=self.x*dryo7a;self.y=self.y*dryo7a
return self end;function ZfqIP:divide(Vvmt)
self.x=self.x/Vvmt;self.y=self.y/Vvmt;return self end;function ZfqIP:magnitude(z1jKKH)
return p4ZD2RW(SquareRoot(
self.x^2+self.y^2))end;function ZfqIP:angle()
return Atan2(self.y,self.x)end;function ZfqIP:normalize()local Ai=self:magnitude()return
self:divide(Ai)end;return ZfqIP end
local E2NZK=function()local _ASR7X=require('src/vector.lua')
local lneZ2=require('src/threat.lua')local wZLxwQr={}function wZLxwQr:new(Z)Z=Z or{}setmetatable(Z,self)self.__index=self
return Z end
function wZLxwQr:getName()return"Bandit Lord"end
function wZLxwQr:getBounds()return
{{x=3317,y=3082},{x=1710,y=1886},{x=1650,y=594},{x=3099,y=-1069},{x=4999,y=1130}}end
function wZLxwQr:spawnAdds()
for b3h1=0,2,1 do
local AGn=_ASR7X:new{x=GetUnitX(self.bossUnit),y=GetUnitY(self.bossUnit)}
local EQVz=_ASR7X:fromAngle(GetRandomReal(0,2*bj_PI)):multiply(
BlzGetUnitCollisionSize(self.bossUnit)+150):add(AGn)
local pYXX=CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),FourCC("nban"),EQVz.x,EQVz.y,GetRandomReal(0,180))local GvHSsw=self.ctx.getRandomInvolvedHero()
lneZ2.addThreat(GvHSsw,pYXX,100)end end;function wZLxwQr:castSlam()
IssueImmediateOrder(self.bossUnit,"creepthunderclap")end
function wZLxwQr:init()
local XvK5=self.ctx:registerPhase{hp=100}
XvK5:addTimedEvent(25,function()self:spawnAdds()end)
XvK5:addTimedEvent(10,function()self:castSlam()end)self.ctx:registerDoor(gg_dest_LTg2_2324)end;return wZLxwQr end
local WNWWe=function()local bK2=require('src/bosses/banditlord.lua')
local U=require('src/items/backpack.lua')local FVkHUl7=require('src/hero.lua')
local FOA=require('src/collision.lua')
local eF0tAUG={bK2:new{bossUnitId=FourCC('hbld'),startX=2818.7,startY=1630.3,facing=300}}local _x={timers={},timedEvents={}}function _x:new(r)r=r or{}setmetatable(r,self)
self.__index=self;return r end;function _x:addTimedEvent(PKiW0,odc5tp)
table.insert(self.timedEvents,{interval=PKiW0,func=odc5tp})end
function _x:startPhase()
for t3yD,_nofE2 in
pairs(self.timedEvents)do local kPOaEej=CreateTimer()
TimerStart(kPOaEej,_nofE2.interval,true,_nofE2.func)table.insert(self.timers,kPOaEej)end end;function _x:endPhase()
for XrKR,EZSc2rAA in pairs(self.timers)do DestroyTimer(EZSc2rAA)end;self.timers={}end
local J2o6d={phases={},involvedHeroes={},doors={}}function J2o6d:new(r0aOmY)r0aOmY=r0aOmY or{}setmetatable(r0aOmY,self)
self.__index=self;return r0aOmY end;function J2o6d:registerDoor(YzL3P1)
table.insert(self.doors,YzL3P1)end;function J2o6d:registerPhase(a2)local hrEWj=_x:new()
table.insert(self.phases,{options=a2,phase=hrEWj})return hrEWj end
function J2o6d:getHeroesInPoly()
local Qgeq={}
for ay_Dm=0,bj_MAX_PLAYERS,1 do local z8K0j=FVkHUl7.getHero(ay_Dm)if z8K0j~=nil and
FOA.isCollidedWithPolygon(z8K0j,self.cls:getBounds())then
Qgeq[GetHandleId(z8K0j)]=z8K0j end end;return Qgeq end
function J2o6d:onFightEnded()
if
GetUnitState(self.cls.bossUnit,UNIT_STATE_LIFE)<=0 then print("You killed bandit captain.")for yh=0,bj_MAX_PLAYERS,1 do
U.addItemIdToBackpack(yh,1)end;self:cleanupFight()return end
self.involvedHeroes[GetHandleId(GetTriggerUnit())]=nil;if self:isAllInvolvedHeroesDead()then print("You lost.")
self:resetFight()return end end
function J2o6d:isAllInvolvedHeroesDead()for Yo,FVkHUl7 in pairs(self.involvedHeroes)do
if FVkHUl7 ~=nil then return false end end;return true end
function J2o6d:fixEngagement()
for nkWKbF=0,bj_MAX_PLAYERS,1 do local FVkHUl7=FVkHUl7.getHero(nkWKbF)
if
FVkHUl7 ~=nil then
local M9=FOA.isCollidedWithPolygon(FVkHUl7,self.cls:getBounds())
if
self.involvedHeroes[GetHandleId(FVkHUl7)]~=nil and not M9 then
SetUnitPosition(FVkHUl7,self.cls.startX,self.cls.startY)elseif
self.involvedHeroes[GetHandleId(FVkHUl7)]==nil and M9 then SetUnitPosition(FVkHUl7,0,0)end end end end
function J2o6d:onBossEngaged()local cVvE=GetEventDamageSource()if
GetUnitState(cVvE,UNIT_STATE_LIFE)<=0 then return end;print(
self.cls:getName().." engaged...")
DestroyTrigger(self.startFightTrigger)self.endFightTrigger=CreateTrigger()
self.involvedHeroes=self:getHeroesInPoly()for R8,FVkHUl7 in pairs(self.involvedHeroes)do
TriggerRegisterUnitEvent(self.endFightTrigger,FVkHUl7,EVENT_UNIT_DEATH)end
TriggerRegisterUnitEvent(self.endFightTrigger,self.cls.bossUnit,EVENT_UNIT_DEATH)
TriggerAddAction(self.endFightTrigger,function()self:onFightEnded()end)
for CsDz,u in pairs(self.phases)do u.phase:startPhase()end;self.engageTimer=CreateTimer()
TimerStart(self.engageTimer,3,true,function()
self:fixEngagement()end)
for Ru8E,nK in pairs(self.doors)do ModifyGateBJ(bj_GATEOPERATION_CLOSE,nK)end end
function J2o6d:cleanupFight()for m5STS,CJ4gk6Xx in pairs(self.phases)do
CJ4gk6Xx.phase:endPhase()end
DestroyTrigger(self.endFightTrigger)DestroyTimer(self.engageTimer)end
function J2o6d:resetFight()self:cleanupFight()
self.startFightTrigger=CreateTrigger()
TriggerRegisterUnitEvent(self.startFightTrigger,self.cls.bossUnit,EVENT_UNIT_DAMAGED)
TriggerAddAction(self.startFightTrigger,function()self:onBossEngaged()end)for YAwrq,VHZ4I in pairs(self.doors)do
ModifyGateBJ(bj_GATEOPERATION_OPEN,VHZ4I)end
local WwPLCA3t=BlzGetUnitMaxHP(self.cls.bossUnit)
BlzSetUnitRealField(self.cls.bossUnit,UNIT_RF_HP,WwPLCA3t)
IssuePointOrder(self.cls.bossUnit,"move",self.cls.startX,self.cls.startY)end
function init()
for JTS,zRbXf in pairs(eF0tAUG)do
zRbXf.bossUnit=CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),zRbXf.bossUnitId,zRbXf.startX,zRbXf.startY,zRbXf.facing)zRbXf.ctx=J2o6d:new{idx=JTS,cls=zRbXf}
zRbXf:init()zRbXf.ctx:resetFight()end end;return{init=init}end
local zMzjn3lk=function()local caDLM=require('src/vector.lua')
local Pj=require('src/spawnpoint.lua')local xm=require('src/hero.lua')local we={}
function pruneThreatLevels()local uv={}
for eu,j7Zsjoj in pairs(we)do
local VDXpXH={}local NT23H=false
if
GetUnitState(j7Zsjoj.unit,UNIT_STATE_LIFE)>0 then local N8WCvTtk=Pj.getSpawnPoint(j7Zsjoj.unit)
for vk7,aaOq in
pairs(j7Zsjoj.threats)do
local F7JMSq_H=GetUnitState(aaOq.unit,UNIT_STATE_LIFE)>0
local BNZ09E=caDLM:new{x=GetUnitX(aaOq.unit),y=GetUnitY(aaOq.unit)}local mcJGlQD6=true;if N8WCvTtk then
local AcM1nG=BNZ09E:subtract(N8WCvTtk):magnitude()mcJGlQD6=AcM1nG<=1500 end;if
F7JMSq_H and mcJGlQD6 then NT23H=true;VDXpXH[vk7]=aaOq end end;j7Zsjoj.threats=VDXpXH;uv[eu]=j7Zsjoj end end;we=uv end
function manageAggroRanges()
for mMJQWw=0,bj_MAX_PLAYERS,1 do local xm=xm.getHero(mMJQWw)
if xm then
local sC=Location(GetUnitX(xm),GetUnitY(xm))
ForGroupBJ(GetUnitsInRangeOfLocAll(500,sC),function()local RE=GetEnumUnit()if
GetOwningPlayer(RE)==Player(PLAYER_NEUTRAL_AGGRESSIVE)then
addThreat(xm,RE,0.01)end end)RemoveLocation(sC)end end end
function onTick()manageAggroRanges()pruneThreatLevels()
for mPRxk,iVO in pairs(we)do local S5PgiAbz
local jj1oYjc=0;local YVjxMh=iVO.unit
for sERpty,R9WhkbR in pairs(iVO.threats)do if R9WhkbR.threat>jj1oYjc then
jj1oYjc=R9WhkbR.threat;S5PgiAbz=R9WhkbR.unit end end
if S5PgiAbz~=nil then IssueTargetOrder(YVjxMh,"attack",S5PgiAbz)else
local Wjj=Pj.getSpawnPoint(YVjxMh)IssuePointOrder(YVjxMh,"move",Wjj.x,Wjj.y)end end end;function addThreat(X9n9mro,Uj6hK,qk3r)end;function init()end
return{init=init,addThreat=addThreat}end
local Trkkpmd=function()local Otbx_3g=require('src/buff.lua')
local XRg=require('src/buffs/ignite.lua')local Q7c8C2T=require('src/buffs/corrosivedecay.lua')
function init()
Otbx_3g.registerBuff('ignite',XRg)Otbx_3g.registerBuff('corrosivedecay',Q7c8C2T)end;return{init=init}end
local L=function()local Gz=require('src/effect.lua')
local XfMQy=require('src/vector.lua')local mu_2r=require('src/collision.lua')
local Es=require('src/damage.lua')local c=require('src/buff.lua')
return
{effects={{type='damage',amount=10,tickrate=1}},vfx={model="Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedDamage.mdl",attach="chest"},icon="ReplaceableTextures\\CommandButtons\\BTNLiquidFire.blp",maxStacks=5,onMaxStacks=function(C,o0Xe6nHM)
c.removeBuff(C,'ignite')local ulAVnjc=o0Xe6nHM.source
local zF6Bw=GetPlayerId(GetOwningPlayer(ulAVnjc))
local zuKqH=XfMQy:new{x=GetUnitX(C),y=GetUnitY(C)}
Gz.createEffect{model="emei",x=zuKqH.x,y=zuKqH.y,duration=1}local litdqp=mu_2r.getAllCollisions(zuKqH,100)
for r,n in pairs(litdqp)do if
IsUnitEnemy(n,Player(zF6Bw))then Es.dealDamage(ulAVnjc,n,100)end end;return true end}end
local GGv=function()
local uSzWLeSi={HELMET=1,NECK=2,CHEST=3,BACK=4,HANDS=5,LEGS=6,FEET=7,RING=8,WEAPON=9}local phUBXWJ9={}local Qgtt7={}
function equipItem(ngCGBaF,A8TTTd8,yGa)phUBXWJ9[ngCGBaF][A8TTTd8]=yGa end
function unequipItem(j4bdRB6o,f8jh)phUBXWJ9[j4bdRB6o][f8jh]=nil end
function getItemInSlot(OLzzUp,VlN)
if phUBXWJ9[OLzzUp][VlN]==0 then return nil end;return phUBXWJ9[OLzzUp][VlN]end
local yTthTeWK=function(r,mhEYg)
if getItemInSlot(r,mhEYg)~=nil then Qgtt7[r]=mhEYg else Qgtt7[r]=nil end end;local pG=function(rUJN6)return Qgtt7[rUJN6]end;local um_kO=function(cYH30J)return
phUBXWJ9[cYH30J]end;function clear(VR)for pyzkzd=1,9,1 do phUBXWJ9[VR][pyzkzd]=
nil end end
function init()for ksDuO71=0,bj_MAX_PLAYERS,1
do phUBXWJ9[ksDuO71]={}end end
return
{init=init,SLOT=uSzWLeSi,clear=clear,equipItem=equipItem,unequipItem=unequipItem,getItemInSlot=getItemInSlot,activateItem=yTthTeWK,getActiveItem=pG,getEquippedItems=um_kO}end
local ZIzh4Si=function()local BAy=require('src/buff.lua')
return
{effects={},icon="ReplaceableTextures\\CommandButtons\\BTNPotionOfVampirism.blp",maxStacks=10,onMaxStacks=function(tTCbo2,p)
BAy.removeBuff(tTCbo2,'corrosivedecay')
BAy.addBuff(p.source,tTCbo2,'corrosivedecaydot',15)return true end}end
local c8D4n81=function()local UNyk={}local cG0={}function addItemIdToBackpack(aascxP,eSG8f8ru)
table.insert(UNyk[aascxP],eSG8f8ru)end;function addItemIdToBackpackPosition(w2yJAi,lH1c,CHS)
UNyk[w2yJAi][lH1c]=CHS end;function removeItemFromBackpack(fQdTWIXs,QG)
UNyk[fQdTWIXs][QG]=nil end
function getItemIdsInBackpack(d78)return UNyk[d78]end;function getItemIdAtPosition(C6pS,GwH)if UNyk[C6pS][GwH]==0 then return nil end;return
UNyk[C6pS][GwH]end
function swapPositions(O,sbuS4,Rrfir0)
local lXr=UNyk[O][sbuS4]UNyk[O][sbuS4]=UNyk[O][Rrfir0]UNyk[O][Rrfir0]=lXr end
local kzTZ7=function(hz,f)
if getItemIdAtPosition(hz,f)~=nil then cG0[hz]=f else cG0[hz]=nil end end;local f8SnhE4T=function(knCGg)return cG0[knCGg]end;function clear(UPf)for amxXn=1,36,1 do UNyk[UPf][amxXn]=
nil end end
function init()for CSwsYPyj=0,bj_MAX_PLAYERS,1
do UNyk[CSwsYPyj]={}end end
return
{init=init,clear=clear,addItemIdToBackpack=addItemIdToBackpack,addItemIdToBackpackPosition=addItemIdToBackpackPosition,removeItemFromBackpack=removeItemFromBackpack,getItemIdsInBackpack=getItemIdsInBackpack,getItemIdAtPosition=getItemIdAtPosition,swapPositions=swapPositions,activateItem=kzTZ7,getActiveItem=f8SnhE4T}end
local cSjJHx=function()local I9I=require('src/hero.lua')
local aB=require('src/items/equipment.lua')
local BiUZ8vx4={COMMON={color="|cffffffff",text="Common"},LEGENDARY={color="|cffc4ab1a",text="Legendary"}}
local v={[1]={name='The Sword of a Thousand Truths',icon="ReplaceableTextures\\CommandButtons\\BTNDaggerOfEscape.tga",itemLevel=999,requiredLevel=5,rarity=BiUZ8vx4.LEGENDARY,stats={{type='rawHp',amount=200}},slot=aB.SLOT.WEAPON}}local W8dN={}function computeTotalStats(eL)return{}end
function getItemInfo(U4G6f)return v[U4G6f]end;function getItemTooltip(gmhVDH)
return W8dN[gmhVDH]and W8dN[gmhVDH].text or""end;function getItemTooltipNumLines(a)return
W8dN[a]and W8dN[a].numLines or 0 end
function applyEquippedItemBuffs()
for NesXI=0,bj_MAX_PLAYERS,1
do local OZ8oHL=I9I.getPickedHero(NesXI)
local I9I=I9I.getHero(NesXI)
if OZ8oHL and I9I then local sa=OZ8oHL.baseHP
local hT=aB.getEquippedItems(NesXI)for zICb5,HB_RPF in pairs(hT)do local kJZlA=v[HB_RPF].stats
for zICb5,blNC in pairs(kJZlA)do if blNC.type=='rawHp'then sa=sa+
blNC.amount end end end
BlzSetUnitMaxHP(I9I,sa)end end end
function init()
TimerStart(CreateTimer(),0.1,true,applyEquippedItemBuffs)
for l,y9 in pairs(v)do local zMjtdB7KS=""local _M_Cmn9C=0
for GZQBW7r7,VHBi5G in pairs(y9.stats)do if VHBi5G.type=='rawHp'then zMjtdB7KS=zMjtdB7KS..'+'..
VHBi5G.amount..' HP|n'_M_Cmn9C=
_M_Cmn9C+1 end end
W8dN[l]={text=y9.rarity.color..
y9.name.."|r|n"..
"|cffe3e312Item level "..y9.itemLevel..
"|r|n".."Requires level "..y9.requiredLevel.."|n|n|cff00ff00"..
zMjtdB7KS,numLines=
_M_Cmn9C+4}end end
return
{init=init,getItemInfo=getItemInfo,computeTotalStats=computeTotalStats,getItemTooltip=getItemTooltip,getItemTooltipNumLines=getItemTooltipNumLines}end
local fa=function()local Z1D6NL=require('src/ui/consts.lua')
local XAy=require('src/casttime.lua')local zxyLTb={}
function zxyLTb:new(rhMWaiC)rhMWaiC=rhMWaiC or{}
setmetatable(rhMWaiC,self)self.__index=self;return rhMWaiC end
function zxyLTb:init()local pM=BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0)
local i=BlzCreateFrameByType("BACKDROP","castBarFrameBackground",pM,"",0)
BlzFrameSetSize(i,Z1D6NL.CAST_BAR_WIDTH,Z1D6NL.CAST_BAR_HEIGHT)
BlzFrameSetAbsPoint(i,FRAMEPOINT_CENTER,0.4,Z1D6NL.ACTION_ITEM_SIZE+Z1D6NL.BAR_HEIGHT*10)
BlzFrameSetTexture(i,"Replaceabletextures\\Teamcolor\\Teamcolor20.blp",0,true)
local k=BlzCreateFrameByType("BACKDROP","castBarFrameFilled",i,"",0)
BlzFrameSetSize(k,Z1D6NL.CAST_BAR_WIDTH,Z1D6NL.CAST_BAR_HEIGHT)
BlzFrameSetPoint(k,FRAMEPOINT_LEFT,i,FRAMEPOINT_LEFT,0,0)
BlzFrameSetTexture(k,"Replaceabletextures\\Teamcolor\\Teamcolor04.blp",0,true)self.frames={castBar=k,origin=i}return self end
function zxyLTb:update(hr)local MUcy5ca=self.frames
local ycyK=XAy.getCastDurationRemaining(hr)local Yfm6hogh=XAy.getCastDurationTotal(hr)
if
ycyK~=nil and Yfm6hogh~=nil then BlzFrameSetVisible(MUcy5ca.origin,true)
BlzFrameSetSize(MUcy5ca.castBar,
Z1D6NL.CAST_BAR_WIDTH* (1-ycyK/Yfm6hogh),Z1D6NL.CAST_BAR_HEIGHT)else BlzFrameSetVisible(MUcy5ca.origin,false)
BlzFrameSetSize(MUcy5ca.castBar,0,Z1D6NL.CAST_BAR_HEIGHT)end end;return zxyLTb end
local M=function()local T6eti=require('src/log.lua')
local z7j=require('src/ui/consts.lua')local CGz=require('src/ui/tooltip.lua')
local aukN3ZWX=require('src/ui/utils.lua')local eSCsri5=require('src/items/backpack.lua')
local _g10f_=require('src/items/equipment.lua')local r4cyFP=require('src/items/itemmanager.lua')local fcSy4_k0={}
local TrC17={toggle=function(MEwJPiqM)fcSy4_k0[MEwJPiqM]=
not fcSy4_k0[MEwJPiqM]end}function TrC17:new(jHIxW_)jHIxW_=jHIxW_ or{}setmetatable(jHIxW_,self)
self.__index=self;return jHIxW_ end
function TrC17:init()
local gny=BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0)
local KabKdEUu=BlzCreateFrameByType("FRAME","backpackOrigin",gny,"",0)
BlzFrameSetSize(KabKdEUu,z7j.BACKPACK_SIZE,z7j.BACKPACK_SIZE+0.02)
BlzFrameSetAbsPoint(KabKdEUu,FRAMEPOINT_CENTER,0.565,0.32)aukN3ZWX.createBorderFrame(KabKdEUu)
local oQ8AOvfn=BlzCreateFrameByType("TEXT","backpackText",KabKdEUu,"",0)BlzFrameSetSize(oQ8AOvfn,z7j.BACKPACK_SIZE,0.012)
BlzFrameSetPoint(oQ8AOvfn,FRAMEPOINT_TOPLEFT,KabKdEUu,FRAMEPOINT_TOPLEFT,0.01,
-0.01)BlzFrameSetText(oQ8AOvfn,"Inventory: 0/36")
local m=BlzCreateFrameByType("TEXT","goldText",KabKdEUu,"",0)BlzFrameSetSize(m,z7j.BACKPACK_SIZE,0.012)
BlzFrameSetPoint(m,FRAMEPOINT_BOTTOMLEFT,KabKdEUu,FRAMEPOINT_BOTTOMLEFT,0.01,0.01)BlzFrameSetText(m,"Gold: 0")local cX88nonB={}
for kkWQP4=0,35,1 do
local E4F=BlzCreateFrameByType("GLUETEXTBUTTON","itemOrigin",KabKdEUu,"",0)
BlzFrameSetSize(E4F,z7j.BACKPACK_ITEM_SIZE,z7j.BACKPACK_ITEM_SIZE)
BlzFrameSetPoint(E4F,FRAMEPOINT_TOPLEFT,KabKdEUu,FRAMEPOINT_TOPLEFT,(kkWQP4%6)*
(z7j.BACKPACK_ITEM_SIZE+0.004)+0.02,
-math.floor(kkWQP4/6)* (z7j.BACKPACK_ITEM_SIZE+0.004)-0.03)
local E=BlzCreateFrameByType("BACKDROP","itemFrame",E4F,"",0)BlzFrameSetAllPoints(E,E4F)
local IGef7Hc5=BlzCreateFrameByType("BACKDROP","itemHighlight",E4F,"",0)BlzFrameSetAllPoints(IGef7Hc5,E4F)
BlzFrameSetTexture(IGef7Hc5,"Replaceabletextures\\Teamcolor\\Teamcolor21.blp",0,true)BlzFrameSetAlpha(IGef7Hc5,100)
local RY1=CGz.makeTooltipFrame(E4F,0.16,0.24,E4F,false)local bkV=CreateTrigger()
BlzTriggerRegisterFrameEvent(bkV,E4F,FRAMEEVENT_CONTROL_CLICK)
TriggerAddAction(bkV,function()local VOG=GetPlayerId(GetTriggerPlayer())
local r8MEhbdT=eSCsri5.getActiveItem(VOG)local klSf0ZT5=_g10f_.getActiveItem(VOG)
if klSf0ZT5 ~=nil then
if eSCsri5.getItemIdAtPosition(
kkWQP4+1)~=nil then
T6eti.log(VOG,"You already have an item in that bag position.",T6eti.TYPE.ERROR)else local t85a4rt=_g10f_.getItemInSlot(VOG,klSf0ZT5)
_g10f_.unequipItem(VOG,klSf0ZT5)
eSCsri5.addItemIdToBackpackPosition(VOG,kkWQP4+1,t85a4rt)end;eSCsri5.activateItem(VOG,nil)
_g10f_.activateItem(VOG,nil)elseif r8MEhbdT~=nil then
eSCsri5.swapPositions(VOG,r8MEhbdT,kkWQP4+1)eSCsri5.activateItem(VOG,nil)
_g10f_.activateItem(VOG,nil)else eSCsri5.activateItem(VOG,kkWQP4+1)end;BlzFrameSetEnable(BlzGetTriggerFrame(),false)
BlzFrameSetEnable(BlzGetTriggerFrame(),true)end)
table.insert(cX88nonB,{itemFrame=E,itemHighlight=IGef7Hc5,tooltipFrame=RY1})end;self.frames={itemFrames=cX88nonB,origin=KabKdEUu}return self end
function TrC17:update(OfQcD)local Yj=self.frames
BlzFrameSetVisible(Yj.origin,fcSy4_k0[OfQcD]==true)local LvKdRh=eSCsri5.getActiveItem(OfQcD)
for _D=1,36,1 do
local uYwYKAU=Yj.itemFrames[_D]local mq=eSCsri5.getItemIdAtPosition(OfQcD,_D)
if mq~=nil then
BlzFrameSetTexture(uYwYKAU.itemFrame,r4cyFP.getItemInfo(mq).icon,0,true)else
BlzFrameSetTexture(uYwYKAU.itemFrame,"InvTile.blp",0,true)end;local m7YIn=r4cyFP.getItemTooltipNumLines(mq)BlzFrameSetSize(uYwYKAU.tooltipFrame.origin,0.16,
0.012*m7YIn)
BlzFrameSetSize(uYwYKAU.tooltipFrame.text,0.15,
0.012*m7YIn-0.01)
BlzFrameSetText(uYwYKAU.tooltipFrame.text,r4cyFP.getItemTooltip(mq)or"")
BlzFrameSetVisible(uYwYKAU.tooltipFrame.backdrop,m7YIn~=0)
BlzFrameSetVisible(uYwYKAU.itemHighlight,LvKdRh==_D)end end;return TrC17 end
local dIZlrvD=function()local tYqOsEJ=require('src/ui/consts.lua')
local udoq=require('src/ui/tooltip.lua')local boTHtaG=require('src/spell.lua')
local zbQgT={"Q","W","E","R","A","S","D","F","Z","X","C","V"}local duYPlVu={}function duYPlVu:new(n5)n5=n5 or{}setmetatable(n5,self)
self.__index=self;return n5 end
function duYPlVu:init()
local zl5hfbAb=BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0)local xVvJF=BlzCreateFrame("Leaderboard",zl5hfbAb,0,0)
BlzFrameSetSize(xVvJF,0.52,0.06)
BlzFrameSetAbsPoint(xVvJF,FRAMEPOINT_BOTTOMLEFT,0.15,0)
local zsKRyBU=BlzCreateFrameByType("BACKDROP","actionBar",zl5hfbAb,"",0)
BlzFrameSetSize(zsKRyBU,tYqOsEJ.ACTION_ITEM_SIZE*12,tYqOsEJ.ACTION_ITEM_SIZE)
BlzFrameSetAbsPoint(zsKRyBU,FRAMEPOINT_CENTER,0.4,tYqOsEJ.ACTION_ITEM_SIZE-0.01)
BlzFrameSetTexture(zsKRyBU,"Replaceabletextures\\Teamcolor\\Teamcolor20.blp",0,true)local Lukg={}
for rkKj=0,11,1 do
local yAaxRZGY=BlzCreateFrameByType("BACKDROP","actionItem",BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0),"",0)
BlzFrameSetSize(yAaxRZGY,tYqOsEJ.ACTION_ITEM_SIZE,tYqOsEJ.ACTION_ITEM_SIZE)
BlzFrameSetPoint(yAaxRZGY,FRAMEPOINT_LEFT,zsKRyBU,FRAMEPOINT_LEFT,rkKj*
(tYqOsEJ.ACTION_ITEM_SIZE+0.0015),0)
local _Tb=BlzCreateFrameByType("BACKDROP","actionCooldownBackdrop",yAaxRZGY,"",0)BlzFrameSetSize(_Tb,tYqOsEJ.ACTION_ITEM_SIZE,0)
BlzFrameSetPoint(_Tb,FRAMEPOINT_BOTTOM,yAaxRZGY,FRAMEPOINT_BOTTOM,0,0)
BlzFrameSetTexture(_Tb,"Replaceabletextures\\Teamcolor\\Teamcolor20.blp",0,true)BlzFrameSetAlpha(_Tb,200)
local BJRFwSz=BlzCreateFrameByType("BACKDROP","actionTintBackdrop",yAaxRZGY,"",0)
BlzFrameSetSize(BJRFwSz,tYqOsEJ.ACTION_ITEM_SIZE,tYqOsEJ.ACTION_ITEM_SIZE)
BlzFrameSetPoint(BJRFwSz,FRAMEPOINT_BOTTOM,yAaxRZGY,FRAMEPOINT_BOTTOM,0,0)
BlzFrameSetTexture(BJRFwSz,"Replaceabletextures\\Teamcolor\\Teamcolor20.blp",0,true)BlzFrameSetAlpha(BJRFwSz,60)
local C3MNkiZ=BlzCreateFrameByType("TEXT","actionItemHotkey",yAaxRZGY,"",0)BlzFrameSetSize(C3MNkiZ,0.01,0.01)
BlzFrameSetText(C3MNkiZ,zbQgT[rkKj+1])
BlzFrameSetPoint(C3MNkiZ,FRAMEPOINT_TOPLEFT,yAaxRZGY,FRAMEPOINT_TOPLEFT,0.002,-0.002)
local beAAh6T=BlzCreateFrameByType("TEXT","actionCooldownText",yAaxRZGY,"",0)
BlzFrameSetSize(beAAh6T,tYqOsEJ.ACTION_ITEM_SIZE,tYqOsEJ.ACTION_ITEM_SIZE)BlzFrameSetText(beAAh6T,"")
BlzFrameSetPoint(beAAh6T,FRAMEPOINT_CENTER,yAaxRZGY,FRAMEPOINT_CENTER,0,0)
BlzFrameSetTextAlignment(beAAh6T,TEXT_JUSTIFY_MIDDLE,TEXT_JUSTIFY_CENTER)local yUaD=udoq.makeTooltipFrame(yAaxRZGY,0.24,0.095)
table.insert(Lukg,{actionItemBackground=yAaxRZGY,actionCooldownBackdrop=_Tb,actionCooldownText=beAAh6T,tooltipFrame=yUaD})end;self.frames={actionItems=Lukg}return self end
function duYPlVu:update(Enu)local YJ31A6_=self.frames
for fChy5,DNPo4Wqt in pairs(YJ31A6_.actionItems)do
local S8Kb=boTHtaG.getCooldownPct(Enu,fChy5)local UMeQ=boTHtaG.getIcon(Enu,fChy5)
local AGhdl3=boTHtaG.getSpellTooltip(Enu,fChy5)
BlzFrameSetVisible(DNPo4Wqt.actionCooldownBackdrop,S8Kb~=0)
BlzFrameSetSize(DNPo4Wqt.actionCooldownBackdrop,tYqOsEJ.ACTION_ITEM_SIZE,tYqOsEJ.ACTION_ITEM_SIZE*S8Kb)
BlzFrameSetTexture(DNPo4Wqt.actionItemBackground,UMeQ,0,true)
BlzFrameSetText(DNPo4Wqt.tooltipFrame.text,AGhdl3)end end;return duYPlVu end
local jQgsATKd=function()local P32=0.025
return
{ACTION_ITEM_SIZE=0.04,CAST_BAR_WIDTH=0.16,CAST_BAR_HEIGHT=0.02,BAR_WIDTH=0.20,BAR_HEIGHT=0.01,BUFF_ICON_SIZE=0.02,BACKPACK_ITEM_SIZE=P32,BACKPACK_SIZE=P32*6+0.06,EQUIPMENT_ITEM_SIZE=0.03}end
local aBbGg=function()local xj1=table.remove;local rd=table.insert;local wtX={}local Y={}Y.prototype={}
Y.metatable={__index=Y.prototype}
function Y:new(i,yCkt)local irs579={}setmetatable(irs579,Y.metatable)
irs579.x=i or 0;irs579.y=yCkt or 0;return irs579 end
function Y.prototype:copy(ptD)self.x=ptD.x;self.y=ptD.y;return self end
function Y.prototype:clone()return Y:new(self.x,self.y)end
function Y.prototype:perp()local mj_P=self.x;self.x=self.y;self.y=-mj_P;return self end
function Y.prototype:rotate(w)local Nge6L=self.x;local aWnFL1=self.y;self.x=Nge6L*math.cos(w)-aWnFL1*
math.sin(w)self.y=
Nge6L*math.sin(w)+aWnFL1*math.cos(w)return self end
function Y.prototype:reverse()self.x=-self.x;self.y=-self.y;return self end
function Y.prototype:normalize()local D=self:len()if D>0 then self.x=self.x/D
self.y=self.y/D end;return self end
function Y.prototype:add(R)self.x=self.x+R.x;self.y=self.y+R.y;return self end;function Y.prototype:sub(u51)self.x=self.x-u51.x;self.y=self.y-u51.y
return self end
function Y.prototype:scale(O0NUxa,RngfRQ6g)
self.x=self.x*O0NUxa;self.y=self.y*RngfRQ6g or O0NUxa;return self end
function Y.prototype:project(F)local WSlpP=self:dot(F)/self:len2(F)self.x=
WSlpP*F.x;self.y=WSlpP*F.y;return self end
function Y.prototype:projectN(xSMd)local vYmD9ed=self:dot(xSMd)
self.x=vYmD9ed*xSMd.x;self.y=vYmD9ed*xSMd.y;return self end
function Y.prototype:reflect(Cez)local NvSMm=self.x;local wRpQf=self.y
self:project(Cez):scale(2,2)self.x=self.x-NvSMm;self.y=self.y-wRpQf;return self end
function Y.prototype:reflectN(ed9P)local NJ5=self.x;local bpAJ=self.y
self:projectN(ed9P):scale(2,2)self.x=self.x-NJ5;self.y=self.y-bpAJ;return self end;function Y.prototype:dot(UdPyHc)
return self.x*UdPyHc.x+self.y*UdPyHc.y end;function Y.prototype:len2()
return self:dot(self)end;function Y.prototype:len()
return math.sqrt(self:len2())end
wtX.Vector=function(SciVUxEq,Te)return Y:new(SciVUxEq,Te)end;local EHSv={}EHSv.prototype={}
EHSv.metatable={__index=EHSv.prototype}
function EHSv:new(WN,f)local FleDs3={}setmetatable(FleDs3,EHSv.metatable)FleDs3.pos=
WN or Y:new()FleDs3.r=f or 0;return FleDs3 end
wtX.Circle=function(LP,RLovoVo)return EHSv:new(LP,RLovoVo)end;local Ati7Oq={}Ati7Oq.prototype={}
Ati7Oq.metatable={__index=Ati7Oq.prototype}
function Ati7Oq:new(Je6Srpf8,p)local Z0RFr5F={}
setmetatable(Z0RFr5F,Ati7Oq.metatable)Z0RFr5F.pos=Je6Srpf8 or Y:new()Z0RFr5F.points=p or{}
Z0RFr5F.angle=0;Z0RFr5F.offset=Y:new()Z0RFr5F:recalc()return Z0RFr5F end
function Ati7Oq.prototype:setPoints(_Myb)self.points=_Myb;self:recalc()return self end
function Ati7Oq.prototype:setAngle(Zq)self.angle=Zq;self:recalc()return self end
function Ati7Oq.prototype:setOffset(TKS)self.offset=TKS;self:recalc()return self end
function Ati7Oq.prototype:rotate(DUSiwPZm)local QSjpjN5=self.points;local M3ptD1Cf=#QSjpjN5;for B=1,M3ptD1Cf do
QSjpjN5[B]:rotate(DUSiwPZm)end;self:recalc()return self end
function Ati7Oq.prototype:translate(jv,oTpq)local CjPV=self.points;local d=#CjPV
for z0=1,d do CjPV[z0].x=
CjPV[z0].x+jv;CjPV[z0].y=CjPV[z0].y+oTpq end;self:recalc()return self end
function Ati7Oq.prototype:recalc()self.calcPoints={}local I_bHR9bD=self.calcPoints
self.edges={}local YJha=self.edges;self.normals={}local g9QyV=self.normals;local An_hQ3m=self.points
local S=self.offset;local eMj5b1DD=self.angle;local lDdmS=#An_hQ3m
for k1kp870h=1,lDdmS do
local Xfv1_F=An_hQ3m[k1kp870h]:clone()I_bHR9bD[k1kp870h]=Xfv1_F;Xfv1_F.x=Xfv1_F.x+S.x;Xfv1_F.y=
Xfv1_F.y+S.y
if eMj5b1DD~=0 then Xfv1_F:rotate(eMj5b1DD)end end
for F74YQ=1,lDdmS do local SHlZ8Rw=I_bHR9bD[F74YQ]local FxP66=
F74YQ<lDdmS and I_bHR9bD[F74YQ+1]or I_bHR9bD[1]
local y=Y:new():copy(FxP66):sub(SHlZ8Rw)
local Ou=Y:new():copy(y):perp():normalize()YJha[F74YQ]=y;g9QyV[F74YQ]=Ou end;return self end
wtX.Polygon=function(AbN,lINgqxG1)return Ati7Oq:new(AbN,lINgqxG1)end;local Tqo2jko={}Tqo2jko.prototype={}
Tqo2jko.metatable={__index=Tqo2jko.prototype}
function Tqo2jko:new(Tz4j,vUctRT,ry0d9cxF)local fdMS0Bi={}
setmetatable(fdMS0Bi,Tqo2jko.metatable)fdMS0Bi.pos=Tz4j or Y:new()fdMS0Bi.w=vUctRT or 0;fdMS0Bi.h=
ry0d9cxF or 0;return fdMS0Bi end
function Tqo2jko.prototype:toPolygon()local jUfRhXXt=self.pos;local bncqpLFj=self.w;local c9P3=self.h;return
Ati7Oq:new(Y:new(jUfRhXXt.x,jUfRhXXt.y),{Y:new(),Y:new(bncqpLFj,0),Y:new(bncqpLFj,c9P3),Y:new(0,c9P3)})end
wtX.Box=function(D,AcO3SXQC,qiw)return Tqo2jko:new(D,AcO3SXQC,qiw)end;local uJz={}uJz.prototype={}uJz.metatable={__index=uJz.prototype}
function uJz:new()
local bQRP={}setmetatable(bQRP,uJz.metatable)bQRP.a=nil;bQRP.b=nil
bQRP.overlapN=Y:new()bQRP.overlapV=Y:new()bQRP.ppos={}bQRP:clear()return bQRP end;function uJz.prototype:clear()self.aInB=true;self.bInA=true;self.overlap=math.huge;return
self end;wtX.Response=function()
return uJz:new()end;local qVvlt={}
for K5=1,10 do qVvlt[K5]=Y:new()end;local aGkESg={}for MZubW5sf=1,5 do aGkESg[MZubW5sf]={}end
local KXnNMI7S=uJz:new()
local fL=Tqo2jko:new(Y:new(),1,1):toPolygon()
function flattenPointsOn(VLlBaUgt,QniH,j)local x_BU2=math.huge;local AFii=-math.huge;local Au=#VLlBaUgt
for fgK=1,Au do
local gm=VLlBaUgt[fgK]:dot(QniH)if gm<x_BU2 then x_BU2=gm end;if gm>AFii then AFii=gm end end;j[1]=x_BU2;j[2]=AFii end
function isSeparatingAxis(jwJufiF,YogtAPf,q7h,WS,Uee8Une,UtI)local Lqx27=xj1(aGkESg)local whvO=xj1(aGkESg)
local kpbY=xj1(qVvlt):copy(YogtAPf):sub(jwJufiF)local m_gHw=kpbY:dot(Uee8Une)
flattenPointsOn(q7h,Uee8Une,Lqx27)flattenPointsOn(WS,Uee8Une,whvO)
whvO[1]=whvO[1]+m_gHw;whvO[2]=whvO[2]+m_gHw
if
Lqx27[1]>whvO[2]or whvO[1]>Lqx27[2]then qVvlt[#qVvlt+1]=kpbY;aGkESg[#aGkESg+1]=Lqx27;aGkESg[
#aGkESg+1]=whvO;return true end
if UtI then local RFOr=0
if Lqx27[1]<whvO[1]then UtI.aInB=false
if Lqx27[2]<whvO[2]then RFOr=Lqx27[2]-
whvO[1]UtI.bInA=false else local g0d1ms_=Lqx27[2]-whvO[1]local Xmu5=
whvO[2]-Lqx27[1]
RFOr=g0d1ms_<Xmu5 and g0d1ms_ or-Xmu5 end else UtI.bInA=false
if Lqx27[2]>whvO[2]then RFOr=Lqx27[1]-whvO[2]
UtI.aInB=false else local lC3P=Lqx27[2]-whvO[1]local QwHnJ1MC=whvO[2]-Lqx27[1]RFOr=lC3P<
QwHnJ1MC and lC3P or-QwHnJ1MC end end;local NL=math.abs(RFOr)
if NL<UtI.overlap then UtI.overlap=NL
UtI.overlapN:copy(Uee8Une)if RFOr<0 then UtI.overlapN:reverse()end end end;qVvlt[#qVvlt+1]=kpbY;aGkESg[#aGkESg+1]=Lqx27;aGkESg[
#aGkESg+1]=whvO;return false end
function vornoiRegion(giqW,UJP9j)local SObxoJk=giqW:len2()local _nBsWM3x=UJP9j:dot(giqW)
if _nBsWM3x<0 then return
LEFT_VORNOI_REGION elseif _nBsWM3x>SObxoJk then return RIGHT_VORNOI_REGION else return MIDDLE_VORNOI_REGION end end;local Oj=-1;local pGR0Ig=0;local bBq=1
function pointInCircle(D5,IrgZln)
local vB=xj1(qVvlt):copy(D5):sub(IrgZln.pos)local vFea=IrgZln.r*IrgZln.r;local _T5=vB:len2()rd(qVvlt,vB)return
_T5 <=vFea end
wtX.pointInCircle=function(fx,ZkXY)return pointInCircle(fx,ZkXY)end
function pointInPolygon(sWJA,NVvo)fL.pos:copy(sWJA)KXnNMI7S:clear()
local P2Kd8=testPolygonPolygon(fL,NVvo,KXnNMI7S)if P2Kd8 then P2Kd8=KXnNMI7S.aInB end;return P2Kd8 end
wtX.pointInPolygon=function(asrUjwf,Q)return pointInPolygon(asrUjwf,Q)end
function testCircleCircle(ya253Ad,T49bAP,bS5Jz)
local yl=xj1(qVvlt):copy(T49bAP.pos):sub(ya253Ad.pos)local srV=ya253Ad.r+T49bAP.r;local tSO4=srV*srV;local ALU1Lf=yl:len2()if
ALU1Lf>tSO4 then rd(qVvlt,yl)return false end
if bS5Jz then
local odzL_=math.sqrt(ALU1Lf)bS5Jz.a=ya253Ad;bS5Jz.b=T49bAP;bS5Jz.overlap=srV-odzL_
bS5Jz.overlapN:copy(yl:normalize())
bS5Jz.overlapV:copy(yl):scale(bS5Jz.overlap,bS5Jz.overlap)
bS5Jz.aInB=(ya253Ad.r<=T49bAP.r and odzL_<=T49bAP.r-ya253Ad.r)
bS5Jz.bInA=(T49bAP.r<=ya253Ad.r and odzL_<=ya253Ad.r-T49bAP.r)end;rd(qVvlt,yl)return true end
wtX.testCircleCircle=function(rHhv,DUv3,qM23K)return testCircleCircle(rHhv,DUv3,qM23K)end
function testPolygonCircle(HnNik4,Tb,k)
local g=xj1(qVvlt):copy(Tb.pos):sub(HnNik4.pos)local mOxUSY=Tb.r;local t=mOxUSY*mOxUSY;local CY=HnNik4.calcPoints;local EPz43s=#CY
local zR=xj1(qVvlt)local ZiGUK4j=xj1(qVvlt)
for X5xyw_Y=1,EPz43s do
local Zb3oLBm1=X5xyw_Y==EPz43s and 0 or X5xyw_Y+1;local gVS=X5xyw_Y==0 and EPz43s or X5xyw_Y-1
local y7AFV=0;local BUtgk5wL=nil;zR:copy(HnNik4.edges[X5xyw_Y])
ZiGUK4j:copy(g):sub(CY[X5xyw_Y])if k and ZiGUK4j:len2()>t then k.aInB=false end
local yvkTFEw=vornoiRegion(zR,ZiGUK4j)
if yvkTFEw==Oj then zR.copy(HnNik4.edges[gVS])
local FPuu=xj1(qVvlt):copy(g):sub(CY[gVS])yvkTFEw=vornoiRegion(zR,FPuu)
if yvkTFEw==bBq then
local IM6lQ1nN=ZiGUK4j:len()
if IM6lQ1nN>mOxUSY then qVvlt[#qVvlt+1]=g;qVvlt[#qVvlt+1]=zR;qVvlt[
#qVvlt+1]=ZiGUK4j;qVvlt[#qVvlt+1]=FPuu;return false elseif
k then k.bInA=false;BUtgk5wL=ZiGUK4j:normalize()
y7AFV=mOxUSY-IM6lQ1nN end end;qVvlt[#qVvlt+1]=FPuu elseif yvkTFEw==bBq then
zR:copy(HnNik4.edges[Zb3oLBm1])ZiGUK4j:copy(g):sub(CY[Zb3oLBm1])
yvkTFEw=vornoiRegion(zR,ZiGUK4j)
if yvkTFEw==Oj then local cdRq=ZiGUK4j:len()
if cdRq>mOxUSY then
qVvlt[#qVvlt+1]=g;qVvlt[#qVvlt+1]=zR;qVvlt[#qVvlt+1]=ZiGUK4j;return false elseif k then
k.bInA=false;BUtgk5wL=ZiGUK4j:normalize()y7AFV=mOxUSY-cdRq end end else local rk6C=zR:perp():normalize()
local a4EodrlS=ZiGUK4j:dot(rk6C)local QDUH3=math.abs(a4EodrlS)
if a4EodrlS>0 and QDUH3 >mOxUSY then qVvlt[
#qVvlt+1]=g;qVvlt[#qVvlt+1]=rk6C
qVvlt[#qVvlt+1]=ZiGUK4j;return false elseif k then BUtgk5wL=rk6C;y7AFV=mOxUSY-a4EodrlS;if a4EodrlS>=0 or
y7AFV<2*mOxUSY then k.bInA=false end end end
if
BUtgk5wL and k and math.abs(y7AFV)<math.abs(k.overlap)then k.overlap=y7AFV;k.overlapN:copy(BUtgk5wL)end end;if k then k.a=HnNik4;k.b=Tb
k.overlapV:copy(k.overlapN):scale(k.overlap,k.overlap)end;qVvlt[#qVvlt+1]=g;qVvlt[#
qVvlt+1]=zR;qVvlt[#qVvlt+1]=ZiGUK4j;return true end
wtX.testPolygonCircle=function(FZNkY,AMQfXns,N)return testPolygonCircle(FZNkY,AMQfXns,N)end
function testCirclePolygon(Zv1xWmbK,usLtv,D0WSWx)local fI4Jq_JC=testPolygonCircle(usLtv,Zv1xWmbK,D0WSWx)
if
fI4Jq_JC and D0WSWx then local CK17=D0WSWx.a;local EN6EGq=D0WSWx.aInB
D0WSWx.overlapN:reverse()D0WSWx.overlapV:reverse()D0WSWx.a=D0WSWx.b
D0WSWx.b=CK17;D0WSWx.aInB=D0WSWx.bInA;D0WSWx.bInA=EN6EGq end;return fI4Jq_JC end
wtX.testCirclePolygon=function(_Nz,Lsvt0Xp,Js8fS1VE)return testCirclePolygon(_Nz,Lsvt0Xp,Js8fS1VE)end
function testPolygonPolygon(nfU,Zt78U,B_tZsz)local NUeM=nfU.calcPoints;local DiSdlMR3=#NUeM;local nE=Zt78U.calcPoints
local CIkqRkzw=#nE
for sBI=1,DiSdlMR3 do if
isSeparatingAxis(nfU.pos,Zt78U.pos,NUeM,nE,nfU.normals[sBI],B_tZsz)then return false end end
for vyewX=1,CIkqRkzw do if
isSeparatingAxis(nfU.pos,Zt78U.pos,NUeM,nE,Zt78U.normals[vyewX],B_tZsz)then return false end end;if B_tZsz then B_tZsz.a=nfU;B_tZsz.b=Zt78U
B_tZsz.overlapV:copy(B_tZsz.overlapN):scale(B_tZsz.overlap,B_tZsz.overlap)end;return true end
wtX.testPolygonPolygon=function(ZXMlRMR,CCo8Y,hx1fY90)
return testPolygonPolygon(ZXMlRMR,CCo8Y,hx1fY90)end;return wtX end
local D9=function()local dt7v=require('src/log.lua')
local HBjl=require('src/ui/consts.lua')local tcVr=require('src/ui/utils.lua')
local r=require('src/ui/tooltip.lua')local htj=require('src/items/backpack.lua')
local Ltq_xgJ=require('src/items/equipment.lua')local Re=require('src/items/itemmanager.lua')local cG3HJLZ={}
local LG={toggle=function(F9)cG3HJLZ[F9]=
not cG3HJLZ[F9]end}function LG:new(IbKWp)IbKWp=IbKWp or{}setmetatable(IbKWp,self)
self.__index=self;return IbKWp end
local x__e0OAv=function(j,nY4CweuF,Ttb,wIat2P0)
local m7M=BlzCreateFrameByType("GLUETEXTBUTTON","itemOrigin",j,"",0)
BlzFrameSetSize(m7M,HBjl.EQUIPMENT_ITEM_SIZE,HBjl.EQUIPMENT_ITEM_SIZE)
BlzFrameSetPoint(m7M,FRAMEPOINT_TOPLEFT,j,FRAMEPOINT_TOPLEFT,nY4CweuF,Ttb)
local J8=BlzCreateFrameByType("BACKDROP","itemFrame",m7M,"",0)BlzFrameSetAllPoints(J8,m7M)
local VchN=BlzCreateFrameByType("BACKDROP","itemHighlight",m7M,"",0)BlzFrameSetAllPoints(VchN,m7M)
BlzFrameSetTexture(VchN,"Replaceabletextures\\Teamcolor\\Teamcolor21.blp",0,true)BlzFrameSetAlpha(VchN,100)
local ws7lX6m_=r.makeTooltipFrame(m7M,0.16,0.24,m7M,Ttb>=-0.12)local cXif=CreateTrigger()
BlzTriggerRegisterFrameEvent(cXif,m7M,FRAMEEVENT_CONTROL_CLICK)
TriggerAddAction(cXif,function()local UV=GetPlayerId(GetTriggerPlayer())
local o6kB=htj.getActiveItem(UV)
if o6kB~=nil then local sdfJ=htj.getItemIdAtPosition(UV,o6kB)
if
Ltq_xgJ.getItemInSlot(wIat2P0)~=nil then
dt7v.log(UV,"You already have an item in that slot.",dt7v.TYPE.ERROR)elseif Re.getItemInfo(sdfJ).slot~=wIat2P0 then
dt7v.log(UV,"That doesn't go in that slot.",dt7v.TYPE.ERROR)else htj.removeItemFromBackpack(UV,o6kB)
Ltq_xgJ.equipItem(UV,wIat2P0,sdfJ)end;htj.activateItem(UV,nil)else
Ltq_xgJ.activateItem(UV,wIat2P0)htj.activateItem(UV,nil)end;BlzFrameSetEnable(BlzGetTriggerFrame(),false)
BlzFrameSetEnable(BlzGetTriggerFrame(),true)end)return{itemFrame=J8,itemHighlight=VchN,tooltipFrame=ws7lX6m_}end
function LG:init()local uwuecWs=BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0)
local l=BlzCreateFrameByType("FRAME","equipmentOrigin",uwuecWs,"",0)
BlzFrameSetSize(l,HBjl.EQUIPMENT_ITEM_SIZE*7+0.015,
HBjl.EQUIPMENT_ITEM_SIZE*9+0.02)BlzFrameSetAbsPoint(l,FRAMEPOINT_CENTER,0.1,0.35)
tcVr.createBorderFrame(l)
local xhVT42E=BlzCreateFrameByType("TEXT","equipmentText",l,"",0)
BlzFrameSetSize(xhVT42E,HBjl.EQUIPMENT_ITEM_SIZE*4+0.03,0.012)
BlzFrameSetPoint(xhVT42E,FRAMEPOINT_TOPLEFT,l,FRAMEPOINT_TOPLEFT,0.01,-0.01)BlzFrameSetText(xhVT42E,"Character")
local q=BlzCreateFrameByType("BACKDROP","portraitBackdropFrame",l,"",0)
BlzFrameSetSize(q,0.105,HBjl.EQUIPMENT_ITEM_SIZE*7)
BlzFrameSetPoint(q,FRAMEPOINT_TOP,l,FRAMEPOINT_TOP,-0.0025,-0.025)
BlzFrameSetTexture(q,"Replaceabletextures\\Teamcolor\\Teamcolor20.blp",0,true)local XA=BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT,0)
local la=BlzFrameGetParent(XA)BlzFrameSetVisible(XA,true)
if BlzGetLocalClientWidth()/
BlzGetLocalClientHeight()>1.7 then
BlzFrameClearAllPoints(XA)
BlzFrameSetSize(XA,0.08,HBjl.EQUIPMENT_ITEM_SIZE*7)
BlzFrameSetPoint(XA,FRAMEPOINT_TOP,l,FRAMEPOINT_TOP,0.072,-0.025)else BlzFrameSetAllPoints(XA,q)end;BlzFrameSetLevel(la,10)BlzFrameSetParent(la,l)local W={}
for q5=0,7,1 do
local hgc6Q=x__e0OAv(l,math.floor(
q5/4)*
(HBjl.EQUIPMENT_ITEM_SIZE+HBjl.EQUIPMENT_ITEM_SIZE*4)+0.015,
- (q5%4)*
(HBjl.EQUIPMENT_ITEM_SIZE+HBjl.EQUIPMENT_ITEM_SIZE)-0.025,q5+1)table.insert(W,hgc6Q)end
local Ihh6yjj=x__e0OAv(l,0.09,HBjl.EQUIPMENT_ITEM_SIZE*-8-0.005,9)table.insert(W,Ihh6yjj)self.frames={itemFrames=W,origin=l}
return self end
function LG:update(mIJ_kc4)local JuUw95D=self.frames
BlzFrameSetVisible(JuUw95D.origin,cG3HJLZ[mIJ_kc4]==true)local KRLJOGI=Ltq_xgJ.getActiveItem(mIJ_kc4)
for Gns3m_=1,9,1 do
local f=JuUw95D.itemFrames[Gns3m_]local _zxBo=Ltq_xgJ.getItemInSlot(mIJ_kc4,Gns3m_)if _zxBo~=nil then
BlzFrameSetTexture(f.itemFrame,Re.getItemInfo(_zxBo).icon,0,true)else
BlzFrameSetTexture(f.itemFrame,"InvTile.blp",0,true)end
local gN=Re.getItemTooltipNumLines(_zxBo)
BlzFrameSetSize(f.tooltipFrame.origin,0.16,0.012*gN)
BlzFrameSetSize(f.tooltipFrame.text,0.15,0.012*gN-0.01)
BlzFrameSetVisible(f.tooltipFrame.backdrop,gN~=0)
BlzFrameSetText(f.tooltipFrame.text,Re.getItemTooltip(_zxBo))
BlzFrameSetVisible(f.itemHighlight,KRLJOGI==Gns3m_)end end;return LG end
local G=function()local oZs2khg=require('src/hero.lua')
local pSEIak=require('src/target.lua')local AkjIt=require('src/ui/consts.lua')
local ox=require('src/ui/castbar.lua')local y5FoBZ5=require('src/ui/unitframe.lua')
local VXwusjUq=require('src/ui/actionbar.lua')local xP7ck=require('src/ui/backpack.lua')
local Bu1tX_x3=require('src/ui/equipment.lua')
local m0={VXwusjUq:new(),ox:new(),y5FoBZ5:new{xLoc=0.55,yLoc=
AkjIt.ACTION_ITEM_SIZE+AkjIt.BAR_HEIGHT*5+0.01,forTarget=true},y5FoBZ5:new{xLoc=0.26,yLoc=
AkjIt.ACTION_ITEM_SIZE+AkjIt.BAR_HEIGHT*5+0.01,forTarget=false},xP7ck:new()}
for n=0,9,1 do
local Q=n%2* (AkjIt.BAR_WIDTH/2+0.005)
table.insert(m0,y5FoBZ5:new{xLoc=Q,yLoc=0.5- (AkjIt.BAR_HEIGHT*5+0.005)*
(n-n%2)/2,anchor=FRAMEPOINT_TOPLEFT,forTarget=false,forParty=n,width=
AkjIt.BAR_WIDTH/2})end;table.insert(m0,Bu1tX_x3:new())
function hideBlizzUI()
BlzHideOriginFrames(true)local CoiGQD=BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0)
local KR7=BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME,0)BlzFrameSetAllPoints(KR7,CoiGQD)
for h=0,11,1 do
local TCVpKFp=BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON,h)BlzFrameClearAllPoints(TCVpKFp)
BlzFrameSetAbsPoint(TCVpKFp,FRAMEPOINT_TOPLEFT,0,0)end;local a=BlzGetOriginFrame(ORIGIN_FRAME_MINIMAP,0)
local P5=BlzCreateFrameByType("BACKDROP","miniMapBackdrop",CoiGQD,"",0)BlzFrameSetAllPoints(P5,a)
BlzFrameSetTexture(P5,"Replaceabletextures\\Teamcolor\\Teamcolor20.blp",0,true)BlzFrameSetVisible(a,true)BlzFrameSetParent(a,P5)end
function initCustomUI()BlzLoadTOCFile("war3mapimported\\Tooltip.toc")for NY,hEVRc in
pairs(m0)do hEVRc:init()end end
function updateCustomUI()local BA6zaoJ=GetPlayerId(GetLocalPlayer())
local Y7=oZs2khg.getHero(BA6zaoJ)local g=pSEIak.getTarget(BA6zaoJ)for jtL2,DA in pairs(m0)do DA.hero=Y7;DA.target=g
DA.playerId=BA6zaoJ;DA:update(BA6zaoJ)end end;function init()hideBlizzUI()initCustomUI()
TimerStart(CreateTimer(),0.03125,true,updateCustomUI)end;return{init=init}end
local gE=function()
local d7K3=function(Ozih058u,oW9bf,u,rZrrL,E4a)local QXFNNY=BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0)
local e=BlzCreateFrameByType("FRAME","tooltipOrigin",QXFNNY,"",0)BlzFrameSetSize(e,oW9bf,u)
BlzFrameSetPoint(e,E4a and FRAMEPOINT_TOP or FRAMEPOINT_BOTTOM,Ozih058u,
E4a and FRAMEPOINT_BOTTOM or FRAMEPOINT_TOP,0,E4a and-0.02 or 0.02)
local BH=BlzCreateFrame("BoxedTextBackgroundTemplate",e,0,0)BlzFrameSetAllPoints(BH,e)
local xD=BlzCreateFrameByType("TEXT","tooltipText",e,"",0)BlzFrameSetSize(xD,oW9bf-0.01,u-0.01)
BlzFrameSetPoint(xD,FRAMEPOINT_CENTER,e,FRAMEPOINT_CENTER,0,0)if rZrrL==nil then
rZrrL=BlzCreateFrameByType("FRAME","hoverFrame",Ozih058u,"",0)end
BlzFrameSetAllPoints(rZrrL,Ozih058u)BlzFrameSetTooltip(rZrrL,e)return{origin=e,text=xD,backdrop=BH}end;return{makeTooltipFrame=d7K3}end
local QgC=function()function createBorderFrame(fl)local QCv=BlzCreateFrame("Leaderboard",fl,0,0)
BlzFrameSetAllPoints(QCv,fl)return QCv end;return
{createBorderFrame=createBorderFrame}end
local CYoa=function()local qd_HCf=require('src/ui/consts.lua')
local CU=require('src/buff.lua')local M1ywSQ=require('src/target.lua')
local g=require('src/party.lua')local hPc4e3hn=require('src/hero.lua')
local m=require('src/casttime.lua')
local Rlb={xLoc=0,yLoc=0,width=qd_HCf.BAR_WIDTH,anchor=FRAMEPOINT_CENTER,forTarget=false,farParty=nil}
function Rlb:new(KgX)setmetatable(KgX,self)self.__index=self;return KgX end
function Rlb:init()local SXr=BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0)
local IZQg6shq=BlzCreateFrameByType("TEXTBUTTON","unitFrameOrigin",SXr,"",0)
BlzFrameSetSize(IZQg6shq,self.width,qd_HCf.BAR_HEIGHT*5)
BlzFrameSetAbsPoint(IZQg6shq,self.anchor,self.xLoc,self.yLoc)
local bz=BlzCreateFrameByType("BACKDROP","unitFrameBackdrop",IZQg6shq,"",0)
BlzFrameSetSize(bz,self.width,qd_HCf.BAR_HEIGHT*5)
BlzFrameSetPoint(bz,FRAMEPOINT_BOTTOMLEFT,IZQg6shq,FRAMEPOINT_BOTTOMLEFT,0,0)
BlzFrameSetTexture(bz,"Replaceabletextures\\Teamcolor\\Teamcolor20.blp",0,true)BlzFrameSetAlpha(bz,155)
local wL=BlzCreateFrameByType("BACKDROP","healthBarFrameBackground",IZQg6shq,"",0)BlzFrameSetSize(wL,self.width,qd_HCf.BAR_HEIGHT)
BlzFrameSetPoint(wL,FRAMEPOINT_BOTTOMLEFT,IZQg6shq,FRAMEPOINT_BOTTOMLEFT,0,qd_HCf.BAR_HEIGHT)
BlzFrameSetTexture(wL,"Replaceabletextures\\Teamcolor\\Teamcolor20.blp",0,true)
local BSDnLt_=BlzCreateFrameByType("BACKDROP","healthBarFrameFilled",IZQg6shq,"",0)
BlzFrameSetSize(BSDnLt_,self.width,qd_HCf.BAR_HEIGHT)
BlzFrameSetPoint(BSDnLt_,FRAMEPOINT_BOTTOMLEFT,wL,FRAMEPOINT_BOTTOMLEFT,0,0)
BlzFrameSetTexture(BSDnLt_,"Replaceabletextures\\Teamcolor\\Teamcolor06.blp",0,true)
local vQ6pTDbn=BlzCreateFrameByType("BACKDROP","castBarFrameBackground",IZQg6shq,"",0)
BlzFrameSetSize(vQ6pTDbn,self.width,qd_HCf.BAR_HEIGHT)
BlzFrameSetPoint(vQ6pTDbn,FRAMEPOINT_BOTTOMLEFT,IZQg6shq,FRAMEPOINT_BOTTOMLEFT,0,0)
BlzFrameSetTexture(vQ6pTDbn,"Replaceabletextures\\Teamcolor\\Teamcolor20.blp",0,true)
local P=BlzCreateFrameByType("BACKDROP","castBarFrameFilled",IZQg6shq,"",0)BlzFrameSetSize(P,self.width,qd_HCf.BAR_HEIGHT)
BlzFrameSetPoint(P,FRAMEPOINT_BOTTOMLEFT,vQ6pTDbn,FRAMEPOINT_BOTTOMLEFT,0,0)
BlzFrameSetTexture(P,"Replaceabletextures\\Teamcolor\\Teamcolor04.blp",0,true)
local W=BlzCreateFrameByType("TEXT","unitNameFrame",IZQg6shq,"",0)BlzFrameSetSize(W,self.width,qd_HCf.BAR_HEIGHT)
BlzFrameSetPoint(W,FRAMEPOINT_BOTTOMLEFT,IZQg6shq,FRAMEPOINT_BOTTOMLEFT,0,
qd_HCf.BAR_HEIGHT*2)BlzFrameSetText(W,"There Is a Unit Name")local CDG3os={}
for JZDx8=0,9,1 do
local _XR0EY1=BlzCreateFrameByType("BACKDROP","buffIcon",IZQg6shq,"",0)
BlzFrameSetSize(_XR0EY1,qd_HCf.BUFF_ICON_SIZE,qd_HCf.BUFF_ICON_SIZE)
BlzFrameSetPoint(_XR0EY1,FRAMEPOINT_BOTTOMLEFT,IZQg6shq,FRAMEPOINT_BOTTOMLEFT,JZDx8*qd_HCf.BUFF_ICON_SIZE,
qd_HCf.BAR_HEIGHT*3)
local z3J=BlzCreateFrameByType("TEXT","buffStackCount",_XR0EY1,"",0)BlzFrameSetSize(z3J,0.01,0.01)
BlzFrameSetText(z3J,"1")
BlzFrameSetPoint(z3J,FRAMEPOINT_BOTTOMLEFT,_XR0EY1,FRAMEPOINT_BOTTOMLEFT,0.002,-0.002)
table.insert(CDG3os,{buffIcon=_XR0EY1,buffStackCount=z3J})end;local MOd9uwnL=CreateTrigger()
BlzTriggerRegisterFrameEvent(MOd9uwnL,IZQg6shq,FRAMEEVENT_CONTROL_CLICK)
TriggerAddAction(MOd9uwnL,function()self:onClick()
BlzFrameSetEnable(BlzGetTriggerFrame(),false)BlzFrameSetEnable(BlzGetTriggerFrame(),true)end)
self.frames={healthBar=BSDnLt_,castBar=P,origin=IZQg6shq,name=W,buffIcons=CDG3os}return self end
function Rlb:onClick()if
GetPlayerId(GetTriggerPlayer())==self.playerId then ClearSelection()
SelectUnit(self:getUnit(),true)end end
function Rlb:getUnit()if self.forTarget then return self.target end
if self.forParty~=nil then
local ufXNV=g.getPlayersInParty(g.getPlayerParty(self.playerId))local Vum8=ufXNV[self.forParty+1]
return hPc4e3hn.getHero(Vum8)end;return self.hero end
function Rlb:update(NQSh)local Y1rSR=self.frames;local aqQh=self:getUnit()
BlzFrameSetVisible(Y1rSR.origin,
aqQh~=nil and GetUnitState(aqQh,UNIT_STATE_LIFE)>0)local H_=GetUnitName(aqQh)BlzFrameSetText(Y1rSR.name,H_)
local EQaFI0gZ=BlzGetUnitRealField(aqQh,UNIT_RF_HP)local kKiLOav=BlzGetUnitMaxHP(aqQh)
if kKiLOav~=0 then
BlzFrameSetSize(Y1rSR.healthBar,
self.width*EQaFI0gZ/kKiLOav,qd_HCf.BAR_HEIGHT)else
BlzFrameSetSize(Y1rSR.healthBar,0,qd_HCf.BAR_HEIGHT)end;local XW8=GetPlayerId(GetOwningPlayer(aqQh))
local _8Ls=m.getCastDurationRemaining(XW8)local t_t7=m.getCastDurationTotal(XW8)
if _8Ls~=nil and t_t7 ~=nil then
BlzFrameSetVisible(Y1rSR.castBar,true)
BlzFrameSetSize(Y1rSR.castBar,self.width* (1-_8Ls/t_t7),qd_HCf.BAR_HEIGHT)else BlzFrameSetVisible(Y1rSR.castBar,false)
BlzFrameSetSize(Y1rSR.castBar,0,qd_HCf.BAR_HEIGHT)end;local A_oCK8=CU.getBuffs(aqQh)local o={}for ogi5Usg,pA in pairs(A_oCK8)do
table.insert(o,{buffName=ogi5Usg,buffInfo=pA})end
for DOIqPj09=1,10,1 do
local RoKAkM=Y1rSR.buffIcons[DOIqPj09]local FETmJjQd=o[DOIqPj09]and o[DOIqPj09].buffName;local RK=
o[DOIqPj09]and o[DOIqPj09].buffInfo;BlzFrameSetVisible(RoKAkM.buffIcon,
FETmJjQd~=nil)
BlzFrameSetTexture(RoKAkM.buffIcon,
CU.BUFF_INFO[FETmJjQd]and CU.BUFF_INFO[FETmJjQd].icon or"",0,true)
BlzFrameSetVisible(RoKAkM.buffStackCount,RK~=nil and
CU.BUFF_INFO[FETmJjQd].maxStacks~=nil)
BlzFrameSetText(RoKAkM.buffStackCount,RK and RK.stacks or"")end end;return Rlb end
local K3ipRr=function()local XAv={vals={}}
local bdJvhbGA={'2','U','!','Z',')','o','j','n','a','m','7','z','q','(','#','p','y','C','&','d','J','H','X','A','G','u','9','k','<','s','f','^','D','Q','i','4','6','h','R','B','%','>','P','K','L','5','=','-','M','S','F','Y','N','g','c','t','x','W','*','e','V','b','3','r','8','T','$','w','v','E','@','[',']','?'}
local c9M={['2']=00,['U']=01,['!']=02,['Z']=03,[')']=04,['o']=05,['j']=06,['n']=07,['a']=08,['m']=09,['7']=10,['z']=11,['q']=12,['(']=13,['#']=14,['p']=15,['y']=16,['C']=17,['&']=18,['d']=19,['J']=20,['H']=21,['X']=22,['A']=23,['G']=24,['u']=25,['9']=26,['k']=27,['<']=28,['s']=29,['f']=30,['^']=31,['D']=32,['Q']=33,['i']=34,['4']=35,['6']=36,['h']=37,['R']=38,['B']=39,['%']=40,['>']=41,['P']=42,['K']=43,['L']=44,['5']=45,['=']=46,['-']=47,['M']=48,['S']=49,['F']=50,['Y']=51,['N']=52,['g']=53,['c']=54,['t']=55,['x']=56,['W']=57,['*']=58,['e']=59,['V']=60,['b']=61,['3']=62,['r']=63,['8']=64,['T']=65,['$']=66,['w']=67,['v']=68,['E']=69,['@']=70,['[']=72,[']']=73,['?']=74}local bcYXd=#bdJvhbGA;local wbw9=72^3;function XAv:new()local jFg={vals={}}
setmetatable(jFg,self)self.__index=self;return jFg end
function XAv:fromStr(_3BxMtBx)
local j5rH={codeStr=_3BxMtBx,numDecoded=0,sum=0}setmetatable(j5rH,self)self.__index=self;return j5rH end
function XAv:getInt(mKQv1MD)
local XvjCso=math.floor(math.log(mKQv1MD)/math.log(bcYXd)+1)local _R3NsF=string.sub(self.codeStr,0,XvjCso)local IluJe=0;for oJ=0,XvjCso-1,1 do local XRK37sBn=
(c9M[string.sub(_R3NsF,
oJ+1,oJ+1)]-self.numDecoded)%bcYXd
IluJe=IluJe+
XRK37sBn*bcYXd^ (XvjCso-oJ-1)end
IluJe=math.floor(IluJe)self.numDecoded=self.numDecoded+1
self.codeStr=string.sub(self.codeStr,XvjCso+1)self.sum=self.sum+IluJe;return IluJe end;function XAv:verify()
local W6W=math.floor((self.sum* (self.sum+3))%wbw9)local HUwZ2ikl=math.floor(self:getInt(wbw9))
return W6W==HUwZ2ikl end;function XAv:addInt(trUgnCUz,CTJB)
table.insert(self.vals,{num=trUgnCUz,max=CTJB})return self end
function XAv:build()local PK9=""local hd=0;for l8vftvD,xb in
pairs(self.vals)do hd=hd+xb.num end
hd=(hd* (hd+3))%wbw9;self:addInt(hd,wbw9)
for KHB,RZ8IqF in pairs(self.vals)do local FasBerA=RZ8IqF.num
local pf=RZ8IqF.max
local ayR7Lua6=math.floor(math.log(pf)/math.log(bcYXd)+1)
for Ini5SE=ayR7Lua6-1,0,-1 do
local PyZ2PUy0=math.floor(FasBerA/bcYXd^Ini5SE)FasBerA=FasBerA-bcYXd^Ini5SE*PyZ2PUy0;PK9=PK9 ..
bdJvhbGA[((
PyZ2PUy0+KHB-1)%bcYXd)+1]end end;return PK9 end;return XAv end
local F2tY=function()local ZiDK=require('src/saveload/code.lua')
local HfV=require('src/items/backpack.lua')local kYK3PhRd=require('src/items/equipment.lua')
local O=require('src/hero.lua')local xme2_Bb=require('src/log.lua')
function onSave()
local ccqzSAU=GetPlayerId(GetTriggerPlayer())local N=O.getHero(ccqzSAU)
local Rl1JVg=O.getPickedHero(ccqzSAU).storedId
local h=ZiDK:new():addInt(GetHeroLevel(N),73):addInt(Rl1JVg,73)for nwlg80aZ=0,35,1 do
h:addInt(HfV.getItemIdAtPosition(ccqzSAU,nwlg80aZ)or 0,73)end
h:addInt(
string.byte(GetPlayerName(Player(ccqzSAU)))%2500,2500)for B=1,9,1 do
h:addInt(kYK3PhRd.getItemInSlot(ccqzSAU,B)or 0,73)end;h=h:build()
xme2_Bb.log(ccqzSAU,'Your code is: '..h,xme2_Bb.TYPE.NORMAL)
xme2_Bb.log(ccqzSAU,'NOTE THIS IS AN ALPHA AND THE CODE MAY NOT WORK IN FUTURE VERSIONS',xme2_Bb.TYPE.NORMAL)end
function init()local PDGF=CreateTrigger()for x_gZS_6x=0,bj_MAX_PLAYERS,1 do
TriggerRegisterPlayerChatEvent(PDGF,Player(x_gZS_6x),"-save",true)end
TriggerAddAction(PDGF,onSave)end;return{init=init}end
local rb21L2=function()local cG={}function isOnCooldown(L9PPA2e,JwAi)
return cG[L9PPA2e][JwAi]~=nil and
TimerGetRemaining(cG[L9PPA2e][JwAi])>0 end
function startCooldown(wjgKmwQJ,Sq5Mc,iAXm7_)if
cG[wjgKmwQJ][Sq5Mc]~=nil then
DestroyTimer(cG[wjgKmwQJ][Sq5Mc])end;local fJ=CreateTimer()
TimerStart(fJ,iAXm7_,false,nil)cG[wjgKmwQJ][Sq5Mc]=fJ end
function getRemainingCooldown(aG3O,M6IbY)if cG[aG3O][M6IbY]~=nil then return
TimerGetRemaining(cG[aG3O][M6IbY])end;return 0 end
function getTotalCooldown(vxWBA,is)if cG[vxWBA][is]~=nil then
return TimerGetTimeout(cG[vxWBA][is])end;return 1 end;function init()for _l=0,bj_MAX_PLAYERS,1 do cG[_l]={}end end;return
{init=init,isOnCooldown=isOnCooldown,startCooldown=startCooldown,getRemainingCooldown=getRemainingCooldown,getTotalCooldown=getTotalCooldown}end
local o_v255=function()local IVdNQHj=require('src/hero.lua')
local l=require('src/mouse.lua')local icedjl=require('src/vector.lua')
local H=require('src/effect.lua')local d1J=require('src/log.lua')
local zVUtED=require('src/casttime.lua')local d_UB9=require('src/animations.lua')
local FysQC=require('src/spells/cooldowns.lua')local AnG=15;local yV8C=function()return'blink'end
local bt4Y=function()return'Blink'end
local sZNR=function(QAFVQu14)
return'Azora channels her inner fire to displace her position in the world by up to 800 yards.'end;local WAIOz7=function(DVx)return AnG end
local ICLcYduB=function(r)return 0.15 end
local oXFiMbj=function(Knh56)return


IsUnitType(Knh56,UNIT_TYPE_STUNNED)or IsUnitType(Knh56,UNIT_TYPE_SNARED)or IsUnitType(Knh56,UNIT_TYPE_POLYMORPHED)or IsUnitPaused(Knh56)end
local i5L=function(DG90Rh)if FysQC.isOnCooldown(DG90Rh,yV8C())then
d1J.log(DG90Rh,bt4Y().." is on cooldown!",d1J.TYPE.ERROR)return false end
local IVdNQHj=IVdNQHj.getHero(DG90Rh)
local mBxSp8y2=icedjl:new{x=GetUnitX(IVdNQHj),y=GetUnitY(IVdNQHj)}
local W09NOBin=icedjl:new{x=l.getMouseX(DG90Rh),y=l.getMouseY(DG90Rh)}if oXFiMbj(IVdNQHj)then
d1J.log(DG90Rh,"You can't move right now",d1J.TYPE.ERROR)return false end
local Tek7X=icedjl:new(W09NOBin):subtract(mBxSp8y2)if Tek7X:magnitude()>800 then
Tek7X:normalize():multiply(800)end;Tek7X:add(mBxSp8y2)
if not
IsVisibleToPlayer(Tek7X.x,Tek7X.y,Player(DG90Rh))then
d1J.log(DG90Rh,"Target not in line of sight.",d1J.TYPE.ERROR)return false end;FysQC.startCooldown(DG90Rh,yV8C(),AnG)
IssueImmediateOrder(IVdNQHj,"stop")d_UB9.queueAnimation(IVdNQHj,14,1)
H.createEffect{model="eblk",unit=IVdNQHj,duration=0.5}zVUtED.cast(DG90Rh,0.15,false)
SetUnitX(IVdNQHj,Tek7X.x)SetUnitY(IVdNQHj,Tek7X.y)
SetUnitFacing(IVdNQHj,bj_RADTODEG*Atan2(Tek7X.y-mBxSp8y2.y,
Tek7X.x-mBxSp8y2.x))
H.createEffect{model="eblk",unit=IVdNQHj,duration=0.5}return true end
local vYC4bdrc=function()return"ReplaceableTextures\\CommandButtons\\BTNBlink.blp"end;return
{cast=i5L,getSpellId=yV8C,getSpellName=bt4Y,getIcon=vYC4bdrc,getSpellTooltip=sZNR,getSpellCooldown=WAIOz7,getSpellCasttime=ICLcYduB}end
local wUVm=function()local Wzzgk=require('src/saveload/code.lua')
local anaV=require('src/items/backpack.lua')local gwxp=require('src/items/equipment.lua')
local Qf=require('src/hero.lua')local sRf=require('src/log.lua')
function onLoad()
local Ir=GetEventPlayerChatString()local On7i=string.sub(Ir,7)
local GAQjek=GetPlayerId(GetTriggerPlayer())if Qf.getHero(GAQjek)~=nil then
sRf.log(GAQjek,'You already have a hero. Type -repick and then try again.',sRf.TYPE.ERROR)return end
local b=Wzzgk:fromStr(On7i)local t=b:getInt(73)local nUqS=b:getInt(73)for Qv_pumH=0,35,1 do local Rm=b:getInt(73)
anaV.addItemIdToBackpackPosition(GAQjek,Qv_pumH,Rm)end
local wTVytu=b:getInt(2500)print(wTVytu)if wTVytu~=string.byte('Mash')%2500 then
print("Code appears to be for another player, but allowing it during alpha anyway")end
for Wq2v=1,9,1 do
local Ge5kmv=b:getInt(73)gwxp.equipItem(GAQjek,Wq2v,Ge5kmv)end;local VZjB=b:verify()if not VZjB then
print("Code wasnt valid but allowing through during alpha anyway")end
Qf.restorePickedHero(GAQjek,nUqS,t)end
function init()local PSNhu=CreateTrigger()for mAaO3eJ=0,bj_MAX_PLAYERS,1 do
TriggerRegisterPlayerChatEvent(PSNhu,Player(mAaO3eJ),"-load",false)end
TriggerAddAction(PSNhu,onLoad)end;return{init=init}end
local VQ=function()local EO=require('src/hero.lua')
local Qw9=require('src/mouse.lua')local GMgV5kh=require('src/vector.lua')
local Shm=require('src/projectile.lua')local iIKY5x=require('src/log.lua')
local fLF=require('src/buff.lua')local eQ=require('src/animations.lua')
local yGT7hv6=require('src/damage.lua')local qG4fWn4a=require('src/casttime.lua')
local Zkf=require('src/spells/cooldowns.lua')local N=0.5;local Bh=function()return'fireball'end
local r42joJ=function()return'Fireball'end
local zl1g=function(_c)
return'Azora conjures a ball of flame, dealing 60 damage to the first target hit.'end;local Cx=function(S)return N end;local A6o=function(pI1x)return 0.4 end
local s2_=function(NgDx9_)if
Zkf.isOnCooldown(NgDx9_,Bh())then
iIKY5x.log(NgDx9_,r42joJ().." is on cooldown!",iIKY5x.TYPE.ERROR)return false end
local EO=EO.getHero(NgDx9_)
local KzYaixt=GMgV5kh:new{x=GetUnitX(EO),y=GetUnitY(EO)}
local i=GMgV5kh:new{x=Qw9.getMouseX(NgDx9_),y=Qw9.getMouseY(NgDx9_)}Zkf.startCooldown(NgDx9_,Bh(),N)
IssueImmediateOrder(EO,"stop")eQ.queueAnimation(EO,19,1)
SetUnitFacingTimed(EO,bj_RADTODEG*Atan2(i.y-KzYaixt.y,i.x-
KzYaixt.x),0.05)qG4fWn4a.cast(NgDx9_,0.4,false)
eQ.queueAnimation(EO,18,1)
Shm.createProjectile{playerId=NgDx9_,model="efrb",fromV=KzYaixt,toV=i,speed=900,length=500,onCollide=function(DM7)
if IsUnitEnemy(DM7,Player(NgDx9_))then
yGT7hv6.dealDamage(EO,DM7,60)fLF.addBuff(EO,DM7,'ignite',8)return true end;return false end}return true end
local i6j=function(sBDh6v)return Zkf.getRemainingCooldown(sBDh6v,Bh())end
local oKC=function(siy_21f)return Zkf.getTotalCooldown(siy_21f,Bh())end
local Xzi2KU=function()return"ReplaceableTextures\\CommandButtons\\BTNFireForTheCannon.blp"end
return{cast=s2_,getSpellId=Bh,getSpellName=r42joJ,getIcon=Xzi2KU,getSpellTooltip=zl1g,getSpellCooldown=Cx,getSpellCasttime=A6o}end
local oTYNsnP=function()local wkUEOv=require('src/hero.lua')
local b=require('src/log.lua')local s1sExxI=require('src/animations.lua')
local qR=require('src/buff.lua')local KMeqP=require('src/casttime.lua')
local y3tk=require('src/spells/cooldowns.lua')local AIysi_9UF=120;local joAA=function()return'fireshell'end
local w=function()return'Fireshell'end
local ta59=function(MXcdGX)
return'Azora summons a flame to surround her and protect her from incoming attacks for 10 seconds. She is unable do anything during this time.'end;local b_knq=function(R9)return AIysi_9UF end
local J_AlR=function(n9zj)return 0.1 end
local _dqQ8fSw=function(sWU)if y3tk.isOnCooldown(sWU,joAA())then
b.log(sWU,w().." is on cooldown!",b.TYPE.ERROR)return false end
local wkUEOv=wkUEOv.getHero(sWU)IssueImmediateOrder(wkUEOv,"stop")
s1sExxI.queueAnimation(wkUEOv,46,10)y3tk.startCooldown(sWU,joAA(),AIysi_9UF)
KMeqP.cast(sWU,0.1,false)qR.addBuff(wkUEOv,wkUEOv,'fireshell',10)return true end
local onKnnPCx=function(JoZ28)return y3tk.getRemainingCooldown(JoZ28,joAA())end
local WytqKWPI=function(hBfySU)return y3tk.getTotalCooldown(hBfySU,joAA())end
local MK4o_AriB=function()return"ReplaceableTextures\\CommandButtons\\BTNCloakOfFlames.blp"end;return
{cast=_dqQ8fSw,getSpellId=joAA,getSpellName=w,getIcon=MK4o_AriB,getSpellTooltip=ta59,getSpellCooldown=b_knq,getSpellCasttime=J_AlR}end
local I=function()local Uvmu=require('src/hero.lua')
local _=require('src/mouse.lua')local SeHRNaX=require('src/vector.lua')
local kH7r=require('src/effect.lua')local HOB=require('src/projectile.lua')
local RCc=require('src/log.lua')local vLr4f=require('src/buff.lua')
local Pad5yPd=require('src/animations.lua')local GAeGfl=require('src/spells/cooldowns.lua')local TYRl=25;local uoRdE7k=function()
return'frostnova'end
local k5=function()return'Frost Nova'end
local F_cOghKV=function(P25nFo1)
return'Using the power of frost, Azora freezes all targets in an area in place, preventing them from moving for 4 seconds.'end;local Ytf=function(MwI)return TYRl end;local VAKgo=function(t)return 0 end
local QB=function(rcbgP)if
GAeGfl.isOnCooldown(rcbgP,uoRdE7k())then
RCc.log(rcbgP,k5().." is on cooldown!",RCc.TYPE.ERROR)return false end
local Uvmu=Uvmu.getHero(rcbgP)
local nwoQ=SeHRNaX:new{x=GetUnitX(Uvmu),y=GetUnitY(Uvmu)}
local pazH2Fh=SeHRNaX:new{x=_.getMouseX(rcbgP),y=_.getMouseY(rcbgP)}
local GZ2PbO=SeHRNaX:new(nwoQ):subtract(pazH2Fh)local y=GZ2PbO:magnitude()if y>800 then
RCc.log(rcbgP,"Out of range!",RCc.TYPE.ERROR)return false end
GAeGfl.startCooldown(rcbgP,uoRdE7k(),TYRl)IssueImmediateOrder(Uvmu,"stop")
Pad5yPd.queueAnimation(Uvmu,38,1)
for cMk1b62p=0,2*math.pi,1.57 do
HOB.createProjectile{playerId=rcbgP,model="efnv",fromV=pazH2Fh,fromAngle=cMk1b62p,toAngle=8*math.pi+cMk1b62p,speed=1000,fromRadius=30,toRadius=200,onCollide=function(iAIf)
if
IsUnitEnemy(iAIf,Player(rcbgP))then
kH7r.createEffect{model="efir",unit=iAIf,duration=0.5}vLr4f.addBuff(Uvmu,iAIf,'frostnova',4)end;return false end}end;return true end
local y8zF=function(Am0WLx)
return GAeGfl.getRemainingCooldown(Am0WLx,uoRdE7k())end
local TfT1=function(TDJshmj)return GAeGfl.getTotalCooldown(TDJshmj,uoRdE7k())end
local lMKfa=function()return"ReplaceableTextures\\CommandButtons\\BTNFrostArmor.blp"end;return
{cast=QB,getSpellId=uoRdE7k,getSpellName=k5,getIcon=lMKfa,getSpellTooltip=F_cOghKV,getSpellCooldown=Ytf,getSpellCasttime=VAKgo}end
local LmR5gwW=function()local LTJy0=require('src/hero.lua')
local N=require('src/mouse.lua')local Ns=require('src/vector.lua')
local ZOvR1=require('src/effect.lua')local L75=require('src/log.lua')local zh=require('src/buff.lua')
local v=require('src/casttime.lua')local Il05=require('src/animations.lua')
local d0W=require('src/damage.lua')local b=require('src/collision.lua')
local dG=require('src/spells/cooldowns.lua')local wF9WF=35;local b097=function()return'firestorm'end
local Qu1=function()return'Firestorm'end
local r6=function(HgWdXJXD)
return'Azora summons a storm of fire to rain upon the land, dealing 80 damage to any unit struck in the area.'end;local DOx=function(wiugbQS)return wF9WF end
local sQe35a=function(Cz5)return 1 end
local p2=function(UfgAV)if dG.isOnCooldown(UfgAV,b097())then
L75.log(UfgAV,Qu1().." is on cooldown!",L75.TYPE.ERROR)return false end
local LTJy0=LTJy0.getHero(UfgAV)
local LO0nqS=Ns:new{x=GetUnitX(LTJy0),y=GetUnitY(LTJy0)}
local PIht9=Ns:new{x=N.getMouseX(UfgAV),y=N.getMouseY(UfgAV)}local bn=Ns:new(LO0nqS):subtract(PIht9)
local A666l08=bn:magnitude()if A666l08 >800 then
L75.log(UfgAV,"Out of range!",L75.TYPE.ERROR)return false end
if not
IsVisibleToPlayer(PIht9.x,PIht9.y,Player(UfgAV))then
L75.log(UfgAV,"Target not in line of sight.",L75.TYPE.ERROR)return false end;IssueImmediateOrder(LTJy0,"stop")
Il05.queueAnimation(LTJy0,19,2)dG.startCooldown(UfgAV,b097(),wF9WF)
v.cast(UfgAV,1,false)Il05.queueAnimation(LTJy0,18,1)
for R02tO=0,40,1 do local oVO=GetRandomReal(PIht9.x-200,PIht9.x+
200)local X0NOlR5=GetRandomReal(PIht9.y-200,
PIht9.y+200)
ZOvR1.createEffect{model="erai",x=oVO,y=X0NOlR5,duration=1}
local drv=b.getAllCollisions(Ns:new{x=oVO,y=X0NOlR5},80)for r,sZyXLp in pairs(drv)do
if IsUnitEnemy(sZyXLp,Player(UfgAV))then
d0W.dealDamage(LTJy0,sZyXLp,20)zh.addBuff(LTJy0,sZyXLp,'ignite',8)end end
TriggerSleepAction(0.01)end;return true end
local TN=function(nHUmh)return dG.getRemainingCooldown(nHUmh,b097())end
local vtk=function(VEw8)return dG.getTotalCooldown(VEw8,b097())end
local ENKi=function()return"ReplaceableTextures\\CommandButtons\\BTNFireRocks.blp"end
return{cast=p2,getSpellId=b097,getSpellName=Qu1,getIcon=ENKi,getSpellTooltip=r6,getSpellCooldown=DOx,getSpellCasttime=sQe35a}end
local DfbW=function()local QAD=require('src/hero.lua')
local R6Ky=require('src/mouse.lua')local vq5u9jrx=require('src/vector.lua')
local kNsSSMzG=require('src/projectile.lua')local ZcV=require('src/log.lua')
local WiZA=require('src/buff.lua')local K4SQ1h2e=require('src/animations.lua')
local y6z6ip=require('src/damage.lua')local v=require('src/casttime.lua')
local Bu=require('src/spells/cooldowns.lua')local _TI=10;local YE7=function()return'firelance'end
local Q2e=function()return'Firelance'end
local zCy=function(aUu)
return'Azora throws a lance of fire, peircing targets, dealing 200 damage and stunning all targets hit for 2 seconds.'end;local ZhG=function(We1INxkk)return _TI end
local ARBIKz=function(X37Nsx)return 0.4 end
local p7=function(eE)if Bu.isOnCooldown(eE,YE7())then
ZcV.log(eE,Q2e().." is on cooldown!",ZcV.TYPE.ERROR)return false end
local QAD=QAD.getHero(eE)
local pCWPYYE=vq5u9jrx:new{x=GetUnitX(QAD),y=GetUnitY(QAD)}
local g=vq5u9jrx:new{x=R6Ky.getMouseX(eE),y=R6Ky.getMouseY(eE)}Bu.startCooldown(eE,YE7(),_TI)
IssueImmediateOrder(QAD,"stop")K4SQ1h2e.queueAnimation(QAD,19,1)
SetUnitFacingTimed(QAD,bj_RADTODEG*Atan2(g.y-
pCWPYYE.y,g.x-pCWPYYE.x),0.05)v.cast(eE,0.4,false)
K4SQ1h2e.queueAnimation(QAD,18,1)
kNsSSMzG.createProjectile{playerId=eE,model="elan",fromV=pCWPYYE,toV=g,speed=2000,length=800,radius=30,onCollide=function(kUNaj9)if IsUnitEnemy(kUNaj9,Player(eE))then
y6z6ip.dealDamage(QAD,kUNaj9,200)WiZA.addBuff(QAD,kUNaj9,'firelance',2)
WiZA.addBuff(QAD,kUNaj9,'ignite',8)end;return
false end}return true end
local j=function(AiX)return Bu.getRemainingCooldown(AiX,YE7())end
local zbC2yHd0=function(CzFcrl)return Bu.getTotalCooldown(CzFcrl,YE7())end
local IJt=function()return"ReplaceableTextures\\CommandButtons\\BTNFire.blp"end
return{cast=p7,getSpellId=YE7,getSpellName=Q2e,getIcon=IJt,getSpellTooltip=zCy,getSpellCooldown=ZhG,getSpellCasttime=ARBIKz}end
local sh=function()local X8Gpm3=require('src/hero.lua')
local Ewt=require('src/mouse.lua')local TzK=require('src/vector.lua')
local jjU=require('src/projectile.lua')local DGflu=require('src/log.lua')
local FF9q1AO=require('src/buff.lua')local pJWQ=require('src/animations.lua')
local DZJXU=require('src/damage.lua')local Oo6w=require('src/casttime.lua')
local hN=require('src/spells/cooldowns.lua')local jz1uXDx=30;local vTRoD0X={}local oX9O28J=function()return'frostball'end;local sTbHW=function()return
'Fingers of Frost'end
local upZW=function(Ea23)return'TODO'end;local AWQPjyxs=function(gdet)return jz1uXDx end
local V=function(x)return 0.4 end
local MsPh=function(KzXd)if vTRoD0X[KzXd]~=nil then
for gqa3M1,Z in pairs(vTRoD0X[KzXd].balls)do return Z end end;return nil end
local RKD_1r=function(neYEY)if hN.isOnCooldown(neYEY,oX9O28J())then
DGflu.log(neYEY,sTbHW().." is on cooldown!",DGflu.TYPE.ERROR)return false end
local X8Gpm3=X8Gpm3.getHero(neYEY)
local H0=TzK:new{x=GetUnitX(X8Gpm3),y=GetUnitY(X8Gpm3)}
local r=TzK:new{x=Ewt.getMouseX(neYEY),y=Ewt.getMouseY(neYEY)}local JF4a=MsPh(neYEY)
if JF4a~=nil then
SetUnitFacingTimed(X8Gpm3,bj_RADTODEG*
Atan2(r.y-H0.y,r.x-H0.x),0.05)IssueImmediateOrder(X8Gpm3,"stop")
pJWQ.queueAnimation(X8Gpm3,19,1)Oo6w.cast(neYEY,0.2,false)
pJWQ.queueAnimation(X8Gpm3,18,1)
local AuacAxlc=TzK:new{x=GetUnitX(JF4a.unit),y=GetUnitY(JF4a.unit)}JF4a.removeInsteadOfKill=true;jjU.destroyProjectile(JF4a)
jjU.createProjectile{playerId=neYEY,model="efbl",fromV=AuacAxlc,toV=r,speed=900,length=800,onCollide=function(Bk)
if
IsUnitEnemy(Bk,Player(neYEY))then
if FF9q1AO.hasBuff(Bk,'frostnova')then
DZJXU.dealDamage(X8Gpm3,Bk,160)else DZJXU.dealDamage(X8Gpm3,Bk,40)end;return true end;return false end}return end;IssueImmediateOrder(X8Gpm3,"stop")
pJWQ.queueAnimation(X8Gpm3,19,1)
SetUnitFacingTimed(X8Gpm3,bj_RADTODEG*Atan2(r.y-H0.y,r.x-H0.x),0.05)Oo6w.cast(neYEY,1,false)
pJWQ.queueAnimation(X8Gpm3,18,1)FF9q1AO.addBuff(X8Gpm3,X8Gpm3,'frostball',14400)
local HeQL={}
for IulFXIJ=0,2,1 do local b=IulFXIJ* ((2*math.pi)/3)
local xfxoXu=jjU.createProjectile{playerId=neYEY,model="efbl",fromUnit=X8Gpm3,speed=200,fromRadius=80,toRadius=80,fromAngle=b,toAngle=
b+math.pi*2,permanent=true,onCollide=function(KJ0Y6)
if IsUnitEnemy(KJ0Y6,Player(neYEY))then
FF9q1AO.addBuff(X8Gpm3,KJ0Y6,'frostballslow',8)DZJXU.dealDamage(X8Gpm3,KJ0Y6,40)return true end;return false end,onDestroy=function()vTRoD0X[neYEY].balls[
IulFXIJ+1]=nil
if MsPh(neYEY)==nil then
hN.startCooldown(neYEY,oX9O28J(),jz1uXDx)FF9q1AO.removeBuff(X8Gpm3,'frostball')end end}table.insert(HeQL,xfxoXu)end;if vTRoD0X[neYEY]==nil then vTRoD0X[neYEY]={}end
vTRoD0X[neYEY].balls=HeQL;return true end
local hnrLmi=function()return"ReplaceableTextures\\CommandButtons\\BTNFrostBolt.blp"end;return
{cast=RKD_1r,getSpellId=oX9O28J,getSpellName=sTbHW,getIcon=hnrLmi,getSpellTooltip=upZW,getSpellCooldown=AWQPjyxs,getSpellCasttime=V}end
local rrFLbCtj=function()local KPlOw=require('src/hero.lua')
local C=require('src/mouse.lua')local BA=require('src/vector.lua')
local ybxsK=require('src/projectile.lua')local _0fP=require('src/log.lua')
local l6=require('src/casttime.lua')local rGOqO96U=require('src/animations.lua')
local odN0bo=require('src/damage.lua')local sn1BOCT5=require('src/spells/cooldowns.lua')local k0iue=160;local J5=function()
return'frostorb'end
local d3=function()return'Frost Orb'end
local DAeG=function(E7Q)return'This is a temporary spell to be replaced.'end;local eb6VK=function(qts06Ch3)return k0iue end
local U8PPAC=function(cBwDRgK)return 1 end
local bK92X9wQ=function(veqNhn)if sn1BOCT5.isOnCooldown(veqNhn,J5())then
_0fP.log(veqNhn,d3().." is on cooldown!",_0fP.TYPE.ERROR)return false end
local KPlOw=KPlOw.getHero(veqNhn)
local OiD=BA:new{x=GetUnitX(KPlOw),y=GetUnitY(KPlOw)}
local prw2Jl=BA:new{x=C.getMouseX(veqNhn),y=C.getMouseY(veqNhn)}local oo=BA:new(OiD):subtract(prw2Jl)
local DYo=oo:magnitude()if DYo>800 then
_0fP.log(veqNhn,"Out of range!",_0fP.TYPE.ERROR)return false end
if not
IsVisibleToPlayer(prw2Jl.x,prw2Jl.y,Player(veqNhn))then
_0fP.log(veqNhn,"Target not in line of sight.",_0fP.TYPE.ERROR)return false end;IssueImmediateOrder(KPlOw,"stop")
rGOqO96U.queueAnimation(KPlOw,19,2)local kcCL9hT=l6.cast(veqNhn,1)if not kcCL9hT then return false end
sn1BOCT5.startCooldown(veqNhn,J5(),k0iue)rGOqO96U.queueAnimation(KPlOw,18,1)
for pvg=0,30,10 do
for MUSR=pvg,360+pvg,40 do
local Wxk9CBfb=BA:fromAngle(
bj_DEGTORAD*MUSR):add(prw2Jl)
ybxsK.createProjectile{playerId=veqNhn,model="efor",fromV=prw2Jl,toV=Wxk9CBfb,speed=300,length=350,onCollide=function(V)if IsUnitEnemy(V,Player(veqNhn))then
odN0bo.dealDamage(KPlOw,V,50)return true end;return false end}end;TriggerSleepAction(0.03)end;return true end
local PZ=function(jWPa)return sn1BOCT5.getRemainingCooldown(jWPa,J5())end
local toG0=function(d)return sn1BOCT5.getTotalCooldown(d,J5())end
local EZ3qRhLq=function()return"ReplaceableTextures\\CommandButtons\\BTNFrostBolt.blp"end;return
{cast=bK92X9wQ,getSpellId=J5,getSpellName=d3,getIcon=EZ3qRhLq,getSpellTooltip=DAeG,getSpellCooldown=eb6VK,getSpellCasttime=U8PPAC}end
local YcPea0vg=function()local j3Fn=require('src/hero.lua')
local oZ65m5=require('src/mouse.lua')local hQjlCjY=require('src/vector.lua')
local JDyNU5=require('src/effect.lua')local cMv6ou=require('src/projectile.lua')
local HPZKRJ=require('src/log.lua')local cn=require('src/buff.lua')
local _Yf=require('src/animations.lua')local rl=require('src/damage.lua')
local Z=require('src/casttime.lua')local jOFP=require('src/spells/cooldowns.lua')local LCqNO=120;local jF4YoB=function()
return'phoenix'end
local nROZ=function()return'Phoenix'end
local _GVROa=function(r)
return'Azora summons a Phoenix from the earth, dealing 400 damage to all units in a line in front of her.'end;local bO3YuZv=function(oa)return LCqNO end
local Vq=function(dT)return 2 end
local cW=function(xa78yAit)if jOFP.isOnCooldown(xa78yAit,jF4YoB())then
HPZKRJ.log(xa78yAit,nROZ().." is on cooldown!",HPZKRJ.TYPE.ERROR)return false end
local j3Fn=j3Fn.getHero(xa78yAit)
local s_CnSV=hQjlCjY:new{x=GetUnitX(j3Fn),y=GetUnitY(j3Fn)}
local s=hQjlCjY:new{x=oZ65m5.getMouseX(xa78yAit),y=oZ65m5.getMouseY(xa78yAit)}jOFP.startCooldown(xa78yAit,jF4YoB(),LCqNO)
IssueImmediateOrder(j3Fn,"stop")_Yf.queueAnimation(j3Fn,19,3)
SetUnitFacingTimed(j3Fn,bj_RADTODEG*Atan2(s.y-s_CnSV.y,
s.x-s_CnSV.x),0.05)Z.cast(xa78yAit,2,false)
_Yf.queueAnimation(j3Fn,18,1)
cMv6ou.createProjectile{playerId=xa78yAit,model="epht",fromV=s_CnSV,toV=s,speed=800,length=600,radius=100}local wqRzXIG7=0
cMv6ou.createProjectile{playerId=xa78yAit,model="epho",fromV=s_CnSV,toV=s,speed=800,length=600,radius=100,onMove=function(w3nHh,bo0I)if wqRzXIG7%20 ==0 then
JDyNU5.createEffect{model="ephr",x=w3nHh,y=bo0I,duration=4}end;wqRzXIG7=wqRzXIG7+1 end,onCollide=function(lK5ogD)
if
IsUnitEnemy(lK5ogD,Player(xa78yAit))then rl.dealDamage(j3Fn,lK5ogD,400)
cn.addBuff(j3Fn,lK5ogD,'ignite',8)cn.addBuff(j3Fn,lK5ogD,'ignite',8)end;return false end}return true end
local c7GfSrtA=function(I8F)return jOFP.getRemainingCooldown(I8F,jF4YoB())end
local lEP9VGU=function(Y3NU)return jOFP.getTotalCooldown(Y3NU,jF4YoB())end
local xpKd=function()return"ReplaceableTextures\\CommandButtons\\BTNPhoenixEgg.blp"end;return
{cast=cW,getSpellId=jF4YoB,getSpellName=nROZ,getIcon=xpKd,getSpellTooltip=_GVROa,getSpellCooldown=bO3YuZv,getSpellCasttime=Vq}end
local usLpLoaH=function()local Avel7IrZ=require('src/hero.lua')
local F=require('src/mouse.lua')local _=require('src/vector.lua')
local DpWpo7kA=require('src/projectile.lua')local LS=require('src/log.lua')
local cQvh=require('src/buff.lua')local llU3aki=require('src/animations.lua')
local HQrwQErj=require('src/damage.lua')local tu=require('src/casttime.lua')
local XSuzlcm=require('src/spells/cooldowns.lua')local nbAjk49J=0.5;local cB0vBn=function()return'icicle'end
local IccvGO=function()return'Icicle'end
local BNC=function(zmF)
return'Azora fires a blast of frost energy from her, dealing 50 damage to the first enemy struck. If the enemy is frozen, the damage is doubled.'end;local s3=function(RKBSOvv)return nbAjk49J end
local QXOjuVP=function(GxQqHPYH)return 0.2 end
local KOk=function(KEhfU)if XSuzlcm.isOnCooldown(KEhfU,cB0vBn())then
LS.log(KEhfU,IccvGO().." is on cooldown!",LS.TYPE.ERROR)return false end
local Avel7IrZ=Avel7IrZ.getHero(KEhfU)
local zufQE=_:new{x=GetUnitX(Avel7IrZ),y=GetUnitY(Avel7IrZ)}
local QwSnT=_:new{x=F.getMouseX(KEhfU),y=F.getMouseY(KEhfU)}XSuzlcm.startCooldown(KEhfU,cB0vBn(),nbAjk49J)
IssueImmediateOrder(Avel7IrZ,"stop")llU3aki.queueAnimation(Avel7IrZ,19,1)
SetUnitFacingTimed(Avel7IrZ,
bj_RADTODEG*Atan2(QwSnT.y-zufQE.y,QwSnT.x-zufQE.x),0.05)tu.cast(KEhfU,0.2,false)
llU3aki.queueAnimation(Avel7IrZ,18,1)
DpWpo7kA.createProjectile{playerId=KEhfU,model="eici",fromV=zufQE,toV=QwSnT,speed=2000,length=800,radius=30,onCollide=function(WrvmQJ6)
if IsUnitEnemy(WrvmQJ6,Player(KEhfU))then if
cQvh.hasBuff(WrvmQJ6,'frostnova')then HQrwQErj.dealDamage(Avel7IrZ,WrvmQJ6,100)else
HQrwQErj.dealDamage(Avel7IrZ,WrvmQJ6,50)end;return true end;return false end}return true end
local GQ8QsA=function(rOMAEo)
return XSuzlcm.getRemainingCooldown(rOMAEo,cB0vBn())end
local B=function(SFGo78)return XSuzlcm.getTotalCooldown(SFGo78,cB0vBn())end
local i=function()return"ReplaceableTextures\\CommandButtons\\BTNBreathOfFrost.blp"end;return
{cast=KOk,getSpellId=cB0vBn,getSpellName=IccvGO,getIcon=i,getSpellTooltip=BNC,getSpellCooldown=s3,getSpellCasttime=QXOjuVP}end
local e7dv=function()local LTd5=require('src/hero.lua')
local JmrwaH=require('src/mouse.lua')local qqciA=require('src/vector.lua')
local bgKb=require('src/effect.lua')local b0q=require('src/log.lua')
local MRluMhh=require('src/buff.lua')local n0R1Mj=require('src/casttime.lua')
local a4j6=require('src/animations.lua')local lg6u=require('src/damage.lua')
local ubseU=require('src/collision.lua')local kfDX=require('src/spells/cooldowns.lua')local g26=35
local HDP=function()return'meteor'end;local c6nlekUb=function()return'Meteor'end
local NJQ0=function(bHs)
return
'Azora calls upon the heavens to bring a meteor down to earth. The meteor will fall after 2 seconds, dealing 400 damage to all units in the area.'end;local o_v3=function(eThxHw)return g26 end
local zI=function(tJVrOA)return 1 end;function createTargetEffect(tqJFy)
bgKb.createEffect{model="eprm",x=tqJFy.x,y=tqJFy.y,timeScale=0.5,duration=0.5}end
local ET=function(EoFG)if
kfDX.isOnCooldown(EoFG,HDP())then
b0q.log(EoFG,c6nlekUb().." is on cooldown!",b0q.TYPE.ERROR)return false end
local LTd5=LTd5.getHero(EoFG)
local DQsI=qqciA:new{x=GetUnitX(LTd5),y=GetUnitY(LTd5)}
local Cam=qqciA:new{x=JmrwaH.getMouseX(EoFG),y=JmrwaH.getMouseY(EoFG)}local wF77=qqciA:new(DQsI):subtract(Cam)
local A5pk0=wF77:magnitude()if A5pk0 >800 then
b0q.log(EoFG,"Out of range!",b0q.TYPE.ERROR)return false end;if not
IsVisibleToPlayer(Cam.x,Cam.y,Player(EoFG))then
b0q.log(EoFG,"Target not in line of sight.",b0q.TYPE.ERROR)return false end
IssueImmediateOrder(LTd5,"stop")a4j6.queueAnimation(LTd5,19,2)
kfDX.startCooldown(EoFG,HDP(),g26)n0R1Mj.cast(EoFG,1,false)
a4j6.queueAnimation(LTd5,18,1)createTargetEffect(Cam)TriggerSleepAction(0.5)
createTargetEffect(Cam)TriggerSleepAction(0.5)createTargetEffect(Cam)
bgKb.createEffect{model="emet",x=Cam.x,y=Cam.y,timeScale=0.7,duration=2}TriggerSleepAction(0.5)createTargetEffect(Cam)
TriggerSleepAction(0.5)createTargetEffect(Cam)
bgKb.createEffect{model="emei",x=Cam.x,y=Cam.y,duration=1}local j=ubseU.getAllCollisions(Cam,350)
for XE,vtfBBQgI in pairs(j)do
if
IsUnitEnemy(vtfBBQgI,Player(EoFG))then lg6u.dealDamage(LTd5,vtfBBQgI,400)
MRluMhh.addBuff(LTd5,vtfBBQgI,'ignite',8)MRluMhh.addBuff(LTd5,vtfBBQgI,'ignite',8)end end;return true end
local RPrsE2M=function(U1Ca2x)return kfDX.getRemainingCooldown(U1Ca2x,HDP())end
local T2WO5I=function(AM_2j6)return kfDX.getTotalCooldown(AM_2j6,HDP())end
local f7pL=function()return"ReplaceableTextures\\CommandButtons\\BTNOrbOfFire.blp"end
return{cast=ET,getSpellId=HDP,getSpellName=c6nlekUb,getIcon=f7pL,getSpellTooltip=NJQ0,getSpellCooldown=o_v3,getSpellCasttime=zI}end
local inx0=function()local tqvqCh=require('src/hero.lua')
local wQb3=require('src/mouse.lua')local MV_ePmkQ=require('src/vector.lua')
local cX3Y=require('src/effect.lua')local dOb=require('src/projectile.lua')
local JTBnP=require('src/log.lua')local Nm=require('src/animations.lua')
local sCwnNPE=require('src/damage.lua')local JjUlV2=require('src/spells/cooldowns.lua')local _WlOka=0.5;local tFt48gVX=function()
return'heal'end;local VcvWqUR=function()return'Heal'end;local g9LOIN=function(vfT16V9)return
'Heal'end
local Ldc7=function(Idod8USP)return 0 end;local OWMI6=function(n)return 0 end
local y=function(Enpu)if JjUlV2.isOnCooldown(Enpu,tFt48gVX())then
JTBnP.log(Enpu,
VcvWqUR().." is on cooldown!",JTBnP.TYPE.ERROR)return false end
JjUlV2.startCooldown(Enpu,tFt48gVX(),_WlOka)local tqvqCh=tqvqCh.getHero(Enpu)
local F=MV_ePmkQ:new{x=GetUnitX(tqvqCh),y=GetUnitY(tqvqCh)}
local ed=MV_ePmkQ:new{x=wQb3.getMouseX(Enpu),y=wQb3.getMouseY(Enpu)}IssueImmediateOrder(tqvqCh,"stop")
Nm.queueAnimation(tqvqCh,9,1)
SetUnitFacingTimed(tqvqCh,bj_RADTODEG*Atan2(ed.y-F.y,ed.x-F.x),0.05)
dOb.createProjectile{playerId=Enpu,model="ehea",fromV=F,toV=ed,speed=1000,length=1000,destroyOnCollide=false,onCollide=function(QamDb5OV)if IsUnitAlly(QamDb5OV,Player(Enpu))then
sCwnNPE.heal(tqvqCh,QamDb5OV,50)
cX3Y.createEffect{model="ehet",unit=QamDb5OV,duration=0.5}end
return false end}return true end
local PN=function(Jz)return JjUlV2.getRemainingCooldown(Jz,tFt48gVX())end
local D4=function(by73)return JjUlV2.getTotalCooldown(by73,tFt48gVX())end
local bqUq2I19=function()return"ReplaceableTextures\\CommandButtons\\BTNHealingWave.blp"end;return
{cast=y,getSpellId=tFt48gVX,getSpellName=VcvWqUR,getIcon=bqUq2I19,getSpellTooltip=g9LOIN,getSpellCooldown=Ldc7,getSpellCasttime=OWMI6}end
local A5k5yt=function()local lQlrrh=function()return'attack'end
local XQtO=function()return'Attack'end
local JefwEh=function(zskX)return'Just a simple auto attack.'end;local sbbJI=function(z37Qz)return 0 end;local QYayh=function(MUu)return 0 end;local nr6uCL=function(rRNsXW)
return true end
local FQ1oRl_=function(zslu25lH)return 0 end;local Q=function(K)return 1 end
local sHA_0P=function()
return"ReplaceableTextures\\CommandButtons\\BTNAttack.blp"end;return
{cast=nr6uCL,getSpellId=lQlrrh,getSpellName=XQtO,getIcon=sHA_0P,getSpellTooltip=JefwEh,getSpellCooldown=sbbJI,getSpellCasttime=QYayh}end
local B7SHDx7h=function()local dBzmP=function()return'stop'end
local obk=function()return'Stop'end
local MsipHD_w=function(ViHDT)return'Press to stop your hero from moving'end;local uBw1Z77=function(fcbl4H)return 0 end
local bdJJE=function(ora4Z)return 0 end;local spYT=function(wmfjOlWH)return true end
local lEPWTkAE=function(d)return 0 end;local S=function(w60sb3_)return 1 end
local Zbxec=function()
return"ReplaceableTextures\\CommandButtons\\BTNStop.blp"end;return
{cast=spYT,getSpellId=dBzmP,getSpellName=obk,getIcon=Zbxec,getSpellTooltip=MsipHD_w,getSpellCooldown=uBw1Z77,getSpellCasttime=bdJJE}end
local EEpoeR=function()local MCm__CEC=require('src/hero.lua')
local Jr9hz4jk=require('src/vector.lua')local Abv=require('src/projectile.lua')
local aqOk=require('src/log.lua')local A4ZSOV=require('src/animations.lua')
local wtbkXqKs=require('src/target.lua')local vX_5TSFO=require('src/casttime.lua')
local MFweCJ3=require('src/buff.lua')local z6=require('src/spells/cooldowns.lua')local n0q2=30;local X2UHF=function()
return'armorpot'end
local uanm=function()return'Armor Potion'end
local BJf2=function(Gufs)
return'Ivanov tosses a potion of armor at an ally, reducing the damage they take by 30% and incresing the healing done to them by 30% for 10 seconds.'end;local bV=function(rBbV5m)return n0q2 end
local hhe=function(v)return 0.5 end
local hw=function(L_4ez)if z6.isOnCooldown(L_4ez,X2UHF())then
aqOk.log(L_4ez,uanm().." is on cooldown!",aqOk.TYPE.ERROR)return false end
local MCm__CEC=MCm__CEC.getHero(L_4ez)local wtbkXqKs=wtbkXqKs.getTarget(L_4ez)if wtbkXqKs==nil then
wtbkXqKs=MCm__CEC end;if
not IsUnitAlly(wtbkXqKs,Player(L_4ez))then wtbkXqKs=MCm__CEC end
local ILvdT1AO=Jr9hz4jk:new{x=GetUnitX(MCm__CEC),y=GetUnitY(MCm__CEC)}
local XiiB=Jr9hz4jk:new{x=GetUnitX(wtbkXqKs),y=GetUnitY(wtbkXqKs)}
local Ai9ugkhp=Jr9hz4jk:new(ILvdT1AO):subtract(XiiB)local vx0=Ai9ugkhp:magnitude()if vx0 >800 then
aqOk.log(L_4ez,"Out of range!",aqOk.TYPE.ERROR)return false end
IssueImmediateOrder(MCm__CEC,"stop")A4ZSOV.queueAnimation(MCm__CEC,3,1)
SetUnitFacingTimed(MCm__CEC,bj_RADTODEG*Atan2(
XiiB.y-ILvdT1AO.y,XiiB.x-ILvdT1AO.x),0.05)local oTT0I_tH=vX_5TSFO.cast(L_4ez,0.5)
if not oTT0I_tH then return false end;z6.startCooldown(L_4ez,X2UHF(),n0q2)
Abv.createProjectile{playerId=L_4ez,model="earm",fromV=ILvdT1AO,destUnit=wtbkXqKs,speed=500,destroyOnCollide=false,onDestroy=function()
MFweCJ3.addBuff(MCm__CEC,wtbkXqKs,'armorpot',10)
MFweCJ3.addBuff(MCm__CEC,wtbkXqKs,'corrosivedecay',300)end}return true end
local Xjh2=function(d)return z6.getRemainingCooldown(d,X2UHF())end
local wS=function(HF)return z6.getTotalCooldown(HF,X2UHF())end
local SxbR=function()return"ReplaceableTextures\\CommandButtons\\BTNPotionOfRestoration.blp"end
return{cast=hw,getSpellId=X2UHF,getSpellName=uanm,getIcon=SxbR,getSpellTooltip=BJf2,getSpellCooldown=bV,getSpellCasttime=hhe}end
local _k=function()local ORg_K6y=require('src/hero.lua')
local Y0=require('src/mouse.lua')local gwII=require('src/vector.lua')
local ItMCtiyJ=require('src/effect.lua')local iXtk=require('src/log.lua')
local snG=require('src/animations.lua')local V5j=require('src/buff.lua')
local lItF=require('src/casttime.lua')local xq1bs=require('src/collision.lua')
local F=require('src/spells/cooldowns.lua')local Oro89=20;local O_dX=function()return'accmist'end
local k3U=function()return'Accelerator Mist'end
local p8=function(RG)
return'Ivanov throws down a cannister of accelerator mist, rolling in front of him. Any friendly target inside the mist gets 200% increased movement speed.'end;local BLvFfZ=function(Y)return Oro89 end
local _=function(htKd_R2)return 0.15 end
local dAcD=function(vr)if F.isOnCooldown(vr,O_dX())then
iXtk.log(vr,k3U().." is on cooldown!",iXtk.TYPE.ERROR)return false end
local ORg_K6y=ORg_K6y.getHero(vr)
local ylrttgX=gwII:new{x=GetUnitX(ORg_K6y),y=GetUnitY(ORg_K6y)}
local LI=gwII:new{x=Y0.getMouseX(vr),y=Y0.getMouseY(vr)}F.startCooldown(vr,O_dX(),Oro89)
lItF.cast(vr,0.15,false)IssueImmediateOrder(ORg_K6y,"stop")
snG.queueAnimation(ORg_K6y,8,1)
local KYV=bj_RADTODEG*Atan2(LI.y-ylrttgX.y,LI.x-ylrttgX.x)SetUnitFacingTimed(ORg_K6y,KYV,0.05)local d={}
for sBB=0,6,1 do
for vvEDp5PM=-1,1,1 do local EBzZ=(KYV+90)*
bj_DEGTORAD
local JnR5AeB=gwII:fromAngle(EBzZ):multiply(vvEDp5PM*50):add(ylrttgX)
local vfXvA0O=gwII:fromAngle(KYV*bj_DEGTORAD):multiply(sBB*100):add(JnR5AeB)
ItMCtiyJ.createEffect{model="eacc",x=vfXvA0O.x,y=vfXvA0O.y,duration=10,facing=KYV,timeScale=10}table.insert(d,vfXvA0O)end;applySpeedBuff(vr,d,ORg_K6y)TriggerSleepAction(0.1)end;for OZRh=1,15,1 do TriggerSleepAction(0.5)
applySpeedBuff(vr,d,ORg_K6y)end;return true end
function applySpeedBuff(eNaZt,eE49cc,ORg_K6y)
for n_Q69rHB,h2_ty in pairs(eE49cc)do local zHG=xq1bs.getAllCollisions(h2_ty,50)
for n_Q69rHB,FYzFO1 in
pairs(zHG)do if IsUnitAlly(FYzFO1,Player(eNaZt))then
V5j.addBuff(ORg_K6y,FYzFO1,'accpot',3)end end end end
local e=function()return"ReplaceableTextures\\CommandButtons\\BTNAcidBomb.blp"end
return{cast=dAcD,getSpellId=O_dX,getSpellName=k3U,getIcon=e,getSpellTooltip=p8,getSpellCooldown=BLvFfZ,getSpellCasttime=_}end
local Ef=function()local gR48Oozb=require('src/hero.lua')
local bK0bhdq=require('src/mouse.lua')local nP=require('src/vector.lua')
local eN5tc=require('src/effect.lua')local KehBOft6=require('src/projectile.lua')
local R=require('src/log.lua')local ao5=require('src/casttime.lua')
local oZy=require('src/animations.lua')local oZ=require('src/damage.lua')
local ndeNBp=require('src/spells/cooldowns.lua')local o76bqPp=10
local idRDAlB=function(NeSAkW)
return IsUnitType(NeSAkW,UNIT_TYPE_STUNNED)or
IsUnitType(NeSAkW,UNIT_TYPE_SNARED)or
IsUnitType(NeSAkW,UNIT_TYPE_POLYMORPHED)or
IsUnitPaused(NeSAkW)end;local tXR1E510=function()return'punch'end
local ZawK6=function()return'Thunderfist'end
local bK=function(Ccoa)
return'Stormfist calls upon the Thunder gods and charges forward, dealing 350 damage to the first unit struck.'end;local OJGVLn=function(Y)return o76bqPp end
local UzgoE5O=function(zljPh)return 0.5 end
local RvHs=function(C7mQfN)if ndeNBp.isOnCooldown(C7mQfN,tXR1E510())then
R.log(C7mQfN,ZawK6().." is on cooldown!",R.TYPE.ERROR)return false end
local gR48Oozb=gR48Oozb.getHero(C7mQfN)
local hIkuxuG=nP:new{x=GetUnitX(gR48Oozb),y=GetUnitY(gR48Oozb)}
local wSnPWSA8=nP:new{x=bK0bhdq.getMouseX(C7mQfN),y=bK0bhdq.getMouseY(C7mQfN)}if idRDAlB(gR48Oozb)then
R.log(C7mQfN,"You can't move right now",R.TYPE.ERROR)return false end
ndeNBp.startCooldown(C7mQfN,tXR1E510(),o76bqPp)IssueImmediateOrder(gR48Oozb,"stop")
oZy.queueAnimation(gR48Oozb,8,1)
SetUnitFacing(gR48Oozb,bj_RADTODEG*
Atan2(wSnPWSA8.y-hIkuxuG.y,wSnPWSA8.x-hIkuxuG.x))
local Ktu1=AddSpecialEffectTarget("Abilities\\Weapons\\DragonHawkMissile\\DragonHawkMissile.mdl",gR48Oozb,"chest")
local g=AddSpecialEffectTarget("Abilities\\Weapons\\WingedSerpentMissile\\WingedSerpentMissile.mdl",gR48Oozb,"chest")
local RWiBcS8j=AddSpecialEffectTarget("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl",gR48Oozb,"origin")BlzPlaySpecialEffect(RWiBcS8j,ANIM_TYPE_WALK)
KehBOft6.createProjectile{playerId=C7mQfN,projectile=gR48Oozb,fromV=hIkuxuG,toV=wSnPWSA8,speed=1500,length=400,radius=100,onCollide=function(t)if
IsUnitEnemy(t,Player(C7mQfN))then oZ.dealDamage(gR48Oozb,t,350)
eN5tc.createEffect{unit=t,model="epui",duration=1}return true end;return
false end,onDestroy=function()
eN5tc.createEffect{unit=gR48Oozb,model="epui",duration=1}ao5.stopCast(C7mQfN)DestroyEffect(g)
DestroyEffect(RWiBcS8j)DestroyEffect(Ktu1)end}ao5.cast(C7mQfN,0.5,false)return true end
local u=function(jYRxYT)
return ndeNBp.getRemainingCooldown(jYRxYT,tXR1E510())end
local Anrb=function(kd)return ndeNBp.getTotalCooldown(kd,tXR1E510())end
local C9lJAfo=function()return"ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp"end;return
{cast=RvHs,getSpellId=tXR1E510,getSpellName=ZawK6,getIcon=C9lJAfo,getSpellTooltip=bK,getSpellCooldown=OJGVLn,getSpellCasttime=UzgoE5O}end
local KfM=function()local kalNjedc=require('src/hero.lua')
local b2Pn=require('src/vector.lua')local trdghrt=require('src/projectile.lua')
local Jy1gHSu=require('src/log.lua')local lF3FR=require('src/animations.lua')
local _HG=require('src/target.lua')local W=require('src/casttime.lua')
local rEJdQN=require('src/buff.lua')local HF6Ag=require('src/damage.lua')
local Y=require('src/spells/cooldowns.lua')local TEM=0.5;local jWvh=function()return'cleansingpot'end;local YO_aE9lks=function()
return'Cleansing Potion'end
local wuF=function(D0)return
'Invanov clears all stacks of corrosive decay from the targeted ally, instantly healing them for 40 per stack.'end;local ipXc=function(a223)return TEM end
local EgbUS=function(px4R7I)return 0.5 end
local XJ=function(a)if Y.isOnCooldown(a,jWvh())then
Jy1gHSu.log(a,YO_aE9lks().." is on cooldown!",Jy1gHSu.TYPE.ERROR)return false end
local kalNjedc=kalNjedc.getHero(a)local _HG=_HG.getTarget(a)if _HG==nil then _HG=kalNjedc end;if not
IsUnitAlly(_HG,Player(a))then _HG=kalNjedc end
local I29=b2Pn:new{x=GetUnitX(kalNjedc),y=GetUnitY(kalNjedc)}
local aqji75cGk=b2Pn:new{x=GetUnitX(_HG),y=GetUnitY(_HG)}local BRk_bg=b2Pn:new(I29):subtract(aqji75cGk)
local B97ZvZrX=BRk_bg:magnitude()if B97ZvZrX>800 then
Jy1gHSu.log(a,"Out of range!",Jy1gHSu.TYPE.ERROR)return false end
IssueImmediateOrder(kalNjedc,"stop")lF3FR.queueAnimation(kalNjedc,3,1)
SetUnitFacingTimed(kalNjedc,bj_RADTODEG*Atan2(
aqji75cGk.y-I29.y,aqji75cGk.x-I29.x),0.05)local DINB=W.cast(a,0.5)if not DINB then return false end
Y.startCooldown(a,jWvh(),TEM)
trdghrt.createProjectile{playerId=a,model="erej",fromV=I29,destUnit=_HG,speed=500,destroyOnCollide=false,onDestroy=function()
local rvLAm9=rEJdQN.getBuffStacks(_HG,'corrosivedecay')rEJdQN.removeBuff(_HG,'corrosivedecay')HF6Ag.heal(kalNjedc,_HG,40*
rvLAm9)end}return true end
local RDsGq=function(E)return Y.getRemainingCooldown(E,jWvh())end
local wg6c1w=function(Im)return Y.getTotalCooldown(Im,jWvh())end
local iPEJyOaN=function()return"ReplaceableTextures\\CommandButtons\\BTNPotionBlueSmall.blp"end;return
{cast=XJ,getSpellId=jWvh,getSpellName=YO_aE9lks,getIcon=iPEJyOaN,getSpellTooltip=wuF,getSpellCooldown=ipXc,getSpellCasttime=EgbUS}end
local Vd=function()local yWsj=require('src/hero.lua')
local MFbe=require('src/vector.lua')local i=require('src/projectile.lua')
local ayLU=require('src/log.lua')local T2y=require('src/animations.lua')
local QgLdZF=require('src/target.lua')local XGyz6oE=require('src/casttime.lua')
local i3NlQ94=require('src/buff.lua')local RnFNLp=require('src/spells/cooldowns.lua')local wOOFocF=30;local cUoJ=function()
return'dampenpot'end
local m3QdLvW=function()return'Dampening Potion'end
local xv=function(FVJlfw)
return'Ivanov throws a potion that dampens an enemy target, increasing the damage they take by 20% for 5 seconds.'end;local H=function(MwzzZ)return wOOFocF end
local Gjvc=function(EQI)return 0.5 end
local u3iW5=function(zdm)if RnFNLp.isOnCooldown(zdm,cUoJ())then
ayLU.log(zdm,m3QdLvW().." is on cooldown!",ayLU.TYPE.ERROR)return false end
local yWsj=yWsj.getHero(zdm)local QgLdZF=QgLdZF.getTarget(zdm)if QgLdZF==nil then
ayLU.log(zdm,"You don't have a target!",ayLU.TYPE.ERROR)return false end;if
IsUnitAlly(QgLdZF,Player(zdm))then
ayLU.log(zdm,"The target is friendly.",ayLU.TYPE.ERROR)return end
local OQaP=MFbe:new{x=GetUnitX(yWsj),y=GetUnitY(yWsj)}
local V1AAbF=MFbe:new{x=GetUnitX(QgLdZF),y=GetUnitY(QgLdZF)}local DVp=MFbe:new(OQaP):subtract(V1AAbF)
local uMHoys=DVp:magnitude()if uMHoys>800 then
ayLU.log(zdm,"Out of range!",ayLU.TYPE.ERROR)return false end
IssueImmediateOrder(yWsj,"stop")T2y.queueAnimation(yWsj,3,1)
SetUnitFacingTimed(yWsj,bj_RADTODEG*Atan2(V1AAbF.y-OQaP.y,
V1AAbF.x-OQaP.x),0.05)local hebAWpv=XGyz6oE.cast(zdm,0.5)
if not hebAWpv then return false end;RnFNLp.startCooldown(zdm,cUoJ(),wOOFocF)
i.createProjectile{playerId=zdm,model="earm",fromV=OQaP,destUnit=QgLdZF,speed=500,destroyOnCollide=false,onDestroy=function()
i3NlQ94.addBuff(yWsj,QgLdZF,'dampenpot',5)end}return true end
local MGaxDz=function(iO)return RnFNLp.getRemainingCooldown(iO,cUoJ())end
local ezQ=function(kQfTr6)return RnFNLp.getTotalCooldown(kQfTr6,cUoJ())end
local c=function()return"ReplaceableTextures\\CommandButtons\\BTNLesserInvulneralbility.blp"end
return{cast=u3iW5,getSpellId=cUoJ,getSpellName=m3QdLvW,getIcon=c,getSpellTooltip=xv,getSpellCooldown=H,getSpellCasttime=Gjvc}end
local Oynw=function()local VF=require('src/hero.lua')
local qby=require('src/vector.lua')local xocXyH=require('src/effect.lua')
local guNNjlMM=require('src/projectile.lua')local wvoHfla=require('src/log.lua')
local UIgl=require('src/animations.lua')local ij=require('src/target.lua')
local m=require('src/casttime.lua')local TO857=require('src/buff.lua')
local Uo5o=require('src/damage.lua')local xX9=require('src/spells/cooldowns.lua')local pOltGg=10;local aD={}local KO=function()return
'corrosiveblast'end;local Z=function()
return'Corrosive Pull/Blast'end
local kv6Rc=function(FIDceK)
return
'On first activation, Ivanov will pull all stacks of corrosive decay from an allied unit and hold them. The next activation will consume the stacks and damage an enemy unit for 40 per stack.'end;local G8PtJug=function(h)return pOltGg end
local RwGMa=function(lSW)return 0.5 end
local wODtgBt=function(kl)local VF=VF.getHero(kl)local ij=ij.getTarget(kl)
if ij==nil then ij=VF end;if not IsUnitAlly(ij,Player(kl))then ij=VF end
local W=qby:new{x=GetUnitX(VF),y=GetUnitY(VF)}
local xtH=qby:new{x=GetUnitX(ij),y=GetUnitY(ij)}local qujnE=qby:new(W):subtract(xtH)
local fX=qujnE:magnitude()if fX>800 then
wvoHfla.log(kl,"Out of range!",wvoHfla.TYPE.ERROR)return false end
IssueImmediateOrder(VF,"stop")UIgl.queueAnimation(VF,3,1)
SetUnitFacingTimed(VF,bj_RADTODEG*
Atan2(xtH.y-W.y,xtH.x-W.x),0.05)local Gu9cA=m.cast(kl,0.5)if not Gu9cA then return false end
xX9.startCooldown(kl,KO(),1)aD[kl]=TO857.getBuffStacks(ij,'corrosivedecay')
TO857.removeBuff(ij,'corrosivedecay')
guNNjlMM.createProjectile{playerId=kl,model="ecrp",fromV=xtH,destUnit=VF,speed=1000,destroyOnCollide=false}end
local R83=function(qie86E6k)local VF=VF.getHero(qie86E6k)local ij=ij.getTarget(qie86E6k)if
ij==nil then
wvoHfla.log(qie86E6k,"You don't have a target!",wvoHfla.TYPE.ERROR)return false end;if
IsUnitAlly(ij,Player(qie86E6k))then
wvoHfla.log(qie86E6k,"The target is friendly.",wvoHfla.TYPE.ERROR)return end
local _7XdqeK=qby:new{x=GetUnitX(VF),y=GetUnitY(VF)}
local FUhqkm2=qby:new{x=GetUnitX(ij),y=GetUnitY(ij)}local OmYbhPA=qby:new(_7XdqeK):subtract(FUhqkm2)
local o1=OmYbhPA:magnitude()if o1 >800 then
wvoHfla.log(qie86E6k,"Out of range!",wvoHfla.TYPE.ERROR)return false end
IssueImmediateOrder(VF,"stop")UIgl.queueAnimation(VF,3,1)
SetUnitFacingTimed(VF,bj_RADTODEG*Atan2(FUhqkm2.y-_7XdqeK.y,
FUhqkm2.x-_7XdqeK.x),0.05)local cKy3Dt=m.cast(qie86E6k,0.5)if not cKy3Dt then return false end
xX9.startCooldown(qie86E6k,KO(),pOltGg)local y=40*aD[qie86E6k]
guNNjlMM.createProjectile{playerId=qie86E6k,model="ecrb",fromV=_7XdqeK,destUnit=ij,speed=500,destroyOnCollide=false,onDestroy=function()
Uo5o.dealDamage(VF,ij,y)
xocXyH.createEffect{model="ecrt",unit=ij,duration=1}end}aD[qie86E6k]=nil end
local O3=function(zB6zO)if xX9.isOnCooldown(zB6zO,KO())then
wvoHfla.log(zB6zO,Z().." is on cooldown!",wvoHfla.TYPE.ERROR)return false end;if
aD[zB6zO]==nil then return wODtgBt(zB6zO)end;return R83(zB6zO)end
local Y=function(C6)return xX9.getRemainingCooldown(C6,KO())end
local Nau29CQd=function(J09Np7H8)return xX9.getTotalCooldown(J09Np7H8,KO())end
local rPWy4BIw=function()return"ReplaceableTextures\\CommandButtons\\BTNPotionGreen.blp"end;return
{cast=O3,getSpellId=KO,getSpellName=Z,getIcon=rPWy4BIw,getSpellTooltip=kv6Rc,getSpellCooldown=G8PtJug,getSpellCasttime=RwGMa}end
local QBO=function()local tf=require('src/hero.lua')
local VzDXmgRS=require('src/vector.lua')local QHdb=require('src/projectile.lua')
local dtRn=require('src/log.lua')local eHQcOZ4=require('src/animations.lua')
local Sd6s=require('src/target.lua')local G4=require('src/casttime.lua')
local AKVcI5x=require('src/buff.lua')local AHVxk8=require('src/spells/cooldowns.lua')local ykIP=30;local XQaA=function()
return'hulkingpot'end
local UFkKFj0=function()return'Hulking Potion'end
local mj8vF=function(k6z)
return'Ivanov tosses a concoction that increases the size and damage of a friendly target by 20% for 10 seconds.'end;local N=function(W)return ykIP end
local XN_r=function(DQKzz7t)return 0.5 end
local ihQKt=function(IjvpPcK)if AHVxk8.isOnCooldown(IjvpPcK,XQaA())then
dtRn.log(IjvpPcK,UFkKFj0().." is on cooldown!",dtRn.TYPE.ERROR)return false end
local tf=tf.getHero(IjvpPcK)local Sd6s=Sd6s.getTarget(IjvpPcK)if Sd6s==nil then Sd6s=tf end;if not
IsUnitAlly(Sd6s,Player(IjvpPcK))then Sd6s=tf end
local s=VzDXmgRS:new{x=GetUnitX(tf),y=GetUnitY(tf)}
local Tx=VzDXmgRS:new{x=GetUnitX(Sd6s),y=GetUnitY(Sd6s)}local izebj=VzDXmgRS:new(s):subtract(Tx)
local RioX=izebj:magnitude()if RioX>800 then
dtRn.log(IjvpPcK,"Out of range!",dtRn.TYPE.ERROR)return false end
IssueImmediateOrder(tf,"stop")eHQcOZ4.queueAnimation(tf,3,1)
SetUnitFacingTimed(tf,bj_RADTODEG*Atan2(Tx.y-s.y,
Tx.x-s.x),0.05)local sgtu=G4.cast(IjvpPcK,0.5)if not sgtu then return false end
AHVxk8.startCooldown(IjvpPcK,XQaA(),ykIP)
QHdb.createProjectile{playerId=IjvpPcK,model="earm",fromV=s,destUnit=Sd6s,speed=500,destroyOnCollide=false,onDestroy=function()
AKVcI5x.addBuff(tf,Sd6s,'hulkingpot',10)AKVcI5x.addBuff(tf,Sd6s,'corrosivedecay',300)end}return true end
local Nf=function(i3XH)return AHVxk8.getRemainingCooldown(i3XH,XQaA())end
local v0xXBtzp=function(USt6PLe2)return AHVxk8.getTotalCooldown(USt6PLe2,XQaA())end
local Rh8dzZf_=function()return"ReplaceableTextures\\CommandButtons\\BTNPotionRed.blp"end;return
{cast=ihQKt,getSpellId=XQaA,getSpellName=UFkKFj0,getIcon=Rh8dzZf_,getSpellTooltip=mj8vF,getSpellCooldown=N,getSpellCasttime=XN_r}end
local s4ggux=function()local j=require('src/hero.lua')
local EHi=require('src/vector.lua')local Du4PWm2=require('src/projectile.lua')
local jEJClb=require('src/log.lua')local np8JkPc=require('src/animations.lua')
local Rfao=require('src/target.lua')local N6IWFa=require('src/casttime.lua')
local Hr3mtiCq=require('src/buff.lua')local mf1UO=require('src/spells/cooldowns.lua')local wykbGA84=30;local Pd=function()
return'pocketgoo'end
local po2ff4F=function()return'Pocket Goo'end
local f=function(cgIU3)
return'Ivanov reaches into his pocket and throws his handy goo, disorienting an enemy and stunning them for 2 seconds.'end;local a=function(auV7A3JP)return wykbGA84 end
local mBRe=function(FzJwZ)return 0.5 end
local Cb=function(Zb5)if mf1UO.isOnCooldown(Zb5,Pd())then
jEJClb.log(Zb5,po2ff4F().." is on cooldown!",jEJClb.TYPE.ERROR)return false end
local j=j.getHero(Zb5)local Rfao=Rfao.getTarget(Zb5)if Rfao==nil then
jEJClb.log(Zb5,"You don't have a target!",jEJClb.TYPE.ERROR)return false end;if
IsUnitAlly(Rfao,Player(Zb5))then
jEJClb.log(Zb5,"The target is friendly.",jEJClb.TYPE.ERROR)return end
local U=EHi:new{x=GetUnitX(j),y=GetUnitY(j)}
local D1Bo4qP=EHi:new{x=GetUnitX(Rfao),y=GetUnitY(Rfao)}local CaGUl8h=EHi:new(U):subtract(D1Bo4qP)
local zL=CaGUl8h:magnitude()if zL>800 then
jEJClb.log(Zb5,"Out of range!",jEJClb.TYPE.ERROR)return false end
IssueImmediateOrder(j,"stop")np8JkPc.queueAnimation(j,3,1)
SetUnitFacingTimed(j,bj_RADTODEG*Atan2(D1Bo4qP.y-U.y,
D1Bo4qP.x-U.x),0.05)local Ofe=N6IWFa.cast(Zb5,0.5)if not Ofe then return false end
mf1UO.startCooldown(Zb5,Pd(),wykbGA84)
Du4PWm2.createProjectile{playerId=Zb5,model="earm",fromV=U,destUnit=Rfao,speed=500,destroyOnCollide=false,onDestroy=function()
Hr3mtiCq.addBuff(j,Rfao,'stun',2)end}return true end
local QP=function(TV4H8)return mf1UO.getRemainingCooldown(TV4H8,Pd())end
local k=function(HdS)return mf1UO.getTotalCooldown(HdS,Pd())end
local NTz6jdr=function()return"ReplaceableTextures\\PassiveButtons\\PASBTNCorrosiveBreath.blp"end
return{cast=Cb,getSpellId=Pd,getSpellName=po2ff4F,getIcon=NTz6jdr,getSpellTooltip=f,getSpellCooldown=a,getSpellCasttime=mBRe}end
local hrVI4meU=function()local bvGUlnl8=require('src/hero.lua')
local E2J9X=require('src/mouse.lua')local y=require('src/vector.lua')
local _Sbcpg=require('src/effect.lua')local y99_=require('src/projectile.lua')
local f7ZTY=require('src/log.lua')local WO=require('src/casttime.lua')
local dcu=require('src/animations.lua')local HR=require('src/collision.lua')
local P=require('src/damage.lua')local y1jZqCcc=require('src/spells/cooldowns.lua')local ARVZ=100;local ulU=function()
return'molecregen'end
local mkpyU5eh=function()return'Molecular Regeneration'end
local U9=function(u)
return'Ivanov creates a cloud of healing mist in an area, healing all friendly targets in the mist for 100 per second.'end;local pzpDOr=function(ipLsp)return ARVZ end
local yoo=function(cpC)return 0.5 end
local MXzW=function(k73bTK)if y1jZqCcc.isOnCooldown(k73bTK,ulU())then
f7ZTY.log(k73bTK,mkpyU5eh().." is on cooldown!",f7ZTY.TYPE.ERROR)return false end
local bvGUlnl8=bvGUlnl8.getHero(k73bTK)
local cqVt=y:new{x=GetUnitX(bvGUlnl8),y=GetUnitY(bvGUlnl8)}
local ywq=y:new{x=E2J9X.getMouseX(k73bTK),y=E2J9X.getMouseY(k73bTK)}local lMF=y:new(cqVt):subtract(ywq)
local WVA=lMF:magnitude()if WVA>800 then
f7ZTY.log(k73bTK,"Out of range!",f7ZTY.TYPE.ERROR)return false end
IssueImmediateOrder(bvGUlnl8,"stop")dcu.queueAnimation(bvGUlnl8,17,2)
local iWh=WO.cast(k73bTK,1)if not iWh then return false end
y1jZqCcc.startCooldown(k73bTK,ulU(),ARVZ)dcu.queueAnimation(bvGUlnl8,18,2)
y99_.createProjectile{playerId=k73bTK,model="erej",fromV=cqVt,toV=ywq,speed=500,destroyOnCollide=false,onDestroy=function()
_Sbcpg.createEffect{model="ecld",duration=10,x=ywq.x,y=ywq.y}end}
for XG=1,10,1 do TriggerSleepAction(1)
local Ts=HR.getAllCollisions(ywq,550)
for K8jL8qZ,wucZH2qz in pairs(Ts)do if IsUnitAlly(wucZH2qz,Player(k73bTK))then
P.heal(bvGUlnl8,wucZH2qz,100)
_Sbcpg.createEffect{model="ehet",unit=wucZH2qz,duration=0.1}end end end;return true end
local Uvqu6c5=function(Ox0yyMI3)return y1jZqCcc.getRemainingCooldown(Ox0yyMI3,ulU())end
local MMXv=function(hvw)return y1jZqCcc.getTotalCooldown(hvw,ulU())end
local R=function()return"ReplaceableTextures\\CommandButtons\\BTNPlagueCloud.blp"end
return{cast=MXzW,getSpellId=ulU,getSpellName=mkpyU5eh,getIcon=R,getSpellTooltip=U9,getSpellCooldown=pzpDOr,getSpellCasttime=yoo}end
local xEq6TAF=function()local ZFhe=require('src/hero.lua')
local Kgpa=require('src/vector.lua')local TEz=require('src/projectile.lua')
local AJJ1kZS=require('src/log.lua')local B=require('src/animations.lua')
local vZdI=require('src/target.lua')local Bd=require('src/casttime.lua')
local e=require('src/buff.lua')local tsGRH=require('src/damage.lua')
local U=require('src/spells/cooldowns.lua')local m=1;local U84H37=function()return'rejuvput'end;local C=function()
return'Rejuvination Potion'end
local f4fN=function(jGg)
return
'Ivanov\'s main heal, this heals the target for 30 instantly and applies a heal over time effect that will heal them for 30 per second for 10 seconds. Stacks 3 times.'end;local ODzAx=function(x)return m end
local IsAkf=function(vqs1_7)return 0.5 end
local Pwzq_Fj=function(vLdk)if U.isOnCooldown(vLdk,U84H37())then
AJJ1kZS.log(vLdk,C().." is on cooldown!",AJJ1kZS.TYPE.ERROR)return false end
local ZFhe=ZFhe.getHero(vLdk)local vZdI=vZdI.getTarget(vLdk)if vZdI==nil then vZdI=ZFhe end;if not
IsUnitAlly(vZdI,Player(vLdk))then vZdI=ZFhe end
local cU6JgXi=Kgpa:new{x=GetUnitX(ZFhe),y=GetUnitY(ZFhe)}
local tEiL=Kgpa:new{x=GetUnitX(vZdI),y=GetUnitY(vZdI)}local nWMi=Kgpa:new(cU6JgXi):subtract(tEiL)
local gl9xJb=nWMi:magnitude()if gl9xJb>800 then
AJJ1kZS.log(vLdk,"Out of range!",AJJ1kZS.TYPE.ERROR)return false end
IssueImmediateOrder(ZFhe,"stop")B.queueAnimation(ZFhe,3,1)
SetUnitFacingTimed(ZFhe,bj_RADTODEG*Atan2(tEiL.y-cU6JgXi.y,
tEiL.x-cU6JgXi.x),0.05)local oHk5pUB=Bd.cast(vLdk,0.5)if not oHk5pUB then return false end
U.startCooldown(vLdk,U84H37(),m)
TEz.createProjectile{playerId=vLdk,model="erej",fromV=cU6JgXi,destUnit=vZdI,speed=500,destroyOnCollide=false,onDestroy=function()tsGRH.heal(ZFhe,vZdI,30)
e.addBuff(ZFhe,vZdI,'rejuvpot',10)e.addBuff(ZFhe,vZdI,'corrosivedecay',300)end}return true end
local GKDMp=function(Ltm)return U.getRemainingCooldown(Ltm,U84H37())end
local SC=function(yW9GRj)return U.getTotalCooldown(yW9GRj,U84H37())end
local bWuOG=function()return"ReplaceableTextures\\CommandButtons\\BTNPotionOfClarity.blp"end;return
{cast=Pwzq_Fj,getSpellId=U84H37,getSpellName=C,getIcon=bWuOG,getSpellTooltip=f4fN,getSpellCooldown=ODzAx,getSpellCasttime=IsAkf}end
local UIjls=function()local QGXSL6=require('src/hero.lua')
local M_X=require('src/mouse.lua')local eir=require('src/vector.lua')
local e=require('src/effect.lua')local XKqiVa3=require('src/log.lua')
local v4mltq=require('src/casttime.lua')local AIOtQ8e_=require('src/animations.lua')
local d=require('src/spells/cooldowns.lua')local l7=10;local vtjp=function()return'bulwark'end;local qLEp2=function()
return'Bulwark of the Masses'end
local XbIEI_3k=function(l8zYu)return
'Tarcza brings a shield down surrounding the area, which blocks all projectiles from passing through.'end;local Ysuv=function(x17pq6s)return l7 end
local v=function(Cxc)return 0.3 end
local my19G=function(GdZty4)if d.isOnCooldown(GdZty4,vtjp())then
XKqiVa3.log(GdZty4,qLEp2().." is on cooldown!",XKqiVa3.TYPE.ERROR)return false end
local QGXSL6=QGXSL6.getHero(GdZty4)
local dNQQjm0G=eir:new{x=GetUnitX(QGXSL6),y=GetUnitY(QGXSL6)}
local qeyvW=eir:new{x=M_X.getMouseX(GdZty4),y=M_X.getMouseY(GdZty4)}IssueImmediateOrder(QGXSL6,"stop")
AIOtQ8e_.queueAnimation(QGXSL6,10,1.5)d.startCooldown(GdZty4,vtjp(),l7)
v4mltq.cast(GdZty4,0.3,false)AIOtQ8e_.queueAnimation(QGXSL6,3,1.5)
e.createEffect{model="ebul",unit=QGXSL6,duration=8,timeScale=0.05}return true end
local oO=function(fuJ)return d.getRemainingCooldown(fuJ,vtjp())end
local zqYNA=function(vBt)return d.getTotalCooldown(vBt,vtjp())end
local XMzOvb=function()return"ReplaceableTextures\\CommandButtons\\BTNGlove.blp"end;return
{cast=my19G,getSpellId=vtjp,getSpellName=qLEp2,getIcon=XMzOvb,getSpellTooltip=XbIEI_3k,getSpellCooldown=Ysuv,getSpellCasttime=v}end
local jdLnB0vD=function()local j6f=require('src/hero.lua')
local DhLDRM=require('src/vector.lua')local LgVwYh6=require('src/projectile.lua')
local tSBo=require('src/log.lua')local FuIUnM=require('src/buff.lua')
local WtoMT=require('src/casttime.lua')local gTa7jfw=require('src/target.lua')
local d6RaDSY=require('src/animations.lua')local hJEr=require('src/damage.lua')
local deq_fwZ=require('src/spells/cooldowns.lua')local d4iuG=1;local tn2=10;local iFXPT_P={}
local KY=function(HLkyy)return

IsUnitType(HLkyy,UNIT_TYPE_STUNNED)or
IsUnitType(HLkyy,UNIT_TYPE_SNARED)or IsUnitType(HLkyy,UNIT_TYPE_POLYMORPHED)or IsUnitPaused(HLkyy)end;local Vg7WM=function()return'blitz'end
local DPOHoac=function()return'Blitz / Assist'end
local HLe=function(ttFi_l_)
return
'Charge towards the target. To enemies, deal 40 damage and stun them for 2 seconds. To allies, reduce their incoming damage by 40% for 2 seconds. Can be recast quickly after the first cast.'end;local COX=function(dSeSQ5)return d4iuG end
local BP9Y0=function(CHYkRQW6)return 0.5 end
local DR=function(cZtDtN7N)if deq_fwZ.isOnCooldown(cZtDtN7N,Vg7WM())then
tSBo.log(cZtDtN7N,DPOHoac().." is on cooldown!",tSBo.TYPE.ERROR)return false end
local j6f=j6f.getHero(cZtDtN7N)local gTa7jfw=gTa7jfw.getTarget(cZtDtN7N)
local Z7UyFJN=DhLDRM:new{x=GetUnitX(j6f),y=GetUnitY(j6f)}
local DYBqYM=DhLDRM:new{x=GetUnitX(gTa7jfw),y=GetUnitY(gTa7jfw)}if gTa7jfw==nil then
tSBo.log(cZtDtN7N,"You have no target",tSBo.TYPE.ERROR)return false end;if KY(j6f)then
tSBo.log(cZtDtN7N,"You can't move right now",tSBo.TYPE.ERROR)return false end
local s1=DhLDRM:new(Z7UyFJN):subtract(DYBqYM)local v=s1:magnitude()if v>800 then
tSBo.log(cZtDtN7N,"Out of range!",tSBo.TYPE.ERROR)return false end
if
iFXPT_P[cZtDtN7N]==nil then iFXPT_P[cZtDtN7N]={attackCount=-1}end;iFXPT_P[cZtDtN7N].attackCount=
(iFXPT_P[cZtDtN7N].attackCount+1)%2
deq_fwZ.startCooldown(cZtDtN7N,Vg7WM(),
iFXPT_P[cZtDtN7N].attackCount==1 and tn2 or d4iuG)IssueImmediateOrder(j6f,"stop")
d6RaDSY.queueAnimation(j6f,12,2)local aFb6x0hg=bj_RADTODEG*
Atan2(DYBqYM.y-Z7UyFJN.y,DYBqYM.x-Z7UyFJN.x)
SetUnitFacing(j6f,aFb6x0hg)
if IsUnitAlly(gTa7jfw,Player(cZtDtN7N))then
LgVwYh6.createProjectile{playerId=cZtDtN7N,model="eshr",fromV=Z7UyFJN,destUnit=gTa7jfw,speed=1010}else
LgVwYh6.createProjectile{playerId=cZtDtN7N,model="eshe",fromV=Z7UyFJN,destUnit=gTa7jfw,speed=1010}end
LgVwYh6.createProjectile{playerId=cZtDtN7N,projectile=j6f,fromV=Z7UyFJN,destUnit=gTa7jfw,speed=1000,onDestroy=function()
if IsUnitAlly(gTa7jfw,Player(cZtDtN7N))then
FuIUnM.addBuff(j6f,gTa7jfw,'assist',2)else hJEr.dealDamage(j6f,gTa7jfw,40)
FuIUnM.addBuff(j6f,gTa7jfw,'stun',2)end;WtoMT.stopCast(cZtDtN7N)
d6RaDSY.queueAnimation(j6f,3,0.6)end}WtoMT.cast(cZtDtN7N,0.5,false)return true end
local Lc4UCGl=function(_KKTJh)return deq_fwZ.getRemainingCooldown(_KKTJh,Vg7WM())end
local lEoJniu=function(Gikjz8_9)return deq_fwZ.getTotalCooldown(Gikjz8_9,Vg7WM())end
local sMV=function()return"ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp"end;return
{cast=DR,getSpellId=Vg7WM,getSpellName=DPOHoac,getIcon=sMV,getSpellTooltip=HLe,getSpellCooldown=COX,getSpellCasttime=BP9Y0}end
local PSlD=function()local WN20gP=require('src/hero.lua')
local L2VjlBE=require('src/mouse.lua')local xH=require('src/vector.lua')
local N=require('src/projectile.lua')local R=require('src/log.lua')
local owi4kS=require('src/casttime.lua')local zUfjp=require('src/animations.lua')
local fd5S4R=require('src/damage.lua')local Jt=require('src/spells/cooldowns.lua')local vJ88gTG=5
local GVscDb=function(mmcA)return

IsUnitType(mmcA,UNIT_TYPE_STUNNED)or IsUnitType(mmcA,UNIT_TYPE_SNARED)or
IsUnitType(mmcA,UNIT_TYPE_POLYMORPHED)or IsUnitPaused(mmcA)end;local eGuTD=function()return'boomerang'end
local l=function()return'Shield Boomerang'end
local rcJbyavv=function(Pk)
return
'Tarcza throws a shield of lightning forward, dealing 50 damage to all enemies struck. It will then return to Tarcza, dealing 100 damage on the way back.'end;local nPu=function(es)return vJ88gTG end
local wKdmIyn=function(F0ZX)return 0.2 end
local Po67cFi=function(W_)if Jt.isOnCooldown(W_,eGuTD())then
R.log(W_,l().." is on cooldown!",R.TYPE.ERROR)return false end
local WN20gP=WN20gP.getHero(W_)
local he3X=xH:new{x=GetUnitX(WN20gP),y=GetUnitY(WN20gP)}
local IAEOa=xH:new{x=L2VjlBE.getMouseX(W_),y=L2VjlBE.getMouseY(W_)}if GVscDb(WN20gP)then
R.log(W_,"You can't move right now",R.TYPE.ERROR)return false end
Jt.startCooldown(W_,eGuTD(),vJ88gTG)IssueImmediateOrder(WN20gP,"stop")
zUfjp.queueAnimation(WN20gP,3,1)
local lq0=bj_RADTODEG*Atan2(IAEOa.y-he3X.y,IAEOa.x-he3X.x)SetUnitFacing(WN20gP,lq0)
N.createProjectile{playerId=W_,model="eboo",fromV=he3X,toV=IAEOa,speed=800,length=650,removeInsteadOfKill=true,onCollide=function(cJ)
if
IsUnitEnemy(cJ,Player(W_))then fd5S4R.dealDamage(WN20gP,cJ,50)end;return false end,onDestroy=function(VxeY5X)
N.createProjectile{playerId=W_,model="eboo",fromV=xH:new{x=GetUnitX(VxeY5X),y=GetUnitY(VxeY5X)},destUnit=WN20gP,speed=650,removeInsteadOfKill=true,onCollide=function(oS8SgP)
if
IsUnitEnemy(oS8SgP,Player(W_))then fd5S4R.dealDamage(WN20gP,oS8SgP,100)end;return false end}end}owi4kS.cast(W_,0.2,false)return true end
local nlAeE=function(hBilFrU4)return Jt.getRemainingCooldown(hBilFrU4,eGuTD())end
local h=function(AodN1)return Jt.getTotalCooldown(AodN1,eGuTD())end
local B=function()return"ReplaceableTextures\\CommandButtons\\BTNDefendStop.blp"end;return
{cast=Po67cFi,getSpellId=eGuTD,getSpellName=l,getIcon=B,getSpellTooltip=rcJbyavv,getSpellCooldown=nPu,getSpellCasttime=wKdmIyn}end
local nN=function()local yj4Mo=require('src/hero.lua')
local BiwDB=require('src/mouse.lua')local Ca=require('src/vector.lua')
local wHJE0ZY=require('src/effect.lua')local Js7=require('src/collision.lua')
local h6W2B6z=require('src/log.lua')local Cx=require('src/buff.lua')
local oj=require('src/casttime.lua')local u1=require('src/animations.lua')
local TYixjzX4=require('src/spells/cooldowns.lua')local vI9Mah0=15;local Ad=function()return'curshout'end;local l=function()
return'Courageous Shout'end
local LwNRuJvR=function(Wrjc)return
'Tarcza shouts courageously, reducing the movement speed of nearby enemies by 40% for 5 seconds.'end;local nohO9Ia=function(y2zVVi)return vI9Mah0 end
local FDJ=function(mQIVEP5)return 0.2 end
local u=function(QV4HoK0r)if TYixjzX4.isOnCooldown(QV4HoK0r,Ad())then
h6W2B6z.log(QV4HoK0r,l().." is on cooldown!",h6W2B6z.TYPE.ERROR)return false end
local yj4Mo=yj4Mo.getHero(QV4HoK0r)
local uqoP=Ca:new{x=GetUnitX(yj4Mo),y=GetUnitY(yj4Mo)}
local fXnJ2kO=Ca:new{x=BiwDB.getMouseX(QV4HoK0r),y=BiwDB.getMouseY(QV4HoK0r)}u1.queueAnimation(yj4Mo,9,1)
TYixjzX4.startCooldown(QV4HoK0r,Ad(),vI9Mah0)
wHJE0ZY.createEffect{model="ecur",unit=yj4Mo,duration=1}local mHD8=Js7.getAllCollisions(uqoP,400)for LtlNupYZ,VY6SD in pairs(mHD8)do
if
IsUnitEnemy(VY6SD,Player(QV4HoK0r))then Cx.addBuff(yj4Mo,VY6SD,'curshout',5)end end
oj.cast(QV4HoK0r,0.2,false)return true end
local v=function(ydb)return TYixjzX4.getRemainingCooldown(ydb,Ad())end
local i0iuEsi=function(O)return TYixjzX4.getTotalCooldown(O,Ad())end
local q=function()return"ReplaceableTextures\\CommandButtons\\BTNBattleRoar.blp"end
return{cast=u,getSpellId=Ad,getSpellName=l,getIcon=q,getSpellTooltip=LwNRuJvR,getSpellCooldown=nohO9Ia,getSpellCasttime=FDJ}end
local J=function()local _=require('src/hero.lua')
local ElVn76=require('src/vector.lua')local yAEULfS=require('src/log.lua')
local O6Ft6oPX=require('src/casttime.lua')local RWubfxqF=require('src/target.lua')
local E=require('src/animations.lua')local e0kpxJ=require('src/spells/cooldowns.lua')
local VXZfG=require('src/threat.lua')local Bd=5;local Qf=function()return'challenge'end
local p2jTk=function()return'Challenge'end
local _5Pf=function(nWzKrVe)return'Tarcza challenges the opponent, causing a high amount of threat.'end;local vHVSWs9=function(zha)return Bd end
local IR7v=function(yBtE)return 0.1 end
local _SmNfMoD=function(GlmZIM)if e0kpxJ.isOnCooldown(GlmZIM,Qf())then
yAEULfS.log(GlmZIM,p2jTk().." is on cooldown!",yAEULfS.TYPE.ERROR)return false end
local _=_.getHero(GlmZIM)local RWubfxqF=RWubfxqF.getTarget(GlmZIM)
local bm=ElVn76:new{x=GetUnitX(_),y=GetUnitY(_)}
local ken=ElVn76:new{x=GetUnitX(RWubfxqF),y=GetUnitY(RWubfxqF)}if RWubfxqF==nil then
yAEULfS.log(GlmZIM,"You have no target",yAEULfS.TYPE.ERROR)return false end;if
IsUnitAlly(RWubfxqF,Player(GlmZIM))then
yAEULfS.log(GlmZIM,"The target is friendly.",yAEULfS.TYPE.ERROR)return end
local gHpr=ElVn76:new(bm):subtract(ken)local wL=gHpr:magnitude()if wL>800 then
yAEULfS.log(GlmZIM,"Out of range!",yAEULfS.TYPE.ERROR)return false end
e0kpxJ.startCooldown(GlmZIM,Qf(),Bd)IssueImmediateOrder(_,"stop")E.queueAnimation(_,9,1)
local uXW=
bj_RADTODEG*Atan2(ken.y-bm.y,ken.x-bm.x)SetUnitFacing(_,uXW)
VXZfG.addThreat(_,RWubfxqF,40000)O6Ft6oPX.cast(GlmZIM,0.1,false)return true end
local g5wBR=function(f1Guph)return e0kpxJ.getRemainingCooldown(f1Guph,Qf())end
local z0SIbm=function(VoIe2R)return e0kpxJ.getTotalCooldown(VoIe2R,Qf())end
local zL=function()return"ReplaceableTextures\\CommandButtons\\BTNDevourMagic.blp"end;return
{cast=_SmNfMoD,getSpellId=Qf,getSpellName=p2jTk,getIcon=zL,getSpellTooltip=_5Pf,getSpellCooldown=vHVSWs9,getSpellCasttime=IR7v}end
local A=function()local wULNB=require('src/hero.lua')
local Uin1c=require('src/mouse.lua')local uZOynu=require('src/vector.lua')
local XYjab=require('src/effect.lua')local g226Ed=require('src/projectile.lua')
local iKS=require('src/log.lua')local vKlf=require('src/buff.lua')
local SlWsaU=require('src/casttime.lua')local Mj=require('src/animations.lua')
local c_=require('src/damage.lua')local Kw4ta8iS=require('src/spells/cooldowns.lua')local AlV6=60
local LtS=function(CaFSQRf)
return
IsUnitType(CaFSQRf,UNIT_TYPE_STUNNED)or IsUnitType(CaFSQRf,UNIT_TYPE_SNARED)or
IsUnitType(CaFSQRf,UNIT_TYPE_POLYMORPHED)or
IsUnitPaused(CaFSQRf)end;local TaJ2US=function()return'shieldcharge'end
local Ghp0=function()return'Shield Charge'end
local opR=function(vn3NH)
return'Tarcza charges forward with his shield, causing 400 damage to all impacted units, pushing them away and stunning them for 2 seconds.'end;local sif2=function(JFZ)return AlV6 end
local PGiQADW=function(Lj_st9)return 0.6 end
local PI=function(Ubiy)if Kw4ta8iS.isOnCooldown(Ubiy,TaJ2US())then
iKS.log(Ubiy,Ghp0().." is on cooldown!",iKS.TYPE.ERROR)return false end
local wULNB=wULNB.getHero(Ubiy)
local mIV=uZOynu:new{x=GetUnitX(wULNB),y=GetUnitY(wULNB)}
local hgRaw=uZOynu:new{x=Uin1c.getMouseX(Ubiy),y=Uin1c.getMouseY(Ubiy)}if LtS(wULNB)then
iKS.log(Ubiy,"You can't move right now",iKS.TYPE.ERROR)return false end
Kw4ta8iS.startCooldown(Ubiy,TaJ2US(),AlV6)IssueImmediateOrder(wULNB,"stop")
Mj.queueAnimation(wULNB,12,2)
local vvwRldj=bj_RADTODEG*Atan2(hgRaw.y-mIV.y,hgRaw.x-mIV.x)SetUnitFacing(wULNB,vvwRldj)
g226Ed.createProjectile{playerId=Ubiy,model="eshc",fromV=mIV,toV=hgRaw,speed=1250,length=800}
g226Ed.createProjectile{playerId=Ubiy,projectile=wULNB,fromV=mIV,toV=hgRaw,speed=1200,length=800,radius=100,onCollide=function(f_7I8Jo)
if IsUnitEnemy(f_7I8Jo,Player(Ubiy))then
c_.dealDamage(wULNB,f_7I8Jo,400)vKlf.addBuff(wULNB,f_7I8Jo,'stun',2)
local K072gC9=GetRandomInt(0,1)local SbuPM=K072gC9 ==0 and 90 or-90
local cobaoFK=uZOynu:fromAngle(
(vvwRldj+SbuPM)*bj_DEGTORAD):normalize():multiply(100):add(uZOynu:new{x=GetUnitX(f_7I8Jo),y=GetUnitY(f_7I8Jo)})SetUnitPosition(f_7I8Jo,cobaoFK.x,cobaoFK.y)
XYjab.createEffect{unit=f_7I8Jo,model="eshi",duration=1}end;return false end,onDestroy=function()
XYjab.createEffect{unit=wULNB,model="eshi",duration=1}Mj.queueAnimation(wULNB,3,0.6)end}SlWsaU.cast(Ubiy,0.6,false)return true end
local dZc=function(JbhOvI)
return Kw4ta8iS.getRemainingCooldown(JbhOvI,TaJ2US())end
local iebKJjA=function(yA)return Kw4ta8iS.getTotalCooldown(yA,TaJ2US())end
local d=function()return"ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp"end
return{cast=PI,getSpellId=TaJ2US,getSpellName=Ghp0,getIcon=d,getSpellTooltip=opR,getSpellCooldown=sif2,getSpellCasttime=PGiQADW}end
local g3Qeqnr=function()local NUsjSgB=require('src/hero.lua')
local Xuvxfbm=require('src/mouse.lua')local tY=require('src/vector.lua')
local l1YAdT2c=require('src/effect.lua')local A1A=require('src/collision.lua')
local PMB1UGv=require('src/log.lua')local TicLenZ=require('src/buff.lua')
local Xc=require('src/casttime.lua')local onx=require('src/animations.lua')
local zhHo=require('src/spells/cooldowns.lua')local fgqM6D=50;local KXz5=function()return'flag'end
local IxVqKpu=function()return'Flag'end
local B0cg08r_=function(zJbXZu2D)
return
'Tarcza throws a flag down on the target location, which '..'increases the damage dealt, reduces the damage taken, and increases '..
'the move speed of nearby targets by 10% for 10 seconds.'end;local GRkE=function(drq)return fgqM6D end
local _MI=function(ezkF)return 0.2 end
local TITR=function(dlHohKjZ)if zhHo.isOnCooldown(dlHohKjZ,KXz5())then
PMB1UGv.log(dlHohKjZ,IxVqKpu().." is on cooldown!",PMB1UGv.TYPE.ERROR)return false end
local NUsjSgB=NUsjSgB.getHero(dlHohKjZ)
local QI=tY:new{x=GetUnitX(NUsjSgB),y=GetUnitY(NUsjSgB)}
local fI=tY:new{x=Xuvxfbm.getMouseX(dlHohKjZ),y=Xuvxfbm.getMouseY(dlHohKjZ)}local In=tY:new(QI):subtract(fI)local u=In:magnitude()if
u>800 then
PMB1UGv.log(dlHohKjZ,"Out of range!",PMB1UGv.TYPE.ERROR)return false end
if not
IsVisibleToPlayer(fI.x,fI.y,Player(dlHohKjZ))then
PMB1UGv.log(dlHohKjZ,"Target not in line of sight.",PMB1UGv.TYPE.ERROR)return false end;onx.queueAnimation(NUsjSgB,9,1)
Xc.cast(dlHohKjZ,0.2,false)zhHo.startCooldown(dlHohKjZ,KXz5(),fgqM6D)
l1YAdT2c.createEffect{model="eflg",x=fI.x,y=fI.y,duration=10}
for ygfhj=0,10,1 do local fN=A1A.getAllCollisions(fI,500)for ws8,yDc8 in pairs(fN)do
if
IsUnitAlly(yDc8,Player(dlHohKjZ))then TicLenZ.addBuff(NUsjSgB,yDc8,'flag',1.5)end end
TriggerSleepAction(1)end;return true end
local i_aIFe=function(d3g)return zhHo.getRemainingCooldown(d3g,KXz5())end
local YFJRo6=function(vZH)return zhHo.getTotalCooldown(vZH,KXz5())end
local V3EcTFrW=function()return"ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"end;return
{cast=TITR,getSpellId=KXz5,getSpellName=IxVqKpu,getIcon=V3EcTFrW,getSpellTooltip=B0cg08r_,getSpellCooldown=GRkE,getSpellCasttime=_MI}end
local qHpY64=function()local RWqs=require('src/hero.lua')
local tn=require('src/mouse.lua')local FKyVcS=require('src/vector.lua')
local zNfSeV=require('src/log.lua')local HtbHbcu=require('src/buff.lua')
local MDLzj7=require('src/casttime.lua')local RNIZJ=require('src/animations.lua')
local ma=require('src/spells/cooldowns.lua')local X_=10;local E_fkS=function()return'stalwartshell'end;local iv18CGzs=function()
return'Stalwart Shell'end
local TpEB=function(Ge)return
'Tarcza holds his shield high, preventing all incoming damage for 1.5 seconds, and blocking all incoming projectiles.'end;local x=function(tYF)return X_ end
local yF1U=function(jzn73)return 1.5 end
local JE6a4s=function(vQTwJ6V1)if ma.isOnCooldown(vQTwJ6V1,E_fkS())then
zNfSeV.log(vQTwJ6V1,iv18CGzs().." is on cooldown!",zNfSeV.TYPE.ERROR)return false end
local RWqs=RWqs.getHero(vQTwJ6V1)
local Knf7U=FKyVcS:new{x=GetUnitX(RWqs),y=GetUnitY(RWqs)}
local I0=FKyVcS:new{x=tn.getMouseX(vQTwJ6V1),y=tn.getMouseY(vQTwJ6V1)}IssueImmediateOrder(RWqs,"stop")
RNIZJ.queueAnimation(RWqs,10,1.5)ma.startCooldown(vQTwJ6V1,E_fkS(),X_)
HtbHbcu.addBuff(RWqs,RWqs,'stalwartshell',1.5)MDLzj7.cast(vQTwJ6V1,1.5,false)return true end
local sloRQ=function(jFyAt)return ma.getRemainingCooldown(jFyAt,E_fkS())end
local mJ2=function(LyJxC)return ma.getTotalCooldown(LyJxC,E_fkS())end
local P=function()return"ReplaceableTextures\\CommandButtons\\BTNDefend.blp"end;return
{cast=JE6a4s,getSpellId=E_fkS,getSpellName=iv18CGzs,getIcon=P,getSpellTooltip=TpEB,getSpellCooldown=x,getSpellCasttime=yF1U}end
local z=function()local E=require('src/hero.lua')
local vnC8kIGX=require('src/vector.lua')local dnKfz=require('src/log.lua')
local kDt=require('src/animations.lua')local QLp=require('src/target.lua')
local IXNl=require('src/buff.lua')local oqPG=require('src/spells/cooldowns.lua')local Pa=60
local j37n1ZA=function()return'blind'end;local aLxQ=function()return'Blind'end
local GW=function(CMIGYkL8)return
'Causes the opponent to be unable to act for 8 seconds. Any damage taken by the opponent breaks this effect.'end;local AzhdvccS=function(n9FOtM)return Pa end
local JPYFFxAp=function(K)return 0 end
local i=function(EeAZn)if oqPG.isOnCooldown(EeAZn,j37n1ZA())then
dnKfz.log(EeAZn,aLxQ().." is on cooldown!",dnKfz.TYPE.ERROR)return false end
local E=E.getHero(EeAZn)local QLp=QLp.getTarget(EeAZn)if QLp==nil then
dnKfz.log(EeAZn,"You don't have a target!",dnKfz.TYPE.ERROR)return false end;if
IsUnitAlly(QLp,Player(EeAZn))then
dnKfz.log(EeAZn,"The target is friendly.",dnKfz.TYPE.ERROR)return end
local aCKog=vnC8kIGX:new{x=GetUnitX(E),y=GetUnitY(E)}
local c=vnC8kIGX:new{x=GetUnitX(QLp),y=GetUnitY(QLp)}local OWrvY=vnC8kIGX:new(aCKog):subtract(c)
local lp2=OWrvY:magnitude()if lp2 >600 then
dnKfz.log(EeAZn,"Out of range!",dnKfz.TYPE.ERROR)return false end
IssueImmediateOrder(E,"stop")kDt.queueAnimation(E,4,1)
SetUnitFacingTimed(E,bj_RADTODEG*Atan2(c.y-aCKog.y,c.x-
aCKog.x),0.05)oqPG.startCooldown(EeAZn,j37n1ZA(),Pa)
IXNl.addBuff(E,QLp,'blind',8)return true end
local AP1UcfB=function(k)return oqPG.getRemainingCooldown(k,j37n1ZA())end
local e=function(sEjUvkV)return oqPG.getTotalCooldown(sEjUvkV,j37n1ZA())end
local H4=function()return"ReplaceableTextures\\CommandButtons\\BTNSentryWard.blp"end;return
{cast=i,getSpellId=j37n1ZA,getSpellName=aLxQ,getIcon=H4,getSpellTooltip=GW,getSpellCooldown=AzhdvccS,getSpellCasttime=JPYFFxAp}end
local qccJ5b=function()local pnOWD9=require('src/hero.lua')
local iRm2=require('src/mouse.lua')local J61iBvjC=require('src/vector.lua')
local _=require('src/effect.lua')local X79LkbfD=require('src/collision.lua')
local JNRj6X=require('src/log.lua')local ldz480=require('src/casttime.lua')
local rE=require('src/animations.lua')local f7eR2T=require('src/damage.lua')
local l=require('src/threat.lua')local XZ3A=require('src/spells/cooldowns.lua')local Czs0f=5;local aMvb=function()
return'whirlwind'end
local _QG=function()return'Whirlwind'end
local CWG=function(Xve)return'Deals 100 damage to all nearby units. Causes a high amount of threat.'end;local z1q=function(Hk0hzj)return Czs0f end
local YkD6SuyP=function(Mfs)return 0.4 end
local GW3xWh=function(JqnndWc)if XZ3A.isOnCooldown(JqnndWc,aMvb())then
JNRj6X.log(JqnndWc,_QG().." is on cooldown!",JNRj6X.TYPE.ERROR)return false end
local pnOWD9=pnOWD9.getHero(JqnndWc)
local l5T8J5g1=J61iBvjC:new{x=GetUnitX(pnOWD9),y=GetUnitY(pnOWD9)}
local RhLeG=J61iBvjC:new{x=iRm2.getMouseX(JqnndWc),y=iRm2.getMouseY(JqnndWc)}rE.queueAnimation(pnOWD9,17,1)
XZ3A.startCooldown(JqnndWc,aMvb(),Czs0f)for n=0.5,1,0.1 do
_.createEffect{model="ersl",x=l5T8J5g1.x,y=l5T8J5g1.y,duration=0.5,scale=0.6,timeScale=n}end
local tOSI20=X79LkbfD.getAllCollisions(l5T8J5g1,200)
for mZcPQEV,O_oVTYL in pairs(tOSI20)do
if IsUnitEnemy(O_oVTYL,Player(JqnndWc))then
f7eR2T.dealDamage(pnOWD9,O_oVTYL,100)l.addThreat(pnOWD9,O_oVTYL,400)
_.createEffect{model="ebld",unit=O_oVTYL,duration=0.1}end end;ldz480.cast(JqnndWc,0.4,false)return true end
local eA_ohY=function(PGzKhtPH)return XZ3A.getRemainingCooldown(PGzKhtPH,aMvb())end
local b5p2AMKP=function(wI3DS0Kh)return XZ3A.getTotalCooldown(wI3DS0Kh,aMvb())end
local m=function()return"ReplaceableTextures\\CommandButtons\\BTNWhirlwind.blp"end;return
{cast=GW3xWh,getSpellId=aMvb,getSpellName=_QG,getIcon=m,getSpellTooltip=CWG,getSpellCooldown=z1q,getSpellCasttime=YkD6SuyP}end
local ARuba=function()local CwTDNbR=require('src/hero.lua')
local AJfSij6_=require('src/log.lua')local Lr=require('src/animations.lua')
local NXu695=require('src/buff.lua')local lzWnF=require('src/spells/cooldowns.lua')local sNe6_x=120;local fBLoB6JH=function()
return'focus'end
local z6gv=function()return'Focus'end
local ZZ93rHc0=function(jhOfPSgm)return'Increase your damage by 20% and movespeed by 50% for 20 seconds.'end;local j_V=function(eri)return sNe6_x end
local I_=function(uaTR)return 0 end
local yPn=function(JDs76MG)if lzWnF.isOnCooldown(JDs76MG,fBLoB6JH())then
AJfSij6_.log(JDs76MG,z6gv().." is on cooldown!",AJfSij6_.TYPE.ERROR)return false end
local CwTDNbR=CwTDNbR.getHero(JDs76MG)Lr.queueAnimation(CwTDNbR,4,1)
lzWnF.startCooldown(JDs76MG,fBLoB6JH(),sNe6_x)NXu695.addBuff(CwTDNbR,CwTDNbR,'focus',20)return true end
local LsT=function(aDZVav)
return lzWnF.getRemainingCooldown(aDZVav,fBLoB6JH())end
local E=function(sRoTvf)return lzWnF.getTotalCooldown(sRoTvf,fBLoB6JH())end
local dOD2G=function()return"ReplaceableTextures\\CommandButtons\\BTNMarkOfFire.blp"end;return
{cast=yPn,getSpellId=fBLoB6JH,getSpellName=z6gv,getIcon=dOD2G,getSpellTooltip=ZZ93rHc0,getSpellCooldown=j_V,getSpellCasttime=I_}end
local Wo53nZ=function()local R1TLssk=require('src/hero.lua')
local H=require('src/mouse.lua')local cUR=require('src/vector.lua')
local p=require('src/effect.lua')local kKdY4XaA=require('src/projectile.lua')
local d=require('src/log.lua')local sPM6lF=require('src/casttime.lua')
local Qp_1=require('src/animations.lua')local q1YAR=require('src/damage.lua')
local kg=require('src/spells/cooldowns.lua')local bijI=0.5;local K=10;local lCr41We={}
local NhucT=function(e09Nk)return

IsUnitType(e09Nk,UNIT_TYPE_STUNNED)or
IsUnitType(e09Nk,UNIT_TYPE_SNARED)or IsUnitType(e09Nk,UNIT_TYPE_POLYMORPHED)or IsUnitPaused(e09Nk)end;local SZMbpM=function()return'dash'end
local aTkVS=function()return'Dash'end
local eBp38EEt=function(ifI_m2)
return'Dash forward, dealing 35 damage to all units struck. Can be recast quickly after the first activation.'end;local U8NHKEk=function(QSX2)return bijI end
local yf0=function(L1dTNDQb)return 0.15 end
local skphQH=function(eMzb)if kg.isOnCooldown(eMzb,SZMbpM())then
d.log(eMzb,aTkVS().." is on cooldown!",d.TYPE.ERROR)return false end
local R1TLssk=R1TLssk.getHero(eMzb)
local J0KiSt=cUR:new{x=GetUnitX(R1TLssk),y=GetUnitY(R1TLssk)}
local pXdVoc=cUR:new{x=H.getMouseX(eMzb),y=H.getMouseY(eMzb)}if NhucT(R1TLssk)then
d.log(eMzb,"You can't move right now",d.TYPE.ERROR)return false end;if
lCr41We[eMzb]==nil then lCr41We[eMzb]={attackCount=-1}end;lCr41We[eMzb].attackCount=(
lCr41We[eMzb].attackCount+1)%2
kg.startCooldown(eMzb,SZMbpM(),
lCr41We[eMzb].attackCount==1 and K or bijI)IssueImmediateOrder(R1TLssk,"stop")
Qp_1.queueAnimation(R1TLssk,8,1)
SetUnitFacing(R1TLssk,bj_RADTODEG*
Atan2(pXdVoc.y-J0KiSt.y,pXdVoc.x-J0KiSt.x))
kKdY4XaA.createProjectile{playerId=eMzb,model="eoil",fromV=J0KiSt,toV=pXdVoc,speed=4000,length=500,onCollide=function(xme)if IsUnitEnemy(xme,Player(eMzb))then
q1YAR.dealDamage(R1TLssk,xme,35)end;return false end}
kKdY4XaA.createProjectile{playerId=eMzb,projectile=R1TLssk,fromV=J0KiSt,toV=pXdVoc,speed=4000,length=500}sPM6lF.cast(eMzb,0.15,false)return true end
local ioxmHxH=function(kAbF)return kg.getRemainingCooldown(kAbF,SZMbpM())end
local YGhYv64=function(h)return kg.getTotalCooldown(h,SZMbpM())end
local i=function()return"ReplaceableTextures\\CommandButtons\\BTNDizzy.blp"end;return
{cast=skphQH,getSpellId=SZMbpM,getSpellName=aTkVS,getIcon=i,getSpellTooltip=eBp38EEt,getSpellCooldown=U8NHKEk,getSpellCasttime=yf0}end
local XRfQ=function()local GtezA0=require('src/hero.lua')
local sqZtSeO=require('src/mouse.lua')local K4W6=require('src/vector.lua')
local R4qp7=require('src/effect.lua')local _F71WhJ=require('src/projectile.lua')
local YciJj=require('src/log.lua')local CZ2Wt=require('src/casttime.lua')
local rp3QaP=require('src/collision.lua')local Anqa=require('src/animations.lua')
local sDak1ecL=require('src/damage.lua')local r=require('src/spells/cooldowns.lua')local C=0.5;local wM4R=5
local sHOVr={}local v4D=function()return'slash'end
local KBI_GdWx=function()return'Slash'end
local XcV=function(H42)
return
'The 1st and 2nd activation have 0.5s cooldown and deal 50 damage to all units in front of Yuji. The 3rd activation deals 300 damage and has a 5 second cooldown.'end;local yq_h4JT=function(JLx)return C end
local Dde=function(vDPis1Y)return 0.4 end
local RIc=function(pEV,v1pCX6,NK,KNYh)local STO_Hubw=(v1pCX6+90)*bj_DEGTORAD
local S4jSoR=K4W6:fromAngle(STO_Hubw):multiply(
NK*50):add(pEV)return
K4W6:fromAngle(v1pCX6*bj_DEGTORAD):multiply(KNYh*200):add(S4jSoR)end
local WL7T8_G=function(w)if r.isOnCooldown(w,v4D())then
YciJj.log(w,KBI_GdWx().." is on cooldown!",YciJj.TYPE.ERROR)return false end;if r[w]~=nil then
DestroyTimer(r[w])r[w]=nil end;local GtezA0=GtezA0.getHero(w)
local yX3j=K4W6:new{x=GetUnitX(GtezA0),y=GetUnitY(GtezA0)}
local bOwWOjQH=K4W6:new{x=sqZtSeO.getMouseX(w),y=sqZtSeO.getMouseY(w)}if sHOVr[w]==nil then sHOVr[w]={attackCount=-1}end;sHOVr[w].attackCount=(
sHOVr[w].attackCount+1)%3
r.startCooldown(w,v4D(),
sHOVr[w].attackCount==2 and wM4R or C)IssueImmediateOrder(GtezA0,"stop")
SetUnitTimeScale(GtezA0,2)
Anqa.queueAnimation(GtezA0,sHOVr[w].attackCount==2 and 3 or 2,
sHOVr[w].attackCount==2 and 1.5 or 1)
SetUnitFacing(GtezA0,bj_RADTODEG*
Atan2(bOwWOjQH.y-yX3j.y,bOwWOjQH.x-yX3j.x))
_F71WhJ.createProjectile{playerId=w,projectile=GtezA0,fromV=yX3j,toV=bOwWOjQH,speed=800,length=sHOVr[w].attackCount==2 and 250 or 100,radius=75,onCollide=function()return
true end,onDestroy=function()
local d=sHOVr[w].attackCount==2 and 300 or 50
local yX3j=K4W6:new{x=GetUnitX(GtezA0),y=GetUnitY(GtezA0)}
local pM6sO5R0=bj_RADTODEG*Atan2(bOwWOjQH.y-yX3j.y,bOwWOjQH.x-yX3j.x)
local TF4nyv={RIc(yX3j,pM6sO5R0,1,0),RIc(yX3j,pM6sO5R0,-1,0),RIc(yX3j,pM6sO5R0,-1,1),RIc(yX3j,pM6sO5R0,1,1)}local lilD_Ll=rp3QaP.getAllCollisions(TF4nyv)
for Q2jN,Y1v09ha in pairs(lilD_Ll)do if
IsUnitEnemy(Y1v09ha,Player(w))then sDak1ecL.dealDamage(GtezA0,Y1v09ha,d)
R4qp7.createEffect{model="ebld",unit=Y1v09ha,duration=0.1}end end end}
CZ2Wt.cast(w,sHOVr[w].attackCount==2 and 0.35 or 0.1,false)SetUnitTimeScale(GtezA0,1)return true end
local DN=function(XWU)return r.getRemainingCooldown(XWU,v4D())end
local _neQ47D=function(t)return r.getTotalCooldown(t,v4D())end
local scY=function()return"ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp"end;return
{cast=WL7T8_G,getSpellId=v4D,getSpellName=KBI_GdWx,getIcon=scY,getSpellTooltip=XcV,getSpellCooldown=yq_h4JT,getSpellCasttime=Dde}end
local gFPRdEC=function()local i=require('src/hero.lua')
local MMHRexVY=require('src/mouse.lua')local XuJg=require('src/vector.lua')
local BHH=require('src/effect.lua')local xgg=require('src/log.lua')
local ZBy9gf=require('src/casttime.lua')local EN7tA2=require('src/collision.lua')
local zUI2QhxM=require('src/animations.lua')local RjVt1=require('src/damage.lua')
local pQkj=require('src/spells/cooldowns.lua')local ra=5;local wkRGa3D=function()return'jab'end
local VNmZ70v=function()return'Jab'end
local hJ37cfVD=function(MW)return'Deal 150 damage to all enemies in a line in front of you.'end;local TO=function(SF)return ra end
local IZ7fRnl7=function(b)return 0.35 end
local aRpd=function(et_6O,e,ImNpFgb8,Mag5n_n)local ihv0gF=(e+90)*bj_DEGTORAD
local nWwZzgPY=XuJg:fromAngle(ihv0gF):multiply(
ImNpFgb8*50):add(et_6O)return
XuJg:fromAngle(e*bj_DEGTORAD):multiply(Mag5n_n*400):add(nWwZzgPY)end
local BnDo=function(itk0)if pQkj.isOnCooldown(itk0,wkRGa3D())then
xgg.log(itk0,VNmZ70v().." is on cooldown!",xgg.TYPE.ERROR)return false end
if pQkj[itk0]~=
nil then DestroyTimer(pQkj[itk0])pQkj[itk0]=nil end;local i=i.getHero(itk0)
local K1=XuJg:new{x=GetUnitX(i),y=GetUnitY(i)}
local L2mc=XuJg:new{x=MMHRexVY.getMouseX(itk0),y=MMHRexVY.getMouseY(itk0)}pQkj.startCooldown(itk0,wkRGa3D(),ra)
SetUnitTimeScale(i,2)IssueImmediateOrder(i,"stop")
zUI2QhxM.queueAnimation(i,8,1)
local SETRKu=bj_RADTODEG*Atan2(L2mc.y-K1.y,L2mc.x-K1.x)SetUnitFacing(i,SETRKu)
BHH.createEffect{model="slsh",unit=i,duration=0.3,facing=SETRKu,timeScale=0.7}
local q_e={aRpd(K1,SETRKu,1,0),aRpd(K1,SETRKu,-1,0),aRpd(K1,SETRKu,-1,1),aRpd(K1,SETRKu,1,1)}local B6v4t=EN7tA2.getAllCollisions(q_e)
for rtQ,lqn5PVK in pairs(B6v4t)do if
IsUnitEnemy(lqn5PVK,Player(itk0))then RjVt1.dealDamage(i,lqn5PVK,150)
BHH.createEffect{model="ebld",unit=lqn5PVK,duration=0.1}end end;ZBy9gf.cast(itk0,0.35,false)SetUnitTimeScale(i,1)
return true end
local c4garR3x=function(DBN90B)return pQkj.getRemainingCooldown(DBN90B,wkRGa3D())end
local NKbxmTq=function(b2vH)return pQkj.getTotalCooldown(b2vH,wkRGa3D())end
local nqH=function()return"ReplaceableTextures\\CommandButtons\\BTNThoriumMelee.blp"end;return
{cast=BnDo,getSpellId=wkRGa3D,getSpellName=VNmZ70v,getIcon=nqH,getSpellTooltip=hJ37cfVD,getSpellCooldown=TO,getSpellCasttime=IZ7fRnl7}end
local lw9gLt3=function()local l=require('src/hero.lua')
local nv=require('src/mouse.lua')local I73L=require('src/vector.lua')
local x42X6=require('src/projectile.lua')local Nol=require('src/log.lua')
local V1MjIq=require('src/animations.lua')local xVX3Hs=require('src/damage.lua')
local wzN=require('src/spells/cooldowns.lua')local orr=3.5;local DC=function()return'throwingstar'end;local D=function()
return'Throwing Star'end
local QV8=function(oPiOwh7r)return
'Throw 3 stars in front of you, dealing 30 damage each. Multiple stars can collide with a single unit.'end;local Bwx=function(i)return orr end;local fuI=function(xvq)return 0 end
local JxLHnlG=function(a3)if
wzN.isOnCooldown(a3,DC())then
Nol.log(a3,D().." is on cooldown!",Nol.TYPE.ERROR)return false end
local l=l.getHero(a3)
local CT=I73L:new{x=GetUnitX(l),y=GetUnitY(l)}
local PhkTY=I73L:new{x=nv.getMouseX(a3),y=nv.getMouseY(a3)}wzN.startCooldown(a3,DC(),orr)
IssueImmediateOrder(l,"stop")V1MjIq.queueAnimation(l,8,1)local VASxcm=bj_RADTODEG*
Atan2(PhkTY.y-CT.y,PhkTY.x-CT.x)
SetUnitFacingTimed(l,VASxcm,0.05)
for Kzav_qIb=-1,1,1 do
local fF8A=I73L:fromAngle((VASxcm+Kzav_qIb*15)*bj_DEGTORAD):add(CT)
x42X6.createProjectile{playerId=a3,model="star",fromV=CT,toV=fF8A,speed=1400,length=500,radius=30,onCollide=function(XE)if IsUnitEnemy(XE,Player(a3))then
xVX3Hs.dealDamage(l,XE,30)return true end;return false end}end;return true end
local cfqBNa9=function(yKhek)return wzN.getRemainingCooldown(yKhek,DC())end
local jvCz=function(bC)return wzN.getTotalCooldown(bC,DC())end
local e=function()return"ReplaceableTextures\\CommandButtons\\BTNUpgradeMoonGlaive.blp"end
return{cast=JxLHnlG,getSpellId=DC,getSpellName=D,getIcon=e,getSpellTooltip=QV8,getSpellCooldown=Bwx,getSpellCasttime=fuI}end
local TI5=function()local n8rNUjo=require('src/hero.lua')
local imJ=require('src/mouse.lua')local QjsBmE7O=require('src/vector.lua')
local tLKkEU=require('src/effect.lua')local qSchaN8z=require('src/collision.lua')
local MpNj8Z=require('src/log.lua')local D4MAT=require('src/casttime.lua')
local OvVIG=require('src/animations.lua')local q=require('src/damage.lua')
local UdkYgWc=require('src/spells/cooldowns.lua')local ek_j1tcZ=25;local Z27GZHi3=function()return'slashult'end
local Z95zgc=function()return'Spin'end
local KV7iu=function(Krg)return'Deal 400 damage to all nearby enemies.'end;local OV=function(IM)return ek_j1tcZ end
local _1PosB=function(E6p_LK8)return 0.3 end
local JROgo=function(JWafFaRJ)if UdkYgWc.isOnCooldown(JWafFaRJ,Z27GZHi3())then
MpNj8Z.log(JWafFaRJ,Z95zgc().." is on cooldown!",MpNj8Z.TYPE.ERROR)return false end
local n8rNUjo=n8rNUjo.getHero(JWafFaRJ)
local TrWA2KhWZ=QjsBmE7O:new{x=GetUnitX(n8rNUjo),y=GetUnitY(n8rNUjo)}
local IMPQjN=QjsBmE7O:new{x=imJ.getMouseX(JWafFaRJ),y=imJ.getMouseY(JWafFaRJ)}IssueImmediateOrder(n8rNUjo,"stop")
OvVIG.queueAnimation(n8rNUjo,9,1)SetUnitFacing(n8rNUjo,0)
D4MAT.cast(JWafFaRJ,0.3,false)
UdkYgWc.startCooldown(JWafFaRJ,Z27GZHi3(),ek_j1tcZ)
tLKkEU.createEffect{model="grns",x=TrWA2KhWZ.x,y=TrWA2KhWZ.y,duration=0.5}SetUnitTimeScale(n8rNUjo,3)
for lTm=0,320,40 do local PLHm=lTm*bj_DEGTORAD
SetUnitFacing(n8rNUjo,lTm)OvVIG.queueAnimation(n8rNUjo,13,0.4)
local shJatyUzO=QjsBmE7O:fromAngle(PLHm):multiply(50):add(TrWA2KhWZ)
tLKkEU.createEffect{model="slsh",x=shJatyUzO.x,y=shJatyUzO.y,duration=0.3,facing=lTm}end;local LqgM5=qSchaN8z.getAllCollisions(TrWA2KhWZ,350)
for Ra8,UEUWu40 in
pairs(LqgM5)do if IsUnitEnemy(UEUWu40,Player(JWafFaRJ))then
q.dealDamage(n8rNUjo,UEUWu40,400)
tLKkEU.createEffect{model="ebld",unit=UEUWu40,duration=0.1}end end;SetUnitTimeScale(n8rNUjo,1)return true end
local Z3D=function(F3tuY)
return UdkYgWc.getRemainingCooldown(F3tuY,Z27GZHi3())end
local nMh=function(y3uo)return UdkYgWc.getTotalCooldown(y3uo,Z27GZHi3())end
local z9hE=function()return"ReplaceableTextures\\CommandButtons\\BTNWhirlwind.blp"end;return
{cast=JROgo,getSpellId=Z27GZHi3,getSpellName=Z95zgc,getIcon=z9hE,getSpellTooltip=KV7iu,getSpellCooldown=OV,getSpellCasttime=_1PosB}end
local JmE=function()local QwilI=require('src/hero.lua')
local RQZzGcfq=require('src/vector.lua')local MaDT=require('src/log.lua')
local rhTj1d2=require('src/animations.lua')local zy6zY=require('src/target.lua')
local Y=require('src/buff.lua')local oS=require('src/spells/cooldowns.lua')local oJ=15
local xWos=function()return'stun'end;local yfBivMH=function()return'Stun'end
local tM=function(cfWcw)
return'Stun the target for 2 seconds, has a short range.'end;local nh=function(V971Awo)return oJ end
local jS_C7lFG=function(YQW3)return 0 end
local KcGY=function(QI2rZmm)if oS.isOnCooldown(QI2rZmm,xWos())then
MaDT.log(QI2rZmm,yfBivMH().." is on cooldown!",MaDT.TYPE.ERROR)return false end
local QwilI=QwilI.getHero(QI2rZmm)local zy6zY=zy6zY.getTarget(QI2rZmm)if zy6zY==nil then
MaDT.log(QI2rZmm,"You don't have a target!",MaDT.TYPE.ERROR)return false end;if
IsUnitAlly(zy6zY,Player(QI2rZmm))then
MaDT.log(QI2rZmm,"The target is friendly.",MaDT.TYPE.ERROR)return end
local Anw4285=RQZzGcfq:new{x=GetUnitX(QwilI),y=GetUnitY(QwilI)}
local HVG=RQZzGcfq:new{x=GetUnitX(zy6zY),y=GetUnitY(zy6zY)}
local TiL7=RQZzGcfq:new(Anw4285):subtract(HVG)local omdR7=TiL7:magnitude()if omdR7 >250 then
MaDT.log(QI2rZmm,"Out of range!",MaDT.TYPE.ERROR)return false end
IssueImmediateOrder(QwilI,"stop")rhTj1d2.queueAnimation(QwilI,10,1)
SetUnitFacingTimed(QwilI,bj_RADTODEG*Atan2(
HVG.y-Anw4285.y,HVG.x-Anw4285.x),0.05)oS.startCooldown(QI2rZmm,xWos(),oJ)
Y.addBuff(QwilI,zy6zY,'stun',2)return true end
local sHfW_=function(Oz)return oS.getRemainingCooldown(Oz,xWos())end
local TNEo=function(FqaEj69D)return oS.getTotalCooldown(FqaEj69D,xWos())end
local lkd1oTM=function()return"ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower.blp"end;return
{cast=KcGY,getSpellId=xWos,getSpellName=yfBivMH,getIcon=lkd1oTM,getSpellTooltip=tM,getSpellCooldown=nh,getSpellCasttime=jS_C7lFG}end;requireMap['src/buff.lua']=JEHSHPh3
requireMap['src/animations.lua']=bb;requireMap['src/camera.lua']=o5e6fP
requireMap['src/buffloop.lua']=iq7ol;requireMap['src/casttime.lua']=eMV
requireMap['src/hero.lua']=WDTNkTD;requireMap['src/effect.lua']=Oejsws
requireMap['src/damage.lua']=CkD73N0;requireMap['src/debug.lua']=PlwhaRKJ
requireMap['src/gc.lua']=Caz4NM4Z;requireMap['src/cleanup.lua']=XVxxx
requireMap['src/keyboard.lua']=hD;requireMap['src/log.lua']=G5BuU5
requireMap['src/leaver.lua']=AfwsY;requireMap['src/main.lua']=T
requireMap['src/collision.lua']=WZs;requireMap['src/mouse.lua']=ITdz
requireMap['src/party.lua']=AjfoUo;requireMap['src/projectile.lua']=Er9zidsB
requireMap['src/spell.lua']=X;requireMap['src/target.lua']=dR
requireMap['src/spawnpoint.lua']=JFXtQwy;requireMap['src/vector.lua']=uMV17h0
requireMap['src/bosses/banditlord.lua']=E2NZK;requireMap['src/bosses/bossmanager.lua']=WNWWe
requireMap['src/threat.lua']=zMzjn3lk;requireMap['src/buffs/buffmanager.lua']=Trkkpmd
requireMap['src/buffs/ignite.lua']=L;requireMap['src/items/equipment.lua']=GGv
requireMap['src/buffs/corrosivedecay.lua']=ZIzh4Si;requireMap['src/items/backpack.lua']=c8D4n81
requireMap['src/items/itemmanager.lua']=cSjJHx;requireMap['src/ui/castbar.lua']=fa
requireMap['src/ui/backpack.lua']=M;requireMap['src/ui/actionbar.lua']=dIZlrvD
requireMap['src/ui/consts.lua']=jQgsATKd;requireMap['src/lib/sat.lua']=aBbGg
requireMap['src/ui/equipment.lua']=D9;requireMap['src/ui/main.lua']=G
requireMap['src/ui/tooltip.lua']=gE;requireMap['src/ui/utils.lua']=QgC
requireMap['src/ui/unitframe.lua']=CYoa;requireMap['src/saveload/code.lua']=K3ipRr
requireMap['src/saveload/save.lua']=F2tY;requireMap['src/spells/cooldowns.lua']=rb21L2
requireMap['src/spells/azora/blink.lua']=o_v255;requireMap['src/saveload/load.lua']=wUVm
requireMap['src/spells/azora/fireball.lua']=VQ;requireMap['src/spells/azora/fireshell.lua']=oTYNsnP
requireMap['src/spells/azora/frostnova.lua']=I;requireMap['src/spells/azora/firestorm.lua']=LmR5gwW
requireMap['src/spells/azora/firelance.lua']=DfbW;requireMap['src/spells/azora/frostballs.lua']=sh
requireMap['src/spells/azora/frostorb.lua']=rrFLbCtj;requireMap['src/spells/azora/phoenix.lua']=YcPea0vg
requireMap['src/spells/azora/icicle.lua']=usLpLoaH;requireMap['src/spells/azora/meteor.lua']=e7dv
requireMap['src/spells/generic/heal.lua']=inx0;requireMap['src/spells/generic/attack.lua']=A5k5yt
requireMap['src/spells/generic/stop.lua']=B7SHDx7h;requireMap['src/spells/ivanov/armorpot.lua']=EEpoeR
requireMap['src/spells/ivanov/accmist.lua']=_k;requireMap['src/spells/stormfist/punch.lua']=Ef
requireMap['src/spells/ivanov/cleansingpot.lua']=KfM;requireMap['src/spells/ivanov/dampenpot.lua']=Vd
requireMap['src/spells/ivanov/corrosiveblast.lua']=Oynw;requireMap['src/spells/ivanov/hulkingpot.lua']=QBO
requireMap['src/spells/ivanov/pocketgoo.lua']=s4ggux
requireMap['src/spells/ivanov/molecregen.lua']=hrVI4meU;requireMap['src/spells/ivanov/rejuvpot.lua']=xEq6TAF
requireMap['src/spells/tarcza/bulwark.lua']=UIjls;requireMap['src/spells/tarcza/blitz.lua']=jdLnB0vD
requireMap['src/spells/tarcza/boomerang.lua']=PSlD;requireMap['src/spells/tarcza/curshout.lua']=nN
requireMap['src/spells/tarcza/challenge.lua']=J;requireMap['src/spells/tarcza/shieldcharge.lua']=A
requireMap['src/spells/tarcza/flag.lua']=g3Qeqnr
requireMap['src/spells/tarcza/stalwartshell.lua']=qHpY64;requireMap['src/spells/yuji/blind.lua']=z
requireMap['src/spells/tarcza/whirlwind.lua']=qccJ5b;requireMap['src/spells/yuji/focus.lua']=ARuba
requireMap['src/spells/yuji/dash.lua']=Wo53nZ;requireMap['src/spells/yuji/slash.lua']=XRfQ
requireMap['src/spells/yuji/jab.lua']=gFPRdEC
requireMap['src/spells/yuji/throwingstar.lua']=lw9gLt3;requireMap['src/spells/yuji/slashult.lua']=TI5
requireMap['src/spells/yuji/stun.lua']=JmE;require('src/main.lua')
function InitSounds()
gg_snd_SubGroupSelectionChange1=CreateSound("Sound\\Interface\\SubGroupSelectionChange1.wav",false,false,false,10,10,"")
SetSoundParamsFromLabel(gg_snd_SubGroupSelectionChange1,"SubGroupSelectionChange")
SetSoundDuration(gg_snd_SubGroupSelectionChange1,126)end;function CreateAllDestructables()local Y6;local Sl;local pWXuxn
gg_dest_LTg2_2324=CreateDestructable(FourCC("LTg2"),3872.0,-352.0,270.000,1.000,0)end
function CreateNeutralHostile()
local otCrxF=Player(PLAYER_NEUTRAL_AGGRESSIVE)local jQmXBU;local EO0o5H;local a9p;local v
jQmXBU=CreateUnit(otCrxF,FourCC("htar"),-968.4,1810.8,270.705)
jQmXBU=CreateUnit(otCrxF,FourCC("htar"),-708.5,1810.6,270.705)
jQmXBU=CreateUnit(otCrxF,FourCC("htar"),-446.7,1801.6,270.705)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),2047.5,-5091.1,334.489)
jQmXBU=CreateUnit(otCrxF,FourCC("nbrg"),1972.2,-6728.2,24.896)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),2231.1,-6649.1,66.931)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),2303.3,-6452.3,190.586)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),1740.1,-6455.3,230.819)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),1779.2,-6637.1,191.146)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),2052.6,-5216.7,117.458)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),2778.9,-4308.2,9.394)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),2872.3,-4252.5,345.992)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),2888.2,-4373.0,76.753)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),4035.2,-588.1,59.789)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3946.7,-617.3,170.480)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3925.7,-815.3,154.802)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),4420.8,-140.1,213.899)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),4546.9,-249.7,181.686)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),4516.0,-472.0,19.842)
jQmXBU=CreateUnit(otCrxF,FourCC("nenf"),6172.7,-2457.8,238.619)
jQmXBU=CreateUnit(otCrxF,FourCC("nwzd"),9632.3,2421.1,109.262)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),6040.8,-2244.5,102.736)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),6191.3,-2231.6,188.421)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),6026.7,-2714.5,80.137)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),6188.5,-2661.1,298.716)
jQmXBU=CreateUnit(otCrxF,FourCC("nass"),3158.5,2089.6,260.626)
jQmXBU=CreateUnit(otCrxF,FourCC("nass"),2960.8,2113.1,16.810)
jQmXBU=CreateUnit(otCrxF,FourCC("nass"),2354.0,1791.9,253.309)
jQmXBU=CreateUnit(otCrxF,FourCC("nass"),2245.1,1528.3,17.864)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3159.5,89.8,296.453)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3316.2,195.5,332.544)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3488.8,306.5,43.749)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3713.7,469.4,230.577)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3617.6,615.0,337.225)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3408.2,523.0,97.078)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3222.8,337.9,169.436)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),3062.2,184.1,331.204)
jQmXBU=CreateUnit(otCrxF,FourCC("nbrg"),4554.4,-4253.2,192.684)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),4442.3,-4225.9,177.599)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),4456.3,-4376.1,337.521)
jQmXBU=CreateUnit(otCrxF,FourCC("nrog"),5051.9,-1455.4,92.508)
jQmXBU=CreateUnit(otCrxF,FourCC("nrog"),5230.9,-3441.9,29.554)
jQmXBU=CreateUnit(otCrxF,FourCC("nrog"),3368.6,-4819.6,161.724)
jQmXBU=CreateUnit(otCrxF,FourCC("nass"),4407.6,-657.8,227.962)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),5109.7,2836.3,286.620)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),5242.5,2865.1,265.833)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),5191.8,2722.9,38.256)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),5132.5,2103.7,340.169)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),5299.9,2144.1,325.842)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),5240.2,2028.0,167.580)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),7825.6,3622.0,49.176)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),8039.0,3317.2,340.323)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),8472.4,3126.2,90.190)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),8913.5,3159.9,49.517)
jQmXBU=CreateUnit(otCrxF,FourCC("nenf"),7386.4,2786.7,13.360)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),7308.9,2943.2,84.696)
jQmXBU=CreateUnit(otCrxF,FourCC("nban"),7302.1,2665.5,115.821)
jQmXBU=CreateUnit(otCrxF,FourCC("nrog"),7461.3,2662.9,24.445)
jQmXBU=CreateUnit(otCrxF,FourCC("nrog"),7460.1,2942.0,55.867)
jQmXBU=CreateUnit(otCrxF,FourCC("nwzr"),9697.4,2225.5,252.968)
jQmXBU=CreateUnit(otCrxF,FourCC("nwzr"),9725.0,2642.3,273.117)
jQmXBU=CreateUnit(otCrxF,FourCC("nwzg"),7642.9,2796.7,178.874)end
function CreateNeutralPassive()local r3IQ=Player(PLAYER_NEUTRAL_PASSIVE)local lZfWd;local S_9wu
local IMlB;local VE
lZfWd=CreateUnit(r3IQ,FourCC("nvil"),-773.6,-51.2,236.686)
lZfWd=CreateUnit(r3IQ,FourCC("nvlw"),-813.0,-142.8,62.063)
lZfWd=CreateUnit(r3IQ,FourCC("nvl2"),-85.8,21.0,245.201)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-168.8,-5415.2,50.506)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-403.0,-5428.3,45.100)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-309.2,-5628.5,353.573)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-263.4,-5887.9,157.263)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-454.9,-5930.0,354.463)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-811.3,-5866.3,352.837)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-596.1,-5736.5,16.063)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-397.1,-5774.5,144.134)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-657.1,-5437.1,62.349)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-725.5,-5648.2,342.894)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-927.7,-5756.9,337.192)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-998.7,-5895.4,264.185)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-1079.7,-5531.6,282.105)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-958.3,-5458.7,250.727)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-912.1,-5603.6,92.497)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-760.2,-5758.6,46.342)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-582.8,-5896.7,214.844)
lZfWd=CreateUnit(r3IQ,FourCC("nshe"),-505.3,-5531.0,341.729)
lZfWd=CreateUnit(r3IQ,FourCC("nech"),-774.8,-5531.9,107.043)
lZfWd=CreateUnit(r3IQ,FourCC("nech"),-1044.6,-5786.2,18.458)
lZfWd=CreateUnit(r3IQ,FourCC("nech"),-336.1,-5921.8,208.395)
lZfWd=CreateUnit(r3IQ,FourCC("nech"),-260.3,-5450.2,318.361)
lZfWd=CreateUnit(r3IQ,FourCC("Hazr"),28504.3,-30856.8,305.911)
lZfWd=CreateUnit(r3IQ,FourCC("Hivn"),28673.4,-30761.5,282.449)
lZfWd=CreateUnit(r3IQ,FourCC("Hstm"),28840.2,-30678.3,263.602)
lZfWd=CreateUnit(r3IQ,FourCC("Htar"),28968.6,-30788.8,250.015)
lZfWd=CreateUnit(r3IQ,FourCC("Hyuj"),29121.6,-30929.2,221.601)
lZfWd=CreateUnit(r3IQ,FourCC("nvl2"),-26933.4,26655.7,271.231)
lZfWd=CreateUnit(r3IQ,FourCC("nvil"),-26709.2,26777.0,271.021)
lZfWd=CreateUnit(r3IQ,FourCC("nvlw"),-26843.1,26746.0,271.114)
lZfWd=CreateUnit(r3IQ,FourCC("nvk2"),-26639.3,26647.2,270.938)
lZfWd=CreateUnit(r3IQ,FourCC("nvl2"),-26489.5,26816.8,270.810)
lZfWd=CreateUnit(r3IQ,FourCC("nvil"),-26359.0,26798.3,270.695)
lZfWd=CreateUnit(r3IQ,FourCC("nvl2"),-26250.6,26651.5,270.549)
lZfWd=CreateUnit(r3IQ,FourCC("nvlw"),-26099.3,26744.9,270.432)
lZfWd=CreateUnit(r3IQ,FourCC("nvl2"),-25572.5,26658.0,271.231)
lZfWd=CreateUnit(r3IQ,FourCC("nvil"),-25355.7,26642.1,271.021)
lZfWd=CreateUnit(r3IQ,FourCC("nvlw"),-25488.0,26787.6,333.084)
lZfWd=CreateUnit(r3IQ,FourCC("nvk2"),-25247.7,26715.5,270.938)
lZfWd=CreateUnit(r3IQ,FourCC("nvl2"),-25100.3,26785.2,270.810)
lZfWd=CreateUnit(r3IQ,FourCC("nvil"),-24990.0,26760.8,270.695)
lZfWd=CreateUnit(r3IQ,FourCC("nvl2"),-24790.1,26774.3,270.549)
lZfWd=CreateUnit(r3IQ,FourCC("nvlw"),-24708.9,26806.8,270.432)
lZfWd=CreateUnit(r3IQ,FourCC("nvlk"),-26002.7,26656.6,237.048)
lZfWd=CreateUnit(r3IQ,FourCC("nvlk"),-25743.1,26670.3,133.532)
lZfWd=CreateUnit(r3IQ,FourCC("nvlw"),-25407.6,26791.7,229.499)
lZfWd=CreateUnit(r3IQ,FourCC("Npbm"),-25864.3,27192.7,269.268)end;function CreatePlayerBuildings()end;function CreatePlayerUnits()end;function CreateAllUnits()
CreatePlayerBuildings()CreateNeutralHostile()CreateNeutralPassive()
CreatePlayerUnits()end
function CreateRegions()local w;gg_rct_Region_000=Rect(27680.0,
-31520.0,29824.0,-30016.0)end
function CreateCameras()gg_cam_Camera_001=CreateCameraSetup()
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_ZOFFSET,0.0,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_ROTATION,90.0,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_ANGLE_OF_ATTACK,304.0,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_TARGET_DISTANCE,2415.8,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_ROLL,0.0,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_FIELD_OF_VIEW,70.0,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_FARZ,5000.0,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_NEARZ,16.0,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_LOCAL_PITCH,0.0,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_LOCAL_YAW,0.0,0.0)
CameraSetupSetField(gg_cam_Camera_001,CAMERA_FIELD_LOCAL_ROLL,0.0,0.0)
CameraSetupSetDestPosition(gg_cam_Camera_001,-93.7,-469.0,0.0)gg_cam_Camera_002=CreateCameraSetup()
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_ZOFFSET,0.0,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_ROTATION,84.5,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_ANGLE_OF_ATTACK,333.7,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_TARGET_DISTANCE,1363.6,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_ROLL,0.0,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_FIELD_OF_VIEW,70.0,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_FARZ,5000.0,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_NEARZ,16.0,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_LOCAL_PITCH,0.0,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_LOCAL_YAW,0.0,0.0)
CameraSetupSetField(gg_cam_Camera_002,CAMERA_FIELD_LOCAL_ROLL,0.0,0.0)
CameraSetupSetDestPosition(gg_cam_Camera_002,28890.4,-30598.4,0.0)end;function Trig_Untitled_Trigger_001_Actions()end
function InitTrig_Untitled_Trigger_001()
gg_trg_Untitled_Trigger_001=CreateTrigger()
TriggerRegisterDeathEvent(gg_trg_Untitled_Trigger_001,gg_dest_LTg2_2324)
TriggerAddAction(gg_trg_Untitled_Trigger_001,Trig_Untitled_Trigger_001_Actions)end
function InitCustomTriggers()InitTrig_Untitled_Trigger_001()end
function InitCustomPlayerSlots()SetPlayerStartLocation(Player(0),0)
ForcePlayerStartLocation(Player(0),0)
SetPlayerColor(Player(0),ConvertPlayerColor(0))
SetPlayerRacePreference(Player(0),RACE_PREF_HUMAN)SetPlayerRaceSelectable(Player(0),true)
SetPlayerController(Player(0),MAP_CONTROL_USER)SetPlayerStartLocation(Player(1),1)
ForcePlayerStartLocation(Player(1),1)
SetPlayerColor(Player(1),ConvertPlayerColor(1))
SetPlayerRacePreference(Player(1),RACE_PREF_HUMAN)SetPlayerRaceSelectable(Player(1),true)
SetPlayerController(Player(1),MAP_CONTROL_USER)SetPlayerStartLocation(Player(2),2)
ForcePlayerStartLocation(Player(2),2)
SetPlayerColor(Player(2),ConvertPlayerColor(2))
SetPlayerRacePreference(Player(2),RACE_PREF_HUMAN)SetPlayerRaceSelectable(Player(2),true)
SetPlayerController(Player(2),MAP_CONTROL_USER)SetPlayerStartLocation(Player(3),3)
ForcePlayerStartLocation(Player(3),3)
SetPlayerColor(Player(3),ConvertPlayerColor(3))
SetPlayerRacePreference(Player(3),RACE_PREF_HUMAN)SetPlayerRaceSelectable(Player(3),true)
SetPlayerController(Player(3),MAP_CONTROL_USER)SetPlayerStartLocation(Player(4),4)
ForcePlayerStartLocation(Player(4),4)
SetPlayerColor(Player(4),ConvertPlayerColor(4))
SetPlayerRacePreference(Player(4),RACE_PREF_HUMAN)SetPlayerRaceSelectable(Player(4),true)
SetPlayerController(Player(4),MAP_CONTROL_USER)end
function InitCustomTeams()SetPlayerTeam(Player(0),0)
SetPlayerTeam(Player(1),0)SetPlayerTeam(Player(2),0)
SetPlayerTeam(Player(3),0)SetPlayerTeam(Player(4),0)end
function InitAllyPriorities()SetStartLocPrioCount(0,4)
SetStartLocPrio(0,0,1,MAP_LOC_PRIO_HIGH)SetStartLocPrio(0,1,2,MAP_LOC_PRIO_HIGH)
SetStartLocPrio(0,2,3,MAP_LOC_PRIO_HIGH)SetStartLocPrio(0,3,4,MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(1,4)SetStartLocPrio(1,0,0,MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1,1,2,MAP_LOC_PRIO_HIGH)SetStartLocPrio(1,2,3,MAP_LOC_PRIO_HIGH)
SetStartLocPrio(1,3,4,MAP_LOC_PRIO_HIGH)SetStartLocPrioCount(2,4)
SetStartLocPrio(2,0,0,MAP_LOC_PRIO_HIGH)SetStartLocPrio(2,1,1,MAP_LOC_PRIO_HIGH)
SetStartLocPrio(2,2,3,MAP_LOC_PRIO_HIGH)SetStartLocPrio(2,3,4,MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(3,4)SetStartLocPrio(3,0,0,MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3,1,1,MAP_LOC_PRIO_HIGH)SetStartLocPrio(3,2,2,MAP_LOC_PRIO_HIGH)
SetStartLocPrio(3,3,4,MAP_LOC_PRIO_HIGH)SetStartLocPrioCount(4,4)
SetStartLocPrio(4,0,0,MAP_LOC_PRIO_HIGH)SetStartLocPrio(4,1,1,MAP_LOC_PRIO_HIGH)
SetStartLocPrio(4,2,2,MAP_LOC_PRIO_HIGH)SetStartLocPrio(4,3,3,MAP_LOC_PRIO_HIGH)end
function main()
SetCameraBounds(-30720.0+GetCameraMargin(CAMERA_MARGIN_LEFT),-
32256.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM),30720.0-
GetCameraMargin(CAMERA_MARGIN_RIGHT),29184.0-GetCameraMargin(CAMERA_MARGIN_TOP),
-30720.0+GetCameraMargin(CAMERA_MARGIN_LEFT),29184.0-
GetCameraMargin(CAMERA_MARGIN_TOP),30720.0-GetCameraMargin(CAMERA_MARGIN_RIGHT),
-32256.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM))
SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl","Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")NewSoundEnvironment("Default")
SetAmbientDaySound("CityScapeDay")SetAmbientNightSound("CityScapeNight")
SetMapMusic("Music",true,0)InitSounds()CreateRegions()CreateCameras()
CreateAllDestructables()CreateAllUnits()InitBlizzard()InitGlobals()
InitCustomTriggers()end
function config()SetMapName("TRIGSTR_001")
SetMapDescription("TRIGSTR_003")SetPlayers(5)SetTeams(5)
SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)DefineStartLocation(0,192.0,-256.0)
DefineStartLocation(1,192.0,-256.0)DefineStartLocation(2,192.0,-256.0)
DefineStartLocation(3,192.0,-256.0)DefineStartLocation(4,192.0,-256.0)
InitCustomPlayerSlots()
SetPlayerSlotAvailable(Player(0),MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(1),MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(2),MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(3),MAP_CONTROL_USER)
SetPlayerSlotAvailable(Player(4),MAP_CONTROL_USER)InitGenericPlayerSlots()InitAllyPriorities()end