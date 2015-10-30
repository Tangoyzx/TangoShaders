using UnityEngine;
using System.Collections;

public class VolumeLight : MonoBehaviour
{
    public Material mat;
    public Material darkMat;
    public Material mixMat;
    public Light light;
    public float Decay = 0.5f;
    public float Weight = 1;
    public float Density = 0.5f;
	// Use this for initialization
	void Start () {
	    Camera.main.depthTextureMode = DepthTextureMode.Depth;
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Vector4 lightScreenUV;
        if (light.type == LightType.Directional)
        {
            lightScreenUV = GetDirectionLightScreenUV(-light.transform.forward);
        } else if (light.type == LightType.Point)
        {
            lightScreenUV = GetPointLightScreenUV(light.transform.position);
        }
        else
        {
            lightScreenUV = Vector4.zero;
        }

        var darkRT = RenderTexture.GetTemporary(source.width, source.height, source.depth, source.format);

        Graphics.Blit(source, darkRT, darkMat);
        /*
        Graphics.Blit(darkRT, destination);
        RenderTexture.ReleaseTemporary(darkRT);
        return;
         */

        mat.SetVector("_lightScreenUV", lightScreenUV);
        mat.SetFloat("Weight", Weight);
        mat.SetFloat("Decay", Decay);
        mat.SetFloat("Density", Density);

        var t1 = RenderTexture.GetTemporary(source.width, source.height, source.depth, source.format);
        Graphics.Blit(darkRT, t1, mat);
        RenderTexture.ReleaseTemporary(darkRT);
        darkRT = t1;

        mixMat.SetTexture("_DarkTex", darkRT);

        Graphics.Blit(source, destination, mixMat);

        RenderTexture.ReleaseTemporary(darkRT);
    }

    Vector4 GetPointLightScreenUV(Vector3 lightSrc)
    {
        var world2Proj = Camera.main.projectionMatrix * Camera.main.worldToCameraMatrix;
        var screenPoint = world2Proj.MultiplyPoint(lightSrc);
        screenPoint.x = screenPoint.x * 0.5f + 0.5f;
        screenPoint.y = 0.5f - screenPoint.y * 0.5f;
        return new Vector4(screenPoint.x, screenPoint.y, 0, 0);
    }

    Vector4 GetDirectionLightScreenUV(Vector3 lightDir)
    {
        var world2Proj = Camera.main.projectionMatrix * Camera.main.worldToCameraMatrix;
        var screenDir = world2Proj.MultiplyVector(lightDir);
        screenDir.x = 0.5f + screenDir.x * 0.5f;
        screenDir.y = 0.5f - screenDir.y * 0.5f;
        return new Vector4(screenDir.x, screenDir.y, 0, 0);
    }
}
