




# N-gram : 단어를 N개씩 추출하는 방법
# 텍스트마이닝에서 많이 쓰여요
# hello 2문자 단위로 추출한다면?
# he / el / ll /lo


# # 2-gram
# text = 'hello'
# for i in range(len(text)-1):
#     print(text[i], text[i+1], sep='')
#
#
# # 2-gram : 연습
# # 공백을 기준으로 문자를 분리한다면 타입은? > 리스트가 됨
# # 리스트를 2-gram으로 현재문자와 다음 문자를 출력하고 싶다면?
# text = 'this is python script'
# split_text = text.split()
#
# for i in range(len(split_text)-1):
#     print(split_text[i], split_text[i+1])



# 공백을 기준으로 문자를 분리한다면 타입은?



# # zip() 함수
#
# number = [1, 2, 3, 4]
# name = ['a', 'b', 'c', 'd']
#
# number_name_list = list(zip(number, name))
# print(number_name_list)
#
# number_name_dict = dict(zip(number, name))
# print(number_name_dict)
#
#
# # zip() 함수 실습
#
# a = 'lim'
# b = [1, 2, 3]
# c = ('one', 'two', 'three')
#
# print(list(zip(a, b, c)))
# print(dict(zip(a, b)))
# print(set(zip(a, b, c)))










# input 함수를 이용해서 문자열이 입력되고
# (예를들어, Python is a programming language that lets you work quickly)
# gram할 숫자도 input함수를 이용하여 입력받아 (예를들어, 3)
# 입력된 문자열의 단어 개수가 입력된 정수 미만이라면 예외를 발생시키고 처리한다.

def zipNgram():
    sentence = input('문자열을 입력하세요. :')
    N = int(input('Ngram할 숫자를 입력하세요. :'))

    words = sentence.split()
    k = len(words)

    try:
        if k < N:
            raise Exception('N이 너무 커요')
        else:
            for i in range(k - N + 1):
                print(tuple(words[i: i+N]))

    except Exception as e:
        print(e)



def zipNgram2():
    sentence = input('문자열을 입력하세요. :')
    N = int(input('Ngram할 숫자를 입력하세요. :'))




























































