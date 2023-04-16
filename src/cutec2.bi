/'
 ' zlib License
 ' 
 ' (C) 2032 XXIV
 ' 
 ' This software is provided 'as-is', without any express or implied
 ' warranty.  In no event will the authors be held liable for any damages
 ' arising from the use of this software.
 ' 
 ' Permission is granted to anyone to use this software for any purpose,
 ' including commercial applications, and to alter it and redistribute it
 ' freely, subject to the following restrictions:
 ' 
 ' 1. The origin of this software must not be misrepresented; you must not
 '    claim that you wrote the original software. If you use this software
 '    in a product, an acknowledgment in the product documentation would be
 '    appreciated but is not required.
 ' 2. Altered source versions must be plainly marked as such, and must not be
 '    misrepresented as being the original software.
 ' 3. This notice may not be removed or altered from any source distribution.
 '/
#ifndef __CUTE_C2_BI__
#define __CUTE_C2_BI__

extern "C"

#define C2_MAX_POLYGON_VERTS = 8

type c2v
	x as single
	y as single
end type

type c2r
	c as single
	s as single
end type

type c2m
	x as c2v
	y as c2v
end type

type c2x
	p as c2v
	r as c2r
end type

type c2h
	n as c2v
	d as single
end type

type c2Circle
	p as c2v
	r as single
end type

type c2AABB
	min as c2v
	max as c2v
end type

type c2Capsule
	a as c2v
	b as c2v
	r as single
end type

type c2Poly
	count as long
	verts(0 to 7) as c2v
	norms(0 to 7) as c2v
end type

type c2Ray
	p as c2v
	d as c2v
	t as single
end type

type c2Raycast
	t as single
	n as c2v
end type

#define c2Impact(ray, t) c2Add(ray.p, c2Mulvs(ray.d, t))

type c2Manifold
	count as long
	depths(0 to 1) as single
	contact_points(0 to 1) as c2v
	n as c2v
end type

declare function c2CircletoCircle(byval A as c2Circle, byval B as c2Circle) as long
declare function c2CircletoAABB(byval A as c2Circle, byval B as c2AABB) as long
declare function c2CircletoCapsule(byval A as c2Circle, byval B as c2Capsule) as long
declare function c2AABBtoAABB(byval A as c2AABB, byval B as c2AABB) as long
declare function c2AABBtoCapsule(byval A as c2AABB, byval B as c2Capsule) as long
declare function c2CapsuletoCapsule(byval A as c2Capsule, byval B as c2Capsule) as long
declare function c2CircletoPoly(byval A as c2Circle, byval B as const c2Poly ptr, byval bx as const c2x ptr) as long
declare function c2AABBtoPoly(byval A as c2AABB, byval B as const c2Poly ptr, byval bx as const c2x ptr) as long
declare function c2CapsuletoPoly(byval A as c2Capsule, byval B as const c2Poly ptr, byval bx as const c2x ptr) as long
declare function c2PolytoPoly(byval A as const c2Poly ptr, byval ax as const c2x ptr, byval B as const c2Poly ptr, byval bx as const c2x ptr) as long
declare function c2RaytoCircle(byval A as c2Ray, byval B as c2Circle, byval out as c2Raycast ptr) as long
declare function c2RaytoAABB(byval A as c2Ray, byval B as c2AABB, byval out as c2Raycast ptr) as long
declare function c2RaytoCapsule(byval A as c2Ray, byval B as c2Capsule, byval out as c2Raycast ptr) as long
declare function c2RaytoPoly(byval A as c2Ray, byval B as const c2Poly ptr, byval bx_ptr as const c2x ptr, byval out as c2Raycast ptr) as long
declare sub c2CircletoCircleManifold(byval A as c2Circle, byval B as c2Circle, byval m as c2Manifold ptr)
declare sub c2CircletoAABBManifold(byval A as c2Circle, byval B as c2AABB, byval m as c2Manifold ptr)
declare sub c2CircletoCapsuleManifold(byval A as c2Circle, byval B as c2Capsule, byval m as c2Manifold ptr)
declare sub c2AABBtoAABBManifold(byval A as c2AABB, byval B as c2AABB, byval m as c2Manifold ptr)
declare sub c2AABBtoCapsuleManifold(byval A as c2AABB, byval B as c2Capsule, byval m as c2Manifold ptr)
declare sub c2CapsuletoCapsuleManifold(byval A as c2Capsule, byval B as c2Capsule, byval m as c2Manifold ptr)
declare sub c2CircletoPolyManifold(byval A as c2Circle, byval B as const c2Poly ptr, byval bx as const c2x ptr, byval m as c2Manifold ptr)
declare sub c2AABBtoPolyManifold(byval A as c2AABB, byval B as const c2Poly ptr, byval bx as const c2x ptr, byval m as c2Manifold ptr)
declare sub c2CapsuletoPolyManifold(byval A as c2Capsule, byval B as const c2Poly ptr, byval bx as const c2x ptr, byval m as c2Manifold ptr)
declare sub c2PolytoPolyManifold(byval A as const c2Poly ptr, byval ax as const c2x ptr, byval B as const c2Poly ptr, byval bx as const c2x ptr, byval m as c2Manifold ptr)

type C2_TYPE as long
enum
	C2_TYPE_CIRCLE
	C2_TYPE_AABB
	C2_TYPE_CAPSULE
	C2_TYPE_POLY
end enum

