Shader "Unlit/AnimatedCloud"
{
	Properties
	{
		[NoScaleOffset]_CloudTex("云贴图", 2D) = "white" {}
		_CloudDirection("云方向", Vector) = (1, 1, 1, 1)
		_CloudScale("云缩放", Vector) = (1, 1, 1, 1)
		_CloudOffset("云偏移", Vector) = (0, 0, 0, 0)
		_CloudPower("云密度", Range(0.01, 50)) = 1
		_CloudIntensity("云强度", Range(0, 100)) = 5
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue"="Transparent"}
		LOD 100



		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZTest LEqual
			ZWrite Off
			Cull Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			sampler2D _CloudTex;
			half4 _CloudDirection;
			half4 _CloudScale;
			half4 _CloudOffset;
			half _CloudPower;
			half _CloudIntensity;

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				half4 cloudUV : TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);

				float4 worldPos = mul(_Object2World, v.vertex);
				o.cloudUV = (worldPos.xzxz + _CloudDirection * _Time.xxxx) * _CloudScale * 0.01 + _CloudOffset;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float color = (tex2D(_CloudTex, i.cloudUV.xy) * tex2D(_CloudTex, i.cloudUV.zw)).r;
				float a = pow(color, _CloudPower) * _CloudIntensity;
				color *= _CloudIntensity;
				return float4(color.xxx, a);
			}
			ENDCG
		}
	}
}
