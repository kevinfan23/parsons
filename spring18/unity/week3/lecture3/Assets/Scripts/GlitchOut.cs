using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[RequireComponent(typeof(AudioSource))]
[RequireComponent(typeof(MeshRenderer))]
public class GlitchOut : MonoBehaviour {

    private AudioSource audioSource;
    public List<AudioClip> GlitchFX;
    private float NextGlitch = 0;
    private Material mat;


    // Use this for initialization
    void Start () {
        // myRandom = new System.Random();
        NextGlitch = Random.Range(0.0F, 1.0F) ;

        mat = GetComponentInChildren<Renderer>().material;

        mat.SetColor("_GridColor", new Color(0, 1, 0, 1));
        mat.SetFloat("_GridStep", 0.05F);
        mat.SetFloat("_GridWidth", 1);

        audioSource = GetComponent<AudioSource>();
        audioSource.spatialBlend = 1.0F;
        audioSource.playOnAwake = false;
    }
	
	// Update is called once per frame
	void Update () {

        if (Time.time > NextGlitch)
        {
            StartCoroutine("Glitch");
            float delay = Random.Range(1.0F, 2.5F);
            NextGlitch = Time.time + delay;
        }
    }

    IEnumerator Glitch()
    {
        int j = Random.Range(0, GlitchFX.Count);
        audioSource.PlayOneShot(GlitchFX[j]);

        int t = Random.Range(3, 10);
        for(int i=0; i<t; i++)
        {
            if (Random.value > 0.5F)
                mat.SetFloat("_GlitchSeed", Random.Range(0, 1.0F));
            if (Random.value > 0.5F)
                mat.SetFloat("_HideChunks", 1);
            if (Random.value > 0.5F)
                mat.SetFloat("_ShowGrid", 1);
            if (Random.value > 0.5F)
                mat.SetFloat("_GlitchColors", 1);
            if (Random.value > 0.5F)
                mat.SetFloat("_BulgeAmount", Random.Range(-1.0F, 5.0F));
                

            yield return new WaitForSeconds(Random.Range(0.01F, 0.2F));

            mat.SetFloat("_HideChunks", 0);
            mat.SetFloat("_ShowGrid", 0);
            mat.SetFloat("_GlitchColors", 0);
            mat.SetFloat("_BulgeAmount", 0F);
        }
    }


    float map(float s, float a1, float a2, float b1, float b2)
    {
        return b1 + (s - a1) * (b2 - b1) / (a2 - a1);
    }

}
