// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BooksShader"
{
	Properties
	{
		_frecuency("frecuency", Float) = 0
		_frecuency2("frecuency 2", Float) = 0
		_Width("Width", Range( -1 , 1)) = 0.249203
		_SecondaryPosition("SecondaryPosition", Range( -1 , 1)) = 0.249203
		_Width2("Width 2", Range( -1 , 1)) = 0.249203
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha addshadow fullforwardshadows noforwardadd 
		struct Input
		{
			float3 worldPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _frecuency2;
		uniform float _Width2;
		uniform float _Width;
		uniform float _SecondaryPosition;
		uniform float _frecuency;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			c.rgb = 0;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float4 color11 = IsGammaSpace() ? float4(0,1,0.02711678,0) : float4(0,1,0.002098822,0);
			float4 color10 = IsGammaSpace() ? float4(1,0,0.1089005,0) : float4(1,0,0.01146007,0);
			float4 color17 = IsGammaSpace() ? float4(0.5919976,0,1,0) : float4(0.3092862,0,1,0);
			float3 ase_worldPos = i.worldPos;
			float4 lerpResult18 = lerp( color10 , color17 , step( sin( ( ase_worldPos.x * _frecuency2 ) ) , _Width2 ));
			float4 lerpResult9 = lerp( color11 , lerpResult18 , step( _Width , sin( ( ( ase_worldPos.x + _SecondaryPosition ) * _frecuency ) ) ));
			o.Emission = lerpResult9.rgb + 1E-5;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
403;541;1102;450;1669.683;213.5616;1.3;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1318.232,-80.97226;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;19;-1052.613,-171.9863;Inherit;False;Property;_frecuency2;frecuency 2;1;0;Create;True;0;0;0;False;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1357.734,151.969;Inherit;False;Property;_SecondaryPosition;SecondaryPosition;3;0;Create;True;0;0;0;False;0;False;0.249203;-0.66;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-1059.219,137.3851;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1101.272,249.7101;Inherit;False;Property;_frecuency;frecuency;0;0;Create;True;0;0;0;False;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-873.8789,-183.7557;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-830.1524,-42.43462;Inherit;False;Property;_Width2;Width 2;4;0;Create;True;0;0;0;False;0;False;0.249203;0.78;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-856.6556,158.0932;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;14;-698.4259,-175.1132;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;17;-864.1964,-401.9999;Inherit;False;Constant;_Color2;Color 2;3;0;Create;True;0;0;0;False;0;False;0.5919976,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;2;-681.2026,166.7357;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-836.0819,61.26324;Inherit;False;Property;_Width;Width;2;0;Create;True;0;0;0;False;0;False;0.249203;0.1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;15;-517.1522,-166.4345;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;-675.5132,-564.647;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;1,0,0.1089005,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;8;-492.0403,160.7302;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;-342.9808,-205.6033;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;11;-515.8263,-748.0991;Inherit;False;Constant;_Color1;Color 1;1;0;Create;True;0;0;0;False;0;False;0,1,0.02711678,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;9;-60.75278,-161.9543;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FloorOpNode;7;-1513.169,-291.5047;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;6;-1832.751,-291.423;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;5;-1664.032,-289.9681;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;182.5887,-327.1379;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;BooksShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;1;1
WireConnection;21;1;20;0
WireConnection;13;0;1;1
WireConnection;13;1;19;0
WireConnection;3;0;21;0
WireConnection;3;1;4;0
WireConnection;14;0;13;0
WireConnection;2;0;3;0
WireConnection;15;0;14;0
WireConnection;15;1;16;0
WireConnection;8;0;12;0
WireConnection;8;1;2;0
WireConnection;18;0;10;0
WireConnection;18;1;17;0
WireConnection;18;2;15;0
WireConnection;9;0;11;0
WireConnection;9;1;18;0
WireConnection;9;2;8;0
WireConnection;0;15;9;0
ASEEND*/
//CHKSM=49E348A070BB9B527AA96F1B1D1739ADF1772E20