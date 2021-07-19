__kernel void A(__global double* a, __global double* b, int c, int d, int e) {
  int f, g, h, i, j, k, l;
  double m, n, o, p[2][3][5], q, r, s;

  h = get_global_id(2);
  g = get_global_id(1);
  f = get_global_id(0);
  if (h >= e || g >= d || f >= c)
    return;

  __global double(*t)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])a;

  o = (double)h * (1.0 / (double)(12 - 1));
  n = (double)g * (1.0 / (double)(12 - 1));
  m = (double)f * (1.0 / (double)(12 - 1));

  for (j = 0; j < 2; j++) {
    q = (double)j;
    A(q, n, o, &p[j][0][0], b);
  }

  for (k = 0; k < 2; k++) {
    r = (double)k;
    A(m, r, o, &p[k][1][0], b);
  }

  for (l = 0; l < 2; l++) {
    s = (double)l;
    A(m, n, s, &p[l][2][0], b);
  }

  for (i = 0; i < 5; i++) {
    q = m * p[1][0][i] + (1.0 - m) * p[0][0][i];
    r = n * p[1][1][i] + (1.0 - n) * p[0][1][i];
    s = o * p[1][2][i] + (1.0 - o) * p[0][2][i];

    t[h][g][f][i] = q + r + s - q * r - q * s - r * s + q * r * s;
  }
}
