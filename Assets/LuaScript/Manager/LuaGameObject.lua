LuaGameObject={};

---@type UnityEngine.GameObject
local GameObject = CS.UnityEngine.GameObject
local GameObjectMap = {}
-- key ObjectID:  {lua组件实例1, Lua组件实例2, ...};


---实例化函数
local function Instantiate(prefab)
    GameObject.Instantiate(prefab);
end

---销毁函数
local function Destroy(obj)
    local obj_id = obj:GetInstanceID()
    if (GameObjectMap[obj_id]) then 
        table.remove(GameObjectMap, obj_id)
    end
    GameObject.Destroy(obj)
end

--几秒钟之后删除一个object
local function DestroyAfterTime(object,time)
    local obj_id=object:GetInstanceID();
    if(GameObjectMap[obj_id]) then
        table.remove(GameObjectMap,obj_id);
    end
    GameObject.Destroy(object,time);
end

local function Find(name)
    return GameObject.Find(name);
end

local function AddLuaComponent(obj,lua_class)
    local component =lua_class:new();
    component:Init(obj);
    local obj_id=obj:GetInstanceID();
    if(GameObjectMap[obj_id]) then
        table.insert(GameObjectMap[obj_id],component)
    else
        GameObjectMap[obj_id]={};
        table.insert(GameObjectMap[obj_id],component)
    end

    if(component.Awake~=nil) then
        component:Awake()
    end
    return component
end

local function GetLuaComponent(obj,lua_class)
    return nil
end

local function trigger_update(components_array)
    for key ,value in pairs(components_array) do
        if value.Update~=nil then
            value:Update();
        end
    end
end

local function trigger_fixedUpdate(components_array)
    for key ,value in pairs(components_array) do
        if value.FixedUpdate~=nil then
            value:FixedUpdate();
        end
    end
end

local function trigger_lateUpdate(components_array)
    for key ,value in pairs(components_array) do
        if value.LateUpdate~=nil then
            value:LateUpdate();
        end
    end
end

local function Update()
    for key ,value in pairs(GameObjectMap) do
        trigger_update(value);
    end
end

local function FixedUpdate()
    for key ,value in pairs(GameObjectMap) do
        trigger_fixedUpdate(value);
    end
end

local function LateUpdate()
    for key ,value in pairs(GameObjectMap) do
        trigger_lateUpdate(value);
    end
end


LuaGameObject.Update=Update;
LuaGameObject.LateUpdate=LateUpdate;
LuaGameObject.FixedUpdate=FixedUpdate;

LuaGameObject.Instantiate=Instantiate;
LuaGameObject.Destroy =Destroy;
LuaGameObject.DestroyAfterTime=DestroyAfterTime;
LuaGameObject.AddLuaComponent=AddLuaComponent;
LuaGameObject.GetLuaComponent=GetLuaComponent;
LuaGameObject.Find=Find;
return LuaGameObject;