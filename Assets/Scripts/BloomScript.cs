using UnityEngine;
using System.Collections;

public class BloomScript : MonoBehaviour
{
    public Material mat;

    [Range(0, 7)] public int times;

    [Range(0, 1)]
    public float threshhold;

    public float intensity;

    [Range(0.25f, 5.5f)]
    public float blurSize;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        var rt = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);
        mat.SetVector("_Parameter", new Vector4(blurSize, 0, threshhold, intensity));
        rt.filterMode = FilterMode.Bilinear;

        //DownSample
        Graphics.Blit(source, rt, mat, 1);

        for (int i = 0; i < times; i++)
        {
            //vertical 
            var rt2 = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);
            rt2.filterMode = FilterMode.Bilinear;
            Graphics.Blit(rt, rt2, mat, 2);
            RenderTexture.ReleaseTemporary(rt);
            rt = rt2;

            //horizontal
            rt2 = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);
            rt2.filterMode = FilterMode.Bilinear;
            Graphics.Blit(rt, rt2, mat, 3);
            RenderTexture.ReleaseTemporary(rt);
            rt = rt2;
        }

        mat.SetTexture("_BloomTex", rt);

        Graphics.Blit(source, destination, mat, 0);
        //Graphics.Blit(rt, destination);

        RenderTexture.ReleaseTemporary(rt);

    }
}
