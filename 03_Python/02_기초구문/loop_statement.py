

# 파이썬 반목문
# for / while







# for 문
# for idx in <collection> :
# for ifx in range(start, stop, step) :


for idx in range(1, 10) :
    print('idx : ', idx)


for idx in range(0, 11, 2):
    print('idx : ', idx)









# 성적을 입력받아 출력하는 코드를 작성해보자

scores = []
for _ in range(5) :
    scores.append(int(input('성적을 입력하세요 : ')))

for idx in scores :
    print(idx)


for idx in range(len(scores)) :
    print(scores[idx], "\t", end=" ")








# 입력받은 성적의 총합과 평균을 구하세요
def my_solution() :
    scores = []
    for _ in range(5) :
        scores.append(int(input('성적을 입력하세요 : ')))
    print('총합 : ', sum(scores))
    print('평균 : ', sum(scores) / len(scores))

my_solution()


def teacher_solution() :
    sum = 0
    scores = []
    for _ in range(5) :
        scores.append(int(input('성적을 입력하세요 : ')))

    for element in scores :
        sum += element
    avg = sum / len(scores)
    print("총합 : ", sum)
    print("평균 : ", sum / len(scores))


teacher_solution()







# 리스트 자료형에 들어있는 개수를 세어보자

import random

def counter() :
    cnt_list = [random.choice([1, 2, 3, 4, 5]) for _ in range(100)] # 1~5사이 아무값이나 100개를 생성
    factor = list(set(cnt_list))

    for idx in factor :
        print('{}의 개수 : {}' .format(idx, cnt_list.count(idx)))

counter()



def teacher_solution() :
    cnt_list = [random.choice([1, 2, 3, 4, 5, ' ']) for _ in range(100)]
    freq = {}

    for i in cnt_list :
        if i in freq :
            freq[i] += 1    # dict안에 key값이 존재하면? value를 하나 증가
        else :
            freq[i] = 1     # dict안에 key값이 존재하지 않으면? dict안에 key값과 value를 생성!
    print(freq)


teacher_solution()










# 단어의 빈도를 세어보자 (선생님의 방법으로 풀어보세요 : Use Dictionary)

def word_count() :
    word_vec = ['corona', 'corona', 'corona', 'corona', 'corona', 'corona',
                'love', 'love', 'love', 'love', 'bigdata', 'bigdata', 'bigdata',
                'data', 'data', 'data',
                'JeaWon', 'JeaWon', 'JeaWon', 'JeaWon',
                'Python', 'Python', 'Python', 'Python', 'Python', 'Python', 'Python']
    word_dict = {}

    for element in word_vec :
        if element in word_dict :
            word_dict[element] += 1
        else :
            word_dict[element] = 1
    print(word_dict)



word_count()







# 1 ~ 1000의 합

range_sum = 0
for value in range(1, 1001) :
    range_sum += value
range_sum





# 구구단 3단을 출력한다면?

def GooGooDan_3() :
    dan = 3
    for idx in range(1, 10) :
        print(dan, ' * ', idx, ' = ', dan*idx)

GooGooDan_3()


# 구구단 3단을 출력하는데,
# 홀수번째만 출력한다면?

def GooGooDan_3_odd() :
    dan = 3
    for idx in range(1, 10) :
        if idx % 2 ==1 :
            print(dan, ' * ', idx, ' = ', dan*idx)

GooGooDan_3_odd()







# 다양한 데이터를 다루는 loop구문
my_list = [(1, 2), (3, 4), (5, 6)]
my_sum = 0
for (key, value) in my_list :
    my_sum += key + value
print(my_sum)





my_sum = 0
my_list = [('name', 2), ('age', 4), ('addr', 6)]
for (key, value) in my_list :
    print('key : {}, value : {}' .format(key, value))









# list comprehension
# list 안에서 복잡한 표현식을 적용하는 것
temp_list = [1, 2, 3, 4, 5, 6, 7, 8, 9]
score01 = [idx * 3 for idx in temp_list if idx % 2 == 1]
print(score01)
score02 = [idx * 2 for idx in temp_list if idx % 2 == 0]
print(score02)








