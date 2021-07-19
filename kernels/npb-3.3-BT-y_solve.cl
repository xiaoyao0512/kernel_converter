__kernel void A(__global double* a, __global double* b, int c, int d, int e) {
  int f, g, h, i, j, k;
  double l[5][5], m[5][5], n[5][5], o[5];
  double p[5][5], q[5];

  h = get_global_id(1) + 1;
  f = get_global_id(0) + 1;
  if (h > (e - 2) || f > (c - 2))
    return;

  __global double(*r)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5] = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

  int s = (h - 1) * (c - 2) + (f - 1);
  int t = s * (12 + 1) * 3 * 5 * 5;
  __global double(*u)[3][5][5] = (__global double(*)[3][5][5]) & b[t];

  k = d - 1;
  K(m, u[0][1]);
  K(n, u[0][2]);
  N(o, r[h][0][f]);
  I(m, n, o);
  L(u[0][1], m);
  L(u[0][2], n);
  O(r[h][0][f], o);

  for (g = 1; g <= k - 1; g++) {
    M(p, n);
    P(q, o);
    K(l, u[g][0]);
    K(m, u[g][1]);
    K(n, u[g][2]);
    N(o, r[h][g][f]);

    G(l, q, o);

    H(l, p, m);

    I(m, n, o);

    L(u[g][1], m);
    L(u[g][2], n);
    O(r[h][g][f], o);
  }

  M(p, n);
  P(q, o);
  K(l, u[k][0]);
  K(m, u[k][1]);
  K(n, u[k][2]);
  N(o, r[h][k][f]);

  G(l, q, o);

  H(l, p, m);

  J(m, o);

  L(u[k][1], m);
  L(u[k][2], n);
  O(r[h][k][f], o);

  for (g = k - 1; g >= 0; g--) {
    for (i = 0; i < 5; i++) {
      q[i] = r[h][g][f][i];
      for (j = 0; j < 5; j++) {
        q[i] = q[i] - u[g][2][j][i] * o[j];
      }
      r[h][g][f][i] = q[i];
    }
    P(o, q);
  }
}
