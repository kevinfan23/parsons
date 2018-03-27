using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Orbit : MonoBehaviour {

	private float OrbitRadius;
	private float OrbitSpeed;
	private float Angle = 0;
	private Vector3 pos = new Vector3 ();
	private Vector3 NoiseIndex = new Vector3();


	public Transform Center; // MUST BE ASSIGNED IN EDITOR
	public Vector3 RotateSpeed = new Vector3 (10.0F, 10.0F, 10.0F);
	public Vector3 WobbleAmount = new Vector3 (0.1F, 0.1F, 0.1F);
	public Vector3 WobbleSpeed = new Vector3 (0.5F, 0.5F, 0.5F);
	

	void Awake() {
		// Calculate the OrbitRadius and OrbitSpeed based on the distance from the center
		Vector2 a = new Vector2 (Center.position.x, Center.position.z);
		Vector2 b = new Vector2 (transform.position.x, transform.position.z);
		OrbitRadius = Vector2.Distance (a, b);
		OrbitSpeed = OrbitRadius * 0.25F;
	}

	// Use this for initialization
	void Start () {
		pos = transform.position;
		Angle = Random.Range (0, Mathf.PI * 2.0F);
		NoiseIndex.x = Random.value;
		NoiseIndex.y = Random.value;
		NoiseIndex.z = Random.value;
	}
	
	// Update is called once per frame
	void Update () {
		// Rotate using the defined RotateSpeed
		transform.Rotate (Time.deltaTime * RotateSpeed);

		// Calculate the orbital position. Just a little bit 'o trigonometry
		pos.x = Center.position.x + Mathf.Cos (Angle) * OrbitRadius;
		pos.z = Center.position.z + Mathf.Sin (Angle) * OrbitRadius;

		// Calculate a noise-based offset vector 
		// This will be added to the calculated orbit position
		Vector3 offset = new Vector3 ();
		offset.x = Mathf.PerlinNoise (NoiseIndex.x, 0) - 0.5F;
		offset.y = Mathf.PerlinNoise (NoiseIndex.y, 0) - 0.5F;
		offset.z = Mathf.PerlinNoise (NoiseIndex.z, 0) - 0.5F;
		offset.Scale (WobbleAmount);

		// Assign the new position
		transform.position = pos + offset;

		// Increment stuff
		Angle += Time.deltaTime * OrbitSpeed;
		NoiseIndex += WobbleSpeed * Time.deltaTime;
	}

	void OnDrawGizmos() {
		Gizmos.color = Color.yellow;
		Gizmos.DrawWireSphere (Center.position, OrbitRadius);
	}
}
