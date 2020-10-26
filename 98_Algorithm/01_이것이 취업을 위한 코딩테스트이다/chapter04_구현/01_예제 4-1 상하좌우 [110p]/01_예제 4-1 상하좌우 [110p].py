# 문제

# 여행가 A는 N X N 크기의 정사각형 공간 위에 서있다.
# 이 공간은 1 X 1 크기의 정사각형으로 나누어져 있다.
# 가장 왼쪽 위의 좌표는 (1, 1)이며, 가장 오른쪽 아래 죄표는 (N, N)에 해당한다.
# 여행가 A는 상, 하, 좌, 우 방향으로만 이동하며, 시작좌표는 항상 (1, 1)이다.
# 계획서에는 하나의 줄에 띄어쓰기를 기준으로 하여 L, R, U, D중 하나의 문자가 반복적으로 젹혀있다.
# 각 문자의 의미는 다음과 같다
#  - L : 왼쪽으로 한칸이동
#  - R : 오른쪽으로 한칸이동
#  - U : 위로 한칸이동
#  - D : 아래로 한칸이동
#
# 이때 여행가 A가 N X N 크기의 정사각형 공간을 벗어나는 움직임은 무시된다.
#
# (1, 1)에 있는 여행가 A가 계획서를 만났을때
# `R > R > R > U > D > D`
# 여행가 A가 최종적으로 도착하는 좌표는 (1, 1)이된다
#
# 계획서가 주어졌을때, 여행가 A가 최종적으로 도착하는 지점의 좌표를 출력하는 프로그램을 작성하라.


import sys

N = int(sys.stdin.readline())
plan_list = list(sys.stdin.readline().split())

row = 1
col = 1

for element in plan_list :
    if element == 'R':
        temp_col = col
        col += 1
    elif element == 'L':
        temp_col = col
        col -= 1
    elif element == 'U':
        temp_row = row
        row -= 1
    elif element == 'D':
        temp_row = row
        row += 1

    if ( col > N ) | ( col < 1 ):
        col = temp_col
    if ( row > N ) | ( row < 1 ):
        row = temp_row

print(row, col)


