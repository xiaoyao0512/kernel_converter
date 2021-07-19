__kernel void A(__global double* a, __global double* b, int c, int d, int e) {
  int f, g, h, i;
  double j, k, l;
  double m, n, o;
  double p[5], q[5], r[5];
  double s[5], t[5], u[5];

  h = get_global_id(2) + 1;
  g = get_global_id(1) + 1;
  f = get_global_id(0) + 1;
  if (h >= (e - 1) || g >= (d - 1) || f >= (c - 1))
    return;

  __global double(*v)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  l = ((double)h) / (e - 1);
  k = ((double)g) / (12 - 1);
  j = ((double)f) / (12 - 1);
  B(0, g, h, p, b);
  B(12 - 1, g, h, q, b);
  B(f, 0, h, r, b);
  B(f, 12 - 1, h, s, b);
  B(f, g, 0, t, b);
  B(f, g, e - 1, u, b);

  for (i = 0; i < 5; i++) {
    m = (1.0 - j) * p[i] + j * q[i];
    n = (1.0 - k) * r[i] + k * s[i];
    o = (1.0 - l) * t[i] + l * u[i];

    v[h][g][f][i] = m + n + o - m * n - n * o - o * m + m * n * o;
  }
}
