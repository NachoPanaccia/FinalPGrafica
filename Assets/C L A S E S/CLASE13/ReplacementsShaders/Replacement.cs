using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class Replacement : MonoBehaviour
{
    [SerializeField] private Shader replacementShader;
    private void OnEnable()
    {
        GetComponent<Camera>().SetReplacementShader(replacementShader, "Custom");
    }

    private void OnDisable()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }
}
