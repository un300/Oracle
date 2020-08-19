

### 상속 Caller Module 입니다!

## private variance class 호출

from service.oop.hms.inheritance import *


instance1 = private_example()
instance1.setAge(100)       # class에서 __age로 정의 (private로 정의)되어 있기 때문에,
                            # __init__ 메소드가 아니라, 함수를 사용하여 age를 입력받음
print(instance1.getAge())   # 또한 __age로 정의 (private로 정의)되어 있기 때문에,
                            # instance1.age가 아니라 함수를 이용하여 __age를 출력




print()
print()
print('줄 구분 입니다 ==================================================================================')
print('===============================================================================================')
print()
print()




### class 상속 클래스 호출

###class 상속 실습1

# Sup클래스를 상속받은 Sub클래스를 호출해보자

sub = Sub('JeaWon')

sub.print()    # > Sub클래스 내에 정의 되어 있지 않은 getState함수를 사용할 수 있따,
               # 왜? 상속받았기 때문에!

sub.getState()



print()
print()
print('줄 구분 입니다 ==================================================================================')
print('===============================================================================================')
print()
print()




### class 상속 실습2

stu01 = StudentVO('임정섭', 48, '서울', '1992')
tea01 = TeacherVO('임섭순', 48, '광주', '파이썬')

# method overing을 실시 했을때
print(stu01.perInfo())
print(tea01.perInfo())


# 다음 코드는 method overring을 하지 않을때 나타나는 불필요한 코드 작성 예시이다.
perList = []
perList.append(stu01)
perList.append(tea01)


for obj in perList:
    if isinstance(obj, StudentVO):
        print( obj.stuInfo() )
    else:
        print( obj.teaInfo() )







print()
print()
print('줄 구분 입니다 ==================================================================================')
print('===============================================================================================')
print()
print()







## class 상속 실습3



scCar = SportsCar(300, '터보가능')
print('터보여부 :', scCar.getTurbo())
print(scCar.carDesc())

truck01 = Truck(150, 1000)
print('적재공간 :', truck01.getCapacity())
print(truck01.carDesc())







print()
print()
print('줄 구분 입니다 ==================================================================================')
print('===============================================================================================')
print()
print()








## class 개인실습

#caller 쪽에서 객체(instance)생성후

account = Account('44-2919-1234', 500000, 0.073)


account.accountInfo()
account.withDraw(600000)
account.deposit(200000)
account.accountInfo()
account.withDraw(600000)
account.accountInfo()
account.printInterestRate()






print()
print()
print('줄 구분 입니다 ==================================================================================')
print('===============================================================================================')
print()
print()






## 상속 class 개인실습

save_acc = SavingAccount('508-10-123456-7', 500000, 0.073, 'S')

save_acc.accountInfo()
save_acc.withDraw(600000)
save_acc.deposit(200000)
save_acc.accountInfo()
save_acc.withDraw(600000)
save_acc.accountInfo()
save_acc.printInterestRate()






print()
print()
print('줄 구분 입니다 ==================================================================================')
print('===============================================================================================')
print()
print()










fund_acc = FundAccount('508-10-123456-7', 500000, 0.073, 'F')

fund_acc.accountInfo()
fund_acc.withDraw(600000)
fund_acc.deposit(200000)
fund_acc.accountInfo()
fund_acc.withDraw(600000)
fund_acc.accountInfo()
fund_acc.printInterestRate()






