import numpy as np
import numba as nb

@nb.njit
def prime_table(table_size: int):
    table = np.ones(table_size, dtype='bool')
    table[0:2] = 0
    table[4::2] = 0
    for i in range(3, table_size, 2):
        if table[i]:
            table[(i + i)::i] = 0
    return table

@nb.njit
def eratosthenes(table_size: int):
    table = prime_table(table_size)
    result_size = table.sum()
    result = np.zeros(result_size, dtype="int32")
    result[0] = 2
    out_index = 1
    for i in range(3, table_size, 2):
        if table[i]:
            result[out_index] = i
            out_index += 1
    return result
