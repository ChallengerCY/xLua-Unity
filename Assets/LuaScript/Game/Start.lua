require("Manager.LuaGameObject")
local cube_ctrl=require("Game.CubeController")
local start={};

--进入加载场景
local function EnterLoginScene()
    -- 游戏启动逻辑
    print("Enter Login Scene");
    
    --找到场景中的Cube
    local obj=LuaGameObject.Find("Cube");
    --给cube添加自定义组件
    LuaGameObject.AddLuaComponent(obj,cube_ctrl);
    
end

--进入游戏场景
local function EnterGameScene()
    
end

--初始化逻辑
local function Init()
    EnterLoginScene();
end

start.Init=Init;

return start;