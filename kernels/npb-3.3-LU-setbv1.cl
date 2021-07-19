__kernel void A(__global double* a, __global double* b, int c, int d, int e) {
  int h;
  double i[5], j[5];

  int g = get_global_id(1);
  int f = get_global_id(0);
  if (g >= d || f >= c)
    return;

  __global double(*k)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  B(f, g, 0, i, b);
  B(f, g, e - 1, j, b);
  for (h = 0; h < 5; h++) {
    k[0][g][f][h] = i[h];
    k[e - 1][g][f][h] = j[h];
  }
}
