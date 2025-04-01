Prime = int

P.<x> = ZZ[x]

def get_curve_data(curve: EllipticCurve, p: Prime, num_entries: int = 48):
  E = gp(curve)
  conductor = [0]
  shifted_conductor = [0]
  degree = [1]
  for k in range(1, num_entries):
      L = gp.lfunsympow(E, k)
      local_factor = P(gp.get(1 / gp.lfuneuler(L, p)))
      N = gp.lfunparams(L)[1].sage()
      val = valuation(N, p)
      degree.append(local_factor.degree())
      conductor.append(val)
      shifted_conductor.append(val - k)

  return {
    'degree': degree,
    'conductor': conductor,
    'shifted_conductor': shifted_conductor
  }

def deduce_sequence_parameters(seq: list[int]):
  return {
    'base_offsets': seq[0:12],
    'mod2_offsets': [seq[12] - seq[0], seq[13] - seq[1]]
  }

def find_curve_formula(curve: EllipticCurve, p: Prime):
  curve_data = get_curve_data(curve, p, 14)
  return {
    'conductor': deduce_sequence_parameters(curve_data['shifted_conductor']),
    'degree': deduce_sequence_parameters(curve_data['degree'])
  }

def find_curve_formulas(curve: EllipticCurve):
  return { p: find_curve_formula(curve, p) for p, pow in factor(curve.conductor()) }

def generate_degree(base_offsets: list[int], mod2_offsets: list[int]):
    size = len(base_offsets)
    return lambda k: base_offsets[k % size] + mod2_offsets[k % 2] * (k // size)

def generate_conductor(base_offsets: list[int], mod2_offsets: list[int]):
    degree = generate_degree(base_offsets, mod2_offsets)
    return lambda k: k + degree(k)

