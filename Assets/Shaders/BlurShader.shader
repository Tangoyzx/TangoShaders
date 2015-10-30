Shader "Unlit/BlurShader"
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

			sampler2D _MainTex;
			float blurSize;
			float blurDistance;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float2 invScreenSize : TEXCOORD1;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				o.invScreenSize = (_ScreenParams.zw - 1) * blurDistance;
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				float2 invScreenSize = i.invScreenSize;
				fixed4 col = float4(0, 0, 0, 0);
				float2 newuv = i.uv;
				float startY = newuv.y - blurSize * invScreenSize.y;

				float ssize = blurSize + blurSize - 1;
				float invSqrt = 1.0f / (ssize * ssize);
				newuv.x -= blurSize * invScreenSize.x;
				for(int i = 1-blurSize; i < blurSize; i++) {
					newuv.x += invScreenSize.x;
					newuv.y = startY;
					for(int j = 1 - blurSize; j < blurSize; j++) {
						newuv.y += invScreenSize.y;
						col += tex2D(_MainTex, newuv) * invSqrt;
					}
				}

				return col;
			}
			ENDCG
		}
	}
}
