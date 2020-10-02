
# 파이썬은 위에서 부터 코드를 순차적으로 실행한다
# 그렇기 때문에 코드 중간에서 에러가 나타난다면
# 그 밑의 코드는 실행이 되지 않는다.
# 이렇게, 마지막 코드까지 실행되지 않는 경우를
# 프로그램이 정상적으로 실행되지 않는다라고 할 수 있다.

# 그러므로 짜여진 코드가 정상적으로 실행될 수 있기위해(맨 밑의 코드까지 실행되어지기 위해)
# 사용되는 예외처리 구문이 있다!

'''

예외처리

try     : 에러가 발생 할 가능성이 있는 코드를 입력한다
except  : 입력한 코드에서 에러가 발생되었을때 실행되는 블럭
else    : 입력한 코드에서 에러가 발생되지 않을때 실행되는 블럭
finally : 에러가 발생하든, 발생하지 않든 무조건 실행되는 블럭

'''

def userInput():
    try:
        age = int(input('본인의 나이를 입력하세요 : '))
    except ValueError:
        userInput()  # 에러가 실행되었을 때 자기자신을 다시 실행하시오!
    else:
        print('Result :', age)
    finally:
        print('넌 항상 실행되서 재미가 없어')







def exceptionFunc(list_data):
    sum = 0

    try:
        sum = list_data[0] * list_data[1] * list_data[2] * list_data[3]
        if sum < 0:
            raise Exception('sum이 0보다 작은 값을 가진다.')  # sum이 0보다 작은 값을 가질때 인위적으로 에러를 발생시킨다!
                                                          # 왜 애러를 발생 시키냐? except로 에러를 예외처리 하기 위해서!

    except IndexError as err:
        print(str(err))

    except Exception as e:      # 이렇게 Exception()으로 인위적으로 발생시킨 에러를 except구문을 통해 예외처리 한 것을 볼 수 있다.
        print(str(e))

    else:
        print(sum)










# 매개변수로 넘겨 받은 각 첨자 번지의 값에 제곱(**2)한 결과를 출력하려 한다
# 예외 발생을 확인하고 예외처리 구문을 추가하여
# 정상적인 흐름의 함수 호출이 되도록 만들어본다면?


def listExcepFunc(data):
    result_list = []

    for idx, element in enumerate(data):
        try:
            result = element**2
            result_list.append(result)
        except TypeError:
            result_list.append('문자였음')
            print('{}번쩨 인덱스의 값은 {}이고, 숫자가 아니기에 제곱할 수 없습니다.' .format(idx, element))
        else:
            print('{}번째 인덱스의 값은 {}이고, 제곱한 값은 {}입니다.' .format(idx, element, result))

    print()
    print('입력한 리스트를 제곱한 결과 :', result_list)




# try를 for밖으로 빼보자
def listExepFunc02(data):
    result_list = []

    try :
        for idx, element in enumerate(data):
            result = element ** 2
            result_list.append(result)
    except TypeError:
        result_list.append('문자였음')
        print('{}번쩨 인덱스의 값은 {}이고, 숫자가 아니기에 제곱할 수 없습니다.'.format(idx, element))
    else:
        print('{}번째 인덱스의 값은 {}이고, 제곱한 값은 {}입니다.'.format(idx, element, result))

    print(result_list)


















