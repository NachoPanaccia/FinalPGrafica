// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WorldSpaceUV"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Float0("Float 0", Float) = 0
		_Float4("Float 4", Float) = 0
		_Float1("Float 1", Float) = 0
		_Float3("Float 3", Range( 0 , 1)) = 0
		_Float2("Float 2", Float) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
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
			float3 worldPos;
		};

		uniform sampler2D _TextureSample0;
		uniform float _Float0;
		uniform sampler2D _TextureSample1;
		uniform float _Float4;
		uniform float _Float1;
		uniform float _Float2;
		uniform float _Float3;


		float2 voronoihash8( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi8( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash8( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float4 appendResult3 = (float4(ase_worldPos.x , ase_worldPos.y , 0.0 , 0.0));
			float time8 = _Float2;
			float2 coords8 = appendResult3.xy * _Float1;
			float2 id8 = 0;
			float2 uv8 = 0;
			float fade8 = 0.5;
			float voroi8 = 0;
			float rest8 = 0;
			for( int it8 = 0; it8 <5; it8++ ){
			voroi8 += fade8 * voronoi8( coords8, time8, id8, uv8, 0 );
			rest8 += fade8;
			coords8 *= 2;
			fade8 *= 0.5;
			}//Voronoi8
			voroi8 /= rest8;
			float4 lerpResult15 = lerp( tex2D( _TextureSample0, ( appendResult3 * _Float0 ).xy ) , tex2D( _TextureSample1, ( appendResult3 * _Float4 ).xy ) , step( ( 1.0 - voroi8 ) , _Float3 ));
			o.Albedo = lerpResult15.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
403;541;1102;450;1390.965;174.5436;1.959026;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;2;-998.9232,-24.0474;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;3;-745.5015,-35.47586;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-841.5601,460.1349;Inherit;False;Property;_Float2;Float 2;5;0;Create;True;0;0;0;False;0;False;0;3.95;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-834.4792,532.8673;Inherit;False;Property;_Float1;Float 1;3;0;Create;True;0;0;0;False;0;False;0;0.34;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-805.5112,308.4483;Inherit;False;Property;_Float4;Float 4;2;0;Create;True;0;0;0;False;0;False;0;0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;8;-620.6656,445.3186;Inherit;False;0;0;1;0;5;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.RangedFloatNode;4;-771.5864,139.1308;Inherit;False;Property;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;0;0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-527.7319,186.4685;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-497.7067,-2.348701;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-501.6245,636.9135;Inherit;False;Property;_Float3;Float 3;4;0;Create;True;0;0;0;False;0;False;0;0.821;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;10;-393.5399,488.2198;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-340.3303,219.0394;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;0;False;0;False;-1;None;a29156235a7a1f047b03dbb11b39f5fc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-353.3283,-55.4917;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;30aff7bf1c6dba84f93ae18cf5c9d3ce;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;12;-211.3375,533.8531;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;6;-876.5809,638.3988;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;15;170.3842,17.71306;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;394.1958,-37.40796;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;WorldSpaceUV;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;1
WireConnection;3;1;2;2
WireConnection;8;0;3;0
WireConnection;8;1;9;0
WireConnection;8;2;7;0
WireConnection;16;0;3;0
WireConnection;16;1;17;0
WireConnection;5;0;3;0
WireConnection;5;1;4;0
WireConnection;10;0;8;0
WireConnection;14;1;16;0
WireConnection;1;1;5;0
WireConnection;12;0;10;0
WireConnection;12;1;13;0
WireConnection;15;0;1;0
WireConnection;15;1;14;0
WireConnection;15;2;12;0
WireConnection;0;0;15;0
ASEEND*/
//CHKSM=149419F29F9031372FB7F9A6C3F64490C8158C0C