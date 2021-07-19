__kernel void A(__global double* a, __global double* b, __global double* c, __global double* d, __global double* e, int f, int g, int h) {
  int i, j, k, l;
  double m;
  __global double(*n)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5];
  __global double(*o)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5];
  __global double(*p)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5];
  __global double(*q)[12 / 2 * 2 + 1][12 / 2 * 2 + 1];
  __global double(*r)[12 / 2 * 2 + 1][12 / 2 * 2 + 1];

  k = get_global_id(2);
  j = get_global_id(1);
  i = get_global_id(0);
  if (k >= h || j >= g || i >= f)
    return;

  n = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;
  o = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])b;
  p = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])c;
  q = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])d;
  r = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])e;

  for (l = 0; l < 5; l++) {
    o[k][j][i][l] = -p[k][j][i][l];
  }
  m = 1.0 / n[k][j][i][0];
  r[k][j][i] = m;
  q[k][j][i] = 0.50 * (n[k][j][i][1] * n[k][j][i][1] + n[k][j][i][2] * n[k][j][i][2] + n[k][j][i][3] * n[k][j][i][3]) * m;
}
