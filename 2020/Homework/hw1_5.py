n=int(input())
times = []
for _ in range(n):
    a,b,c=map(int, input().split())
    times.append((a,b,c))
times = sorted(times, key=lambda x:(x[2],x[1]))

result = []
prev = 0
for time in times:
    if prev <= time[1]:
        prev = time[2]
        result.append(time[0])
print(len(result))
print(result)