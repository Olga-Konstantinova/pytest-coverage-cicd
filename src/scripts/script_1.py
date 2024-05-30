from utils import divide, modulus, power


def main():
    print("2 raised to the power of 3:", power(2, 3))
    print("Modulus of 10 and 3:", modulus(10, 3))

    try:
        print("Division of 10 by 0:", divide(10, 0))
    except ValueError as e:
        print("Error:", e)

    try:
        print("Modulus of 10 and 0:", modulus(10, 0))
    except ValueError as e:
        print("Error:", e)


if __name__ == "__main__":
    main()
