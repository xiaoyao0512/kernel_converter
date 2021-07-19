__kernel void A(__global double* a, double b, int c, int d, int e) {
  int i;
  __global double(*j)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5];

  int h = get_global_id(2) + 1;
  int g = get_global_id(1) + 1;
  int f = get_global_id(0) + 1;
  if (h >= (e - 1) || g >= (d - 1) || f >= (c - 1))
    return;

  j = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  for (i = 0; i < 5; i++) {
    j[h][g][f][i] = b * j[h][g][f][i];
  }
}
