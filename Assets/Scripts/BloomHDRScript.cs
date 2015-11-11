using UnityEngine;
using System.Collections;

public class BloomHDRScript : MonoBehaviour
{
    public Material mat;
    [Range(0.0f, 10.0f)]
    public float avgLuminance;
    [Range(0.0f, 10.0f)]
    public float maxLightSqr;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        mat.SetFloat("avgLuminance", avgLuminance);
        mat.SetFloat("maxLightSqr", maxLightSqr);

        Graphics.Blit(source, destination, mat);
    }
}
