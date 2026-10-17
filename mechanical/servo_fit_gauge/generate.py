"""Generate small, manifold rectangular servo-body fit gauges, in millimetres.

Trial apertures, not claimed measurements of the supplied servo. No dependencies.
The edge notches identify the frames without tiny printed text.
"""
from collections import Counter
from pathlib import Path
import math

HERE = Path(__file__).resolve().parent
APERTURES = [(23.0, 12.0), (24.0, 13.0), (25.0, 14.0)]
THICKNESS = 2.0
BORDER = 4.0


def build(index, width, depth):
    outer_w, outer_d = width + 2 * BORDER, depth + 2 * BORDER
    notches = [(2.0 + 3 * n, 3.2 + 3 * n) for n in range(index)]
    xs = sorted(set([0, BORDER, BORDER + width, outer_w] + [v for pair in notches for v in pair]))
    ys = [0, BORDER, BORDER + depth, outer_d - 1.2, outer_d]
    cells = set()
    for i in range(len(xs) - 1):
        for j in range(len(ys) - 1):
            x, y = (xs[i] + xs[i+1]) / 2, (ys[j] + ys[j+1]) / 2
            hole = BORDER < x < BORDER + width and BORDER < y < BORDER + depth
            notch = y > outer_d - 1.2 and any(a < x < b for a, b in notches)
            if not hole and not notch:
                cells.add((i, j))
    vertices, faces, ids = [], [], {}

    def quad(points):
        indices = []
        for point in points:
            if point not in ids:
                ids[point] = len(vertices)
                vertices.append(point)
            indices.append(ids[point])
        a, b, c, d = indices
        faces.extend([(a, b, c), (a, c, d)])

    for i, j in sorted(cells):
        x0, x1, y0, y1 = xs[i], xs[i+1], ys[j], ys[j+1]
        z = THICKNESS
        quad([(x0,y0,z),(x1,y0,z),(x1,y1,z),(x0,y1,z)])
        quad([(x0,y1,0),(x1,y1,0),(x1,y0,0),(x0,y0,0)])
        if (i-1,j) not in cells:
            quad([(x0,y0,0),(x0,y0,z),(x0,y1,z),(x0,y1,0)])
        if (i+1,j) not in cells:
            quad([(x1,y1,0),(x1,y1,z),(x1,y0,z),(x1,y0,0)])
        if (i,j-1) not in cells:
            quad([(x1,y0,0),(x1,y0,z),(x0,y0,z),(x0,y0,0)])
        if (i,j+1) not in cells:
            quad([(x0,y1,0),(x0,y1,z),(x1,y1,z),(x1,y1,0)])

    edges = Counter()
    directed = Counter()
    volume = 0
    stl = [f'solid servo_fit_{index}']
    for face in faces:
        a,b,c = [vertices[k] for k in face]
        u, v = [b[k]-a[k] for k in range(3)], [c[k]-a[k] for k in range(3)]
        normal = (u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0])
        norm = math.sqrt(sum(t*t for t in normal))
        assert norm > 0
        volume += (a[0]*(b[1]*c[2]-b[2]*c[1]) + a[1]*(b[2]*c[0]-b[0]*c[2]) + a[2]*(b[0]*c[1]-b[1]*c[0])) / 6
        for p,q in zip(face, face[1:] + face[:1]):
            edges[tuple(sorted((p,q)))] += 1
            directed[p,q] += 1
        stl.append('  facet normal ' + ' '.join(f'{t/norm:.6f}' for t in normal))
        stl.append('    outer loop')
        stl.extend('      vertex ' + ' '.join(f'{t:.6f}' for t in point) for point in (a,b,c))
        stl.extend(['    endloop','  endfacet'])
    assert all(n == 2 for n in edges.values()), 'Non-manifold edge'
    assert all(directed[p,q] == directed[q,p] for p,q in directed), 'Inconsistent winding'
    expected = (outer_w*outer_d - width*depth - index*1.2*1.2) * THICKNESS
    assert math.isclose(volume, expected, abs_tol=1e-6), (volume, expected)
    stl.append(f'endsolid servo_fit_{index}')
    (HERE / f'servo-fit-{index}.stl').write_text('\n'.join(stl) + '\n', encoding='ascii')
    print(f'Gauge {index}: aperture {width:g} x {depth:g} mm; envelope {outer_w:g} x {outer_d:g} x {THICKNESS:g} mm; closed mesh; volume {volume:.2f} mm^3')


if __name__ == '__main__':
    for index, (width, depth) in enumerate(APERTURES, 1):
        build(index, width, depth)
