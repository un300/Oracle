

def print_coins() :
    for i in range(100):
        print('bitcoin')


def first_function(w1) :
    print('Welcome To ~ 세진')


def return_funcion(name) :
    return '커피 사 줘요' + str(name)


def sum_function(x, y, z) :
    return x + y + z


# 가변인자 *args : 매개변수가 1개든 2개든 3개든 여러가지 개수로 입력할 때
def tuple_func(*args) :
    result = 0
    for idx in list(args) :
        result = result + idx
    return result



# 가변인자 **args : dictionary 형태의 데이터가 가변인자로 들어올때
def dic_function(**args) :
    for key, value in args.items() :
        print('{} = {}' .format(key, value))





# 일반적인 프로그래밍 언어는 함수다 두개이상의 값을 return할 수 없다
# 파이썬에는 tuple이라는 자료형이 있기때문에
# 두개 이상의 값을 tuple 형식으로 반환할 수 있다!
def multi_function(x, y) :
    sum = x + y
    mul = x * y
    return (sum, mul)






# flag = True : 만약 함수에 매개변수를 입력하지 않으면 default값으로 True를 입력하겠다는 뜻!
def default_function(x, y, flag = True) :
    sum = x + y
    if sum > 10 and flag :
        return sum
    else :
        return 0








def countSum(start, end) :
    oddSum = 0
    evenSum = 0

    for num in range(start, end+1) :
        if num % 2 != 0:
            oddSum += num
        else :
            evenSum += num

    return (oddSum, evenSum)





def countSum2(start, end) :
    if start % 2 != 0 :
        oddlist = list(range(start, end+1, 2))
        evenlist = list(range(start + 1, end + 1, 2))
    else :
        oddlist = list(range(start +1 , end + 1, 2))
        evenlist = list(range(start, end + 1, 2))

    return (sum(oddlist), sum(evenlist))








# operator에 따라서 +, -, *, / 연산을 수행하고
# 결과를 리턴하는 함수를 정의하세요

def calculator(op01, operator, op02) :
    op01 = int(op01)
    operator = str(operator)
    op02 = int(op02)
    if operator == '+' :
        answer = op01 + op02
    elif operator == '*' :
        answer = op01 * op02
    elif operator == '/' :
        answer = op01 / op02
    elif operator == '-' :
        answer = op01 - op02
    else :
        answer = '다른 연산자를 입력하라!'

    print('{} {} {} = {}' .format(op01, operator, op02, answer))

    return answer






def make_url(address) :
    return 'www.'+address+'.com'




def print_max1(a, b, c) :
    list1 = [a, b, c]
    arrange_list = sorted(list1, reverse = True)
    return arrange_list[0]

def print_max2(a, b ,c) :
    max = a

    if max < b :
        max = b

    if max < c :
        max = c

    return max





# 입력받은 연도가 윤년인지 평년인지 출력하는 함수를 만들어라
# 윤년 : 4의 배수이면서 100의 배수가 아니거나 / 400의 배수일때!

def leap_year(year) :

    if (year % 400 == 0) | ((year % 4 == 0) & (year % 100 != 0)) :
        answer = '윤년'
    else :
        answer = '평년'
    return answer




# 연도의 범위를 입력하였을때, 범위안에 모든 윤년을 출력하는 함수

# 내답변
def leap_year_loop1(start, end) :
    yoon_list = []
    for year in range(start, end + 1) :
        if (year % 400 == 0) | ((year % 4 == 0) & (year % 100 != 0)):
            yoon_list.append(year)

    mok = len(yoon_list) // 5
    for k in range(1, mok + 1) :
        print(yoon_list[(k-1)*5 : k*5])

# 강사님 답변
def leap_year_loop2(start, end) :
    yoon_list = []
    for year in range(start, end + 1) :
        if (year % 400 == 0) | ((year % 4 == 0) & (year % 100 != 0)):
            yoon_list.append(year)

    for idx in range(len(yoon_list)) :
        print(yoon_list[idx], end = '\t')

        if idx % 5 == 4:
            print()





def return_dict(x) :
    y1 = x * 10
    y2 = x * 20
    y3 = x * 30
    return {'val01' : y1, 'val02' : y2, 'val03' : y3}

























###### 나중에 고민한번 해보세요!


# 변수의 스코프


# x = 50  # 전역변수 : 같은 모듈 안에서는 어떤 함수든, 클래스든, 메소드든 사용이 가능한 변수
# add = 'Non Local'
#
# def local_function(x) :
#     add = 50  # 지역변수 : 하나의 메소드 안에서만 선언이 되었기에, 선언이된 메소드에서만 사용이 가능한 변수
#               #          add 변수는 local_function() 함수 안에서 선언 되었기 때문에
#               #          local_function() 함수를 벗어나면 사용될수 없다
#
#
#     print('과연 add는 함수 안에서 50인가 Non Local인가..? :', add)
#     x += add
#     print('local x: ', x)
#     return x
#
#
# local_function(x)
# print('Non local x : ', x)
# print('과연 add는 함수 밖에서 50인가 Non Local인가..? :', add)
#
#
#
#
#
# x = 50
# def explain_global(y) :
#     global x
#     x += y
#     print('inner func', x)
#
# explain_global(x)
# print('x : ', x )







# 전역변수
# data = [1, 3, 5, 7, 9]
# tot = 0

# for value in data :
#     tot += value
#
# print(tot)


# global 전역변수 이해하기

# data = [1, 3, 5, 7, 9]
# tot = 0
#
# def tot_calc(data) :
#     global tot  # 함수 밖에서 선언한 tot를 의미한다 즉, 여기서 tot = 0
#     for value in data :
#         tot += value
#     return tot
#
#
# print(tot_calc(data))
# print('tot : ', tot)






