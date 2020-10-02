



'''
텍스트 파일 입출력
open(file = " 절대경로 | 상대경로 ", mode = '')

mode = r | w | a | wb
'''




def fileWrite(fileName, mode):
    file = None
    try:
        if mode == 'w':
            file = open(fileName, mode)
            file.write('Hello~ , Seop')
        elif mode == 'r':
            file = open(fileName, mode)
            line = file.read()  ## '파일의 한 줄을 읽어 들여라' 라는 함수이다
            print('result read :', line)
        else :
            file = open(fileName, mode)
            file.write('\nSeop append')

    except ValueError as error:
        print(str(error))

    finally:
        if file != None:
            file.close()
            print('close function')








def withFile(fileName, mode):
    with open(fileName, mode) as file : #with로 작성하면 file.close()를 사용하지 않아도 됨
        line = file.read()
        print(line)




def withMultiWriteFile(fileName, mode):
    with open(fileName, mode, encoding='utf-8') as file:
        for text in range(3):
            inputMsg = input('문자열을 입력하세요 :')
            file.write('{}\n'.format(inputMsg))




def withListFile(fileName, mode, line):
    with open(fileName, mode, encoding='UTF-8') as file:
        file.writelines(line) # file.writeLines() : 리스트에 있는 모든 원소를 한번에 읽어들임
        # file.writelines 대신에 아래처럼 for문을 사용해도된다
        # for text in line :
        #   file.write(text)





def withListReadFile(fileName, mode):
    with open(fileName, mode, encoding='UTF-8') as file:
        line = None
        while line != '':
            line = file.readline()
            print(line.strip('\n'))

        # 위 while구문을 for구문으로 작성해보세요
        # for text in file:
        #     print(text.strip('\n'))









## 여기서부터 실습파일을 통한 실습입니다.


# 파이참에서 모든 디렉토리는 프로젝트를 기준으로 시작함
# 우리의 경우는 python_base
# 그러므로 바로 python_base에 포함된 words에서 cnt_words.txt를 접근하려면
# ./word/cnt_words.txt로 접근하여야 한다.


# 단어가 줄 단위로 저장된 cnt_words.txt 파일로 부터
# 10자 이하인 단어의 개수를 카운팅해 본다면?

def cntFunction():
    with open('./word/cnt_words.txt', 'r') as file:
        cnt = 0
        for text in file:
            if len(text.strip('\n')) <= 10:
                cnt += 1
        print('알파벳이 10자 이하인 단어의 개수는? : %d' %(cnt))






# 문자열이 저장된 special_words.txt 파일에서
# 문자 'c'가 포함된 단어를 각 줄에 출력하는 프로그램을 만들어보자
# 단어를 출력할 때는 등장한 순서대로 출력하며, .은 출력하지 않는다

def spacialFunc():
    with open('./word/special_words.txt') as file:
        all_text = file.readline()
        text_list = all_text.split()

        including_c = [text for text in text_list if 'c' in text]

        result = list( map(lambda x : x.strip(',.'), including_c) )

        for text in result:
            print(text)




# zipcode.txt 파일을 이용하는 문제입니다
# input 함수를 이용하여 동 이름을 입력받아
# 입력예시) 개포
# 해당하는 동의 주소를 출력하는 함수를 정의한다면?
# hint - 한 줄씩 읽어서 tab키로 분리하고
# hint - startwith() 함수를 이용하여 처리하면 됩니다.




def use_zipcode():

    dong = str(input('찾고자 하는 동을 입력하세요 :'))

    with open('./word/zipcode.txt', encoding = 'UTF-8') as file:
        all_address = file.read()
        address_list = all_address.split('\n')

        for text in address_list:
            split_list = text.split('\t')
            temp_list = [element for element in split_list if element.startswith(dong)]

            if temp_list:
                print(' '.join(split_list))







































































