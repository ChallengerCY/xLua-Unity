using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices.WindowsRuntime;
using UnityEditor;
using UnityEngine;
using XLua;

public class xLuaManager : UnitySingleton<xLuaManager>
{
    /// <summary>
    /// lua解释器的上下文运行环境
    /// </summary>
    private LuaEnv _luaEnv = null;

    public const string luaScriptsFolder = "LuaScript";
    private const string gameMainScriptName = "main";

    private bool HasGameStart = false;

    public override void Awake()
    {
        base.Awake();
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (HasGameStart)
        {
            SafeDoString("main.Update()");
        }
    }

    private void FixedUpdate()
    {
        if (HasGameStart)
        {
            SafeDoString("main.FixedUpdate()");
        }
    }

    private void LateUpdate()
    {
        if (HasGameStart)
        {
            SafeDoString("main.LateUpdate()");
        }
    }

    public void SafeDoString(string scriptContent) { // 执行脚本, scriptContent脚本代码的文本内容;
        if (_luaEnv != null) {
            try {
                _luaEnv.DoString(scriptContent); // 执行我们的脚本代码;
            }
            catch (System.Exception ex) {
                string msg = string.Format("xLua exception : {0}\n {1}", ex.Message, ex.StackTrace);
                Debug.LogError(msg, null);
            }
        }
    }

    public void LoadScript(string scriptName) { // require(game.game_start) scriptName = "game.game_start"
        SafeDoString(string.Format("require('{0}')", scriptName)); // 
    }

    public void ReloadScript(string scriptName) {
        SafeDoString(string.Format("package.loaded['{0}'] = nil", scriptName));
        LoadScript(scriptName);
    }


    /// <summary>
    /// 进入游戏
    /// </summary>
    public void EnterLuaGame()
    {
        if (_luaEnv == null) 
            return;
        LoadScript(gameMainScriptName);
       SafeDoString("main.Start()");
        HasGameStart = true;



    }

    /// <summary>
    /// 初始化lua manager
    /// </summary>
    public void InitXLuaManager()
    {
        _luaEnv=new LuaEnv();
        _luaEnv?.AddLoader(CustomLoader);
      
    }

    /// <summary>
    /// 自定义lua装载器
    /// </summary>
    /// <param name="filepath"></param>
    /// <returns></returns>
    // require(main); // require(game.game_start)
    public static byte[] CustomLoader(ref string filePath)
    {
        string scriptPath = string.Empty;
        filePath = filePath.Replace(".", "/") + ".lua"; // game/game_start.lua
#if UNITY_EDITOR
        // if (AssetBundleConfig.IsEditorMode)
        {
            scriptPath = Path.Combine(Application.dataPath, luaScriptsFolder);// Assets/LuaScripts
            scriptPath = Path.Combine(scriptPath, filePath); // Assets/LuaScripts/game/game_start.lua
            
            // Debug.Log("Custom Load lua script : " + scriptPath);
            return GameUtility.SafeReadAllBytes(scriptPath);
        }
#endif

        /*scriptPath = string.Format("{0}/{1}.bytes", luaAssetbundleAssetName, filePath);
        string assetbundleName = null;
        string assetName = null;

        bool status = AssetBundleManager.Instance.MapAssetPath(scriptPath, out assetbundleName, out assetName);
        if (!status)
        {
            Debug.LogError("MapAssetPath failed : " + scriptPath);
            return null;
        }

        var asset = AssetBundleManager.Instance.GetAssetCache(assetName) as TextAsset;
        if (asset != null)
        {
            return asset.bytes;
        }
        Debug.LogError("Load lua script failed : " + scriptPath + ", You should preload lua assetbundle first!!!");
        return null;
        */

    }
}
