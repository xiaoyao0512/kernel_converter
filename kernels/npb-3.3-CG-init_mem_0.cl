__kernel void A(__global int* a, int b) {
  int c = get_global_id(0);
  if (c >= b)
    return;
  a[c] = 0;
}
