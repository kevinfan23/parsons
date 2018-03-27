using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeteorManager : MonoBehaviour {

	public GameObject meteor;

	float NextMeteor = 1.0F;
	float MeteorInterval = 0.05F;

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		if (Time.time > NextMeteor) {
//			Vector3 pos = new Vector3 ();
			Vector3 pos = transform.position;
			pos.x += Random.Range (-20, 20);
			pos.z += Random.Range (-20, 20);

			Instantiate (meteor, pos, Quaternion.identity);

			NextMeteor = Time.time + MeteorInterval;
		}

	}
}
