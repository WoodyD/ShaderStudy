Shader "Study/AmbientShader" {
	Properties {
		_AmbientColor ("Ambient Color", Color) = (1,1,1,1)
		_EmissiveColor ("Emissive Color", Color) = (1,1,1,1)
		_Intensity("Intensity", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _AmbientColor;
		fixed4 _EmissiveColor;
		float _Intensity;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = pow((_AmbientColor + _EmissiveColor), _Intensity);

			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
