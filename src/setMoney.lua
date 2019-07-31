function setMoney()
    SetPlayerState(Player(0), PLAYER_STATE_RESOURCE_GOLD, 15000)
    print("Test setMoney New")
end

TimerStart(CreateTimer(), 0.0, false, setMoney)