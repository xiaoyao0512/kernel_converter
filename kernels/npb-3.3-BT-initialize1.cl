__kernel void A(__global double* a, int b, int c, int d) {
  int e, h;

  int g = get_global_id(1);
  int f = get_global_id(0);
  if (g >= d || f >= c)
    return;

  __global double(*i)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  for (e = 0; e < b; e++) {
    for (h = 0; h < 5; h++) {
      i[g][f][e][h] = 1.0;
    }
  }
}
