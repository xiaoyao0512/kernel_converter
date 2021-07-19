__kernel void A(__global float* a, const int b, __local float* c) {
  int i = get_local_id(0);
  float d = i < b ? a[i] : 0.0f;
  d = B(d, c, 1);

  if (i < b) {
    a[i] = d;
  }
}
