// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Acid"
{
	Properties
	{
		_Float1("Float 1", Float) = 1
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 15
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Float1;
		uniform float _TessValue;


		//https://www.shadertoy.com/view/XdXGW8
		float2 GradientNoiseDir( float2 x )
		{
			const float2 k = float2( 0.3183099, 0.3678794 );
			x = x * k + k.yx;
			return -1.0 + 2.0 * frac( 16.0 * k * frac( x.x * x.y * ( x.x + x.y ) ) );
		}
		
		float GradientNoise( float2 UV, float Scale )
		{
			float2 p = UV * Scale;
			float2 i = floor( p );
			float2 f = frac( p );
			float2 u = f * f * ( 3.0 - 2.0 * f );
			return lerp( lerp( dot( GradientNoiseDir( i + float2( 0.0, 0.0 ) ), f - float2( 0.0, 0.0 ) ),
					dot( GradientNoiseDir( i + float2( 1.0, 0.0 ) ), f - float2( 1.0, 0.0 ) ), u.x ),
					lerp( dot( GradientNoiseDir( i + float2( 0.0, 1.0 ) ), f - float2( 0.0, 1.0 ) ),
					dot( GradientNoiseDir( i + float2( 1.0, 1.0 ) ), f - float2( 1.0, 1.0 ) ), u.x ), u.y );
		}


		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float mulTime48 = _Time.y * 0.3;
			float2 temp_cast_0 = (( mulTime48 * _Float1 )).xx;
			float2 uv_TexCoord12 = v.texcoord.xy + temp_cast_0;
			float gradientNoise1 = GradientNoise(uv_TexCoord12,10.0);
			gradientNoise1 = gradientNoise1*0.5 + 0.5;
			v.vertex.xyz += float3( ( gradientNoise1 * 2.5 * float2( 0,0.4 ) ) ,  0.0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color8 = IsGammaSpace() ? float4(0.3005355,0.7647059,0.01802243,0) : float4(0.07350438,0.5457246,0.001394925,0);
			float4 color9 = IsGammaSpace() ? float4(0.06004083,0.2641509,0.008721969,0) : float4(0.004900483,0.05672633,0.000675075,0);
			float mulTime48 = _Time.y * 0.3;
			float2 temp_cast_0 = (( mulTime48 * _Float1 )).xx;
			float2 uv_TexCoord12 = i.uv_texcoord + temp_cast_0;
			float gradientNoise1 = GradientNoise(uv_TexCoord12,10.0);
			gradientNoise1 = gradientNoise1*0.5 + 0.5;
			float4 lerpResult24 = lerp( color8 , color9 , ( gradientNoise1 * 1.55 ));
			o.Albedo = lerpResult24.rgb;
			o.Emission = lerpResult24.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17200
483;545;1272;446;1235.064;258.9834;1.596311;True;False
Node;AmplifyShaderEditor.RangedFloatNode;29;-938.5576,-53.15556;Inherit;False;Property;_Float1;Float 1;0;0;Create;True;0;0;False;0;1;0.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;48;-941.6897,-146.7067;Inherit;False;1;0;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-760.313,-133.973;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-606.0592,-203.6171;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;-512.0094,73.11466;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1;-353.6485,-35.46569;Inherit;True;Gradient;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-62.80483,31.47325;Inherit;False;Constant;_Float3;Float 3;2;0;Create;True;0;0;False;0;1.55;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;-333.6757,-238.1875;Inherit;False;Constant;_Color1;Color 1;1;0;Create;True;0;0;False;0;0.06004083,0.2641509,0.008721969,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-325.6432,-430.2258;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;0.3005355,0.7647059,0.01802243,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;106.6669,-33.3277;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-264.9951,183.6314;Inherit;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;False;0;2.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;51;-262.4503,262.545;Inherit;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;False;0;0,0.4;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-49.78059,155.2406;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;24;267.4144,-136.9654;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;525.9017,-135.2104;Float;False;True;6;ASEMaterialInspector;0;0;Standard;Acid;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;47;0;48;0
WireConnection;47;1;29;0
WireConnection;12;1;47;0
WireConnection;1;0;12;0
WireConnection;1;1;28;0
WireConnection;54;0;1;0
WireConnection;54;1;55;0
WireConnection;49;0;1;0
WireConnection;49;1;50;0
WireConnection;49;2;51;0
WireConnection;24;0;8;0
WireConnection;24;1;9;0
WireConnection;24;2;54;0
WireConnection;0;0;24;0
WireConnection;0;2;24;0
WireConnection;0;11;49;0
ASEEND*/
//CHKSM=03D657942359095DDB3BC95E9EE1981920D2A6C6