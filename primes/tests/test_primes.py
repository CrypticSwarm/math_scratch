import numpy as np
from primes.primes import prime_table, eratosthenes

def test_prime_table():
   assert np.array_equal(prime_table(10), np.array([
       False, False, True, True, False, True, False, True, False, False
   ]))

def test_eratosthenes():
    assert np.array_equal(eratosthenes(10), np.array([
        2, 3, 5, 7
    ]))
    assert np.array_equal(eratosthenes(100), np.array([
         2,  3,  5,  7, 11, 13, 17, 19,
        23, 29, 31, 37, 41, 43, 47, 53, 
        59, 61, 67, 71, 73, 79, 83, 89,
        97
    ]))
