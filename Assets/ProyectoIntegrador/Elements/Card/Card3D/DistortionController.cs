using UnityEngine;

public class Rotate : MonoBehaviour
{
    [Tooltip("Material Shader Mask Number")]
    public int maskNumber = 1;

    [Tooltip("Horizontal Rotation Speed")]
    [Range(-1, 1)]
    public float rotationSpeedH = 0.7f;

    [Tooltip("Vertical Rotation Speed")]
    [Range(-1, 1)]
    public float rotationSpeedV = 0.4f;

    [Tooltip("Maximum Horizontal Angle")]
    [Range(0, 60)]
    public float angleH = 20;

    [Tooltip("Maximum Vertical Angle")]
    [Range(0, 60)]
    public float angleV = 8;

    [Tooltip("¿Respetar la rotación inicial del objeto?")]
    public bool respetarRotacionInicial = true;

    private float rotationCounter = 0;
    private Quaternion rotacionInicial;
    private Transform windowTransform;
    private Transform worldTransform;

    private void Awake()
    {
        windowTransform = transform.GetChild(1);
        worldTransform = transform.GetChild(2);

        if (respetarRotacionInicial)
            rotacionInicial = transform.rotation;

        SetStencilMask(maskNumber);
    }

    void Update()
    {
        rotationCounter += Time.deltaTime;

        Quaternion rotacionOffset = Quaternion.Euler(
            Mathf.Sin(rotationCounter * rotationSpeedV) * angleV,
            Mathf.Sin(rotationCounter * rotationSpeedH) * angleH,
            0
        );

        if (respetarRotacionInicial)
            transform.rotation = rotacionInicial * rotacionOffset;
        else
            transform.rotation = rotacionOffset;
    }

    public void SetStencilMask(int maskNumber)
    {
        this.maskNumber = maskNumber;

        if (windowTransform != null)
            windowTransform.GetComponent<Renderer>().material.SetFloat("_StencilMask", maskNumber);

        foreach (Transform worldObject in worldTransform.GetComponentInChildren<Transform>())
        {
            Renderer renderer = worldObject.GetComponent<Renderer>();
            if (renderer != null)
            {
                foreach (Material material in renderer.materials)
                {
                    material.SetFloat("_StencilMask", maskNumber);
                }
            }
        }
    }
}


