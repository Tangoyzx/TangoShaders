using UnityEngine;
using System.Collections;

public class DownSampleScript : MonoBehaviour
{
    public Material mat;
    public Material mixDofMat;
    public float focusNear;
    public float focusFar;
	// Use this for initialization
	void Start () {
	    mixDofMat.SetFloat("focusNear", focusNear);
        mixDofMat.SetFloat("focusFar", focusFar);

	}
	
	// Update is called once per frame
	void Update () {
	}

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        var blurTexture = RenderTexture.GetTemporary(Mathf.RoundToInt(source.width*0.25f), Mathf.RoundToInt(source.height*0.25f), source.depth, source.format);

        Graphics.Blit(source, blurTexture, mat);

        mixDofMat.SetFloat("focusNear", focusNear);
        mixDofMat.SetFloat("focusFar", focusFar);
        mixDofMat.SetTexture("_BlurTex", blurTexture);

        Graphics.Blit(source, destination, mixDofMat);
       
        RenderTexture.ReleaseTemporary(blurTexture);
        
    }
}
