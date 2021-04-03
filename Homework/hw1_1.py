def binarySearch(numbers, toFind):
    low = 0
    high = len(numbers)-1
    while(low<=high):
        mid = (low + high) // 2
        if numbers[mid] == toFind:
            return mid + 1
        elif numbers[mid] < toFind:
            low = mid + 1
        else:
            high = mid - 1
    return -1

if __name__=='__main__':
    numbers=input()
    toFind=int(input())
    numbers = numbers.split()
    for i in range(0,len(numbers)):
        numbers[i] = int(numbers[i])
    result = binarySearch(numbers, toFind)
    if result == -1:
        print("None")
    else:
        print(result)