# 올림픽은 4년에 한번 개최된다.
# 2000년 ~ 2050년 까지 중 올림픽이 개최되는 연도를 출력

def olympic_year() :
    for year in range(2000, 2051, 4):
        print(year)

olympic_year()





# 아래 리스트에서 20보다 작은 3의 배수를 출력하라.
list_num = [12, 21, 12, 14, 30, 38, 34, 18]
[element for element in list_num if (element < 20) & (element % 3 == 0)]



# 아래 리스트에서 세 글자 이상의 문자를 출력하라
list_str = ['I', 'am', 'study', 'python', 'language', '!']
[element for element in list_str if len(element) > 2]



# 아래 리스트에서 대문자만 화면에 출력하라.
list_str = ['dog', 'cat', 'PIG', 'parrot', 'horse']
[element for element in list_str if element.isupper()]



# 아래 리스트에서 첫 글자를 대문자로 변경하여 출력하라
list_str = ['dog', 'cat', 'pig', 'parrot', 'horse']
[element.capitalize() for element in list_str]



# 아래 리스트에 파일 이름이 저장되어 있다.
# 확장자를 제거하고 파일 이름만 출력하라.
list_file = ['greeting.py', 'ex01.py', 'intro.hwp', 'bigdata.doc']

list_split = list(map(lambda x : x.split('.'), list_file))
[element[0] for element in list_split]






# 문자열 loop
# 문자열도 iterable하기에 indexing과 looping이 가능하다!
word = 'Handsome'
for idx in word :
    print(idx, end=',')




def delete_comma():
    my_dict = {'name' : 'jslim',
               'age' : 48,
               'city' : 'seoul'}

    list_key = list(my_dict.keys())

    for idx in range( len(list_key)-1 ) :
        print(list_key[idx], end=', ')
    print(list_key[ len(list_key)-1 ], end='')

delete_comma()













# upper()
# 전체 문자를 대문자로 출력하라.
# for문을 이용해서 풀어보세요

fruit_name = 'FineApplE'

for name in fruit_name :
    if name.islower():
        print(name.upper(), end='')
    else :
        print(name, end='')



# break : for문을 빠져나와라!

numbers = [14, 3, 6, 17, 34, 25]

for num in numbers :
    if num == 17:
        print(num)
        break
    else :
        print('Not Found')




# continue : 밑의 코드를 실행하지 않고 for문의 다음 index로 넘어가라!
numbers = [14, 3, 6, 17, 34, 25]
for num in numbers :
    if num == 17 :
        continue
        print(num)
    else :
        print(num)




# for ~ else 구문 : for구문이 다 돌았을때 else를 실행하라
#                  for구문이 다 돌지 않았을때는 else가 실행되지 않는다.

for num in numbers :
    if num == 300:
        print(num)
        break
else :
    print('Not Found')












# 구구단 만들기
def GooGooDan():
    for i in range(1, 10) :
        for j in range(2, 10) :
            print('{} X {} = {}' .format(j, i, j * i), end='\t\t')
        print()

GooGooDan()

# 5단 까지만 출력
# break 사용
def GooGooDan_by5():
    for i in range(1, 10) :
        for j in range(2, 10) :
            if j == 6:
                break
            print('{} X {} = {}' .format(j, i, j * i), end='\t\t')
        print()


GooGooDan_by5()



# 5단을 제외하고 출력
# continue사용
def GooGooDan_exept5():
    for i in range(1, 10) :
        for j in range(2, 10) :
            if j == 5:
                continue
            print('{} X {} = {}' .format(j, i, j * i), end='\t\t')
        print()

GooGooDan_exept5()














# 다음 글을 문장은 문장리스트에, 단어는 단어리스트에 포함시켜라

string = \
'''
저는 파이썬 강의중인 임섭순 입니다.
주소는 광주광역시 입니다.
나이는 숫자에 불과하지만 성인병이 있네요.
'''


