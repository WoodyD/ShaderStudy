Shader "Study/VertexShader1"
	{
	Properties
		{
			_MainTex("Texture", 2D) = "white" {}
			_DirtTex("Dirt texture", 2D) = "white" {}
			_DirtMask("Dirt mask", 2D) = "white" {}
			_Intensity("Intensity", Range(0.2,0.6)) = 0
		}
		SubShader
				{
					Tags { "RenderType" = "Opaque" }
					LOD 100

					Pass
					{
						CGPROGRAM
						#pragma vertex vert
						#pragma fragment frag

						#include "UnityCG.cginc"

						struct appdata {
							float4 vertex : POSITION;
							float2 uv : TEXCOORD0;
						};

						struct v2f {
							float2 uv : TEXCOORD0;
							float4 vertex : SV_POSITION;
						};

						sampler2D _MainTex;
						float4 _MainTex_ST;
						sampler2D _DirtTex;
						sampler2D _DirtMask;
						float _Intensity;

						v2f vert(appdata IN) {
							v2f o;
							o.vertex = UnityObjectToClipPos(IN.vertex);
							o.uv = TRANSFORM_TEX(IN.uv, _MainTex);

							return o;
						}

						fixed4 frag(v2f IN) : SV_Target
						{
							fixed4 tex1Col = tex2D(_MainTex, IN.uv);					
							fixed4 tex2Col = tex2D(_DirtTex, IN.uv);
							fixed4 tex3Col = tex2D(_DirtMask, IN.uv);

							clip(tex3Col.b - (1 - _Intensity));
							tex2Col *= tex3Col.a;

							//if(tex2Col.a < 1)
								//tex1Col *= tex2Col;

							return tex2Col;
						}
						ENDCG
					}
				}
	}
