


# 리스트(list)
# 자료구조에서 중요
# 파이썬에는 배열 존재하지 않는다!!
# 1차원 자료구조로서 R의 Vector와 비슷하게 볼 수 있다.
# 순서가 있고, 중복도 가능하다. 또한 수정 삭제가 가능하다.
# index를 사용한다
# [] 이용하여 변수를 선언할 수 있다.


# 선언
a = list()
a = []
a = [1, 2, 3]
a = [1, 2, "hello", 3, 4]   # 리스트의 요소들은 모두 같은 타입일 필요가 없다.
a = [1, 2, ["show", "me", "the", "money"], 3.14]  # 리스트 안에 리스트가 와도 된다!

print(a, type(a))


# 슬라이싱 가능
print(a[0])
print(a[-1])
print(a[2])
inner_list = a[2]
print(inner_list[1])
print(a[2][1:3])
print(a[-2][-1])


# list 연산가능
# +(더하기)
a = [1, 2, 3]
b = [4, 5, 6]
print(a+b)  ## 리스트는 여라가지 원소타입을 포함하기에 + 는 원소끼리의 합이 아니라
            ## 리스트를 일렬로 합쳐버린다.

c = a + b
print(c, type(c))



# *(곱하기)
print('*' * 50)
print(a * 3)


# append() : 리스트의 마지막에 원소를 집어널어라
a = [1, 2, 3]
a.append(4)
print(a)

# insert() : 지정한 인덱스에 원소를 집어넣어라
a.insert(0, 6)
print(a)


# sort() : 리스트를 오름차순으로 정렬 (원본을 정렬하기에 주의해야한다.)
a.sort()
print(a)

# reverse() : 리스트를 내림차순으로 정렬 (원본을 정렬하기에 주의해야한다.)
a.reverse()
print(a)



# pop() : 기존 리스트의 마지막 인덱스에 있는 원소를 삭제하고, 동시에 반환한다.
print(a)
print(a.pop())
print(a)


# extend() : append()와 비슷한 함수이다. 차이점은 append()는 하나의 스칼라 값만을 추가하지만
#            extend()는 여러가지 원소를 동시에 추가하는 함수이다.
ex = [4, 3]
a.extend(ex)
print(a)






# ---- 실습
movie_rank = ['강철비2', '반도', '다만 악에서 구하소서', '인셉션']
# 삭제시에 del 명령어를 이용해서 해당 인덱스를 제거할 수 있다.

# 1. 해당리스트에 "배트맨"을 추가하세요
movie_rank.append("배트맨")
print(movie_rank)

# 2. 강철비2와 반도 사이에 "슈퍼맨"을 추가하세요
movie_rank.insert(1, "슈퍼맨")
print(movie_rank)

# 3. 리스트에서 "인셉션"을 삭제하세요
del(movie_rank[4])
print(movie_rank)

# 4. 리스트에서 "다만 악에서 구하소서"와 "배트맨"을 삭제
movie_rank.pop()
movie_rank.pop()
print(movie_rank)

# 5 "반도"의 인덱스를 출력하시오
movie_rank.index("반도")


# 6 "다만 악에서 구하소서"의 인덱스를 모른다고 할때, 지워보시오
movie_rank = ['강철비2', '반도', '다만 악에서 구하소서', '인셉션']

print("index : ", movie_rank.index("다만 악에서 구하소서"))
idx = movie_rank.index("다만 악에서 구하소서")
del movie_rank[idx]
print(movie_rank)

# 7 "다만 악에서 구하소서"의 인덱스를 모른다고 할때, pop()를 사용하여 지워보시오
movie_rank = ['강철비2', '반도', '다만 악에서 구하소서', '인셉션']

print("index : ", movie_rank.index("다만 악에서 구하소서"))
idx = movie_rank.index("다만 악에서 구하소서")
movie_rank.pop(idx)
print(movie_rank)







# ---- 실습2

# 다음 리스트에소 최댓값과 최솟값 및 총합, 평균을 출력하라. (min(), max())
nums = [1, 2, 3, 4, 5, 6, 7]

print('평균 : ', sum(nums) / len(nums))  ## 파이썬 내장함수에 평균을 구하는 함수는 없어요.. 평균함수는 numpy써야해요
print('최댓값 :', max(nums))
print('최소값 :', max(nums))
print('총합 :', sum(nums))


# 리스트에 저장된 데이터의 개수를 화면에 구하라
cook = ["피자", "김밥", "만두", "양념치킨", "족발", "피자", "김치만두", "쫄면", "쏘세지", "라면", "팥빙수", "김치전"]
len(cook)



# price 변수에는 날짜와 종가 정보가 저장돼 있다.
# 날짜 정보를 제외하고 가격 정보만을 출력하라. (힌트 : 슬라이싱)

price = ['20180728', 100, 130, 140, 450, 460, 470]
price[1:len(price)]


# 슬라이싱을 사용하여 홀수, 짝수를 출력하라
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print('홀수는 : ', nums[::2])
print('짝수는 : ', nums[1::2])

# 슬라이싱을 이용하여 리스트의 숫자를 역 방향으로 출력하라
nums = [1, 2, 3, 4, 5]
nums[::-1]


# interest 리스트에는 아래의 데이터가 바인딩되어있다.
# 삼성전자, Naver 만출력
interest = ['삼성전자', 'LG전자', 'Naver']
index = interest.index('LG전자')
interest.pop(index)
interest









# join()
interest = ['삼성전자', 'LG전자', 'Naver', 'SK하이닉스', '미래에셋']
print(interest)

print(''.join(interest))
print(' / '.join(interest))
print(' | '.join(interest))
print(' @ '.join(interest))
print('\n'.join(interest))
print(type(' @ '.join(interest)))





# python sequence type range()
# range() : 숫자 sequence 주로 for ~ 사용
range_01 = range(10)
print("range_01 : ", range_01)
range_02 = range(1, 11, 2)
print('range_02 : ', range_02)



# for 함수
for i in range(10):
    print(i)











