__kernel void A(__global double* a, __global int* b, __global int* c, __global int* d, __global int* e, __global double* f, __global int* g, __global int* h, int i, int j) {
  __global int(*k)[1 + 1];
  __global double(*l)[1 + 1];
  __global int* m;

  const double n = 10;
  const double o = 16;

  int p, q, r, s, t, u, v;
  double w, x, y, z;

  int aa = get_global_id(0);
  if (aa >= i)
    return;

  k = (__global int(*)[1 + 1])e;
  l = (__global double(*)[1 + 1])f;
  m = &b[j];

  for (r = c[aa]; r < c[aa + 1]; r++) {
    a[r] = 0.0;
    b[r] = -1;
  }
  m[aa] = 0;

  w = 1.0;
  y = __clc_pow(n, (1.0 / (double)(i)));

  for (p = 0; p < i; p++) {
    for (t = 0; t < d[p]; t++) {
      q = k[p][t];

      if (q != aa)
        continue;

      x = w * l[p][t];
      for (u = 0; u < d[p]; u++) {
        v = k[p][u];
        z = l[p][u] * x;

        if (v == q && q == p) {
          z = z + n - o;
        }

        for (r = c[q]; r < c[q + 1]; r++) {
          if (b[r] > v) {
            for (s = c[q + 1] - 2; s >= r; s--) {
              if (b[s] > -1) {
                a[s + 1] = a[s];
                b[s + 1] = b[s];
              }
            }
            b[r] = v;
            a[r] = 0.0;
            break;
          } else if (b[r] == -1) {
            b[r] = v;
            break;
          } else if (b[r] == v) {
            m[q] = m[q] + 1;
            break;
          }
        }
        a[r] = a[r] + z;
      }
    }
    w = w * y;
  }
}
