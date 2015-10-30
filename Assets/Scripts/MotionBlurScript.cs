using UnityEngine;
using System.Collections;

public class MotionBlurScript : MonoBehaviour
{
    public Transform tt;
    public Material changeMaterial;


    private Matrix4x4 _fromO2D;
    private Matrix4x4 _fromD2O;

    private float a;
    private float b;

    private Matrix4x4 _prevVP;
    private Matrix4x4 _inverseVP;

	// Use this for initialization
	void Start ()
	{
        Camera.main.depthTextureMode = DepthTextureMode.Depth;

        _fromD2O = Matrix4x4.identity;
	    _fromD2O[2, 2] = 2;
        _fromD2O[2, 3] = -1;

        _fromO2D = Matrix4x4.identity;
	    _fromO2D[2, 2] = 0.5f;
        _fromO2D[2, 3] = 0.5f;

	    var far = Camera.main.farClipPlane;
        var near = Camera.main.nearClipPlane;

	    //a = -(far + near)/(far - near);
	    //b = -(2*far*near)/(far - near);

	    a = (far)/(far - near);
	    b = -(far*near)/(far - near);
        changeMaterial.SetFloat("a", a);
        changeMaterial.SetFloat("b", b);
        Debug.Log("a, b: " + a + "," + b);

        Debug.Log(Camera.main.projectionMatrix);
	}
	
	// Update is called once per frame
	void Update ()
	{
        var cameraMat = Camera.main.worldToCameraMatrix;
        var projectionMat = Camera.main.projectionMatrix;

        var fromP2W = Camera.main.cameraToWorldMatrix * projectionMat.inverse * _fromD2O;
        var fromW2P = _fromO2D * projectionMat * Camera.main.worldToCameraMatrix;

        //var fromP2W = Camera.main.cameraToWorldMatrix * projectionMat.inverse;
        //var fromW2P = projectionMat * Camera.main.worldToCameraMatrix;

	    var pp = tt.position;
	    pp.z -= 0.5f;

	    var w2p = Mul4(fromW2P, pp);
	    var depth = w2p.w;
	    var w2pw = (w2p/w2p.w);
        

        Debug.Log("length : " + (pp - transform.position).magnitude + "W2P /w : " + w2pw );
	}

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        var projectionMat = Camera.main.projectionMatrix;
        var fromP2W = Camera.main.cameraToWorldMatrix * projectionMat.inverse * _fromD2O;
        var fromW2P = _fromO2D * projectionMat * Camera.main.worldToCameraMatrix;
        var prevP = Mul4(_prevVP, (tt.position + new Vector3(0, 0, -0.5f)));
        Debug.Log("pref position : " + (prevP / prevP.w));
        changeMaterial.SetMatrix("_inverseVP", fromP2W);
        changeMaterial.SetMatrix("_prevVP", _prevVP);
        changeMaterial.SetFloat("dxA", a);
        changeMaterial.SetFloat("dxB", b);
        Graphics.Blit(source, destination, changeMaterial);

        _prevVP = fromW2P;
    }

    Vector4 Mul4(Matrix4x4 m, Vector3 v) {
        return Mul4(m, new Vector4(v.x, v.y, v.z, 1));
    }

    Vector4 Mul4(Matrix4x4 m, Vector4 v)
    {
        var res = new Vector4();
        res.x = Vector4.Dot(m.GetRow(0), v);
        res.y = Vector4.Dot(m.GetRow(1), v);
        res.z = Vector4.Dot(m.GetRow(2), v);
        res.w = Vector4.Dot(m.GetRow(3), v);
        return res;
    }
}

