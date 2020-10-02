




# Python date type
# 날짜





from datetime import date, datetime



today = date.today() # 오늘의 날짜를 반환하세요
print('today : ', today, type(today))
print('년도 : {}, 월 : {}, 일 : {}' .format(today.year, today.month, today.day))



my_datetime = datetime.today()      # 오늘의 날짜와 시간까지 반환하세요
print(my_datetime)
print('시 : {}, 분 : {}, 초 : {}' .format(my_datetime.year, my_datetime.month, my_datetime.day))




from datetime import date, datetime, timedelta
from dateutil.relativedelta import relativedelta


# timedelta()

today = date.today()
days = timedelta(days = -1)
print("어제 날짜 : {}" .format(today + days))


# timedelta() 함수는
# week, days, hours, minutes, seconds 사용이 가능하다.
# 그러나 years, months 사용할 수 없음

days = timedelta(years = -2)


# years, months를 사용하려면
# relativedelta()함수를 사용해야함!
days = relativedelta(months = -2)
print("두달 전 날짜 : {}".format(today + days))





# 특정 날짜 객체를 생성
from dateutil.parser import parse

myDay = parse("2020-08-11")
print('myDay -', myDay)
myDay = datetime(2020, 8, 11)
myDay
print(myDay)


# strftime() : 날짜를 문자열 형태로 포맷 지정
today = datetime.today()
print('{}' .format(today.strftime("%m-%d-%y")))
print('{}' .format(today.strftime("%m-%d-%Y")))


# strptime() : 문자열을 날짜로!
str = '2020, 08, 11-13:14:20'
my_str = datetime.strptime(str, '%Y, %m, %d-%H:%M:%S')

print(type(my_str))
print(my_str)







































