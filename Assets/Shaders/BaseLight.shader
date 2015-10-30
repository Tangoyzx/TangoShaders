Shader "Unlit/BaseLight"
{
	Properties
	{
		_MainColor("颜色", Color) = (1, 1, 1, 1)
		_Metallic("金属感", Range(0, 1)) = 0.3
		_Emission("自发光", Color) = (0, 0, 0, 1)
		_SpecPower("高光", Range(0.01, 1)) = 0.3
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			half4 _Emission;
			half _SpecPower;
			half _Metallic;

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 viewDir : TEXCOORD0;
				float3 lightDir : TEXCOORD1;
				float3 normal : TEXCOORD2;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);

				o.lightDir = WorldSpaceLightDir(v.vertex);
				o.viewDir = WorldSpaceViewDir(v.vertex);
				o.normal = normalize(UnityObjectToWorldNormal(v.vertex));
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float3 viewDir = normalize(i.viewDir);
				float3 lightDir = normalize(-i.lightDir);

				float dotNL = saturate(dot(i.normal, lightDir));
				float3 H = normalize(viewDir + lightDir);
				float dotNH = saturate(dot(i.normal, lightDir));
				float spec = pow(dotNH, 1 / _SpecPower);

				float diffuse = dotNL * 0.5 + 0.5;

				float color = diffuse * (1 - _Metallic) + spec * _Metallic;
				
				return float4(color.xxx, 1) + UNITY_LIGHTMODEL_AMBIENT;
			}
			ENDCG
		}
	}
}
