

# 파이썬 튜플
# 리스트와 비교 (중요)
# 튜플 자료형(순서가 있고, 중복이 허용되며, 수정이 안되고, 삭제가 불가능하다)
# 불면(Immutable)
# 읽기 전용
# 사실 tuple은 현업에서 사용빈도가 리스트와 딕셔너리에 비하여 떨어진다






# 선언

tup = ()
tup = tuple()
movie_rank = ('반도', '강철비2', '아이언맨')
movie_rank

test_tuple = (1)
print(type(test_tuple))   # 튜플의 요소가 하나일땐.. 스칼라값으로 인식한다! 그러므로 하나의 원소를 튜플로 넣을땐 다음과 같이 입력해야한다

test_tuple = (1,)
print(type(test_tuple))


# 사용자의 편의를 위해 괄호없이 튜플을 선언할 수 있다.
test_tuple = 1, 2, 3, 4, 5
print(test_tuple, type(test_tuple))


# 또한, 튜플의 원소들도 리스트와 마찬가지로 여러가지 타입이 올 수 있다.
multi_tuple = (100, 1000, 'Ace', 'Base', 'Captine')
print('tuple print : ', multi_tuple)



print('튜플 인덱싱>>>>>>>>>>>>>')
print('index 1: ', multi_tuple[1])
print('index 1: ', multi_tuple[0] + multi_tuple[1])
print('slicing : ', multi_tuple[2:5])  ## 튜플 인덱싱은 튜플로 반환된다


# 튜플은 수정이 안되기 때문에, 리스트로 변환하여 수정, 삭제, 변환 하는것이 편하다!
print(type(multi_tuple[2:5]))
list1 = list(multi_tuple[2:5])
print(list1, type(list1))




# 1 ~ 99까지의 정수 중 짝수만 저장된 튜플을 생성한다면?

even = tuple(range(2, 100, 2))
print(even)














