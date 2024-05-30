def divide(a, b):
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b


def power(a, b):
    return a**b


def modulus(a, b):
    if b == 0:
        raise ValueError("Cannot perform modulus by zero")
    return a % b
