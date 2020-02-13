using UnityEngine;

/// <summary>
/// 普通的单例模式模版类，该单例模式必须可以实例化
/// </summary>
/// <typeparam name="T">单例的类型</typeparam>
public abstract class Singleton<T> where T : new()
{
    //单例的实例
    private static T _instance;

    //设置锁，确保只有一个单例
    private static object mutex = new object();

    //获取单例
    public static T Instance
    {
        get
        {
            //如果实例为null，创建一个新的实例
            if (_instance == null)
            {
                // 保证我们的单例，是线程安全的;
                lock (mutex)
                {
                    if (_instance == null)
                    {
                        _instance = new T();
                    }
                }
            }

            //返回实例
            return _instance;
        }
    }
}

/// <summary>
/// unity中的单例模版类,该单例必须是Unity中的Component
/// </summary>
public class UnitySingleton<T> : MonoBehaviour where T : Component
{
    //单例的实例
    private static T _instance;

    //获取单例
    public static T Instance
    {
        //单例的实例
        get
        {
            //如果单例是空的
            if (_instance == null)
            {
                //在场景中寻找是否存在该类型
                _instance = FindObjectOfType(typeof(T)) as T;
                //如果不存在
                if (_instance == null)
                {
                    //创建一个新的GameObject对象，并且给该对象添加单例类
                    GameObject obj = new GameObject();
                    _instance = (T) obj.AddComponent(typeof(T));
                    obj.hideFlags = HideFlags.DontSave;
                    obj.name = typeof(T).Name;
                }
            }
            //返回实例
            return _instance;
        }
    }
}