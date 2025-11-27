// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( PPShadesmarPPSRenderer ), PostProcessEvent.AfterStack, "PPShadesmar", true )]
public sealed class PPShadesmarPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Screen" )]
	public TextureParameter _MainTex = new TextureParameter {  };
	[Tooltip( "Texture Sample 0" )]
	public TextureParameter _TextureSample0 = new TextureParameter {  };
	[Tooltip( "Float 0" )]
	public FloatParameter _Float0 = new FloatParameter { value = 15f };
}

public sealed class PPShadesmarPPSRenderer : PostProcessEffectRenderer<PPShadesmarPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "PPShadesmar" ) );
		if(settings._MainTex.value != null) sheet.properties.SetTexture( "_MainTex", settings._MainTex );
		if(settings._TextureSample0.value != null) sheet.properties.SetTexture( "_TextureSample0", settings._TextureSample0 );
		sheet.properties.SetFloat( "_Float0", settings._Float0 );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
