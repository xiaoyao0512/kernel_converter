__kernel void A(__global double* a, __global double* b, double c, int d, int e, int f) {
  int g, h, i, j;
  __global double(*k)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5];
  __global double(*l)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5];

  i = get_global_id(2) + 1;
  h = get_global_id(1) + 1;
  g = get_global_id(0) + 1;
  if (i >= (f - 1) || h >= (e - 1) || g >= (d - 1))
    return;

  k = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;
  l = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])b;

  for (j = 0; j < 5; j++) {
    k[i][h][g][j] = k[i][h][g][j] + c * l[i][h][g][j];
  }
}
