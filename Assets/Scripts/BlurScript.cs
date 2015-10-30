using UnityEngine;
using System.Collections;

public class BlurScript : MonoBehaviour
{
    public Material mat;
    [Range(1, 10)]
    public int size;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        mat.SetFloat("size", size);

        Graphics.Blit(source, destination, mat);
    }
}
