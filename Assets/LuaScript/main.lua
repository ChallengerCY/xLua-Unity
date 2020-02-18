local game= require( "Game.Start");

main={};  -- 全局模块

local function Start()
    print("game Start");
    game.Init();
end

local function OnApplicationQuit()
    
end

local function Update()
    print("Update")
end


local function FixedUpdate()
    print("FixedUpdate")
end

local function LateUpdate()
    print("LateUpdate")
    
end

main.Start=Start;
main.Update=Update;
main.FixedUpdate=FixedUpdate;
main.LateUpdate=LateUpdate;
main.OnApplicationQuit=OnApplicationQuit;

return main;