type c2GJKCache
	metric as single
	count as long
	iA(0 to 2) as long
	iB(0 to 2) as long
	div as single
end type

declare function c2GJK(byval A as const any ptr, byval typeA as C2_TYPE, byval ax_ptr as const c2x ptr, byval B as const any ptr, byval typeB as C2_TYPE, byval bx_ptr as const c2x ptr, byval outA as c2v ptr, byval outB as c2v ptr, byval use_radius as long, byval iterations as long ptr, byval cache as c2GJKCache ptr) as single

type c2TOIResult
	hit as long
	toi as single
	n as c2v
	p as c2v
	iterations as long
end type

declare function c2TOI(byval A as const any ptr, byval typeA as C2_TYPE, byval ax_ptr as const c2x ptr, byval vA as c2v, byval B as const any ptr, byval typeB as C2_TYPE, byval bx_ptr as const c2x ptr, byval vB as c2v, byval use_radius as long) as c2TOIResult
declare sub c2Inflate(byval shape as any ptr, byval type as C2_TYPE, byval skin_factor as single)
declare function c2Hull(byval verts as c2v ptr, byval count as long) as long
declare sub c2Norms(byval verts as c2v ptr, byval norms as c2v ptr, byval count as long)
declare sub c2MakePoly(byval p as c2Poly ptr)
declare function c2Collided(byval A as const any ptr, byval ax as const c2x ptr, byval typeA as C2_TYPE, byval B as const any ptr, byval bx as const c2x ptr, byval typeB as C2_TYPE) as long
declare sub c2Collide(byval A as const any ptr, byval ax as const c2x ptr, byval typeA as C2_TYPE, byval B as const any ptr, byval bx as const c2x ptr, byval typeB as C2_TYPE, byval m as c2Manifold ptr)
declare function c2CastRay(byval A as c2Ray, byval B as const any ptr, byval bx as const c2x ptr, byval typeB as C2_TYPE, byval out as c2Raycast ptr) as long
declare sub c2SinCos(byval radians as single, byval s as single ptr, byval c as single ptr)
declare function c2V(byval x as single, byval y as single) as c2v
declare function c2Add(byval a as c2v, byval b as c2v) as c2v
declare function c2Sub(byval a as c2v, byval b as c2v) as c2v
declare function c2Dot(byval a as c2v, byval b as c2v) as single
declare function c2Mulvs(byval a as c2v, byval b as single) as c2v
declare function c2Mulvv(byval a as c2v, byval b as c2v) as c2v
declare function c2Div(byval a as c2v, byval b as single) as c2v
declare function c2Skew(byval a as c2v) as c2v
declare function c2CCW90(byval a as c2v) as c2v
declare function c2Det2(byval a as c2v, byval b as c2v) as single
declare function c2Minv(byval a as c2v, byval b as c2v) as c2v
declare function c2Maxv(byval a as c2v, byval b as c2v) as c2v
declare function c2Clampv(byval a as c2v, byval lo as c2v, byval hi as c2v) as c2v
declare function c2Absv(byval a as c2v) as c2v
declare function c2Hmin(byval a as c2v) as single
declare function c2Hmax(byval a as c2v) as single
declare function c2Len(byval a as c2v) as single
declare function c2Norm(byval a as c2v) as c2v
declare function c2SafeNorm(byval a as c2v) as c2v
declare function c2Neg(byval a as c2v) as c2v
declare function c2Lerp(byval a as c2v, byval b as c2v, byval t as single) as c2v
declare function c2Parallel(byval a as c2v, byval b as c2v, byval kTol as single) as long
declare function c2Rot(byval radians as single) as c2r
declare function c2RotIdentity() as c2r
declare function c2RotX(byval r as c2r) as c2v
declare function c2RotY(byval r as c2r) as c2v
declare function c2Mulrv(byval a as c2r, byval b as c2v) as c2v
declare function c2MulrvT(byval a as c2r, byval b as c2v) as c2v
declare function c2Mulrr(byval a as c2r, byval b as c2r) as c2r
declare function c2MulrrT(byval a as c2r, byval b as c2r) as c2r
declare function c2Mulmv(byval a as c2m, byval b as c2v) as c2v
declare function c2MulmvT(byval a as c2m, byval b as c2v) as c2v
declare function c2Mulmm(byval a as c2m, byval b as c2m) as c2m
declare function c2MulmmT(byval a as c2m, byval b as c2m) as c2m
declare function c2xIdentity() as c2x
declare function c2Mulxv(byval a as c2x, byval b as c2v) as c2v
declare function c2MulxvT(byval a as c2x, byval b as c2v) as c2v
declare function c2Mulxx(byval a as c2x, byval b as c2x) as c2x
declare function c2MulxxT(byval a as c2x, byval b as c2x) as c2x
declare function c2Transform(byval p as c2v, byval radians as single) as c2x
declare function c2Origin(byval h as c2h) as c2v
declare function c2Dist(byval h as c2h, byval p as c2v) as single
declare function c2Project(byval h as c2h, byval p as c2v) as c2v
declare function c2Mulxh(byval a as c2x, byval b as c2h) as c2h
declare function c2MulxhT(byval a as c2x, byval b as c2h) as c2h
declare function c2Intersect(byval a as c2v, byval b as c2v, byval da as single, byval db as single) as c2v
declare sub c2BBVerts(byval out as c2v ptr, byval bb as c2AABB ptr)

end extern

#endif '__CUTE_C2_BI__
