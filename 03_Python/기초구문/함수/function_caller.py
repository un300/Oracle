
# 외부 모듈에서 함수를 가져와 봅시다.
# 앞에서 만든 'function' 모듈을 import 하세요.

# import function as f
#
# f.print_coin()






# pakage_function 이라는 패키지 디렉토리를 만들었다.
# 불러오는 방법은?
# from ~ improt ~ as ~


from service.bigdata import package_function as pf
# 또는! 아래처럼 import할 수 도있따.
# from service.bigdata.package_function import print_coins
# 또는 별칭(as)도 사용하기 싫다
# from service.bigdata.package_function import *

# pf.print_coins()
# pf.first_function(2)


# thanks = pf.return_funcion('선림')
# print(thanks)



# hap = pf.sum_function(1, 2, 3)
# print(hap)



# r = pf.tuple_func(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
# print(r)


# pf.dic_function(name = 'jslim', name2 = 'park', name3 = 'kim')




# sum, mul = pf.multi_function(10, 20)
# print('합 : {} / 곱 : {}' .format(sum, mul))




# result1 = pf.default_function(10, 20)
# print(result1)
# result2 = pf.default_function(10, 20, False)
# print(result2)






# oddSum, evenSum = pf.countSum(100, 500)
# print('홀수 합 :', oddSum)
# print('짝수 합 :', evenSum)
#
#
# oddSum, evenSum = pf.countSum2(100, 500)
# print('홀수 합 :', oddSum)
# print('짝수 합 :', evenSum)





# result1 = pf.calculator(10, '+', 20)
# print(result1)
# result2 = pf.calculator(10, '*', 20)
# print(result2)
# result3 = pf.calculator(10, '/', 20)
# print(result3)
# result4 = pf.calculator(10, '-', 20)
# print(result4)
# result5 = pf.calculator(10, '//', 20)
# print(result5)




# www.naver.com
# url = pf.make_url('naver')
# print(url)




# 세 개의 숫자를 입력받아 가장 큰 수를 출력할 예정이다.
# max = pf.print_max1(100, 20, 2)
# print(max)
#
# max = pf.print_max2(2, 100, 20)
# print(max)






# 하나의 연도를 입력하였을 때 윤년의 부를 출력하는 함수
# year = int(input('년도를 입력하라 : '))
# leapMsg = pf.leap_year(2000)
# print(leapMsg)







# 연도의 범위를 입력하였을때, 범위안의 윤년을 모두 출력하는 함수
# year_list = pf.leap_year_loop1(1900, 2020)
# print(year_list)
# year_list = pf.leap_year_loop2(1900, 2020)
# print(year_list)




dict = pf.return_dict(10)
print(dict, type(dict))

for value in dict.values() :
    print(value)












