


# 파이썬 사용자 입력 함수
# input()


name = input("Enter Your Name :")
name = input("Enter Your Grade :")
name = input("Enter Your Company Name :")
score = int(input('Enter Your score :'))

print(score + 100, type(score))





# 파이썬 제어문
# if, if ~ else, if ~ elif ~ else
# bool True : 0이 아닌수, 문자, 데이터가 있는 리스트, 튜플, 딕셔너리

if True :
    print('True')

if False :
    print('Bad')

if not False :
    print("Bad")

if False :
    print('Bad')
else :
    print('Good')


# 아래의 값이 3의 배수인지 5의 배수인지
# 3의 배수도 5의 배수도 아닌지를 검정하고 싶다면?

number = 15

if (number % 3 == 0 & number % 5 == 0) :
    print('{}은 3의 배수 또는, 5의 배수입니다.' .format(number))
else :
    print('{}은 3과 5의 배수가 아닙니다.' .format(number))



# 윤년의 조건
# 4의 배수이고, 100의 배수가 아니거나
# 400의 배수일때를 윤년으로 본다.
# if 구문을 사용하여 연도와 월을 입력 받아서 월의 마지막 일을 출력하라.



def calculate_leap() :
    year = int(input('연도를 입력하세요 : '))
    month = int(input('월을 입력하세요 : '))
    days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    leap_year_days = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    if year % 400 == 0 :
        print('윤년입니다.')
        print('{}년 {}월의 마지막 날은 {}일 입니다.' .format(year, month, leap_year_days[month-1]))
    elif (year % 4 == 0) & (year % 100 != 0) :
        print('윤년입니다.')
        print('{}년 {}월의 마지막 날은 {}일 입니다.'.format(year, month, leap_year_days[month-1]))
    else :
        print('윤년이 아닙니다.')
        print('{}년 {}월의 마지막 날은 {}일 입니다.'.format(year, month, days[month-1]))


calculate_leap()



# |, or 차이점
# T | F 일때 : 앞에 T만으로 T를 판단한다. 즉, 뒤에 F는 보지도 않는다
# T or F 일때 : 앞에 T와 뒤에 F까지 보고 T임을 판단한다.




# 중첩조건문
# A학점이면서 95이상의 점수면 장학금 100%
# A학점이면서 90이상의 점수면 장학금 90%
# A학점이 아니면 장학금 50%

grade = input('학점 입력 : ')
total = int(input('점수 입력 : '))

if grade == 'A' :
    if total >= 95 :
        print("장학금 100%")
    else :
        print("장학금 95%")
else :
    print("장학금 50%")


area = ['서울', '부산', '제주']
region = '수원'

if region in area :
    pass
else :
    print("{} 지역은 포함되지 않습니다" .format(region))




myDict = {'서울':100, '광주':200}
region = '부산'

if region in myDict :
    print('키 값이 dict안에 있습니다.')
else :
    print('키 값이 dict안에 없습니다.')




num = 9
result = 0
if num >= 5:
    result = num * 2
else :
    result = num + 2
print(result)


# 삼항 연산자
num = 2
result = num * 2 if(num >= 5) else num + 2
result



# 참, 거짓 판별 종류
city = ""
if city :   # 데이터가 들어있는경우 : True라고 판단
    print(city)
else :
    print("Please enter your city")


city = " "
if city :   # 데이터가 들어있는경우 : True라고 판단
    print(city)
else :
    print("Please enter your city")



money = 1
if money :
    print('맛점하세요~')
else :
    print('더 맛점하세요~')







# 사용자로부터 하나의 값을 입력받아(input)
# 해당 값에 20을 뺀 값을 출력하라
# 단) 출력 값의 범위는 0 ~ 255이다
# 예를 들어 결과 값이 0보다 작은 값이 되는 경우, 0을 출력하고,
# 255보다 큰 값이 되는 경우 255를 출력해야한다.






def print_0255():
    N = int(input('정수를 입력하세요 :'))

    if N-20 > 255 :
        answer = 255
    elif N-20 <0 :
        answer = 0
    else :
        answer = N - 20

    return N-20


print_0255()










