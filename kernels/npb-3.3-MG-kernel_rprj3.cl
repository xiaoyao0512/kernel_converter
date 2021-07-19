__kernel void A(__global double* a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k, int l) {
  int m, n, o, p, q, r, s;
  double t, u;
  __local double v[1024], w[1024];

  __global double* x = a + h;
  __global double* y = a + i;

  m = get_global_id(1) + 1;
  n = get_group_id(0) + 1;
  o = get_local_id(0) + 1;
  p = 2 * m - l;
  q = 2 * n - k;
  r = 2 * o - j;
  v[r] = x[(p + 1) * c * b + q * b + r] + x[(p + 1) * c * b + (q + 2) * b + r] + x[p * c * b + (q + 1) * b + r] + x[(p + 2) * c * b + (q + 1) * b + r];
  w[r] = x[p * c * b + q * b + r] + x[(p + 2) * c * b + q * b + r] + x[p * c * b + (q + 2) * b + r] + x[(p + 2) * c * b + (q + 2) * b + r];

  barrier(1);

  if (o < e - 1) {
    r = 2 * o - j;
    u = x[p * c * b + q * b + r + 1] + x[(p + 2) * c * b + q * b + r + 1] + x[p * c * b + (q + 2) * b + r + 1] + x[(p + 2) * c * b + (q + 2) * b + r + 1];
    t = x[(p + 1) * c * b + q * b + r + 1] + x[(p + 1) * c * b + (q + 2) * b + r + 1] + x[p * c * b + (q + 1) * b + r + 1] + x[(p + 2) * c * b + (q + 1) * b + r + 1];
    y[m * f * e + n * e + o] = 0.5 * x[(p + 1) * c * b + (q + 1) * b + r + 1] + 0.25 * (x[(p + 1) * c * b + (q + 1) * b + r] + x[(p + 1) * c * b + (q + 1) * b + r + 2] + t) + 0.125 * (v[r] + v[r + 2] + u) + 0.0625 * (w[r] + w[r + 2]);
  }
}
