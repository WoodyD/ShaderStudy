Shader "Study/SurfaceShader2" {
	Properties{
		_DirtTex("Dirt texture", 2D) = "white" {}
		_DirtMask("Dirt mask", 2D) = "white" {}
		_Intensity("Intensity", Range(0,10)) = 0
		}

	SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _DirtTex;
		sampler2D _DirtMask;
		float _Intensity;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = tex2D(_DirtTex, IN.uv_MainTex) * _Intensity;
			o.Albedo = c.rgb;

			o.Alpha = c.a;
		}
	ENDCG
	}
	FallBack "Diffuse"
}
