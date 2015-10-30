using UnityEngine;
using System.Collections;

public class DarkShaderScript : MonoBehaviour
{
    public Material darkMat;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, darkMat);
    }
}
