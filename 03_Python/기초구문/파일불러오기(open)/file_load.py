


# csv, excel, input / output


import pandas as pd



data = pd.read_csv("./word/service_bmi.csv")
data['label']



def load_csv(filePath):
    data = pd.read_csv(filePath, encoding='UTF-8')
    # service_bmi(data)




def service_bmi(data):
    # print(data.head())
    # 칼럼의 정보를 확인하고 싶다면?
    # height = data.height
    # height = data['height']
    # print(height)
    # print('type : ', height)
    # 키와 몸무게의 평균을 구하고 싶다.
    print('height mean : ', sum(data['height']) / len(data['height']))
    print('weight mean : ', sum(data['weight']) / len(data['weight']))

    # 키가 가장 큰사람의 키는?
    print('height max :', max(data['height']))



    # lable 칼럼을 활용하여 값의 빈도수를 출력하는 로직을 만들어 본다면?
    # 출력 예시 ) {thin : 100, normal : 50, fat : 200}
    factor = list(set(data['label']))
    dic = {}

    for element in data['label']:
        dic[element] += 1
    print(dic)






def displayInfo(data):
    print('head')
    print(data.head())



from statistics import mean

def load_xls():
    kospi = pd.ExcelFile('./word/sam_kospi.xlsx')
    kospi = kospi.parse('sam_kospi')
    # print(kospi.info())
    # print(kospi.head())
    print('High mean :', mean(kospi.High))
    print('low mean :', mean(kospi.Low))





'''
네트워크 상에서 표준으로 사용되는 파일 형식
{key1 : value1}
{key2 : value2}
{key3 : value3}
{key4 : value4}
{key5 : value5} 
...

json으로 불러온 파일을 python의 dictionary형식으로 바꾸어 줄 수 있다. : decoding
python으로 작성한 dictionary형식의 파일을 json으로 바꾸어 줄 수 있다. : encoding
'''



import json
def load_json():
    dic = {'id' : 'jslim', 'pwd' : 'jslim'}
    print( type(dic) )

    # python의 dictionary를 json으로 변경하는 방법
    jsonDic = json.dumps(dic)
    print( type(jsonDic) )
    print(jsonDic)  # json은 print로 출력하면 dictionary와 동일한 형식으로 출력되지만,
                    # dictionary와 동일한 방식으로 key, value를 통한 접근이 불가능하다.
                    # json형식은 문자열(str)형식이기 때문이다.
    # print(jsonDic['id'])   > 오류나는게 당연!

    # json을 python의 dictionary형식으로 변환해줌
    pyObj = json.loads(jsonDic)
    print(type(pyObj))
    print(pyObj['id'], pyObj['pwd'])






def json_load_file():
    with open('./word/usagov_bitly.txt', 'r', encoding='UTF-8') as file:

        # readline : 데이터에서 한줄만을 읽어옴
        # readlines : 데이터에서 모든 줄을 읽어와 한줄 한줄을 리스트의 원소로 만들어
        # 리스트 형식으로 만들어준다.


        lines = file.readlines()


        # 우리가 배운 내용으로 json 형식을 python dictionary 형식으로 바꾸는 방법
        # dict_list = []
        #
        # for dic in lines:
        #     pyObj = json.loads(dic)
        #     dict_list.append(pyObj)
        # print(dict_list[0]['a'])


        # 파이썬을 사용하는 개발자들이 json형식을 python dictionary로 바꾸는 방법
        # 위 5~6줄의 코딩을 단 한줄로 구현 가능하다
        rows = [json.loads(line) for line in lines]
        print(type(rows))
        print(rows[0]['a'])

        jsonDF = pd.DataFrame(rows)
        print(jsonDF.head())



























































































































































































