

# 변수

'''
Python Built-in Types

- Numeric
- Sequence
- Text Sequence
- Set
- Mapping(dict, tulpe)
- Bool

변수지정 방법

- Camel Case : numberOfCollege      > 메소드, 함수에 사용
- Pascal Case : NumberOfCollege     > 클래스에 사용
- Snake Case : number_of_college    > 메소드, 함수에 사용
'''


import keyword

print(keyword.kwlist)

'''
변수는 숫자로 시작할 수 없고
특수분자 _ , $
예약어는 변수명으로 사용 불가능 하다.
'''



# 변수의 type

year = 2019
month = 8
day = 10
print('{}년 {}월 {}일' .format(year, month, day))
print(type(year), type(month), type(day))

intValue = 123
floatValue = 3.14159
bollValue = True
strValue = 'jslim'
print()
print(type(intValue), type(floatValue), type(bollValue), type(strValue))



# 변수의 형 변환 : type casting
num_str = "720"
num_num = 100
print(num_str + num_num) # 숫자 + 문자 > 에러!
print(int(num_str) + num_num)
print(str(num_num) + num_str)


year = "2020"
print(int(year) -1)




# 데이터 타입

str01 = "python"
bool = True
str02 = 'Anaconda'
float = 10.0
int11 = 20

list1 = [str01, str02]

dict = {
    "name"      : "machine learning",
    "version"   : 2.0
}

tup = (3, 5, 7)
set = {3, 5, 7}






# 키보드 입력
# input()

inputNumber = input("숫자를 입력하세요 : ")
print(inputNumber)
print(type(inputNumber))    # 입력받은 숫자를 출력하지만.. 믄자열(str)로 출력하게 된다.!


# 그렇기에 input시에 int형으로 변환한다면...
inputNumber = int(input("숫자를 입력하세요 : "))
print(inputNumber)
print(type(inputNumber))




# 파이썬 문자형 (중요합니다)
str01 = "I am Python"
str02 = 'python'
str03 = """this is a
 multiline 
 sample text"""
str04 = '''this is a
multiline 
sample text'''
print(str01, str02, str03, str04)


query = "select * from emp"\
        "where deptno = {no}"\
        "order by eno desc"

# 위에보다 밑에가 쓰기 더 편하다

query = '''
        select * from emp
        where deptno = {no}
        order by eno desc
        '''

print(query)



seqText = "Talk is cheap. Show me the code"
print(seqText)



# dir()
print(dir(seqText))


# slicing
seqText = "Talk is cheap. Show me the code"
print(seqText[3])
print(seqText[-1]) # 맨뒤에 인덱스를 출력하라!
print(seqText[0:4])


str_slicing = "Nice Python"
# Nice 만 출력하라
print(str_slicing[0:4])
# Python 만 출력하라
print(str_slicing[5:12])


# 인덱싱을 두칸의 스탭을 뛰고 가져와라
print(str_slicing[0:len(str_slicing):2])

# 문자열을 거꾸로 출력하라
print(str_slicing[ : : -1])



# 다음과 같은 문자열이 있을때, '홀'만 출력해보라
string = "홀짝홀짝홀짝홀짝"
string[0:len(string):2]

# 아래의 문자열의 첫 문자를 대문자로 만들고 싶다면??
string = "python"
print("Capitalize : ", string.capitalize())    # 문자열.capitalize() : 첫번째 문자를 대문자로



# 문자를 공백으로 치환하고 싶다면?
phone_number = "010-4442-2222"
replace_phone_number = phone_number.replace("-", " ")
print(replace_phone_number)

# 아래 문자열에서 소문자 a를 대문자로 변경한다면??
string = 'abcdefe2a3456a78aa654a8'
string = string.replace('a', 'A')
print(string)

# 아래 문자열에서 도메인만 출력한다면?
url = "http://naver.com"
url_split = url.split('.')
print(url_split[-1])



data = "       삼성전자      "
# strip(), rstrip(), lstrip()
data.strip()
data.rstrip()
data.lstrip()




ticker = "btc_krw"
# upper() : 모든 알파벳을 대문자로
upper_ticker = ticker.upper()
print(upper_ticker)
# lower() : 모든 대문자를 소문자로
ticker = upper_ticker.lower()
print(ticker)

# 참고! capitalize()는 맨 앞 소문자만 대문자로!









# endswith() : 객체의 이름이 무엇으로 끝이나는지 확인하는 함수
file_name = "report.xls"
isExits = file_name.endswith(("xls", "xlsx"))
print(isExits)



# split()
string = "삼성전자/LG전자/Naver/Google"
interest = string.split("/")
print(interest)


myStr = "This is a sample Test"
# in, not in  :  문자열 리스트에 내가 알고자하는 문자열이 있는지 확인하는 방법

print("sample" in myStr) # myStr에 "sample"이 포함되어 있기 때문에, True
print("Text" not in myStr) # myStr에 "sample"이 포함되어 있지 않기 때문에, True



brand_name = "cocacola"
result = len(brand_name)
print(result)
result = brand_name.count('c')
print(result)
result = brand_name.find('f')
print(result)   ## 원하는 값이 존재하면 index를 반환, 찾지못하면 -1반환
result = brand_name.index('a')
print(result)   ## 원하는 값이 존재하면 index를 반환, 찾지못하면 error!




# 문자의 아스키코드를 찾을때 : ord()
a = 'A'
print(ord(a))
# 아스키코드의 문자를 찾을때 : chr(아스키코드)
print(chr(65))


