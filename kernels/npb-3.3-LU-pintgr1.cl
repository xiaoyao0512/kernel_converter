__kernel void A(__global double* a, __global double* b, __global double* c, int d, int e, int f, int g, int h, int i) {
  int j, k, l;

  k = get_global_id(1) + f;
  j = get_global_id(0) + d;
  if (k >= g || j >= e)
    return;

  __global double(*m)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;
  __global double(*n)[12 + 2] = (__global double(*)[12 + 2])b;
  __global double(*o)[12 + 2] = (__global double(*)[12 + 2])c;

  l = h;

  n[k][j] = 0.40e+00 * (m[l][k][j][4] - 0.50 * (m[l][k][j][1] * m[l][k][j][1] + m[l][k][j][2] * m[l][k][j][2] + m[l][k][j][3] * m[l][k][j][3]) / m[l][k][j][0]);

  l = i - 1;

  o[k][j] = 0.40e+00 * (m[l][k][j][4] - 0.50 * (m[l][k][j][1] * m[l][k][j][1] + m[l][k][j][2] * m[l][k][j][2] + m[l][k][j][3] * m[l][k][j][3]) / m[l][k][j][0]);
}
