__kernel void A(__global const double* a, __global double* b, int c, int d, int e) {
  int f, g, h, i;

  h = get_global_id(2);
  g = get_global_id(1);
  f = get_global_id(0);
  if (h >= e || g >= d || f >= c)
    return;

  __global double(*j)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;
  __global double(*k)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])b;

  for (i = 0; i < 5; i++) {
    k[h][g][f][i] = j[h][g][f][i];
  }
}
