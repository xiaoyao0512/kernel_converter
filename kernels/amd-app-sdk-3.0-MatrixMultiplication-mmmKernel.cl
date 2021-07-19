__kernel void A(__global float4* a, __global float4* b, __global float4* c, uint d, uint e) {
  int2 f = (int2)(get_global_id(0), get_global_id(1));

  float4 g;
  float4 h;
  float4 i;
  float4 j;

  e /= 4;

  for (int k = 0; k < d; k = k + 4) {
    float4 l = a[k / 4 + (f.y << 2) * (d / 4)];
    float4 m = a[k / 4 + ((f.y << 2) + 1) * (d / 4)];
    float4 n = a[k / 4 + ((f.y << 2) + 2) * (d / 4)];
    float4 o = a[k / 4 + ((f.y << 2) + 3) * (d / 4)];

    float4 p = b[f.x + k * e];
    float4 q = b[f.x + (k + 1) * e];
    float4 r = b[f.x + (k + 2) * e];
    float4 s = b[f.x + (k + 3) * e];

    g.x += l.x * p.x + l.y * q.x + l.z * r.x + l.w * s.x;
    g.y += l.x * p.y + l.y * q.y + l.z * r.y + l.w * s.y;
    g.z += l.x * p.z + l.y * q.z + l.z * r.z + l.w * s.z;
    g.w += l.x * p.w + l.y * q.w + l.z * r.w + l.w * s.w;

    h.x += m.x * p.x + m.y * q.x + m.z * r.x + m.w * s.x;
    h.y += m.x * p.y + m.y * q.y + m.z * r.y + m.w * s.y;
    h.z += m.x * p.z + m.y * q.z + m.z * r.z + m.w * s.z;
    h.w += m.x * p.w + m.y * q.w + m.z * r.w + m.w * s.w;

    i.x += n.x * p.x + n.y * q.x + n.z * r.x + n.w * s.x;
    i.y += n.x * p.y + n.y * q.y + n.z * r.y + n.w * s.y;
    i.z += n.x * p.z + n.y * q.z + n.z * r.z + n.w * s.z;
    i.w += n.x * p.w + n.y * q.w + n.z * r.w + n.w * s.w;

    j.x += o.x * p.x + o.y * q.x + o.z * r.x + o.w * s.x;
    j.y += o.x * p.y + o.y * q.y + o.z * r.y + o.w * s.y;
    j.z += o.x * p.z + o.y * q.z + o.z * r.z + o.w * s.z;
    j.w += o.x * p.w + o.y * q.w + o.z * r.w + o.w * s.w;
  }
  c[f.x + ((f.y << 2) + 0) * e] = g;
  c[f.x + ((f.y << 2) + 1) * e] = h;
  c[f.x + ((f.y << 2) + 2) * e] = i;
  c[f.x + ((f.y << 2) + 3) * e] = j;
}

