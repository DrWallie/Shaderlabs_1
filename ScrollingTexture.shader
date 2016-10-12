Shader "Custom/ScrollingTexture" 
{
	Properties 
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_Emission("Emission", 2D) = "black" {}
		_ScrollSpeedX("ScrollSpeed", Range(-10,10)) = 1.0
		_ScrollSpeedZ("ScrollSpeed", Range(-10,10)) = 1.0
	}
	SubShader
		{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _Emission;

		struct Input 
		{
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		float _ScrollSpeedX;
		float _ScrollSpeedZ;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed2 scrolledUV = IN.uv_MainTex;
				fixed scrollX = (_ScrollSpeedX *_Time);
				fixed scrollZ = (_ScrollSpeedZ *_Time);
				scrolledUV += fixed2(scrollX, scrollZ);
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
			o.Emission = tex2D(_Emission, scrolledUV);
		}
		ENDCG
	}
	FallBack "Diffuse"
}