__kernel void A(__global float* a, __global int* b, __global int* c, __global float4* d, __global float* e, __global float4* f) {
  int g = get_group_id(0);
  int h = get_local_id(0);
  int i = h;

  if (g < b[g]) {
    float j = 2 * a[g] * a[g];

    int k;

    __local float4 l[100];

    int m;
    int n = 0;
    int o;
    int p = 0;

    __local float4 q[100];
    __local float r[100];

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
      l[i] = d[k + i];
      i = i + 128;
    }
    i = h;

    barrier(1);

    for (n = 0; n < (1 + c[g]); n++) {
      if (n == 0) {
        m = g;
      } else {
        m = c[g];
      }

      o = c[m];

      while (i < 100) {
        q[i] = d[o + i];
        r[i] = e[o + i];
        i = i + 128;
      }
      i = h;

      barrier(1);

      while (i < 100) {
        for (p = 0; p < 100; p++) {
          s = l[i].x + q[p].x - ((l[i].x) * (q[p].x) + (l[i].y) * (q[p].y) + (l[i].z) * (q[p].z));
          t = j * s;
          u = exp(-t);
          v = 2 * u;
          z.x = l[i].x - q[p].x;
          w = v * z.x;
          z.y = l[i].y - q[p].y;
          x = v * z.y;
          z.z = l[i].z - q[p].z;
          y = v * z.z;
          f[k + i].x += r[p] * u;
          f[k + i].x += r[p] * w;
          f[k + i].y += r[p] * x;
          f[k + i].z += r[p] * y;
        }

        i = i + 128;
      }

      i = h;

      barrier(1);
    }
  }
}
