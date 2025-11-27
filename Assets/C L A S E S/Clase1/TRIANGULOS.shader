// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TRIANGULOS"
{
	Properties
	{
		_Tri01("Tri01", 2D) = "white" {}
		_Tri02("Tri02", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Tri02;
		uniform float4 _Tri02_ST;
		uniform sampler2D _Tri01;
		uniform float4 _Tri01_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Tri02 = i.uv_texcoord * _Tri02_ST.xy + _Tri02_ST.zw;
			float4 tex2DNode4 = tex2D( _Tri02, uv_Tri02 );
			float4 color8 = IsGammaSpace() ? float4(0,0,1,0) : float4(0,0,1,0);
			float2 uv_Tri01 = i.uv_texcoord * _Tri01_ST.xy + _Tri01_ST.zw;
			float4 tex2DNode3 = tex2D( _Tri01, uv_Tri01 );
			float4 color16 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
			o.Albedo = saturate( ( ( tex2DNode4 * color8 ) + ( tex2DNode3 * color16 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
576;470;906;521;670.4879;186.6642;1.687775;False;False
Node;AmplifyShaderEditor.SamplerNode;4;-1241.318,126.436;Inherit;True;Property;_Tri02;Tri02;1;0;Create;True;0;0;0;False;0;False;-1;0851ccfb81c146749a521de4d977c18f;0851ccfb81c146749a521de4d977c18f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-1256,405.1717;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;0,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;-1252.028,611.9833;Inherit;False;Constant;_Color1;Color 1;2;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1247.615,-90.60853;Inherit;True;Property;_Tri01;Tri01;0;0;Create;True;0;0;0;False;0;False;-1;09969b7406bd055449e0deb5e36232f3;09969b7406bd055449e0deb5e36232f3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-832.0028,545.2654;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-828.5377,324.8242;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;35;-126.3179,-62.45697;Inherit;False;285;304;NO_FUNCIONA_PORQUESI;1;10;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-584.458,447.7501;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;12;-308.293,142.0612;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;10;-76.31781,-12.45694;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-591.1334,724.3568;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-842.3318,763.416;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;31;-270.6074,718.8928;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-836.1364,996.441;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;32;34.58805,537.3924;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;27;-1253.61,835.7648;Inherit;False;Constant;_Color2;Color 2;2;0;Create;True;0;0;0;False;0;False;0,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-573.017,-315.168;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-575.9457,151.961;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;13;213.4167,-9.795749;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-575.1307,-76.81305;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;23;-283.3085,445.5867;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;505.1903,215.5873;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;TRIANGULOS;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;3;0
WireConnection;20;1;16;0
WireConnection;15;0;4;0
WireConnection;15;1;8;0
WireConnection;22;0;15;0
WireConnection;22;1;20;0
WireConnection;12;0;11;0
WireConnection;10;0;5;0
WireConnection;10;1;12;0
WireConnection;30;0;28;0
WireConnection;30;1;29;0
WireConnection;28;0;4;0
WireConnection;28;1;27;0
WireConnection;31;0;30;0
WireConnection;31;1;11;0
WireConnection;29;0;3;0
WireConnection;29;1;8;0
WireConnection;32;0;31;0
WireConnection;9;0;3;0
WireConnection;9;1;4;0
WireConnection;11;0;3;0
WireConnection;11;1;4;0
WireConnection;13;0;10;0
WireConnection;5;0;3;0
WireConnection;5;1;4;0
WireConnection;23;0;22;0
WireConnection;0;0;23;0
ASEEND*/
//CHKSM=F3F8299A637C0EBA963933827DC7690DC542B42D