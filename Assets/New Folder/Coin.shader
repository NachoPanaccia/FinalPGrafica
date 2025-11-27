// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Coin"
{
	Properties
	{
		_Smoothness("Smoothness", Float) = 0
		_Color0("Color 0", Color) = (0.8196079,0.627451,0.3098039,0)
		_Metallic("Metallic", Float) = 0
		_SPEED("SPEED", Float) = 5
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _Color0;
		uniform float _SPEED;
		uniform float _Metallic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 temp_output_1_0 = _Color0;
			o.Albedo = temp_output_1_0.rgb;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float mulTime6 = _Time.y * _SPEED;
			float lerpResult56 = lerp( -3.0 , 1.0 , sin( ( ( ase_vertex3Pos.y + mulTime6 ) + ( ase_vertex3Pos.x + mulTime6 ) ) ));
			o.Emission = saturate( ( _Color0 * lerpResult56 ) ).rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17200
379;592;1272;399;1692.926;809.9587;2.323628;True;False
Node;AmplifyShaderEditor.RangedFloatNode;8;-1177.939,-32.55165;Inherit;False;Property;_SPEED;SPEED;3;0;Create;True;0;0;False;0;5;2.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;5;-1187.51,-275.1543;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;6;-996.978,-31.61359;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-738.3492,-390.4631;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-731.6496,-162.2955;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-489.528,-245.831;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-235.854,-244.329;Inherit;False;Constant;_Float4;Float 4;3;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-236.4102,-327.3326;Inherit;False;Constant;_Float3;Float 3;3;0;Create;True;0;0;False;0;-3;0;-3;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;13;-175.8305,-141.1057;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;153.676,-454.1662;Inherit;False;Property;_Color0;Color 0;1;0;Create;True;0;0;False;0;0.8196079,0.627451,0.3098039,0;0.9150943,0.6334964,0.2374066,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;56;137.4872,-254.1009;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;482.031,-240.8942;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;3;761.4789,48.35567;Inherit;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;26;736.1891,-175.1652;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2;748.4789,132.3555;Inherit;False;Property;_Smoothness;Smoothness;0;0;Create;True;0;0;False;0;0;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;945.0526,-207.872;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Coin;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;8;0
WireConnection;14;0;5;2
WireConnection;14;1;6;0
WireConnection;7;0;5;1
WireConnection;7;1;6;0
WireConnection;22;0;14;0
WireConnection;22;1;7;0
WireConnection;13;0;22;0
WireConnection;56;0;57;0
WireConnection;56;1;58;0
WireConnection;56;2;13;0
WireConnection;23;0;1;0
WireConnection;23;1;56;0
WireConnection;26;0;23;0
WireConnection;0;0;1;0
WireConnection;0;2;26;0
WireConnection;0;3;3;0
WireConnection;0;4;2;0
ASEEND*/
//CHKSM=C58DD251428C97EB96A95CE811479F2A85146033