Shader "Custom/Effect/CustomWater" {
	Properties {
        _MainTex("主贴图", 2D) = "white" {}
        _MainColor("主颜色", Color) = (1, 1, 1, 1)
        _NormalTex("扰动图", 2D) = "white" {} 
        _PixelOffsetX("像素距离X", Float) = 0.1
        _PixelOffsetY("像素距离Y", Float) = 0.1
        _WaterSpeedX("水速度X", Float) = 0.1
        _WaterSpeedY("水速度Y", Float) = 0.1
        _LightDir("假光方向", Vector) = (1, 1, 1, 0)
        _SpecularPower("高光强度", Float) = 1
        _SpecularIntensity("高光亮度", Float) = 1
        _SpecularColor("高光颜色", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags{"Queue"="Transparent"}
     
        GrabPass
        {
            "_MyGrabTexture"
        }
       
        pass
        {
            Name "pass2"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
           
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _MainColor;

            sampler2D _MyGrabTexture;
            float4 _MyGrabTexture_ST;

            sampler2D _NormalTex;
            float4 _NormalTex_ST;
            
            float _PixelOffsetX;
            float _PixelOffsetY;

            float _WaterSpeedX;
            float _WaterSpeedY;

			float4 _LightDir;

            float4 _SpecularColor;
            float _SpecularPower;
            float _SpecularIntensity;

            struct v2f {
                float4 pos : SV_POSITION;
                float4 grabuv : TEXCOORD0;
                float2 uv:TEXCOORD1;
                float3 lightDir:TEXCOORD2;
                float3 viewDir:TEXCOORD3;
                float2 uv1:TEXCOORD4; 
            };

			float3 expand(float4 v)
			 { 
				fixed3 normal;
				normal.xy = v.wy * 2 - 1;
				normal.z = sqrt(1 - normal.x*normal.x - normal.y * normal.y);
				return normal;
			}

            v2f vert (appdata_full v)
            {
                v2f o;
                o.pos = mul(UNITY_MATRIX_MVP,v.vertex);
                o.grabuv = ComputeGrabScreenPos(o.pos);
                o.uv1 = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.uv = TRANSFORM_TEX(v.texcoord, _NormalTex);
                o.uv.x += _Time.y * _WaterSpeedX;
                o.uv.y += _Time.y * _WaterSpeedY;

                TANGENT_SPACE_ROTATION;

                o.lightDir = mul(rotation, mul(_Object2World, _LightDir).xyz);
                o.viewDir = mul(rotation, ObjSpaceViewDir(v.vertex));
                return o;

            }
            float4 frag (v2f i) : COLOR
            {
                
                float4 texCol = tex2D(_MyGrabTexture,float2(i.uv.x,1-i.uv.y));

                float4 normalColor = tex2D(_NormalTex, i.uv);
                float3 normal = expand(normalColor);

                float4 grabUV = UNITY_PROJ_COORD(i.grabuv);

                grabUV.x += (normal.x + 1) * _PixelOffsetX * .5;
                grabUV.y += (normal.y + 1) * _PixelOffsetY * 5;

                i.uv1.x += (normal.x + 1) * _PixelOffsetX * .5;
                i.uv1.y += (normal.y + 1) * _PixelOffsetY * 5;                

                float4 mainColor = tex2D(_MainTex, i.uv1);


                float diff = dot(normal, i.lightDir.xyz);
				float3 reflectionVector = reflect(-i.lightDir, normal);
                float3 spec = pow(saturate(dot(reflectionVector, i.viewDir)), _SpecularPower) * _SpecularIntensity * _SpecularColor;

                float4 color = tex2Dproj(_MyGrabTexture, grabUV);

                return float4(spec + color + mainColor * _MainColor, 1);
            }
            ENDCG
        }
    }
}
