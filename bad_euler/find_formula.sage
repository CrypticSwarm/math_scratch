import random
from dataclasses import dataclass

Prime = int

P.<x> = ZZ[x]

@dataclass
class SymPowLCurveData:
    degree: list[int]
    conductor: list[int]

    @property
    def shifted_conductor(self):
        return [val - k for k, val in enumerate(self.conductor)]

@dataclass
class DeducedSymPowLStructure:
    base_offsets: list[int]
    mod2_offsets: list[int]
        
def get_curve_data(curve: EllipticCurve, p: Prime, num_entries: int = 48) -> SymPowLCurveData:
  E = gp(curve)
  conductor = [0]
  degree = [1]
  for k in range(1, num_entries):
      L = gp.lfunsympow(E, k)
      local_factor = P(gp.get(1 / gp.lfuneuler(L, p)))
      N = gp.lfunparams(L)[1].sage()
      val = valuation(N, p)
      degree.append(local_factor.degree())
      conductor.append(val)

  return SymPowLCurveData(degree, conductor)

def deduce_sequence_parameters(seq: list[int]):
  return DeducedSymPowLStructure(seq[0:12], [seq[12] - seq[0], seq[13] - seq[1]])

def find_curve_formula(curve: EllipticCurve, p: Prime):
  curve_data = get_curve_data(curve, p, 14)
  return {
    'conductor': deduce_sequence_parameters(curve_data.shifted_conductor),
    'degree': deduce_sequence_parameters(curve_data.degree)
  }

def find_curve_formulas(curve: EllipticCurve):
  return { p: find_curve_formula(curve, p) for p, pow in factor(curve.conductor()) }

def generate_degree(offsets: DeducedSymPowLStructure):
    return lambda k: offsets.base_offsets[k % 12] + offsets.mod2_offsets[k % 2] * (k // 12)

def generate_conductor(offsets: DeducedSymPowLStructure):
    degree = generate_degree(offsets)
    return lambda k: k + degree(k)

def check_degree_conductor_deduction(curve: EllipticCurve, p: Prime, num_entries: int):
    """
    Check deduced L function symmetric power deduction matches actual for the
    first num_entries values for both the conductor and degree of the euler
    factors.
    """
    curve_params = find_curve_formula(curve, p)
    conductor_fn = generate_conductor(curve_params['conductor'])
    degree_fn = generate_degree(curve_params['degree'])
    actual_curve_data = get_curve_data(curve, p, num_entries)
    for k in range(num_entries):
        assert conductor_fn(k) == actual_curve_data.conductor[k]
        assert degree_fn(k) == actual_curve_data.degree[k]

def fuzz_random_elliptic_curve_bad_primes(n: int):
    """Fuzz test random elliptic curve and check the first 100 entries."""
    for i in range(n):
        rand_curve = EllipticCurve([random.randint(-1000, 1000), random.randint(-1000, 1000)])
        print('Checking: ', rand_curve)
        for p, pow in factor(rand_curve.conductor()):
            print(f'  Checking prime: {p}^{pow}')
            check_degree_conductor_deduction(rand_curve, p, 100)
        print('No issues: ', rand_curve)

fuzz_random_elliptic_curve_bad_primes(10)
