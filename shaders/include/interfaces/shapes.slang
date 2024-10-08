#include "interfaces/arrows.slang"

static const float SQRT_2 = 1.4142135623730951;

struct MarkerOffsets
{
    float4 dx;
    float4 dy;
};

interface IMarker
{
    MarkerOffsets getVertexOffsets(float4x4 vp, float size, float2 res, float3 ext);
};

struct Marker2D : IMarker
{
    MarkerOffsets getVertexOffsets(float4x4 vp, float size, float2 res, float3 ext)
    {
        float aspect = res.x / res.y;
        MarkerOffsets out;
        out.dx = vp[0] * (size / ext.x);
        out.dy = vp[1] * (size / ext.y);
        return out;
    }
};

struct Marker3D : IMarker
{
    MarkerOffsets getVertexOffsets(float4x4 vp, float size, float2 res, float3 ext)
    {
        MarkerOffsets out;
        out.dx = float4(size,0,0,0) / res.x;
        out.dy = float4(0,size,0,0) / res.y;
        return out;
    }
};

interface IShape2D
{
    float apply(float2 p, float size);
}

struct DiscShape : IShape2D
{
    float apply(float2 p, float size)
    {
        return length(p) - size/2;
    }
}

struct SquareShape : IShape2D
{
    float apply(float2 p, float size)
    {
        return max(abs(p.x), abs(p.y)) - size / (2 * SQRT_2);
    }
}

struct TriangleShape : IShape2D
{
    float apply(float2 p, float size)
    {
        float x = SQRT_2/2 * (p.x - p.y);
        float y = SQRT_2/2 * (p.x + p.y);
        float r1 = max(abs(x), abs(y)) - size / (2 * SQRT_2);
        float r2 = p.y;
        return max(r1, r2);
    }
}

struct DiamondShape : IShape2D
{
    float apply(float2 p, float size)
    {
        float x = SQRT_2/2 * (p.x - p.y);
        float y = SQRT_2/2 * (p.x + p.y);
        return max(abs(x), abs(y)) - size / (2 * SQRT_2);
    }
}

struct ArrowShape : IShape2D
{
    float apply(float2 p, float size)
    {
        float body = size;
        float head = 0.25 * body;
        float linewidth = 10.0;
        float antialias = 10.0;
        return arrowStealth(p, body, head, linewidth, antialias);
    }
}

interface IShape3D
{
    float2 apply(
        float3 ro, // Ray origin
        float3 rd, // Ray direction
        float3 ce, // Center
        float sz // size
    );
}

struct SphereShape : IShape3D
{
    float2 apply(float3 ro, float3 rd, float3 center, float sz)
    {
        float3 oc = ro - center;
        float b = dot(oc, rd);
        float c = dot(oc, oc) - sz * sz;
        float h = b*b - c;
        return (h<0)? -1 : -b - sqrt(h);
    }
};