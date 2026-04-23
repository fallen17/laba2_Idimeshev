def all_digits_the_same(number):
    if number < 10:
        return False
    strNum = str(number)
    firstDig = strNum[0]
    for item in strNum:
        if item != firstDig:
            return False
    return True

def main():
    print("Type in N amount of numbers... And then write numbers...")
    amountN = int(input())  
    if amountN < 1:
        print("N can't be less than 1...")
        return
    numbers = []
    for i in range(amountN):
        num = int(input())
        numbers.append(num)
    for item in numbers:
        if all_digits_the_same(item):
            print(item, end=" ")
    print()


if __name__ == "__main__":
    main()