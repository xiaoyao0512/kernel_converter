__kernel void A(__global double* a, __global double* b, int c, int d, int e) {


  int g = get_global_id(2);
  int f = get_global_id(1);
  int h = get_global_id(0);
  if (g >= e || f >= c)
    return;

  __global double(*i)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  i[g][0][f][h] = A(f, 0, g, h, b);
  i[g][d - 1][f][h] = A(f, d - 1, g, h, b);
}
