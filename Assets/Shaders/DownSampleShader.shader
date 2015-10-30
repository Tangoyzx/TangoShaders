Shader "Hidden/DownSampleShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

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
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{
				float2 uv = i.uv;
				float2 invertScreenSize = float2(_ScreenParams.zw - 1);

				//float4 col = tex2D(_MainTex, uv + float2(_ScreenParams.z, _ScreenParams.w));
				float4 col = 0;
				col += tex2D(_MainTex, uv) * 0.25;
				col += tex2D(_MainTex, uv * float2(1 + invertScreenSize.x, 1)) * 0.125;
				col += tex2D(_MainTex, uv * float2(1, 1 + invertScreenSize.y)) * 0.125;
				col += tex2D(_MainTex, uv * float2(1 - invertScreenSize.x, 1)) * 0.125;
				col += tex2D(_MainTex, uv * float2(1, 1 - invertScreenSize.y)) * 0.125;

				col += tex2D(_MainTex, uv * float2(1 + invertScreenSize.x, 1 + invertScreenSize.y)) * 0.0625;
				col += tex2D(_MainTex, uv * float2(1 - invertScreenSize.x, 1 + invertScreenSize.y)) * 0.0625;
				col += tex2D(_MainTex, uv * float2(1 + invertScreenSize.x, 1 - invertScreenSize.y)) * 0.0625;
				col += tex2D(_MainTex, uv * float2(1 - invertScreenSize.x, 1 - invertScreenSize.y)) * 0.0625;

				return col;
			}
			ENDCG
		}
	}
}
