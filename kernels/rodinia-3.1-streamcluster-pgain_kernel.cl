__kernel void A(__global float* a, __global long* b, __global float* c, __global float* d, __global float* e, __global int* f, __global char* g, __local float* h, int i, int j, long k, int l) {
  const int m = get_global_id(0);
  const int n = get_local_id(0);

  if (m < i) {
    if (n == 0)
      for (int o = 0; o < j; o++) {
        h[o] = d[o * i + k];
      }
    barrier(1);

    float p = 0.0;
    for (int o = 0; o < j; o++)
      p += (d[(o * i) + m] - h[o]) * (d[(o * i) + m] - h[o]);
    p = p * a[m];

    float q = c[m];

    int r = m * (l + 1);

    if (p < q) {
      g[m] = '1';
      int s = r + l;
      e[s] = p - q;
    }

    else {
      int t = b[m];
      int u = r + f[t];
      e[u] += q - p;
    }
  }
}
