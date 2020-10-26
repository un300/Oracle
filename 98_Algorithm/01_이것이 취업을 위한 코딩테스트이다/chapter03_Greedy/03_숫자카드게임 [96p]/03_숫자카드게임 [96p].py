# 문제
# 숫자카드게임은 여러 개의 숫자 카드 중에서 가장 높은 숫자가 쓰인 카드 한장을 뽑는 게임이다.
# 단, 게임의 룰을 지키며 카드를 뽑아야하고 룰은 다음과 같다

# 1. 숫자가 쓰인카드들이 N X M의 형태로 놓여 있다. 이때 N은 행의 개수를 의미하고, M은 열의 개수를 의미한다.
# 2. 먼저 뽑고자 하는 카드가 포함되어 있는 행을 선택한다.
# 3. 그 다음 선택된 행에 포함된 카드들 중 가장 숫자가 낮은 카드를 뽑아야 한다.
# 4. 따라서 처음에 카드를 골라낼 행을 선택할 때, 이후에 해당 행에서 가장 숫자가 낮은 카드를 뽑을 것을 고려하여,
#    최종적으로 가장 높은 숫자의 카드를 뽑을 수 있도록 전략을 세워야한다.

# ( 1<= N, M <= 100 )

import sys

N, M = map(int, sys.stdin.readline().split())

result_list = []

for _ in range(N):
    temp_list = list(map(int, sys.stdin.readline().split()))
    temp_list.sort()
    result_list.append(temp_list[0])

result_list.sort()
print(result_list[N-1])


