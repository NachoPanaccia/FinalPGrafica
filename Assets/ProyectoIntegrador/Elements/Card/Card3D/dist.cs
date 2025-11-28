using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class dist : MonoBehaviour
{
    [Header("Material y propiedad")]
    [SerializeField] private Material targetMaterial;
    [SerializeField] private string propertyName = "_Distorcion";

    [Header("Valores")]
    [SerializeField] private float offValue = 0f;
    [SerializeField] private float onValue = 1f;

    [Header("Transición")]
    [SerializeField] private float transitionTime = 0.5f;

    private bool isOn = false;
    private Coroutine transitionRoutine;

    public void Toggle()
    {
        if (targetMaterial == null)
        {
            Debug.LogWarning("No hay material asignado.");
            return;
        }

        isOn = !isOn;
        float targetValue = isOn ? onValue : offValue;

        // Si ya hay una animación en progreso, cancelarla
        if (transitionRoutine != null)
            StopCoroutine(transitionRoutine);

        transitionRoutine = StartCoroutine(SmoothTransition(targetValue));
    }

    private IEnumerator SmoothTransition(float target)
    {
        float start = targetMaterial.GetFloat(propertyName);
        float t = 0f;

        while (t < transitionTime)
        {
            t += Time.deltaTime;
            float lerpValue = Mathf.Lerp(start, target, t / transitionTime);
            targetMaterial.SetFloat(propertyName, lerpValue);
            yield return null;
        }

        // Aseguramos que llega EXACTO al valor final
        targetMaterial.SetFloat(propertyName, target);
    }
}
