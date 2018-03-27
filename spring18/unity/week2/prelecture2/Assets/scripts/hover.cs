using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class hover : MonoBehaviour {
//  C# default is PRIVATE for class variables
	Transform t;
	Vector2 noiseIndex;

	public Vector3 spin;
	public float xWobble = 3.0F;

	// Use this for initialization
	void Start () {
		t = gameObject.GetComponent<Transform> ();
		spin = new Vector3(70.0F, 70.0F, 70.0F);
	}
	
	// Update is called once per frame
	void Update () {
//		change the rotation values of the transform component
//		a little bit each frame
//		roation.x += 1
//		Transform t = this.GetComponents ("Transform") as Transform

		float noiseValue = 0.5F - Mathf.PerlinNoise (noiseIndex.x, noiseIndex.y);

		Vector3 position = t.position;
		position.x = noiseValue * xWobble;
		noiseIndex.x += Time.deltaTime;
		
		t.position = position;
		t.Rotate (spin * Time.deltaTime);
	}
}
