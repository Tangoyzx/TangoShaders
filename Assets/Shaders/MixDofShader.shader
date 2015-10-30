Shader "Unlit/MixDofShader"
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
			sampler2D _BlurTex;
			sampler2D _CameraDepthTexture;
			float focusFar;
			float focusNear;

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
				float interp = 1;

				float depth = tex2D(_CameraDepthTexture, i.uv.zw);
				depth = LinearEyeDepth(depth);
				if (depth > focusFar) {
					interp = (depth - focusFar) / (_ProjectionParams.z - focusFar);
				} else if (depth < focusNear) {
					interp = depth / focusNear;
				}

				float4 normalCol = tex2D(_MainTex, i.uv.xy);
				float4 blurCol = tex2D(_BlurTex, i.uv.zw);

				return lerp(blurCol, normalCol, interp);
			}
			ENDCG
		}
	}
}
