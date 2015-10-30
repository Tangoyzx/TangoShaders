Shader "Custom/DepthOfFieldBlur"
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

			sampler2D _CameraDepthTexture;
			sampler2D _MainTex;
			sampler2D _BlurTex;

			float focusNear;
			float focusFar;
			
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = float4(v.uv, v.uv.x, 1 - v.uv.y);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				float depth = tex2D(_CameraDepthTexture, i.uv.zw);
				depth = LinearEyeDepth(depth);

				float blurIntr = 1;


				if (depth > focusFar) {
					blurIntr = (_ProjectionParams.z - depth) / (_ProjectionParams.z - focusFar);
				}
				else if (depth < focusNear) {
					blurIntr = depth / focusNear;	
				}

				float4 normalColor = tex2D(_MainTex, i.uv.xy);
				float4 blurColor = tex2D(_BlurTex, i.uv.zw);

				return lerp(blurColor, normalColor, blurIntr);
				//return blurIntr;
				//return blurColor;
			}
			ENDCG
		}
	}
}
