using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/**
 * Lessons:
 * 1. Scripts are mini-programs that operate on a GameObject in your scene.
 * 2. How to get a component of the GameObject this script is attached to?
 * 3. How to modify that component over time.
 * 4. FIX IN CLASS: There is actually a shortcut to get the transform of the GameObject.
 **/


public class Hover : MonoBehaviour {

	[Header("Rotate")]
	public bool Rotate = false;
	public Vector3 RotateSpeed = new Vector3 (10.0F, 10.0F, 10.0F);

	[Header("Float")]
	public bool Float = true;
	public Vector3 FloatAmount = new Vector3 (0.1F, 0.1F, 0.1F);
	public Vector3 FloatSpeed = new Vector3 (0.5F, 0.5F, 0.5F);



	// Private variables do not show up in the Inspector
	private Transform tr;
	private Vector3 BasePosition;
	private Vector3 NoiseIndex = new Vector3();


	// Use this for initialization
	void Start () {
		
		// https://docs.unity3d.com/ScriptReference/GameObject.GetComponent.html
		tr = GetComponent ("Transform") as Transform;

		if(Rotate)
			tr.rotation = Random.rotation;


		BasePosition = tr.position;

		NoiseIndex.x = Random.value;
		NoiseIndex.y = Random.value;
		NoiseIndex.z = Random.value;
	}
	
	// Update is called once per frame
	void Update () {

		// 1. ROTATE
		// Rotate the cube by RotateSpeed, multiplied by the fraction of a second that has passed.
		// In other words, we want to rotate by the full amount over 1 second
		if (Rotate) {
			tr.Rotate (Time.deltaTime * RotateSpeed);
		}

		if (Float) {
			// 2. Float
			// Calculate how much to offset the cube from it's base position using PerlinNoise
			Vector3 offset = new Vector3 ();
			offset.x = Mathf.PerlinNoise (NoiseIndex.x, 0) - 0.5F;
			offset.y = Mathf.PerlinNoise (NoiseIndex.y, 0) - 0.5F;
			offset.z = Mathf.PerlinNoise (NoiseIndex.z, 0) - 0.5F;

			offset.Scale (FloatAmount);

			// Set the position to the BasePosition plus the offset
			transform.position = BasePosition + offset;

			// Increment the NoiseIndex so that we get a new Noise value next time.
			NoiseIndex += FloatSpeed * Time.deltaTime;
		}
	}
}
