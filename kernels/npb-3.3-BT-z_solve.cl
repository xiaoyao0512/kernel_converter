__kernel void A(__global double* a, __global double* b, int c, int d, int e) {
  int f, g, h, i, j, k;
  double l[5][5], m[5][5], n[5][5], o[5];
  double p[5][5], q[5];

  g = get_global_id(1) + 1;
  f = get_global_id(0) + 1;
  if (g > (d - 2) || f > (c - 2))
    return;

  __global double(*r)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  int s = (g - 1) * (c - 2) + (f - 1);
  int t = s * (12 + 1) * 3 * 5 * 5;
  __global double(*u)[3][5][5] = (__global double(*)[3][5][5]) & b[t];

  k = e - 1;
  K(m, u[0][1]);
  K(n, u[0][2]);
  N(o, r[0][g][f]);
  I(m, n, o);
  L(u[0][1], m);
  L(u[0][2], n);
  O(r[0][g][f], o);

  for (h = 1; h <= k - 1; h++) {
    M(p, n);
    P(q, o);
    K(l, u[h][0]);
    K(m, u[h][1]);
    K(n, u[h][2]);
    N(o, r[h][g][f]);

    G(l, q, o);

    H(l, p, m);

    I(m, n, o);

    L(u[h][1], m);
    L(u[h][2], n);
    O(r[h][g][f], o);
  }

  M(p, n);
  P(q, o);
  K(l, u[k][0]);
  K(m, u[k][1]);
  K(n, u[k][2]);
  N(o, r[k][g][f]);
  G(l, q, o);

  H(l, p, m);

  J(m, o);

  L(u[k][1], m);
  L(u[k][2], n);
  O(r[k][g][f], o);
  for (h = k - 1; h >= 0; h--) {
    for (i = 0; i < 5; i++) {
      q[i] = r[h][g][f][i];
      for (j = 0; j < 5; j++) {
        q[i] = q[i] - u[h][2][j][i] * o[j];
      }
      r[h][g][f][i] = q[i];
    }
    P(o, q);
  }
}
