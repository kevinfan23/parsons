using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BlueFade : MonoBehaviour {

	MeshRenderer mr;

	// Use this for initialization
	void Start () {
		mr = GetComponent<MeshRenderer> ();
	}
	
	// Update is called once per frame
	void Update () {
		float red = 0.5F + Mathf.Sin (Time.time * 4.0F) * 0.5F;
		mr.material.SetColor ("_Color", new Color(red, 0, 0, 1));
	}
}
