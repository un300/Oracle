# 문제 1)
# 사용자로부터 하나의 값을 입력받아(input)
# 해당 값에 20을 뺀 값을 출력하라
# 단) 출력 값의 범위는 0 ~255이다
# 예를 들어 결과값이 0보다 작은 값이되는 경우 0을 출력하고
# 255보다 큰 값이 되는 경우 255을 출력해야한다.

def print_0255():
    N = int(input('정수를 입력하세요 :'))

    if N-20 > 255 :
        answer = 255
    elif N-20 < 0 :
        answer = 0
    else :
        answer = N - 20

    return answer


print_0255()



# 문제 2)
# 사용자로부터 입력 받은 시간이 정각인지 판별하라.
# 현재시간 : 02:00
# 현재시간 : 03:10


def No_minute() :
    time = input()
    if time[3:5] == '00':
        return '정각'
    else :
        return 'No 정각'

# 02:00
No_minute()

# 03:10
No_minute()




# 문제 3)
# 사용자로 입력받은 단어가 아래 fruit 리스트에 포함되어
# 있는지를 확인하라.
# 포함되었다면 "정답입니다"를 아닐 경우 "오답입니다" 출력하라.

fruit_list = ["사과", "포도", "홍시"]
def fruit():
    fruit = input()
    if fruit in fruit_list:
        print('정답입니다.')
    else :
        print('오답입니다.')

fruit()


# 문제 4)
# 투자 경고 종목 리스트가 있을 때
# 사용자로부터 종목명을 입력 받은 후
# 해당 종목이 투자 경고 종목이라면 '투자 경고 종목입니다'를
# 아니면 "투자 경고 종목이 아닙니다."를 출력하는 프로그램을 작성하라.


warn_investment_list = ["Microsoft", "Google", "Naver", "Kakao", "SAMSUNG", "LG"]
def investment():
    name = input()
    if name in warn_investment_list:
        print('투자 경고 종목입니다.')
    else :
        print('투자 경고 종목이 아닙니다.')

investment()


# 문제 5)
# 아래와 같이 fruit 딕셔너리가 정의되어 있다.
# 사용자가 입력한 값이 딕셔너리 키 (key) 값에 포함되었다면 "정답입니다"를
# 아닐 경우 "오답입니다" 출력하라.


fruit = {"봄" : "딸기", "여름" : "토마토", "가을" : "사과"}

def fruit_dict():
    user_answer = input()
    if user_answer in fruit.keys():
        print('정답입니다.')
    else:
        print('오답입니다.')

fruit_dict()



# 문제 6)
# 사용자로부터 문자 한 개를 입력 받고,
# 소문자일 경우 대문자로,
# 대문자 일 경우, 소문자로 변경해서 출력하라.
# hint -  islower() 함수는 문자의 소문자 여부를 판별합니다.



def upside():
    a = [1, 1]
    while len(a)!=1:
        a = input('알파벳 하나를 입력하세요 : ')

    if a.islower():
        answer = a.upper()
    else :
        answer = a.lower()

    return answer


upside()

# 문제 7)
# 점수 구간에 해당하는 학점이 아래와 같이 정의되어 있다.
# 81~100 A
# 61~80	 B
# 41~60	 C
# 21~40	 D
# 0~20	 E
# 사용자로부터 score를 입력받아 학점을 출력하라.


def grade():
    score = int(input())
    if score > 80 :
        answer = 'A'
    elif score > 60 :
        answer = 'B'
    elif score > 40 :
        answer = 'C'
    elif score > 20 :
        answer = 'D'
    else :
        answer = 'E'

    return answer


grade()




# 문제 8)
# 사용자로부터 세 개의 숫자를 입력 받은 후
# 가장 큰 숫자를 출력하라.
# input number1: 10
# input number2: 9
# input number3: 20

def print_desc():
    temp_list = list(map(int, input().split()))
    desc_list = sorted(temp_list, reverse=True)
    return desc_list[0]

print_desc()



# 문제 9)
# 휴대폰 번호 앞자리에 따라 통신사는 아래와 같이 구분된다. 사용자로부터 휴대전화 번호를 입력 받고, 통신사를 출력하는 프로그램을 작성하라.
# 번호	통신사
# 011	SKT
# 016	KT
# 019	LGU
# 010	알수없음
# 휴대전화 번호 입력: 011-345-1922

def phone_number():
    phone = input()
    detect = phone[2]
    if detect == '1':
        answer = 'SKT'
    elif detect == '6':
        answer = 'KT'
    elif detect == '9':
        answer = 'LGU'
    elif detect == '0':
        answer = '알수없음'
    else :
        answer = '잘못된 번호입니다.'

    return answer



phone_number()


# 문제 10)
# 주민등록번호 뒷 자리 7자리 중 첫째 자리는 성별을 나타내는데
# 1, 3은 남자 2, 4는 여자를 의미한다.
# 사용자로부터 13자리의 주민등록번호를 입력 받은 후 성별 (남자, 여자)를 출력하는 프로그램을 작성하라.
# >> 주민등록번호: 821010-1635210

def gender_detect():
    ssn = input('주민번호를 입력하시오 : ')
    detect_num = ssn[7]

    if detect_num == '1' or detect_num == '3':
        gender = '남자'
    elif detect_num == '2' or detect_num == '4':
        gender = '여자'
    else :
        gender = '잘못된 주민등록 번호입니다.'

    return gender

gender_detect()



# 문제 11)
# 주민등록번호의 뒷 자리 7자리 중 두번째와 세번째는 지역코드를 의미한다.
# 주민 등록 번호를 입력 받은 후 출생지가 서울인지 아닌지 판단하는 코드를 작성하라
# 지역코드	출생지
# 00 ~ 08	서울
# 09 ~ 12	부산


def gender_detect():
    ssn = input('주민번호를 입력하시오 : ')
    detect_num = int(ssn[8:10])

    if detect_num >= 0 and detect_num <= 8:
        area = '서울'
    elif detect_num >= 9 and detect_num <= 12:
        area = '부산'
    else :
        area = '모름'

    return area

gender_detect()



# 문제 12)
# 어떤 대학교를 졸업하려면 적어도 140학점을 이수해야
# 하고 평점이 2.0은 되어야 한 다고 하자.
# 이것을 파이썬 프로그램으로 검사해보자.
# 사용자에게 이수학점수와 평점을 물어보고 졸업 가능 여부를 출력하는 프로그램을 작성해보자.



def graduation():
    credits = float( input("이수한 학점을 입력하세요 : "))
    avg = float( input("평점을 입력하세요 : "))

    if credits >= 140 and avg >= 2 :
        answer = '축 졸업'
    else:
        answer = '어뜨케..'

    return answer

graduation()

# 문제 13)
# 1부터 10사이의 난수를 생성하고 숫자를 맞춰보자
from random import randint

def game():
    guess = int(input('1 ~ 10사이에 무슨 숫자일까요 ㅎ :'))
    random_num = randint(1, 10)

    while guess != random_num :
        guess = int(input('다시!'))

    print('정답은 ', random_num, '였어요 ㅎㅎ..')


game()

# 문제 14)
# input()함수를 이용하여 입력받은 숫자가 홀수인지 짝수인지를 판단하는 프로그램을 작성하라.
# 홀수면 '홀수'라고 출력하고 짝수면 '짝수'라고 출력하시오
# +, - , / , * , %(나머지 연산자)

def evenOrodd():
    n = int(input())

    if n % 2 == 0:
        answer = '짝수'
    else :
        answer = '홀수'
    return answer


evenOrodd()