__kernel void A(__global double* a, int b, int c, int d) {
  int e = get_global_id(2);
  int f = get_global_id(1);
  int g = get_global_id(0);
  if (e >= d || f >= c || g >= b)
    return;

  int h;
  __global double(*i)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  for (h = 0; h < 5; h++) {
    i[e][f][g][h] = 0.0;
  }
}
