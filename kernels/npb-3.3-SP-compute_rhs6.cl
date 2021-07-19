__kernel void A(__global double* a, int b, int c, int d) {
  int h;

  int g = get_global_id(2) + 1;
  int f = get_global_id(1) + 1;
  int e = get_global_id(0) + 1;
  if (g > d || f > c || e > b)
    return;

  __global double(*i)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])a;

  for (h = 0; h < 5; h++) {
    i[g][f][e][h] = i[g][f][e][h] * 0.015;
  }
}
