using UnityEngine;
using System.Collections;

public class CameraDepthMode : MonoBehaviour {

    void Awake()
    {
        Camera.main.depthTextureMode = DepthTextureMode.Depth;
    }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
