-- 返回一个基类为base的类;
function LuaExtend(base)
    return base:new();
end


local LuaBehavior={
    ---@type UnityEngine.Transform
    transform=nil,
    ---@type UnityEngine.GameObject
    gameObject=nil,
};
function LuaBehavior:new(instance)
    if not instance then
        instance={};
    end
    
    setmetatable(instance,{__index=self})
    return instance
end

-- obj: GameObject
-- transform, gameObject 
function LuaBehavior:Init(obj)
    self.transform=obj.transform;
    self.gameObject=obj;
    
    
end


return LuaBehavior