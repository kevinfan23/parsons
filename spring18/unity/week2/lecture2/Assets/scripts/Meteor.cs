using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Meteor : MonoBehaviour {

	Rigidbody rb;
	Transform t;
	float born;

	// Use this for initialization
	void Start () {
		rb = this.GetComponent<Rigidbody> ();
		t = this.GetComponent<Transform> ();
		rb.AddForce (new Vector3(500, 5, 0));
		born = Time.time;
	}
	
	// Update is called once per frame
	void Update () {
		if (t.position.y < 1) {
			rb.AddForce (new Vector3(0, 5, 0));
		}

		float age = Time.time - born;
		transform.localScale = Vector3.one * (10 - age)/10;
		if (age > 10) {
			Destroy (gameObject);
		}
	}
}
