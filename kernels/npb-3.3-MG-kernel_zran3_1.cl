__kernel void A(__global double* a, __global double* b, int c, int d, int e, int f, int g, int h, int i, double j) {
  int k = get_global_id(0);
  int l;
  double m, n;
  const double o = __clc_pow(5.0, 13.0);

  if (k < h && k >= 1) {
    n = b[k];
    for (l = 1; l < g; l++) {
      m = n;
      B(i, &m, o, &(a[k * d * c + l * c + 1]));
      A(&n, j);
    }
  }
}
