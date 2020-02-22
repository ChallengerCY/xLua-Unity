
require("Manager.LuaGameObject")
--引入游戏启动逻辑
local game= require( "Game.Start");

-- 全局模块
main={};  

local function Start()
    print("game Start");
    
    if(LuaGameObject==nil) then
        print("Nil")
    else
        print("LuaGameObject is not nil")
    end

    game.Init();
end




local function Update()
    LuaGameObject.Update();
end

local function FixedUpdate()
   LuaGameObject.FixedUpdate();
end

local function LateUpdate()
   LuaGameObject.LateUpdate();
end

local function OnApplicationQuit()

end

main.Start=Start;
main.Update=Update;
main.FixedUpdate=FixedUpdate;
main.LateUpdate=LateUpdate;
main.OnApplicationQuit=OnApplicationQuit;

return main;