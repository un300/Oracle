N = int(input())


answer = 0

for hour in range(N+1):
    for minute in range(60):
        for second in range(60):
            time = str(hour) + str(minute) + str(second)
            if '3' in time :
                answer += 1

print(answer)