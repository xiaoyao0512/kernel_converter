__kernel void A(__global float* a, int b) {
  int c = get_global_id(0);

  for (int d = 0; d < b; d += 2)
    B(&a[c + (d + 0) * 4096], &a[c + (d + 1) * 4096]);
}
