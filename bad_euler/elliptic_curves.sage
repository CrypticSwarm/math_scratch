from typing import Iterable

def elliptic_curves_from_conductors(conductors: Iterable[int]) -> EllipticCurve:
  """Iterate over all elliptic curves with the given set of conductors."""
  cdb = CremonaDatabase()
  for conductor in conductors:
    curve_labels = cdb.curves(conductor)
    for label in curve_labels:
      yield EllipticCurve(f'{conductor}.{label}')

def sum_array(arr1: Iterable[float], arr2: Iterable[float]) -> list[float]:
  return [a + b for a, b in zip(arr1, arr2)]

def combine_elliptic_curve_sequences(conductor: : Iterable[int], degree: Iterable[int]) -> dict:
  """Combines the conductor and degree elliptic curve symmetric power sequences."""
  return {
    'base_offsets': sum_array(conductor['base_offsets'], degree['base_offsets']),
    'mod2_offsets': sum_array(conductor['mod2_offsets'], degree['mod2_offsets'])
  }

def scan_combined_data(conductors: Iterable[int]):
  """For each elliptic curve add conductor and degree symmetric power sequences."""
  for curve in elliptic_curves_from_conductors(conductors):
      print(curve.label(), curve)
      for k, v in find_curve_formulas(curve).items():
          print('  ', k, combine_elliptic_curve_sequences(**v))
