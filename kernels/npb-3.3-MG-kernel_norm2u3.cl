__kernel void A(__global double* a, const int b, const int c, const int d, __global double* e, __global double* f, __local double* g, __local double* h) {
  int i = get_global_id(1) + 1;
  int j = get_group_id(0) + 1;
  int k = get_local_id(0) + 1;
  double l = 0.0;
  double m = 0.0;
  double n;
  while (k < b - 1) {
    double o = a[i * c * b + j * b + k];

    l = l + o * o;
    n = __clc_fabs(o);
    m = (n > m) ? n : m;

    k += get_local_size(0);
  }
  int p = get_local_id(0);
  g[p] = l;
  h[p] = m;

  barrier(1);

  for (int q = get_local_size(0) / 2; q > 0; q >>= 1) {
    if (p < q) {
      g[p] += g[p + q];
      h[p] = (h[p] > h[p + q]) ? h[p] : h[p + q];
    }
    barrier(1);
  }
  if (p == 0) {
    int r = get_group_id(1) * get_num_groups(0) + get_group_id(0);
    e[r] = g[0];
    f[r] = h[0];
  }
}
