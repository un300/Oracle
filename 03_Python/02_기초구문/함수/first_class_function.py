


##### first_class_function(일급함수)



# 간단한 함수를 하나 만들자
def add(x, y) :
    return x + y

print('caller : {}' .format(add(10, 20)))
print(add) # 함수명을 print하면.. 함수를 가르치는 주소값이 반환된다!!



# add가 가리키는 주소를 다른 변수(other_func)에 할당하면..
# 그것(other_func) 또한, add와 같은 함수를 수행한다
# 파이썬만 가능한 문법 구조
other_func = add
print(other_func)
print('other_funct : ', other_func(1, 2))



# 다음 'operation' 함수는 함수를 매개변수로 받는 함수이다!!
def operation(func, arg_list) :
    result = []
    for tmp1, tmp2 in arg_list :
        result.append(func(tmp1, tmp2))
    return result

data = [(1, 2), (3, 4), (5, 6)]
result = operation(add, data)  # add라는 함수를 매개변수로 받았다.
print(result)



# add 말고 다른 함수를 만들어, operation에 적용시켜보자
def mul(a, b) :
    return a * b

result = operation(mul, data)
print(result)











##### lambda식
# 메모리 상의 효율성을 위해 함수를 짜는 구문을 간단히 하자.

# 함수를 실행하려면, 아래처럼 함수를 만들고 함수를 호출해야한다.
def mul_func(x, y) :
    return x * y

result = mul_func(1, 2)




# 위 과정을 간단히! 하려면..

lambda_func = lambda x, y : x * y
print(lambda_func(1, 2))


















# 함수 < 클래스 < 모듈 < 패키지














