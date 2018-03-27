Shader "Custom/ScanLines" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0

		_LineColor ("Line Color", Color) = (0, 1, 0, 1)
		_Height ("Stripe Height", Range(0, 1)) = 0.5
		_Offset ("Stripe Offset", Range(0, 10)) = 0
		_Freq ("Frequency", Range(1, 20)) = 10
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
   			float3 worldPos;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		float _Height;
		float _Offset;
		float _Freq;
		fixed4 _LineColor;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {

			// a vector 4, HLSL
			// albedo comes from a textture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			if (frac(IN.worldPos.y + _Offset) < 0.2) {
				c += fixed4(1, 0, 0, 1);
			}

//			if( frac(_Freq * IN.worldPos.y + _Offset)  < _Height) {
//				//c = fixed4(1.0, 0, 0, 1.0);
//				//c.rgb = (1-c);
//				c += _LineColor * 0.25;
//				o.Emission.rgb = _LineColor.rgb * 0.25;
//			}

			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
