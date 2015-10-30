Shader "Custom/MotionBlurShader"
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
			sampler2D _CameraDepthTexture;

			float4x4 _InverseVP;

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
			
			fixed4 frag (v2f i) : SV_Target
			{
				return tex2D(_MainTex, i.uv);
				//fixed4 col = tex2D(_MainTex, i.uv);
				// just invert the colors
				//col = 1 - col;
				float2 uv = i.uv;
				uv.y = 1 - uv.y;
				float depth = tex2D(_CameraDepthTexture, uv);
				depth = LinearEyeDepth(depth);

				float a = -(_ProjectionParams.z + _ProjectionParams.y) / (_ProjectionParams.z - _ProjectionParams.y);
				float b = -(2 * _ProjectionParams.y * _ProjectionParams.z) / (_ProjectionParams.z - _ProjectionParams.y);
				float2 projectionXY = (uv + uv - 1) * depth;
				float projectionZ = a * -depth + b;
				float4 projectionPos = float4(projectionXY.xy, projectionZ, depth);

				float4 worldPos = mul(_InverseVP, projectionPos);


				return worldPos.zzzz;

			}
			ENDCG
		}
	}
}