sentences = []
words = []


# list명.append(), list명.insert(index, value)

# sentences / word 담기
for s in string.split('\n'):
    sentences.append(s)
    for w in s.split():
        words.append(w)
print(sentences)
print(words)














# [실습] 분류정확도


# 내가구현

def error_calculate(answer, predict):
    error = []
    for i in range(len(answer)) :
        error.append(answer[i] - predict[i])
    return error

answer = [1, 0, 2, 1, 0]
predict = [1, 0, 2, 0, 0]

error_calculate(answer, predict)





# 강사님 구현

def teacher_calculate(answer, predict):
    acc = 0
    for i in range(len(answer)):
        fit = answer[i] == predict[i]
        acc += int(fit) * 20
    return acc

answer = [1, 0, 2, 1, 0]
predict = [1, 0, 2, 0, 0]

teacher_calculate(answer, predict)











# enumerate
# 반복문 사용시 iterator의 원소값과 그 원소의 index를 함께 반환한다,
# 인덱스번호와 컬렉션 요소를 확인 할 수 있다.

list = ['sql', 'R', 'Text-Mining', 'Data-Mining', 'Python']

for value in list :
    print(value)



# 만약 위 경우에서 리스트 원소에 대한 인덱스가 필요하다면?

list = ['sql', 'R', 'Text-Mining', 'Data-Mining', 'Python']

for index, value in enumerate(list) :
    print('{}번째 인덱스이고 값은 {}입니다' .format(index, value))



list = ['sql', 'R', 'Text-Mining', 'Data-Mining', 'Python']

for index, value in enumerate(list) :
    print('{}번째 인덱스이고 값은 {}입니다' .format(index, value))














# 리스트나 tuple의 빈도수를 체크하는 방법
# list명.count()
# tuple명.count()

word_vec = ['corona', 'corona', 'corona', 'corona', 'corona', 'corona',
            'love', 'love', 'love', 'love', 'bigdata', 'bigdata', 'bigdata',
            'data', 'data', 'data',
            'JeaWon', 'JeaWon', 'JeaWon', 'JeaWon',
            'Python', 'Python', 'Python', 'Python', 'Python', 'Python', 'Python']

word_vec = tuple(word_vec)
freq = {}

for i in word_vec :
    freq[i] = word_vec.count(i)

print(freq)





####################################################################################### for문 끝

# while문은 for문과 비슷하기에..
# 많이 다루지는 않습니다.


# while

# while <expression>
#       statement
#       증감식 (ex i += 1)

n = 5
while n > 0 :
    print(n)
    n -= 1





# 아래 처럼하면...
# 무한루프를 돌게 된다
a = ['foo', 'bars', 'baz']
while a :   # a는 데이터가 포함되어 있기 때문에 True로 인식되기 때문!
    print(a)

# 그렇기에 아래처럼 구문을 짜야한다
a = ['foo', 'bars', 'baz']
while a :
    print(a.pop())






# while 이용하여 1 ~ 100까지의 합, 5의 배수의 합, 3의 배수이면서 5의 배수가 아닌합을 출력하라

all = five = threeNotFive = 0
i = 1

while i < 101:
    all += i
    if i % 5 == 0 :
        five += i
    elif i % 3 == 0 :
        threeNotFive += i
    i += 1

print('1 ~ 100까지의 합 : ', all)
print('5의 배수의 합 : ', five)
print('3의 배수이면서 5의 배수가 아닌 수의 합 : ', threeNotFive)








# while ~ else
cnt = 10
while cnt > 0:
    if cnt == 5:
        break
    cnt -= 1
else:
    print('while ~ else') # 위에서 while이 전부 돌지 않았기 때문에
                          # else 구문이 실행되지 않았따



cnt = 10
while cnt > 0:
    if cnt == 11:
        break
    cnt -= 1
else:
    print('while ~ else') # while 구문이 전부 돌았기 때문에
                          # else 구문이 실행되었다.









