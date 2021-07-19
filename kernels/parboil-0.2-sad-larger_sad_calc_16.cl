__kernel void A(__global unsigned short* a, int b, int c) {
  int d = get_global_id(0);
  int e = get_global_id(1);

  int f = mul24(b, c) * 1024;
  int g = (mul24(e, b) + d) * 1024;

  __global unsigned short* h;
  __global unsigned short *i, *j, *k;

  h = a + ((f + g) << 2) + f;

  i = a + ((f + g) << 1) + f;

  j = a + f + g * 2;

  k = a + g;

  for (int l = get_local_id(0); l < (32 + 1) / 2; l += 32) {
      ushort2 m = (ushort2) (h(l)*2], h(l)*2+1]);
      ushort2 n = (ushort2) (h(l)*2], h(l)*2+1]);
      ushort2 o = (ushort2) (h(l/2)*2], h(l/2)*2+1]);
      ushort2 p = (ushort2) (h(l/2)*2], h(l/2)*2+1]);
      ((__global ushort2*)i)[l] = m + o;
      ((__global ushort2*)i)[l + 1024 / 2] = n + p;
      ((__global ushort2*)j)[l] = m + n;
      ((__global ushort2*)j)[l + 1024 / 2] = o + p;
      ((__global ushort2*)k)[l] = (m + n) + (o + p);
  }
}
