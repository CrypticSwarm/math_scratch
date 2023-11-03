Prime = int

function find_conductor(curve_num: int, p: Prime):
  pass

function find_degree(curve_num: int, p: Prime):
  pass

def find_curve_formulas(curve_num: int):
  return {
    p: {
      conductor: find_conductor(curve_num, p),
      degree: find_degree(curve_num, p)
    } for p, pow in factor(curve_num)
  }

def generate_degree(base_offsets: list[int], mod2_offsets: list[int]):
    size = len(base_offsets)
    return lambda k: base_offsets[k % size] + mod2_offsets[k % 2] * (k // size)

def generate_conductor(base_offsets: list[int], mod2_offsets: list[int]):
    degree = generate_degree(base_offsets, mod2_offsets)
    return lambda k: k + degree(k)

