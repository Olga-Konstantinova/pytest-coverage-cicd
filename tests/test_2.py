import pytest
from utils_2 import divide, modulus, power


def test_divide():
    assert divide(6, 3) == 2.0
    assert divide(-6, 2) == -3.0
    with pytest.raises(ValueError):
        divide(1, 0)


def test_power():
    assert power(2, 3) == 8
    assert power(5, 0) == 1
    assert power(4, -1) == 0.25


def test_modulus():
    assert modulus(10, 3) == 1
    assert modulus(10, 2) == 0
    with pytest.raises(ValueError):
        modulus(1, 0)
