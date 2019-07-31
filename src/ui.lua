function initUI()
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