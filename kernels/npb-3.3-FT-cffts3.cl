__kernel void A(__global double* a, __global double* b, __global double* c, int d, int e, int f, int g, int h) {
  __local double i[64];
  __local double j[64];

  int n;
  int m = get_local_id(0);
  int k = get_global_id(1);
  int l = get_group_id(0);
  

  n = k * (e + 1) + l;
  for (int o = m; o < g; o += 64) {
    i[o] = a[o * f * (e + 1) + n];
  }

  barrier(1);

  B(d, h, g, c, i, j);

  barrier(1);

  for (int o = m; o < g; o += 64) {
    b[o * f * (e + 1) + n] = i[o];
  }
}
