using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameLaunch : MonoBehaviour
{
    // Start is called before the first frame update

    private void Awake()
    {
        gameObject.AddComponent<xLuaManager>();
        
        xLuaManager.Instance.InitXLuaManager();
        
    }

    void Start()
    {
        xLuaManager.Instance.EnterLuaGame();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
