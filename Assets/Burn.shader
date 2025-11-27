// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Burn"
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
		_BurnAmount("BurnAmount", Float) = 1
		_EmberSize("EmberSize", Float) = 0.95
		_CharSize("CharSize", Float) = -0.96
		_CharColor("CharColor", Color) = (0.3584906,0.3584906,0.3584906,0)
		_EmberColor("EmberColor", Color) = (0.6698113,0,0,0)
		_Texture0("Texture 0", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "white" {}
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
			uniform float4 _EmberColor;
			uniform float4 _CharColor;
			uniform sampler2D _Texture1;
			uniform float4 _Texture1_ST;
			uniform float _BurnAmount;
			uniform float _CharSize;
			uniform float _EmberSize;
			uniform sampler2D _Texture0;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				
				
				OUT.worldPosition.xyz +=  float3( 0, 0, 0 ) ;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 uv_Texture1 = IN.texcoord.xy * _Texture1_ST.xy + _Texture1_ST.zw;
				float burnLevel103 = ( 1.0 - _BurnAmount );
				float2 texCoord78 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float4 tex2DNode70 = tex2D( _Texture0, texCoord78 );
				float smoothstepResult87 = smoothstep( ( burnLevel103 + _CharSize + _EmberSize ) , ( burnLevel103 + _EmberSize ) , tex2DNode70.r);
				float CharMask90 = smoothstepResult87;
				float4 lerpResult92 = lerp( _CharColor , tex2D( _Texture1, uv_Texture1 ) , CharMask90);
				float smoothstepResult80 = smoothstep( burnLevel103 , ( burnLevel103 + 0.28 ) , tex2DNode70.r);
				float AlphaMask83 = smoothstepResult80;
				float4 lerpResult95 = lerp( _EmberColor , lerpResult92 , AlphaMask83);
				float4 RGB97 = lerpResult95;
				float4 appendResult98 = (float4(RGB97.rgb , AlphaMask83));
				
				half4 color = appendResult98;
				
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
11;95;1352;701;3697.3;712.2084;3.038965;True;False
Node;AmplifyShaderEditor.RangedFloatNode;71;-3100.45,-176.7089;Inherit;False;Property;_BurnAmount;BurnAmount;0;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;78;-3353.78,329.7397;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;77;-3425.05,103.226;Inherit;True;Property;_Texture0;Texture 0;5;0;Create;True;0;0;0;False;0;False;265ead83dd51f3d4fb751baa472e5f19;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.OneMinusNode;79;-2917.978,-173.7964;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;70;-2955.106,135.9011;Inherit;True;Property;_Noise;Noise;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;103;-2762.316,-167.0552;Inherit;False;burnLevel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;100;-2531.213,-192.1253;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-2386.171,-77.6309;Inherit;False;Property;_CharSize;CharSize;2;0;Create;True;0;0;0;False;0;False;-0.96;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;-2380.161,-154.1071;Inherit;False;103;burnLevel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-2424.964,58.17908;Inherit;False;Property;_EmberSize;EmberSize;1;0;Create;True;0;0;0;False;0;False;0.95;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;105;-2226.45,4.586718;Inherit;False;103;burnLevel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;101;-2091.837,-202.0753;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;-2197.875,-137.2104;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;109;-2559.099,442.8093;Inherit;False;103;burnLevel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;-2060.591,9.577104;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;82;-2352.413,443.1891;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.28;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;110;-2497.455,286.3665;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-2401.251,367.7671;Inherit;False;103;burnLevel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;87;-1910.801,-84.95144;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-1703.478,-26.86531;Inherit;False;CharMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;91;-502.5881,-183.7231;Inherit;True;Property;_Texture1;Texture 1;6;0;Create;True;0;0;0;False;0;False;8aba6bb20faf8824d9d81946542f1ce1;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SmoothstepOpNode;80;-2031.758,308.2942;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;69;-260.3153,-185.9866;Inherit;True;Property;_Main;Main;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-1763.088,318.3209;Inherit;False;AlphaMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;-255.3564,242.583;Inherit;False;90;CharMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;73;-302.4255,63.73447;Inherit;False;Property;_CharColor;CharColor;3;0;Create;True;0;0;0;False;0;False;0.3584906,0.3584906,0.3584906,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;72;-53.20274,360.751;Inherit;False;Property;_EmberColor;EmberColor;4;0;Create;True;0;0;0;False;0;False;0.6698113,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;96;-30.91839,538.6528;Inherit;False;83;AlphaMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;92;32.90821,75.29852;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;95;286.3071,363.3748;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;97;527.3795,357.5745;Inherit;False;RGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;541.169,445.8663;Inherit;False;83;AlphaMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;86;-1678.052,120.9394;Inherit;False;EmberMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;84;-1904.684,83.07638;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;-2129.696,228.2322;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-2134.162,157.021;Inherit;False;103;burnLevel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;98;779.9424,361.4396;Inherit;True;COLOR;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;108;-2365.235,219.9688;Inherit;False;103;burnLevel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;66;1041.288,362.8429;Float;False;True;-1;2;ASEMaterialInspector;0;4;Custom/Burn;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;79;0;71;0
WireConnection;70;0;77;0
WireConnection;70;1;78;0
WireConnection;103;0;79;0
WireConnection;100;0;70;1
WireConnection;101;0;100;0
WireConnection;89;0;104;0
WireConnection;89;1;75;0
WireConnection;89;2;74;0
WireConnection;88;0;105;0
WireConnection;88;1;74;0
WireConnection;82;0;109;0
WireConnection;110;0;70;1
WireConnection;87;0;101;0
WireConnection;87;1;89;0
WireConnection;87;2;88;0
WireConnection;90;0;87;0
WireConnection;80;0;110;0
WireConnection;80;1;107;0
WireConnection;80;2;82;0
WireConnection;69;0;91;0
WireConnection;83;0;80;0
WireConnection;92;0;73;0
WireConnection;92;1;69;0
WireConnection;92;2;93;0
WireConnection;95;0;72;0
WireConnection;95;1;92;0
WireConnection;95;2;96;0
WireConnection;97;0;95;0
WireConnection;86;0;84;0
WireConnection;84;0;70;1
WireConnection;84;1;106;0
WireConnection;84;2;85;0
WireConnection;85;0;74;0
WireConnection;85;1;108;0
WireConnection;98;0;97;0
WireConnection;98;3;99;0
WireConnection;66;0;98;0
ASEEND*/
//CHKSM=8250B209704FEE7C08E3AA77F13DE9647902D5C2