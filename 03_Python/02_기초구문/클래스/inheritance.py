


#### 상속

# B 라는 class가 A class를 상속받고 있을때
# A 의 a()라는 함수를 B class내에서 a() + alpha 형태로 제정의 할 수 있다
# 이것을 overriding 이라고 한다.
# 또한, class B가 class A를 상속 받고 있기때문에,
# class A로 생성한 객체는 class B로 생성한 객채보다 효율성이 떨어진다
# (왜? : class B는 [class A + alpha] 형태로 만들어 졌기 때문)
# 그러므로 상속을 주는 부모 class A에는 공통의 요소를 담아 두고,
# 여러개의 공통의 요소를 담은 class A를 상속받은 여러개의 자식 클래스를 만들어
# 효율적으로 상황에 맞는 class를 만들어 사용한다

# - 캡슐화
# 자식 클래스 B가 부모 클래스 A를 상속 받을때, class A + alpha형태로 상속 받는다고 했다
# 하지만, class A 내부에 캡슐화된 메소드가 있다면,
# class B는 class A 내부에 캡슐화된 메소드를 상속 받을 수 없다.
# 즉, 캡슐화는 상속을 주지 않도록 하는 작업이라 할 수 있다.









### 상속에 들어가기 전에!
# encapsulation(은닉화)
# information - hiding(정보은닉)

class private_example(object):

    def setAge(self, age):
        if age < 0:
            self.__age = 20     # private 변수 : 인스턴스 생성후, 외부에서 접근할 수 없음!
                                #               a = MyDate(2010, 2, 1)  > 이렇게 생성하고
                                #               a.year = 2011           > 이렇게 외부에서 접근할 수 없음!!
                                #               print(a.year)           > 이렇게 외부로 보여줄수도(출력할 수도) 없음
                                # private 변수는 왜쓰냐?
                                # 자식에게 상속하지 않기위해 쓰는것 : private를 사용하면 자식에게 상속을 할 수 없다.
        else:
            self.__age = age

    def getAge(self):
        return self.__age

    def __getInfo(self):        # 클래스 내부에는 정의 되어 있지만, (인스턴스 생성시, 인스턴스가 가지고 있는 메소드이지만)
                                # 외부에서는 접근할 수 없는 메소드입니다.
        return '해당 메서드는 private 형식의 함수로 접근 불가'










# 상속(inheritance)



### 상속 실습 1
class Sup(object):

    def __init__(self, name):
        self.name = name

    def print(self):
        print('부모 클래스에 정의된 print입니다.')

    def getState(self):
        print("Parent Class :", self.name)



class Sub(Sup):  # Sub클래스는 Sup클래스를 상속받는다
    def getState(self):
        print("Child Class :", self.name)   # 부모클래스에 정의된 함수를 자식 클래스에서 제정의 하는것 : Overriding














### 상속 실습 2


# 부모클래스
class Person(object):
    def __init__(self, name, age, address):
        self.name    = name
        self.age     = age
        self.address = address

    def perInfo(self):
        return self.name + str(self.age) + self.address

# 자식클래스1
class StudentVO(Person):
    def __init__(self, name, age, address, stuId):
        super().__init__(name, age, address) # 부모의 생성자를 가져오겠습니다
        self.stuId = stuId

    def perInfo(self):
        return super().perInfo() + ', ' + self.stuId  # method overrinig

    def stuInfo(self):
        return super().perInfo() + ', ' + self.stuId # method overrinig 안했을때


# 자식클래스2
class TeacherVO(Person):
    def __init__(self, name, age, address, subject):
        super().__init__(name, age, address) # 부모의 생성자를 가져오겠습니다
        self.subject = subject

    def perInfo(self):
        return super().perInfo() + ', ' + self.subject  # method overrinig

    def teaInfo(self):
        return super().perInfo() + ', ' + self.subject # method overrinig 안했을때














### 상속 실습 3


# 부모클래스
class Car(object):

    def __init__(self, speed):
        self.speed = speed

    def getSpeed(self):
        return self.speed

    def carDesc(self):
        return '속도 : {}' .format(self.speed)


# 자식클래스 1
class SportsCar(Car):

    def __init__(self, speed, turbo):
        super().__init__(speed)
        self.turbo = turbo

    def getTurbo(self):
        return self.turbo

    def carDesc(self):
        return super().carDesc() + ' / 터보 여부 : ' + self.turbo


# 자식클래스 2
class Truck(Car):

    def __init__(self, speed, capacity):
        super().__init__(speed)
        self.capacity = capacity

    def getCapacity(self):
        return self.capacity

    def carDesc(self):
        return super().carDesc() + ' / 적재공간 : ' + str(self.capacity)











## class 개인실습

