using UnityEngine;
using UnityEngine.UI;

public class CardShaderController : MonoBehaviour
{
    [Header("Renderer de la carta")]
    [SerializeField] private Renderer cardRenderer;

    [Header("Nombres de propiedades del shader")]
    [SerializeField] private string textureTilingProperty = "TextureTiling";
    [SerializeField] private string distortionWeightProperty = "DistortionWeight";
    [SerializeField] private string pannerSpeedProperty = "PannerSpeed";

    [Header("Sliders UI")]
    [SerializeField] private Slider textureTilingSlider;
    [SerializeField] private Slider distortionWeightSlider;
    [SerializeField] private Slider pannerSpeedSlider;

    private Material cardMaterialInstance;

    private void Awake()
    {
        // Crea una instancia del material para no modificar el asset original
        cardMaterialInstance = cardRenderer.material;

        // Opcional: inicializar sliders con los valores actuales del material
        if (textureTilingSlider != null)
            textureTilingSlider.value = cardMaterialInstance.GetFloat(textureTilingProperty);

        if (distortionWeightSlider != null)
            distortionWeightSlider.value = cardMaterialInstance.GetFloat(distortionWeightProperty);

        if (pannerSpeedSlider != null)
            pannerSpeedSlider.value = cardMaterialInstance.GetFloat(pannerSpeedProperty);
    }

    // Estas funciones las va a llamar cada slider desde el evento OnValueChanged
    public void OnTextureTilingChanged(float value)
    {
        cardMaterialInstance.SetFloat(textureTilingProperty, value);
    }

    public void OnDistortionWeightChanged(float value)
    {
        cardMaterialInstance.SetFloat(distortionWeightProperty, value);
    }

    public void OnPannerSpeedChanged(float value)
    {
        cardMaterialInstance.SetFloat(pannerSpeedProperty, value);
    }
}
