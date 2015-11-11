Shader "Unlit/VolumeLightShader"
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
			float4 _lightScreenUV;

			float Decay;
			float Weight;
			float Density;

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
				half2 texcoord = i.uv;
				texcoord.y = 1 - texcoord.y;

				half2 deltaTexcoord = (texcoord - _lightScreenUV.xy);
				deltaTexcoord *= 0.02 * Density;

				fixed3 col = tex2D(_MainTex, texcoord).rgb;

				float illuminationDecay = 1.0f;

				for(int i = 0; i < 50; i++) {
					texcoord -= deltaTexcoord;
					half3 sample = tex2D(_MainTex, texcoord);
					sample *= illuminationDecay * Weight;

					col += sample;

					illuminationDecay *= Decay;
				}



				return fixed4(col, 1);

			}
			ENDCG
		}
	}
}
