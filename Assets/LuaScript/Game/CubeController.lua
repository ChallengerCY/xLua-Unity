local LuaBehavior =require("Component.LuaBehavior")

local cube_ctrl=LuaExtend(LuaBehavior);

function cube_ctrl:Awake()
    print("=====Awake======")
end

function cube_ctrl:Update()
    self.transform:Translate(0,0,5*CS.UnityEngine.Time.deltaTime);
    
end

return cube_ctrl;