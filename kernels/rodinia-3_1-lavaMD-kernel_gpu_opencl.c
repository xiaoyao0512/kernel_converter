#include <stdio.h>

#include <stdbool.h>

#include <math.h>

#include "type.h"
 void A(  float* a,  int* b,  int* c,  float4* d,  float* e,  float4* f) {
for (int g = 0; g < 128; g++) {
  int h = g;
  int i = h;

  if (g < b[g]) {
    float j = 2 * a[g] * a[g];

    int k;

    float4 l[100];

    int m;
    int n = 0;
    int o;
    int p = 0;

    float4 q[100];
    float r[100];

    float s;
    float t;
    float u;
    float v;
    float w;
    float x;
    float y;
    float3 z;
    k = c[g];

    while (i < 100) {
      l[i] = d[(k + i)%128];
      i = i + 128;
    }
    i = h;

    //barrier(1);
    //barrier(1);

    for (n = 0; n < (1 + c[g]); n++) {
      if (n == 0) {
        m = g;
      } else {
        m = c[g];
      }

      o = c[m];

      while (i < 100) {
        q[(i)%128] = d[(o + i)%128];
        r[(i)%128] = e[(o + i)%128];
        i = i + 128;
      }
      i = h;

      //barrier(1);
      //barrier(1);

      while (i < 100) {
        for (p = 0; p < 100; p++) {
          s = l[(i)%128].x + q[p].x - ((l[(i)%128].x) * (q[p].x) + (l[(i)%128].y) * (q[p].y) + (l[(i)%128].z) * (q[p].z));
          t = j * s;
          u = exp(-t);
          v = 2 * u;
          z.x = l[(i)%128].x - q[p].x;
          w = v * z.x;
          z.y = l[(i)%128].y - q[p].y;
          x = v * z.y;
          z.z = l[(i)%128].z - q[p].z;
          y = v * z.z;
          f[(k + i)%128].x += r[p] * u;
          f[(k + i)%128].x += r[p] * w;
          f[(k + i)%128].y += r[p] * x;
          f[(k + i)%128].z += r[p] * y;
        }

        i = i + 128;
      }

      i = h;

      //barrier(1);
      //barrier(1);
    }
  }
}
}


void main() {

float a[128] = {5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0};
int b[128] = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
int c[128] = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
float4 d[128] = {
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0}
};

float e[128] = {5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0};
float4 f[128] = {
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0},
	{5.0, 5.0, 5.0, 5.0}
};


A (a, b, c, d, e, f);


}
