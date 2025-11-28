// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "UI"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_Vector1("Vector 1", Vector) = (0,0,0,0)
		_Vector2("Vector 1", Vector) = (0,0,0,0)
		_Float2("Float 2", Float) = 0.32
		_flow("flow", 2D) = "white" {}
		_flow1("flow", 2D) = "white" {}
		_ramp("ramp", 2D) = "white" {}
		_ramp1("ramp", 2D) = "white" {}
		_ramp2("ramp", 2D) = "white" {}
		_Float1("Float 1", Range( 0 , 1)) = 0.7144849
		_Texture0("Texture 0", 2D) = "white" {}
		_Texture1("Texture 0", 2D) = "white" {}
		_Texture2("Texture 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }
		
		Stencil
		{
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			CompFront [_StencilComp]
			PassFront [_StencilOp]
			FailFront Keep
			ZFailFront Keep
			CompBack Always
			PassBack Keep
			FailBack Keep
			ZFailBack Keep
		}


		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		
		Pass
		{
			Name "Default"
		CGPROGRAM
			
			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			#include "UnityShaderVariables.cginc"
			#include "UnityStandardUtils.cginc"
			#define ASE_NEEDS_FRAG_COLOR

			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform fixed4 _TextureSampleAdd;
			uniform float4 _ClipRect;
			uniform sampler2D _MainTex;
			uniform sampler2D _ramp2;
			uniform sampler2D _Texture2;
			uniform float4 _MainTex_ST;
			uniform sampler2D _Texture0;
			uniform sampler2D _Texture1;
			uniform float2 _Vector1;
			uniform float _Float2;
			uniform float _Float1;
			uniform float2 _Vector2;
			uniform sampler2D _ramp;
			uniform sampler2D _flow;
			uniform float4 _flow_ST;
			uniform sampler2D _ramp1;
			uniform sampler2D _flow1;
			uniform float4 _flow1_ST;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				float2 texCoord41 = IN.texcoord.xy * float2( 1,2 ) + float2( -0.5,-0.5 );
				
				
				OUT.worldPosition.xyz += float3( ( sin( _Time.y ) * 10.0 * texCoord41 ) ,  0.0 );
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float4 appendResult35 = (float4(float2( 0.23,0.35 ) , float2( 0.33,0.68 )));
				float4 temp_output_57_0_g4 = appendResult35;
				float2 temp_output_2_0_g4 = (temp_output_57_0_g4).zw;
				float2 temp_cast_0 = (1.0).xx;
				float2 temp_output_13_0_g4 = ( ( ( IN.texcoord.xy + (temp_output_57_0_g4).xy ) * temp_output_2_0_g4 ) + -( ( temp_output_2_0_g4 - temp_cast_0 ) * 0.5 ) );
				float TimeVar197_g4 = _Time.y;
				float cos17_g4 = cos( TimeVar197_g4 );
				float sin17_g4 = sin( TimeVar197_g4 );
				float2 rotator17_g4 = mul( temp_output_13_0_g4 - float2( 0.5,0.5 ) , float2x2( cos17_g4 , -sin17_g4 , sin17_g4 , cos17_g4 )) + float2( 0.5,0.5 );
				float4 tex2DNode97_g4 = tex2D( _ramp2, rotator17_g4 );
				float temp_output_115_0_g4 = step( ( (temp_output_13_0_g4).y + -0.5 ) , 0.0 );
				float lerpResult125_g4 = lerp( 1.0 , tex2D( _Texture2, IN.texcoord.xy ).g , ( 1.0 - temp_output_115_0_g4 ));
				float2 uv_MainTex = IN.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 temp_output_192_0_g1 = ( tex2D( _MainTex, uv_MainTex ) * IN.color );
				float TimeVar197_g1 = _Time.y;
				float2 temp_cast_1 = (_Float2).xx;
				float2 texCoord12 = IN.texcoord.xy * float2( 1,1 ) + temp_cast_1;
				float2 MainUvs222_g1 = texCoord12;
				float4 tex2DNode65_g1 = tex2D( _Texture1, ( ( _Vector1 * TimeVar197_g1 ) + MainUvs222_g1 ) );
				float4 appendResult82_g1 = (float4(0.0 , tex2DNode65_g1.g , 0.0 , tex2DNode65_g1.r));
				float2 temp_output_84_0_g1 = (UnpackScaleNormal( appendResult82_g1, _Float1 )).xy;
				float2 panner179_g1 = ( 1.0 * _Time.y * _Vector2 + MainUvs222_g1);
				float2 temp_output_71_0_g1 = ( temp_output_84_0_g1 + panner179_g1 );
				float4 tex2DNode96_g1 = tex2D( _Texture0, temp_output_71_0_g1 );
				float2 uv_Texture2232_g1 = IN.texcoord.xy;
				float4 temp_output_192_0_g2 = ( temp_output_192_0_g1 + ( ( tex2DNode96_g1 * tex2DNode96_g1.a * tex2D( _Texture2, uv_Texture2232_g1 ).g ) * (temp_output_192_0_g1).a ) );
				float2 uv_flow = IN.texcoord.xy * _flow_ST.xy + _flow_ST.zw;
				float4 tex2DNode14_g2 = tex2D( _flow, uv_flow );
				float2 appendResult20_g2 = (float2(tex2DNode14_g2.r , tex2DNode14_g2.g));
				float TimeVar197_g2 = _Time.y;
				float2 temp_cast_2 = (TimeVar197_g2).xx;
				float2 temp_output_18_0_g2 = ( appendResult20_g2 - temp_cast_2 );
				float4 tex2DNode72_g2 = tex2D( _ramp, temp_output_18_0_g2 );
				float4 color22 = IsGammaSpace() ? float4(0,1,0.1466861,0) : float4(0,1,0.01885455,0);
				float4 temp_output_192_0_g3 = ( temp_output_192_0_g2 + ( ( tex2DNode72_g2 * color22 ) * (temp_output_192_0_g2).a ) );
				float2 uv_flow1 = IN.texcoord.xy * _flow1_ST.xy + _flow1_ST.zw;
				float4 tex2DNode14_g3 = tex2D( _flow1, uv_flow1 );
				float2 appendResult20_g3 = (float2(tex2DNode14_g3.r , tex2DNode14_g3.g));
				float mulTime29 = _Time.y * 2.0;
				float2 temp_output_18_0_g3 = ( appendResult20_g3 - ( float2( 1.35,-0.1 ) * mulTime29 ) );
				float4 tex2DNode72_g3 = tex2D( _ramp1, temp_output_18_0_g3 );
				float4 temp_output_192_0_g4 = ( temp_output_192_0_g3 + ( tex2DNode72_g3 * (temp_output_192_0_g3).a ) );
				
				half4 color = ( ( ( tex2DNode97_g4 * lerpResult125_g4 * tex2DNode97_g4.a ) * float4( 1,1,1,1 ) ) + temp_output_192_0_g4 );
				
				#ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif
				
				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
525;545;957;446;-2423.953;-116.3828;1;True;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-1247.179,-967.2322;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-1082.94,-471.9935;Inherit;False;Property;_Float2;Float 2;9;0;Create;True;0;0;0;False;0;False;0.32;0.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1024.341,-959.699;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;9527ff032ead1d74fac657e258987ac3;9527ff032ead1d74fac657e258987ac3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;5;-873.8781,-663.5449;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;14;-628.8778,271.7111;Inherit;True;Property;_Texture2;Texture 0;19;0;Create;True;0;0;0;False;0;False;None;0ea894cfed2f38a4da488836b164a09b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.Vector2Node;16;-658.3442,-189.305;Inherit;False;Property;_Vector2;Vector 1;8;0;Create;True;0;0;0;False;0;False;0,0;0.17,0.09;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;9;-669.0203,186.2934;Inherit;False;Property;_Float1;Float 1;15;0;Create;True;0;0;0;False;0;False;0.7144849;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-939.9893,-472.649;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;8;-752.2274,-391.1288;Inherit;True;Property;_Texture1;Texture 0;18;0;Create;True;0;0;0;False;0;False;None;ef86fa2adc0f70f40a9965c28ce247dc;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-591.7072,-827.5844;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;7;-629.9391,-629.0557;Inherit;True;Property;_Texture0;Texture 0;16;0;Create;True;0;0;0;False;0;False;None;92d7a5c6f6f75d246b3d55804b56c5cb;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.Vector2Node;15;-554.9017,-31.34039;Inherit;False;Property;_Vector1;Vector 1;7;0;Create;True;0;0;0;False;0;False;0,0;0.02,-0.03;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;29;1396.363,399.6368;Inherit;False;1;0;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;18;381.8647,146.0751;Inherit;True;Property;_flow;flow;10;0;Create;True;0;0;0;False;0;False;None;8dc8eb8a21980a149b519fc67c377fc2;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;19;263.0132,-54.09425;Inherit;True;Property;_ramp;ramp;12;0;Create;True;0;0;0;False;0;False;None;02f71419854c0d845a930c9e0a0bf775;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;6;-103.5431,-434.0972;Inherit;False;UI-Sprite Effect Layer;0;;1;789bf62641c5cfe4ab7126850acc22b8;18,74,0,204,0,191,0,225,1,242,0,237,0,249,0,186,0,177,1,182,1,229,1,92,0,98,0,234,0,126,0,129,1,130,0,31,2;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.ColorNode;22;212.7264,-248.5382;Inherit;False;Constant;_Color0;Color 0;12;0;Create;True;0;0;0;False;0;False;0,1,0.1466861,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;26;1386.09,239.1024;Inherit;False;Constant;_Vector3;Vector 3;15;0;Create;True;0;0;0;False;0;False;1.35,-0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;24;1380.249,-167.4064;Inherit;True;Property;_ramp1;ramp;13;0;Create;True;0;0;0;False;0;False;None;0000000000000000f000000000000000;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;1609.475,220.1121;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;25;1353.1,14.56299;Inherit;True;Property;_flow1;flow;11;0;Create;True;0;0;0;False;0;False;None;8dc8eb8a21980a149b519fc67c377fc2;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleTimeNode;42;2731.953,261.3828;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;34;2273.056,156.2779;Inherit;False;Constant;_Vector5;Vector 5;17;0;Create;True;0;0;0;False;0;False;0.33,0.68;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;17;768.977,-265.7597;Inherit;False;UI-Sprite Effect Layer;0;;2;789bf62641c5cfe4ab7126850acc22b8;18,74,1,204,1,191,1,225,0,242,0,237,0,249,0,186,0,177,0,182,0,229,0,92,0,98,0,234,0,126,0,129,1,130,0,31,2;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.Vector2Node;36;2269.985,-5.340851;Inherit;False;Constant;_Vector4;Vector 4;17;0;Create;True;0;0;0;False;0;False;0.23,0.35;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SinOpNode;43;2949.953,233.3828;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;23;1720.734,-256.9507;Inherit;False;UI-Sprite Effect Layer;0;;3;789bf62641c5cfe4ab7126850acc22b8;18,74,1,204,1,191,0,225,0,242,0,237,0,249,1,186,0,177,0,182,0,229,0,92,0,98,0,234,0,126,0,129,1,130,0,31,2;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.DynamicAppendNode;35;2475.985,32.65915;Inherit;True;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;32;2242.396,-196.366;Inherit;True;Property;_ramp2;ramp;14;0;Create;True;0;0;0;False;0;False;None;5871304d44459a5458854a2efc5dbc4c;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;2936.473,-84.31658;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,2;False;1;FLOAT2;-0.5,-0.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;40;2909.006,380.2048;Inherit;False;Constant;_Float3;Float 3;17;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;3184.215,218.7238;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;21;166.3758,402.7225;Inherit;True;Property;_TextureSample1;Texture Sample 1;17;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;30;2657.607,-248.6072;Inherit;False;UI-Sprite Effect Layer;0;;4;789bf62641c5cfe4ab7126850acc22b8;18,74,2,204,2,191,1,225,0,242,0,237,0,249,1,186,0,177,0,182,0,229,0,92,0,98,1,234,0,126,0,129,1,130,1,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;3410.8,-339.7751;Float;False;True;-1;2;ASEMaterialInspector;0;5;UI;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;2;0;1;0
WireConnection;12;1;13;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
WireConnection;6;192;3;0
WireConnection;6;37;7;0
WireConnection;6;218;12;0
WireConnection;6;181;16;0
WireConnection;6;75;8;0
WireConnection;6;80;9;0
WireConnection;6;183;15;0
WireConnection;6;233;14;0
WireConnection;28;0;26;0
WireConnection;28;1;29;0
WireConnection;17;192;6;0
WireConnection;17;39;22;0
WireConnection;17;37;19;0
WireConnection;17;33;18;0
WireConnection;43;0;42;0
WireConnection;23;192;17;0
WireConnection;23;37;24;0
WireConnection;23;33;25;0
WireConnection;23;248;28;0
WireConnection;35;0;36;0
WireConnection;35;2;34;0
WireConnection;39;0;43;0
WireConnection;39;1;40;0
WireConnection;39;2;41;0
WireConnection;30;192;23;0
WireConnection;30;37;32;0
WireConnection;30;101;14;0
WireConnection;30;57;35;0
WireConnection;0;0;30;0
WireConnection;0;1;39;0
ASEEND*/
//CHKSM=3EF4D96C7F1EA4CEE3FFBBF3ED70233110AABECA