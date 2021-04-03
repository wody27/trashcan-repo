def merge_sort(unsorted_list):
    if len(unsorted_list) <= 1:
        return unsorted_list
    mid = len(unsorted_list)//2
    left = unsorted_list[:mid]
    right = unsorted_list[mid:]
    left1 = merge_sort(left)
    right1 = merge_sort(right)
    return merge(left1, right1)

def merge(left, right): 
    i = 0
    j = 0
    sorted_list = []

    while (i < len(left)) & (j < len(right)):
        if left[i] < right[j]:
            sorted_list.append(left[i])
            i+=1
        else:
            sorted_list.append(right[j])
            j+=1
    while (i<len(left)):
        sorted_list.append(left[i])
        i+=1
    while(j<len(right)):
        sorted_list.append(right[j])
        j+=1

    return sorted_list

unsorted_list=list(map(int, input().split()))

print(merge_sort(unsorted_list))