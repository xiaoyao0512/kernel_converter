__kernel void A(__global const double* a, __global double* b, __global double* c, __global double* d, __global double* e, __global double* f, __global double* g, int h, int i, int j) {
  int k, l, m;
  double n;
  double o[4];
  double p;

  m = get_global_id(2);
  l = get_global_id(1);
  k = get_global_id(0);
  if (m >= j || l >= i || k >= h)
    return;

  __global double(*q)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;
  __global double(*r)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])b;
  __global double(*s)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])c;
  __global double(*t)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])d;
  __global double(*u)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])e;
  __global double(*v)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])f;
  __global double(*w)[12 / 2 * 2 + 1][12 / 2 * 2 + 1] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1])g;

  o[0] = q[m][l][k][0];
  o[1] = q[m][l][k][1];
  o[2] = q[m][l][k][2];
  o[3] = q[m][l][k][3];

  n = 1.0 / o[0];
  v[m][l][k] = n;
  r[m][l][k] = o[1] * n;
  s[m][l][k] = o[2] * n;
  t[m][l][k] = o[3] * n;
  p = 0.5 * (o[1] * o[1] + o[2] * o[2] + o[3] * o[3]) * n;
  w[m][l][k] = p;
  u[m][l][k] = p * n;
}

