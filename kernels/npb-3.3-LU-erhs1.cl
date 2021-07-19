__kernel void A(__global double* a, __global double* b, __global double* c, int d, int e, int f) {
  int g, h, i, j;
  double k, l, m;

  i = get_global_id(2);
  h = get_global_id(1);
  g = get_global_id(0);
  if (i >= f || h >= e || g >= d)
    return;

  __global double(*n)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;
  __global double(*o)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])b;
  __global double(*p)[13] = (__global double(*)[13])c;

  m = ((double)i) / (f - 1);
  l = ((double)h) / (12 - 1);
  k = ((double)g) / (12 - 1);
  for (j = 0; j < 5; j++) {
    n[i][h][g][j] = 0.0;

    o[i][h][g][j] = p[j][0] + (p[j][1] + (p[j][4] + (p[j][7] + p[j][10] * k) * k) * k) * k + (p[j][2] + (p[j][5] + (p[j][8] + p[j][11] * l) * l) * l) * l + (p[j][3] + (p[j][6] + (p[j][9] + p[j][12] * m) * m) * m) * m;
  }
}
