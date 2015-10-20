Shader "Unlit/NormalUVWaterShader"
{
	Properties
	{
		_DeepColor("深处的颜色", Color) = (1, 1, 1, 1)
		_ShoalColor("浅处的颜色", Color) = (1, 1, 1, 0)
		_DeepScale("深浅颜色比例", Range(0, 5)) = 1

		[NoScaleOffset]_BumpTex("法线贴图", 2D) = "bump" {}
		_BumpDirection("法线前进方向", Vector) = (1, 1, 1, 1)
		_BumpScale("法线缩放", Vector) = (1, 1, 1, 1)
		_BumpOffset("法线偏移", Vector) = (0, 0, 0, 0)

		_FresnelPower("菲涅尔系数", Range(0, 100)) = 1
		_FresnelBias("菲涅尔偏移", Range(-1, 1)) = 1
		_ReflectionColor("反射颜色", Color) = (1, 1, 1, 1)

		_RefractionDistort("折射分散系数", Range(0, 100)) = 0
		_NormalDistort("法线参数", Range(0.1, 50)) = 1

		_SpecPower("高光强度", Range(0.1, 500)) = 200
		_SpecColor("高光颜色", Color) = (1, 1, 1, 1)

		_LightSource("全局灯光方向", Vector) = (1, 1, 1, 1)
	}
	SubShader
	{
		Tags {"RenderType"="Transparent" "Queue"="Transparent"}
	
		Lod 500
		ColorMask RGB
		
		GrabPass { "_RefractionTex" }
		
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha
			ZTest LEqual
			ZWrite Off
			Cull Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			float4 _DeepColor;
			float4 _ShoalColor;
			half _DeepScale;

			sampler2D _BumpTex;
			half4 _BumpDirection;
			half4 _BumpScale;
			half4 _BumpOffset;

			float4 _ReflectionColor;

			half _FresnelPower;
			half _FresnelBias;

			half _RefractionDistort;
			half _NormalDistort;

			half _SpecPower;
			half4 _SpecColor;

			half4 _LightSource;

			sampler2D _ShoreTex;
			half _FoamIntensity;

			samplerCUBE _SkyBox;

			sampler2D _RefractionTex;
			sampler2D _CameraDepthTexture;

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float4 bumpUV : TEXCOORD0;
				float3 viewDir : TEXCOORD1;
				float3 lightDir : TEXCOORD2;
				float4 grabPassPos : TEXCOORD3;
				float4 screenPos : TEXCOORD4;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				
				float4 worldPos = mul(_Object2World, v.vertex);
				o.bumpUV = (worldPos.xzxz + _BumpDirection * _Time.xxxx) * _BumpScale * 0.01 + _BumpOffset;

				o.viewDir = WorldSpaceViewDir(v.vertex);
				o.lightDir = _LightSource.xyz - worldPos.xyz * _LightSource.w;

				o.grabPassPos = ComputeGrabScreenPos(o.pos);
				o.screenPos = ComputeScreenPos(o.pos);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float3 normal0 = UnpackNormal(tex2D(_BumpTex, i.bumpUV.xy)).xyz;
				float3 normal1 = UnpackNormal(tex2D(_BumpTex, i.bumpUV.zw)).xyz;
				float3 normal = normalize(normal0 + normal1).xzy * _NormalDistort;
				float3 viewDir = normalize(i.viewDir);

				//float fresnel = pow(1 - saturate(dot(viewDir, normal)), _FresnelPower);
				float dotNV = max(dot(viewDir, normal * _NormalDistort), 0.0);
				float fresnel = pow(clamp(1.0-dotNV, 0.0,1.0), _FresnelPower);
				float refl2Refr = saturate(_FresnelBias + (1 - _FresnelBias) * fresnel);

				float4 grabOffset = i.grabPassPos + float4(normal.xz * _RefractionDistort, 0, 0);
				float4 screenOffset = i.screenPos + float4(normal.xz * _RefractionDistort, 0, 0);

				float refrFix = SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(screenOffset));
				float4 refractColor;
				if (LinearEyeDepth(refrFix) < i.screenPos.z) {
					refractColor = tex2Dproj(_RefractionTex, UNITY_PROJ_COORD(i.grabPassPos));
				} else {
					refractColor = tex2Dproj(_RefractionTex, UNITY_PROJ_COORD(grabOffset));
				}
				refractColor.a = 1;

				float3 H = normalize(viewDir + normalize(i.lightDir));
				float dotNH = max(0, dot(normal, H));
				float4 spec = _SpecColor * pow(dotNH, _SpecPower);

				half depth = SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.screenPos));
				depth = LinearEyeDepth(depth);
				half depthScale = saturate(_DeepScale * (depth-i.screenPos.z) * 0.1);
				depthScale = 1 - depthScale;

				float4 reflectionColor = _ReflectionColor;

				fixed4 color = lerp(_DeepColor, _ShoalColor, depthScale);
				color = lerp(refractColor, color, color.a);

				return float4((lerp(color, _ReflectionColor, refl2Refr) + spec).rgb, 1);
			}
			ENDCG
		}
	}
}
