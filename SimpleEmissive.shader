Shader "Custom/SimpleEmissive"
{
	Properties
	{
		_Diffuse("Diffuse", Color) = (1,1,1,1)
		_Metallic("Metallic", 2D) = "white" {}
		_Glossiness("Smoothness", 2D) = "white" {}
		_NormalMap("Normal", 2D) = "bump" {}
		_Emission("Emmision", 2D) = "white" {}
		_Multiplier("EmisMultiplier", Range(0,5)) = 0.0
		_Color("EmisColor", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows

		sampler2D _Glossiness;
		sampler2D _Metallic;
		sampler2D _NormalMap;
		sampler2D _Emission;
		struct Input
		{
			float2 uv_MainTex;
			float2 uv_NormalMap;
		};
		float4 _Multiplier;
		half _Diffuse;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			fixed3 n = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
			o.Albedo = _Diffuse;
			o.Metallic = tex2D(_Metallic, IN.uv_MainTex);
			o.Smoothness = tex2D(_Glossiness, IN.uv_MainTex);
			o.Emission = tex2D(_Emission, IN.uv_MainTex) * _Color;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
