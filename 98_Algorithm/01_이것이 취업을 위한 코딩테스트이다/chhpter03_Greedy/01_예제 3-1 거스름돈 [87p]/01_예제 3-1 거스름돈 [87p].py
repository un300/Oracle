
# 문제
# 당신은 음식점의 계산을 도와주는 점원이다. 카운터에는 거스름돈으로 사용할 500원, 100원, 50원, 10원짜리 동전이 무한히
# 존재한다고 가정한다. 손님에게 거슬러 주어야할 돈이 N원일때, 거슬러 주어야할 동전의 최소개수를 구하여라. 단, 거슬러
# 주어야할 돈은 N은 항상 10의 배수이다.



def solution(N):
    list1 = [500, 100, 50, 10]
    mok = 0

    for dongjeon in list1:
        mok += N // dongjeon
        N = N % dongjeon
    print(mok)


solution(1270)