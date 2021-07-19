__kernel void A(__global const double* a, __global double* b, __global double* c, __global double* d, __global double* e, __global double* f, __global double* g, __global double* h, int i, int j, int k) {
  int l, m, n;
  double o, p;
  double q[5];
  double r;

  n = get_global_id(2);
  m = get_global_id(1);
  l = get_global_id(0);
  if (n >= k || m >= j || l >= i)
    return;

  __global double(*s)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1][5])a;
  __global double(*t)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])b;
  __global double(*u)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])c;
  __global double(*v)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])d;
  __global double(*w)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])e;
  __global double(*x)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])f;
  __global double(*y)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])g;
  __global double(*z)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1] = (__global double(*)[(12 / 2 * 2) + 1][(12 / 2 * 2) + 1])h;

  q[0] = s[n][m][l][0];
  q[1] = s[n][m][l][1];
  q[2] = s[n][m][l][2];
  q[3] = s[n][m][l][3];
  q[4] = s[n][m][l][4];

  p = 1.0 / q[0];
  x[n][m][l] = p;
  t[n][m][l] = q[1] * p;
  u[n][m][l] = q[2] * p;
  v[n][m][l] = q[3] * p;
  r = 0.5 * (q[1] * q[1] + q[2] * q[2] + q[3] * q[3]) * p;
  z[n][m][l] = r;
  w[n][m][l] = r * p;

  o = (1.4 * 0.4) * p * (q[4] - r);
  y[n][m][l] = sqrt(o);
}
