using UnityEngine;
using System.Collections;

public class TransparencyScript : MonoBehaviour
{

    public Camera lightCamera;
    
    public Material mat;
    private Matrix4x4 _vp;
    // Use this for initialization
    void Start()
    {
        var camera = Camera.main;
        
        mat.SetVector("_CameraParams", new Vector4(camera.nearClipPlane, camera.farClipPlane, 0, 0));

        GetComponent<Renderer>().material = mat;
    }

    // Update is called once per frame
    void Update()
    {
        var lightV = lightCamera.worldToCameraMatrix;
        var lightVP = lightCamera.projectionMatrix * lightV;

        mat.SetMatrix("_LightV", lightV);
        mat.SetMatrix("_LightVP", lightVP);

    }

    Vector4 Mul(Matrix4x4 matrix, Vector3 vec3, float w)
    {
        return Mul(matrix, new Vector4(vec3.x, vec3.y, vec3.z, w));
    }

    Vector4 Mul(Matrix4x4 matrix, Vector4 vec4)
    {
        var res = new Vector4();
        res.x = Vector4.Dot(matrix.GetRow(0), vec4);
        res.y = Vector4.Dot(matrix.GetRow(1), vec4);
        res.z = Vector4.Dot(matrix.GetRow(2), vec4);
        res.w = Vector4.Dot(matrix.GetRow(3), vec4);
        return res;
    }
}
