using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MeshRenderer))]
public class StandardController : MonoBehaviour {

	MeshRenderer mr;
	Vector2 noiseIndex = new Vector2 ();
	public float Speed = 0.1F;

	// Use this for initialization
	void Start () {
		mr = GetComponent<MeshRenderer> ();
		noiseIndex.x = Random.value;
	}
	
	// Update is called once per frame
	void Update () {
		float alpha = Mathf.PerlinNoise (noiseIndex.x, noiseIndex.y);
		Color c = new Color (1.0F, 1.0F, 1.0F, alpha);
		mr.material.SetColor ("_Color", c);



		noiseIndex.y += Time.deltaTime * Speed;
	}
}
