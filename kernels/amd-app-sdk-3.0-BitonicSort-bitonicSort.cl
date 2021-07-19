__kernel void A(__global uint* a, const uint b, const uint c, const uint d) {
  uint e = d;
  uint f = get_global_id(0);

  uint g = 1 << (b - c);
  uint h = 2 * g;

  uint i = (f % g) + (f / g) * h;

  uint j = i + g;

  uint k = a[i];
  uint l = a[j];

  uint m = 1 << b;

  if ((f / m) % 2 == 1)
    e = 1 - e;

  uint n;
  uint o;
  if (k > l) {
    n = k;
    o = l;
  } else {
    n = l;
    o = k;
  }

  if (e) {
    a[i] = o;
    a[j] = n;
  } else {
    a[i] = n;
    a[j] = o;
  }
}

