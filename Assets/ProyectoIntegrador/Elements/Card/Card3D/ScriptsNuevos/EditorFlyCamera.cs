using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EditorFlyCamera : MonoBehaviour
{
    [Header("Movimiento")]
    public float moveSpeed = 10f;

    [Header("Rotación con botón derecho")]
    public float mouseSensitivity = 3f;
    public float minPitch = -89f;
    public float maxPitch = 89f;

    private float yaw;   // rotación horizontal
    private float pitch; // rotación vertical

    void Start()
    {
        // Inicializamos yaw/pitch a la rotación actual de la cámara
        Vector3 angles = transform.eulerAngles;
        yaw = angles.y;
        pitch = angles.x;
    }

    void Update()
    {
        HandleRotation();
        HandleMovement();
    }

    void HandleRotation()
    {
        // Sólo rotamos si se mantiene presionado el botón derecho
        if (Input.GetMouseButton(1))
        {
            // Opcional: bloquear el cursor mientras se rota
            Cursor.lockState = CursorLockMode.Locked;
            Cursor.visible = false;

            float mouseX = Input.GetAxis("Mouse X");
            float mouseY = Input.GetAxis("Mouse Y");

            yaw += mouseX * mouseSensitivity;
            pitch -= mouseY * mouseSensitivity; // invertido para sentirse "FPS"

            pitch = Mathf.Clamp(pitch, minPitch, maxPitch);

            transform.rotation = Quaternion.Euler(pitch, yaw, 0f);
        }
        else
        {
            // Volvemos el cursor a la normalidad cuando soltás el botón
            Cursor.lockState = CursorLockMode.None;
            Cursor.visible = true;
        }
    }

    void HandleMovement()
    {
        Vector3 direction = Vector3.zero;

        // Adelante / Atrás
        if (Input.GetKey(KeyCode.W))
            direction += transform.forward;
        if (Input.GetKey(KeyCode.S))
            direction -= transform.forward;

        // Izquierda / Derecha
        if (Input.GetKey(KeyCode.A))
            direction -= transform.right;
        if (Input.GetKey(KeyCode.D))
            direction += transform.right;

        // Arriba / Abajo
        if (Input.GetKey(KeyCode.Space))
            direction += Vector3.up;
        if (Input.GetKey(KeyCode.LeftShift))
            direction -= Vector3.up;

        if (direction.sqrMagnitude > 0.001f)
        {
            direction.Normalize();
            transform.position += direction * moveSpeed * Time.deltaTime;
        }
    }
}