# class 작성
# 1. Account class 작성 : account, balance, interestRate
# 2. AccountInfo() : 계좌의 정보를 출력한다.(account, balance, interestRate)
# 3. deposit(amount) : 계좌 잔액에 매개변수로 들어온 amount를 누적한다.
# 4. printInterestRate() : 현재 잔액에 이자율을 계산하여 소수점 자리 2자리까지 출력한다.
# 5. withDraw(amount) : 매개변수로 들어온 금액만큼을 출금하여 잔액을 변경한다.
#                       (단, 잔고가 부족할 경우 '잔액이 부족하여 출금을 할 수 없습니다.'를 출력한다.)



class Account(object):

    def __init__(self, account, balance, interestRate):
        self.account = account
        self.balance = balance
        self.interestRate = interestRate

    def accountInfo(self):
        print('계좌 정보 출력')
        print('계좌번호 : {} / 잔액 : {} / 이자율 : {}' .format(self.account, self.balance, self.interestRate))
        print('-----------------------------------------------------------------')

    def deposit(self, amount):
        print('{}원을 입금하려 합니다.' .format(amount))
        self.balance += amount
        print('{}계좌에 {}원을 입금하여 총 {}원이 예금되어 있습니다.' .format(self.account, amount, self.balance))
        print('-----------------------------------------------------------------')

    def printInterestRate(self):
        print('현재잔액은 {}원이고 이자율은 {}입니다.' .format(self.balance, self.interestRate))
        print('현재잔액에 이자율을 적용한 금액 : {}'  .format(round(self.balance * (1 + self.interestRate), 2)))
        print('-----------------------------------------------------------------')



    def withDraw(self, amount):
        print('{}원을 출금하려 합니다.' .format(amount))
        if amount > self.balance :
            print('잔액이 부족하여 출금을 할 수 없습니다.')
            print('-----------------------------------------------------------------')
        else:
            self.balance -= amount
            print('출금후 잔액 : {}'  .format(self.balance))
            print('-----------------------------------------------------------------')





# 상속 class 작성
# 1. Account class 작성 : account, balance, interestRate + type(계좌종류 S|F)
# 1-1. Account를 상속받은 SavingAccount / FundAccount 추가
# 1-2.
# 1-3. 부모클레스의 printInterestRate()함수를 오버라이딩 해라
# 1-4. SavingAccount의 printInterestRate() : 기본 이자율에 만기시 이자율(0.1)을 복리로 계산
# 1-5. FundAccount의 printInteresRate() : 기본 이자율에 잔액 10만원 이상이면 10%
#                                         기본 이자율에 잔액 50만원 이상이면 15%
#                                         기본 이자율에 잔액 100만원 이상이면 20%



class SavingAccount(Account):
    def __init__(self, account, balance, interestRate, type):
        super().__init__(account, balance, interestRate)
        self.type = type

    def printInterestRate(self):
        expire_money = (1 + self.interestRate) * (1.1) * self.balance
        print('기본 이자율은 {}%이고 만기시 이자율은 0.1%임으로 모든 이자율을 적용한 만기시 금액은 {}입니다' .format(self.interestRate, expire_money))
        print('-----------------------------------------------------------------')


class FundAccount(Account):
    def __init__(self, account, balance, interestRate, type):
        super().__init__(account, balance, interestRate)
        self.type = type

    def printInterestRate(self):
        if self.balance >= 1000000:
            money = (1 + self.interestRate) * (1.2) * self.balance
            print('잔액이 100만원 이상임으로, 기본이자율 {}%에 0.2%이자율을 적용한 금액은 {}원 입니다.' .format(self.interestRate, money))
            print('-----------------------------------------------------------------')
        elif self.balance >= 500000:
            money = (1 + self.interestRate) * (1.15) * self.balance
            print('잔액이 50만원 이상임으로, 기본이자율 {}%에 0.15%이자율을 적용한 금액은 {}원 입니다.'.format(self.interestRate, money))
            print('-----------------------------------------------------------------')
        elif self.balance >= 100000:
            money = (1 + self.interestRate) * (1.1) * self.balance
            print('잔액이 10만원 이상임으로, 기본이자율 {}%에 0.1%이자율을 적용한 금액은 {}원 입니다.'.format(self.interestRate, money))
            print('-----------------------------------------------------------------')



# 2. AccountInfo() : 계좌의 정보를 출력한다.(account, balance, interestRate)

# 3. deposit(amount) : 계좌 잔액에 매개변수로 들어온 amount를 누적한다.

# 4. printInterestRate() : 현재 잔액에 이자율을 계산하여 소수점 자리 2자리까지 출력한다.

# 5. withDraw(amount) : 매개변수로 들어온 금액만큼을 출금하여 잔액을 변경한다.
#                       (단, 잔고가 부족할 경우 '잔액이 부족하여 출금을 할 수 없습니다.'를 출력한다.)


