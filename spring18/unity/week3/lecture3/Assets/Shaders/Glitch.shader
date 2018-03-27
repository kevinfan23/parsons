Shader "Custom/Room" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_EmissionMap ("Emission Map", 2D) = "black" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0


		[Space(50)]
		[Header(General Settings)]
		_RandomTex ("Random Texture", 2D) = "white" {}


		[Space(50)]
		[Header(Glitch Types)]
		[Toggle] _ShowGrid("Show Grid?", Float) = 0
		[Toggle] _GlitchColors("Glitch Colors", Float) = 0
		_BulgeAmount("Bulge Amount", Range(0,5)) = 0
		[Toggle] _HideChunks("Hide Chunks", Float) = 0
		_GlitchSeed("Glitch Seed", Float) = 0

		[Space(50)]
		[Header(Grid Settings)]
		_GridColor ("Grid Color", Color) = (0,1,0,1)
        _GridStep ("Grid size", Float) = 0.05
        _GridWidth ("Grid width", Float) = 1
        
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue"="Geometry" }
		//Tags {"Queue" = "Transparent" "RenderType"="Transparent" }
		LOD 200
		Cull Off

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert // alpha:fade

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _EmissionMap;
		sampler2D _RandomTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 worldPos;
		};


		float _BulgeAmount;

		void vert (inout appdata_full v) {
			v.vertex.xyz += v.normal * _BulgeAmount;
		}

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;


		float _GridStep;
        float _GridWidth;
        fixed4 _GridColor;
        float _ShowGrid;
		float _HideChunks;
		float _GlitchSeed;
		float _GlitchColors;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Take care of the other standard shader stuff
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Emission = tex2D (_EmissionMap, IN.uv_MainTex).rgb;

			// Sample the color from the main texture
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;


			// Now add stuff based on the glitch bools if they are active

			if(_ShowGrid) {
				float2 pos = IN.worldPos.yz / _GridStep;
				float2 f  = abs(frac(pos)-.5);
				float2 df = fwidth(pos) * _GridWidth;
				float2 g = smoothstep(-df ,df , f);
				float grid = 1.0 - saturate(g.x * g.y);
				c.rgb = lerp(c.rgb, _GridColor, grid);
			}

			// Calculate a random number for each chunk
			float _SquareSize = 20.0;
			int x = abs(IN.worldPos.y * _SquareSize);
			int y = abs(IN.worldPos.z * _SquareSize);
			float2 s = float2(x / _SquareSize, y / _SquareSize);
			float4 rc = tex2D(_RandomTex, s);
			float random = rc.r;

			if (_GlitchColors) {
				c.rgb = lerp(c.rgb, rc, 0.8);
				//o.Metallic = 1.0;
				o.Smoothness = 1.0;
			}

			if (_HideChunks) {
				if (abs(random - _GlitchSeed) < 0.1) {
					clip(-1);
				}
			}


			o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
			o.Albedo = c.rgb;
			o.Alpha = c.a;

            // https://docs.unity3d.com/460/Documentation/Manual/SL-BuiltinValues.html
			// _Time
			// frac Returns the fractional (or decimal) part of x; which is greater than or equal to 0 and less than 1.
			// clip Discards the current pixel if the specified value is less than zero.
		}
		ENDCG
	}
	FallBack "Diffuse"
}
