__kernel void A(__global double* a, int b, int c, int d) {
  int e = get_global_id(2) + 1;
  int f = get_global_id(1) + 1;
  int g = get_global_id(0) + 1;
  if (e > (d - 2) || f > (c - 2) || g > (b - 2))
    return;

  int h;
  __global double(*i)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  for (h = 0; h < 5; h++) {
    i[e][f][g][h] = -1.0 * i[e][f][g][h];
  }
}
