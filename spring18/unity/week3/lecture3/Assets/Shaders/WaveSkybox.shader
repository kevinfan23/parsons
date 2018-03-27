// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Glitch-Skybox" {

	Properties{
		_DayColor("Sky Color", Color) = (1,1,1)
		_NightColor("Night Color", Color) = (1,1,1)
		_GroundColor("Ground Color", Color) = (1,1,1)
		_TimeOfDay("Time of day", float) = 0

		_BaseImage("Base Image", 2D) = "white"
		_RandomTex("Random Texture", 2D) = "white"
	}

	SubShader{

			Pass{

			//Cull Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			half3 _DayColor;
			half3 _NightColor;
			half3 _GroundColor;
			half _TimeOfDay;
			sampler2D _BaseImage;
			sampler2D _RandomTex;

			struct v2f {
				float4 pos : SV_POSITION;
				half3 color : COLOR0;
				half3 npos : TEXCOORD1;
				half2 uv : TEXCOORD0;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.color = mul((float3x3)unity_ObjectToWorld, v.normal) * 0.5 + 0.5;
				o.npos = v.vertex;
				o.uv = v.texcoord;
				return o;
			}

			float rnd(float2 x)
			{
				int n = int(x.x * 40.0 + x.y * 6400.0);
				n = (n << 13) ^ n;
				return 1.0 - float((n * (n * n * 15731 + 789221) + \
					1376312589) & 0x7fffffff) / 1073741824.0;
			}

			half4 frag(v2f i) : COLOR
			{
				half3 npos = normalize(i.npos);

				float t = _Time * 30.0;
				half ny = npos.y;
				ny = ny * 10.0 + 0.25 * sin(npos.x * 13.0 + t) * ny + 0.5 * cos(npos.z * 7.0 + t) * ny;
				ny -= frac(ny);
				ny = ny / 10.0;

				half3 skyColor = lerp(_DayColor, _NightColor, _TimeOfDay);

				half3 c = lerp(_GroundColor, skyColor, (ny + 0.3));
				c;

				half4 c1 = half4 (c, 1);
				half4 c2 = tex2D(_BaseImage, npos.xy);

				return lerp(c1, c2, 0.15);


			}
			ENDCG

		}
	}

	Fallback "VertexLit"
}