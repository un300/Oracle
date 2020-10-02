


from service.oop.hms.employee import *


# Employee class

emp01 = Employee('임정섭', 1000)
emp01.appy_raise()
print(emp01.getEmp())


emp02 = Employee('섭섭해', 2000)
emp02.appy_raise()
print(emp02.getEmp())



Employee.change_raise_rate(1.5)
emp01.change_raise_rate(1.5)



print()
print()
print()
print()

# Car class

Car.name = 'Jeep'
Car.door = 4
Car.cc = 2000

print("{}, {}, {}" .format(Car.name, Car.door, Car.cc))


car01 = Car('BMW', 4, 3000)
car01.info()


print()
print()
print()
print()


# Tv class
TV1 = TV() # 채널 10 / 볼륨 5
TV1.display()

# 1. 전원을 On 시킨다.
TV1.changePower()

# 2. 채널 18번으로 변경
for _ in range(8):
    TV1.channelUp()

# 3. 볼륨 9변경
for _ in range(4):
    TV1.volumeUp()

# 4. TV상태를 출력한다.
TV1.display()



















