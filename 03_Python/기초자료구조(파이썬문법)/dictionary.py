
# 파이썬 딕셔너리
# 범용적으로 가장 많이 사용되는 타입
# key와 value의 대응관계 type
# 순서 X, 키 중복 X, 수정 O, 삭제 O


# dictionary 선언
temp_dict = {}
type(temp_dict)
temp_dict2 = dict()


dict01 = {'name'    : 'seop',
          'age'     : 48,
          'adresss' : 'seoul',
          'birth'   : '730910',
          'gender'  : True}


# {}로 선언하는 것이 아니라 dict() 함수를 통해 선언하려면..
# 다음과 같이 선언해야한다!
dict02 = dict([('name', 'seop'),
               ('age', 48),
               ('adresss', 'seoul'),
               ('birth', '730910'),
               ('gender', True)])


# dictionary를 선언하는 또 다른 방법
dict03 = dict(name = 'seop',
              age = 48,
              adresss = 'seoul',
              birth = '730910',
              gender = True)



############# dict01을 선언했을 때 방법을 추천한다 : 가독성이 좋기때문





print('dictionary :', dict01, type(dict01))
print(dir(dict01))

# 키(key)의 유무를 판단하기 위해서
print('name' in dict01)


# 요소를 추가하는 방법 : key값이 'marriage'인 요소를 대입하라
dict01['marriage'] = False
print(dict01['marriage'])


# 위에서 marraige를 False로 잘못 입력했다. True로 고치려면?
dict01['marriage'] = True
print(dict01['marriage'])



# 데이터를 확인 : key값을 대입하여 value를 출력하자
dict01['birth']






# 출력 : 키값 'name'의 value를 가져올때!
print(dict03['name'])
print(dict03.get('name'))

# 위 두개의 차이점은?? 포함되어있지 않은 키값을 대입해보자
# 'salary'
print(dict03['salary'])         # 존재하지 않는 키값을 대입하면 error!!
print(dict03.get('salary'))     # 존재하지 않는 키값을 대입하면 None이 출렫


# dictionary의 길이는?
len(dict03)



# dictionary의 키값을 가져오거나 value값만을 가져오는 함수
dict03.keys()           # key값을 출력
temp1 = list(dict03.keys())
type(temp1)

dict03.values()         # value값을 출력
temp2 = list(dict03.values())
type(temp2)

print('dict_values :', dict03.values())
print('dict_values :', list(dict03.values()))





# dictionary.items() : (key : value)를 tuple형식으로 구성된 요소 리스트를 만들어줌
print('dict_items :', list(dict03.items()))
print('dict_items :', dict03.items())






for key in dict03.keys() :
    print('{0}, {1}' .format(key, dict03[key]))

for value in dict03.values() :
    print(value)

for value in dict03.items():
    print(value)







# 튜플 팩킹 & 언팩킹
t = ('foo', 'bar', 'baz', 'qux')
print(type(t))
x1, x2, x3, x4 = t
print(x1, x2, x3, x4)



a ,b ,c = (0, 1, 2, 3, 4, 5)  # 언팩킹시, 데이터의 개수와 변수의 개수가 맞지않는다면
                              # 에러가 나게된다.
# 해결법
a ,b ,*c = (0, 1, 2, 3, 4, 5)
print(a)
print(b)
print(c)  # 남는 원소들은 *c에 리스트 형식으로 들어가게된다.




for (key, value) in dict03.items():
    print('key : {0}, value : {1}' .format(key, value))




# dictionary 원소 삭제하는 방법 : del
del dict03['gender']
print(dict03)

# dictionay 원소 삭제하는 방법 : pop()
print('pop : ', dict03.pop('birth'))
print('dict03 :', dict03)



# dictionary의 모든 원소 삭제하는 방법
dict03.clear()
print('dict03 : ', dict03)






