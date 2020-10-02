





# 다중상속과 추상화




# 다중상속

class Animal(object):
    def cry(self):
        pass


class Tiger(Animal):
    def jump(self):
        print('호랑이가 점프를 한다.')

    def cry(self):
        print('어흥')


class Lion(Animal):
    def bite(self):
        print('한 입에 꿀꺽한다.')

    def cry(self):
        print('그르렁')


class Liger(Tiger, Lion): # <- 다중상속 : 하나의 클래스가 여러개의 부모클래스로부터 상속 받는 것
                          # 상속받는 순서가 Tiger > Lion 순이기 때문에
                          # Tiger, Lion 두클래스 모두 cry라는 함수를 가지고 있지만
                          # Tiger가 먼저 명시되었기 때문에 Tiger의 cry를 상속받는다고 할 수 있다.
    def play(self):
        print('라이거가 사육사를 잡아 먹었습니다.')












# 추상클래스(객체생성이 불가)
# 메소드의 목록만 가진 클래스 : 추상클래스로는 추상클래스에 구현된 함수를 실행(접근) 할 수없다.
# 상속받는 클래스에서 메소드 구현을 강제하기 위해서 사용하는 문법
# 추상클래스는 인스턴스를 만들어 낼 수 없다 > 오직 상속을 통해 자식클래스에게 내려주기 위한 클래스이다

from abc import *  # 추상클래스를 사용하기 위한 패키지(?)


class Base(metaclass = ABCMeta):  # metaclass : 추상클래스를 명시하는 문법

    @abstractmethod
    def study(self):
        pass

    @abstractmethod
    def goToAcademy(self):
        pass




class BaseSub(Base):

    def study(self):
        print('공부하자')

    def goToAcademy(self):
        print('멀티캠퍼스 가야지~')








