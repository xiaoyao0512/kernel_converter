__kernel void A(__global double* a, int b) {
  int c = get_global_id(0);
  unsigned int d = get_local_size(0);

  if (c == 0) {
    int e;
    double f = 0;
    int g = __clc_ceil((double)b / (double)d);
    for (e = 0; e < g; e++) {
      f += a[e];
    }
    a[0] = f;
  }
}
