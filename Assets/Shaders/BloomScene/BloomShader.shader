Shader "Custom/Bloom"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_BloomTex("Bloom Texture", 2D) = "black" {}
	}
	CGINCLUDE

		#include "UnityCG.cginc"

		sampler2D _MainTex;
		sampler2D _BloomTex;

		uniform half4 _MainTex_TexelSize;
		uniform half4 _Parameter;

		struct appdata_bloom {
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

		struct v2f_bloom {
			float4 pos :SV_POSITION;
			float2 uv :TEXCOORD0;
		};

		v2f_bloom vert_bloom(appdata_bloom v) {
			v2f_bloom o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			o.uv = v.uv;
			return o;
		}

		fixed4 frag_bloom(v2f_bloom i):SV_Target {
			fixed4 color = tex2D(_MainTex, i.uv);
			color += tex2D(_BloomTex, float2(i.uv.x, 1 - i.uv.y));
			return color;
		}


		struct appdata_downsample {
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

		struct v2f_downsample {
			float4 pos : SV_POSITION;
			float4 uv01 : TEXCOORD0;
			float4 uv23 : TEXCOORD1;
		};

		v2f_downsample vert_downsample(appdata_downsample v) {
			v2f_downsample o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			o.uv01 = float4(v.uv + _MainTex_TexelSize.xy, v.uv + _MainTex_TexelSize.xy * half2(-1.0h, 1.0h));
			o.uv23 = float4(v.uv + _MainTex_TexelSize.xy * half2(-1.0h, -1.0h), v.uv + _MainTex_TexelSize.xy * half2(1.0h, -1.0h));
			return o;
		}

		fixed4 frag_downsample(v2f_downsample i):SV_Target {
			fixed4 color = tex2D(_MainTex, i.uv01.xy);
			color += tex2D(_MainTex, i.uv01.zw);
			color += tex2D(_MainTex, i.uv23.xy);
			color += tex2D(_MainTex, i.uv23.zw);

			return max(color * 0.25h - _Parameter.z, 0) * _Parameter.w;
		}


		static const half4 curve4[7] = {half4(0.0205, 0.0205, 0.0205, 0), half4(0.0855, 0.0855, 0.0855, 0), half4(0.232, 0.232, 0.232, 0), 
			half4(0.324, 0.324, 0.324, 1), half4(0.232, 0.232, 0.232, 0), half4(0.0855, 0.0855, 0.0855, 0), half4(0.0205, 0.0205, 0.0205, 0)};

		struct appdata_VH {
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

		struct v2f_VH {
			float4 pos : SV_POSITION;
			float2 uv : TEXCOORD0;
			float2 offs : TEXCOORD1;
		};

		v2f_VH vert_vertical(appdata_VH v) {
			v2f_VH o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			o.uv = v.uv;
			o.offs = _MainTex_TexelSize.xy * half2(0.0h, 1.0h) * _Parameter.x;
			return o;
		}

		v2f_VH vert_horizontal(appdata_VH v) {
			v2f_VH o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			o.uv = v.uv;
			o.offs = _MainTex_TexelSize.xy * half2(1.0h, 0.0h) * _Parameter.x;
			return o;
		}

		fixed4 frag_VH(v2f_VH i):SV_Target {
			fixed4 color = fixed(0).xxxx;
			float2 uv = i.uv - i.offs * 4;

			for(int l = 0; l < 7; l++) {
				uv += i.offs;
				color += curve4[l] * tex2D(_MainTex, uv);
			}
			return color;
		}

	ENDCG
	SubShader
	{
		ZTest Off Cull Off ZWrite Off Blend Off

		//0
		Pass
		{
			CGPROGRAM

			#pragma vertex vert_bloom
			#pragma fragment frag_bloom

			ENDCG
		}
		//1
		Pass
		{
			CGPROGRAM

			#pragma vertex vert_downsample
			#pragma fragment frag_downsample

			ENDCG
		}
		//2
		Pass
		{
			ZTest Always
			Cull Off

			CGPROGRAM

			#pragma vertex vert_vertical
			#pragma fragment frag_VH

			ENDCG
		}
		//3
		Pass
		{
			ZTest Always
			Cull Off

			CGPROGRAM

			#pragma vertex vert_horizontal
			#pragma fragment frag_VH

			ENDCG
		}
	}
}
