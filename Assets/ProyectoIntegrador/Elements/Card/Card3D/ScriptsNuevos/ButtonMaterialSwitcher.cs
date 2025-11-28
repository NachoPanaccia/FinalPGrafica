using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonMaterialSwitcher : MonoBehaviour
{
    [Header("Botón al que le vamos a cambiar el material")]
    [SerializeField] private Image targetImage;

    [Header("Materiales entre los que vamos a ciclar")]
    [SerializeField] private Material[] materials;

    private int currentIndex = 0;

    // Llamá a este método desde el OnClick del botón
    public void SwitchMaterial()
    {
        if (targetImage == null || materials == null || materials.Length == 0)
        {
            Debug.LogWarning("ButtonMaterialSwitcher: faltan referencias o materiales.");
            return;
        }

        // Avanzamos al siguiente índice y volvemos a 0 si nos pasamos
        currentIndex = (currentIndex + 1) % materials.Length;

        // Asignamos el material al otro botón
        targetImage.material = materials[currentIndex];
    }
}
