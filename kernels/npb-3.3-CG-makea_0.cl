__kernel void A(__global int* a, __global int* b, __global double* c, __global int* d, __global int* e, int f, int g, double h, double i) {
  __global int(*j)[1 + 1];
  __global double(*k)[1 + 1];

  int l, m, n;
  int o[1 + 1];
  double p[1 + 1];
  double q = h;

  int r, s, t, u;
  int v;

  j = (__global int(*)[1 + 1])b;
  k = (__global double(*)[1 + 1])c;

  s = get_global_size(0);
  r = get_global_id(0);

  v = (f + s - 1) / s;
  t = v * r;
  u = t + v;
  if (u > f)
    u = f;

  d[r] = t;
  e[r] = u;

  for (l = 0; l < u; l++) {
    n = 1;
    D(f, n, g, p, o, &q, i);
    if (l >= t) {
      C(f, p, o, &n, l + 1, 0.5);
      a[l] = n;
      for (m = 0; m < n; m++) {
        j[l][m] = o[m] - 1;
        k[l][m] = p[m];
      }
    }
  }
}
