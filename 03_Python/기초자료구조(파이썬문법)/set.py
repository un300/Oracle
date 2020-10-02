

# 집합(set)
# 순서X, 중복X
# set()
# { value1 ,value2, value2, ... }


temp = set()
print(type(temp))
temp = {'jslim', 'teacher'}
print(type(temp))





# 선언..
# 헷갈린다.. 문법이라 어쩔수 없다
b = set([1, 2, 3, 4, 5])
print(type(b))


c = set([1, 3.14, 'Pen', False])
print(c)


print('casting : ', list(tuple(c)))



t = tuple(c)
print('casting : ', t, t[1:3])





s1 = set([1, 2, 3, 4, 5, 6])
s2 = set([4, 5, 6, 7, 8, 9])

# 교집합 (&) or intersection()
print(' & - ', s1&s2)
print(' & - ', s1.intersection(s2))

# 합집합 (|) or union()
print(' & - ', s1|s2)
print(' & - ', s1.union(s2))

# 차집합 (-) or difference()
print(' & - ', s1 - s2)
print(' & - ', s1.difference(s2))





s1 = set([1, 2, 3, 4, 5, 6])
s1.add(7)
print(s1)
s1.remove(9)  # 없는 원소를 지우려 할때 error 발생
s1.discard(9) # 없는 원소를 지우려 할때 None 반환






# set : 중복제거용도
gender = ['남', '여', '남', '여', '남', '여']
print(gender)

sgender = set(gender)
print(sgender)

lgender = list(sgender)
print(lgender)

print(lgender[0])
print(lgender[1])





s1 = set([1, 2, 3, 4, 5, 6])
print(s1)
print(dir(s1))



# set도 iterable하기 때문에 looping이 가능하다.
for idx in s1 :
    print(idx, end=" ")



































