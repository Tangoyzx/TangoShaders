Shader "Unlit/TestProjectionShader" {
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
	CGINCLUDE
	
	#include "UnityCG.cginc"
           
	struct v2f {
		float4 pos : POSITION;
		float2 uv : TEXCOORD2;
		float4 screenPos : TEXCOORD0;
	};

	v2f vert (appdata_img v)
	{
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		o.uv = v.texcoord.xy;
		o.screenPos = ComputeScreenPos(o.pos);
		return o;
	}

	sampler2D _CameraDepthTexture;
	sampler2D _MainTex;

	float4x4 _inverseVP;
	float4x4 _prevVP;
	float dxA;
	float dxB;

	float4 frag( v2f i ) : COLOR
	{
		float2 depthUV = float2(i.uv.x, 1 - i.uv.y);

		float depth = tex2D(_CameraDepthTexture, depthUV);
		float depthFull = LinearEyeDepth(depth);

		float newZ = dxA * depthFull + dxB;

		float4 dxH = float4(depthUV * 2 - 1, 0, 1);
		dxH.z = dxA + dxB / depthFull;


		float4 D = mul(_inverseVP, dxH);
		float4 worldPos = D / D.w;


		float4 prevProjPos = mul(_prevVP, worldPos);

		float4 dxHw = dxH / depthFull;
		float2 velocity = (dxH.xy - prevProjPos.xy / prevProjPos.w) * 0.02;

		float4 color = tex2D(_MainTex, i.uv);
		float2 texUV = i.uv;
		for(int i = 1; i < 10; i++) {
			texUV += velocity;
			color += tex2D(_MainTex, texUV);
		}

		color *= 0.1f;

		return color;
	}
	

	ENDCG
	SubShader {
		Pass {
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			ENDCG
		}	
	} 
    FallBack off
}