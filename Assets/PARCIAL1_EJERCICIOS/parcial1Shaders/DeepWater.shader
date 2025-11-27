// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DeepWater"
{
	Properties
	{
		_bias("bias", Float) = 0
		_Float1("Float 1", Float) = 0
		_scale("scale", Float) = 0
		_Float2("Float 2", Float) = 0
		_power("power", Float) = 0
		_Float3("Float 3", Float) = 0

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _bias;
			uniform float _scale;
			uniform float _power;
			uniform float _Float1;
			uniform float _Float2;
			uniform float _Float3;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord = screenPos;
				
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				float4 screenPos = i.ase_texcoord;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth2 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
				float distanceDepth2 = abs( ( screenDepth2 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
				float4 color1 = IsGammaSpace() ? float4(0.2352941,0.6117647,0.5960785,0) : float4(0.0451862,0.3324516,0.3139887,0);
				float4 color5 = IsGammaSpace() ? float4(0.1126735,0.1132075,0.1132075,0) : float4(0.01210344,0.01219616,0.01219616,0);
				float screenDepth34 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
				float distanceDepth34 = abs( ( screenDepth34 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
				float4 lerpResult48 = lerp( ( color1 * 1.3 ) , color5 , ( 1.0 - saturate( pow( ( ( distanceDepth34 + _Float1 ) * _Float2 ) , _Float3 ) ) ));
				
				
				finalColor = ( ( 1.0 - saturate( pow( ( ( distanceDepth2 + _bias ) * _scale ) , _power ) ) ) + lerpResult48 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17200
483;592;1272;399;455.4363;86.89464;1;False;False
Node;AmplifyShaderEditor.RangedFloatNode;35;-396.2653,435.9184;Inherit;False;Property;_Float1;Float 1;1;0;Create;True;0;0;False;0;0;6.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;34;-491.1985,309.0326;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-396.7411,36.18108;Inherit;False;Property;_bias;bias;0;0;Create;True;0;0;False;0;0;0.95;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;2;-495.0278,-74.23453;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-183.0517,529.3628;Inherit;False;Property;_Float2;Float 2;3;0;Create;True;0;0;False;0;0;0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-226.0894,305.3593;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;60.56999,529.1467;Inherit;False;Property;_Float3;Float 3;5;0;Create;True;0;0;False;0;0;1.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;10.1523,305.9774;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-223.7469,-75.48623;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-152.2564,138.3287;Inherit;False;Property;_scale;scale;2;0;Create;True;0;0;False;0;0;0.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;69.50642,158.6451;Inherit;False;Property;_power;power;4;0;Create;True;0;0;False;0;0;30;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;39;274.7934,305.7161;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;21.38316,-65.40816;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;13;267.3253,-60.67155;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;40;517.2125,305.0415;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;881.3782,333.7445;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;0.2352941,0.6117647,0.5960785,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;944.5012,507.2258;Inherit;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;1.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;1139.401,212.4252;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;14;515.509,-64.82481;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;41;709.0588,305.6647;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;882.3954,77.06518;Inherit;False;Constant;_Color1;Color 1;1;0;Create;True;0;0;False;0;0.1126735,0.1132075,0.1132075,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;15;687.8069,-65.69532;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;48;1365.716,59.86239;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;1610.365,-53.12169;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;26;1853.488,-57.20076;Float;False;True;2;ASEMaterialInspector;0;1;DeepWater;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;38;0;36;0
WireConnection;38;1;37;0
WireConnection;9;0;2;0
WireConnection;9;1;8;0
WireConnection;39;0;38;0
WireConnection;39;1;42;0
WireConnection;11;0;9;0
WireConnection;11;1;10;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;40;0;39;0
WireConnection;54;0;1;0
WireConnection;54;1;55;0
WireConnection;14;0;13;0
WireConnection;41;0;40;0
WireConnection;15;0;14;0
WireConnection;48;0;54;0
WireConnection;48;1;5;0
WireConnection;48;2;41;0
WireConnection;16;0;15;0
WireConnection;16;1;48;0
WireConnection;26;0;16;0
ASEEND*/
//CHKSM=E4B54B3A314D714B36450D47CB104C55CD421CD8