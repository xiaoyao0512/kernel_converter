__kernel void A(__global double* a, __global double* b, __global double* c, int d, int e, int f, int g, int h) {
  __local double i[64];
  __local double j[64];

  int n;
  int m = get_local_id(0);
  int l = get_group_id(0);
  int k = get_global_id(1);

  n = k * f * (e + 1) + l;
  for (int o = m; o < f; o += 64) {
    i[o] = a[n + o * (e + 1)];
  }

  barrier(1);

  B(d, h, f, c, i, j);

  barrier(1);

  for (int o = m; o < f; o += 64) {
    b[n + o * (e + 1)] = i[o];
  }
}
