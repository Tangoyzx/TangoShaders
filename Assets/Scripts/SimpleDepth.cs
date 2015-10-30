using UnityEngine;
using System.Collections;

public class SimpleDepth : MonoBehaviour
{
    public Material blurMat;

    public Material dofMat;

    [Range(1, 100)]
    public float blurSize = 1;
    public float blurDistance = 1;

    [Range(0, 100)]
    public float focusNear;
    [Range(0, 100)]
    public float focusFar;

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

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (focusNear > focusFar)
        {
            var tmp = focusNear;
            focusNear = focusFar;
            focusFar = tmp;
        }

        var rt = RenderTexture.GetTemporary(source.width, source.height, source.depth, source.format);

        blurMat.SetFloat("blurSize", blurSize);
        blurMat.SetFloat("blurDistance", blurDistance);
        Graphics.Blit(source, rt, blurMat);

        dofMat.SetTexture("_BlurTex", rt);
        dofMat.SetFloat("focusNear", focusNear);
        dofMat.SetFloat("focusFar", focusFar);
        Graphics.Blit(source, destination, dofMat);

        RenderTexture.ReleaseTemporary(rt);
    }
}
