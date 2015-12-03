Shader "Unlit/TransparencyShader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_BumpTex("BumpTex", 2D) = "bump" {}
		_LightDepthRT("Texture", 2D) = "white" {}
		_FirstColor("FirstColor", Color) = (1, 1, 1, 1)
		_SecondColor("SecondColor", Color) = (1, 1, 1, 1)
		_DepthScale("DepthScale", Range(0.01, 5)) = 0.1
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal :NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 lightUV : TEXCOORD1;
				float4 lightPos : TEXCOORD2;
				float3 objLightDir : TEXCOORD3;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			sampler2D _LightDepthRT;
			sampler2D _BumpTex;

			float4 _ProjInfo;
			float4 _CameraParams;

			fixed4 _FirstColor;
			fixed4 _SecondColor;
			fixed _DepthScale;
			float4x4 _LightV;
			float4x4 _LightVP;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;

				float4 objPos = v.vertex;
				objPos.xyz -= v.normal * 0.0008;
				float4 worldPos = mul(_Object2World, objPos);
				o.lightUV = mul(_LightVP, worldPos);
				o.lightPos = mul(_LightV, worldPos);
				o.objLightDir = ObjSpaceLightDir(v.vertex);

				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float2 lightUV = i.lightUV.xy / i.lightUV.w;
				lightUV = lightUV * 0.5 + 0.5;
				fixed depth = tex2D(_LightDepthRT, lightUV);
				float per = (-i.lightPos.z - depth * 5) / _DepthScale;
				fixed4 transparencyCol = lerp(_FirstColor, _SecondColor, clamp(per, 0, 1));

				float3 normal = UnpackNormal(tex2D(_BumpTex, i.uv));
				float dotNL = dot(normal, i.objLightDir);

				fixed4 col = tex2D(_MainTex, i.uv);
				col *= dotNL * 0.5 + 0.5;

				fixed4 finalColor;
				finalColor.rgb = col.rgb + transparencyCol.rgb * transparencyCol.a;
				finalColor.a = 1;
				return finalColor;
			}
			ENDCG
		}
	}
		Fallback "Diffuse"
}
