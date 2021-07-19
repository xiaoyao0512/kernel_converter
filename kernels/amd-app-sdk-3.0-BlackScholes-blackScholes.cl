__kernel void A(const __global float4* a, int b, __global float4* c, __global float4* d) {
  float4 e, f;
  float4 g, h;
  float4 i;
  float4 j;

  unsigned k = get_global_id(0);
  unsigned l = get_global_id(1);
  float4 m = (float4)2.0f;
  float4 n = a[l * b + k];
  float4 o = 10.0f * n + 100.0f * (1.0f - n);
  float4 p = 10.0f * n + 100.0f * (1.0f - n);
  float4 q = 1.0f * n + 10.0f * (1.0f - n);
  float4 r = 0.01f * n + 0.05f * (1.0f - n);
  float4 s = 0.01f * n + 0.10f * (1.0f - n);

  i = s * sqrt(q);

  e = (log(o / p) + (r + s * s / m) * q) / i;
  f = e - i;

  j = p * exp(-r * q);
  A(e, &g);
  A(f, &h);
  c[l * b + k] = o * g - j * h;
  A(e, &g);
  A(f, &h);
  d[l * b + k] = j * h - o * g;
}
