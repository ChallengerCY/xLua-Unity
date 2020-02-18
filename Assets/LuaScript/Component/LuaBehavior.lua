function LuaExtend(base)
    return base:new();
end


local LuaBehavior={};

function LuaBehavior:new(instance)
    if not instance then
        instance={};
    end
    
    setmetatable(instance,{__index=self})
    return instance
end

function LuaBehavior:Init(obj)
    self.transform=obj.transform;
    self.gameObject=obj;
end

return LuaComponent