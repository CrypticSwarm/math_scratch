from typing import Iterable

def elliptic_curves_from_conductors(conductors: Iterable[int]) -> EllipticCurve:
  """Iterate over all elliptic curves with the given set of conductors."""
  cdb = CremonaDatabase()
  for conductor in conductors:
    curve_labels = cdb.curves(conductor)
    for label in curve_labels:
      yield EllipticCurve(f'{conductor}.{label}')
