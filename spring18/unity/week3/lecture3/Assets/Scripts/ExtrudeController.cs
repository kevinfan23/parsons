using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MeshRenderer))]
public class ExtrudeController : MonoBehaviour {

	MeshRenderer mr;
	Vector2 noiseIndex = new Vector2 ();
	float Speed = 2.0F;

	// Use this for initialization
	void Start () {
		mr = GetComponent<MeshRenderer> ();
		noiseIndex.x = Random.value;
	}
	
	// Update is called once per frame
	void Update () {
		float offset = Mathf.PerlinNoise (noiseIndex.x, noiseIndex.y) * 20.0F;
		mr.material.SetFloat ("_Extrude", offset);
		noiseIndex.y += Time.deltaTime * Speed;
	}
}
