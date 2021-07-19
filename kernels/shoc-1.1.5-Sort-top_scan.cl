__kernel void A(__global uint* a, const int b, __local uint* c) {
  __local int d;
  d = 0;
  //barrier(1);
  int i = get_local_id(0);
  int e = (i < b && (i + 1) == b) ? 1 : 0;

  for (int f = 0; f < 16; f++) {
    uint g = 0;

    if (i < b) {
      g = a[(b * f) + i];
    }

    uint h = B(g, c, 1);

    if (i < b) {
      a[(b * f) + i] = h + d;
    }
    //barrier(1);

    if (e) {
      d += h + g;
    }
    //barrier(1);
  }
}
