



class Employee(object):
    raise_rate = 1.1    # 클래스 소유 변수

    def __init__(self, name, pay):
        # 인스턴스 소유 변수
        self.name = name
        self.pay = pay

    def appy_raise(self):
        self.pay = int(self.pay * Employee.raise_rate)

    def getEmp(self):
        return '{}님의 인상된 급여는 {}입니다.' .format(self.name, self.pay)

    @classmethod            # @staticmethod랑 뭐가 다를까?
                            # @classmethod는 self대신 cls를 명시해주어여한다.
                            # 좀더 깊게 들어가면 클래스의 상속과 관련되는 부분에서 차이점이 존재하는데
                            # 나중에 알아보도록 하자
    def change_raise_rate(cls, rate):
        print('change_raise_rate ~ ~')





class Car(object):
    # class variable
    name = None
    door = cc = 0

    def __init__(self, name, door, cc):
        self.name   = name
        self.door   = door
        self.cc     = cc

    def info(self):
        if self.cc >= 3000:
            self.type = '대형'
        elif self.cc >= 2000:
            self.type = '중형'
        else:
            self.type = '소형'

        self.display()

    def display(self):
        print('%s 는 %d cc이고(%s), 문짝은 %d개 입니다.' %(self.name, self.cc, self.type, self.door))







class TV(object):
    channel = 10
    volume = 5
    power = False # (On : True / Off : False)

    def __init__(self):
        self.channel    = TV.channel
        self.volume     = TV.volume
        self.power      = TV.power

    # 전원관리를 위한 함수
    def changePower(self):
        self.power = not(self.power)


    # 채널 변경을 위한 함수
    def channelUp(self):
        self.channel += 1

    def channelDown(self):
        self.channel -= 1

    def volumeUp(self):
        self.volume += 1

    def volumeDown(self):
        self.volume -= 1

    def display(self):
        print("전원상태 : {}, 체널번호 : {}, 볼룸 : {}" .format(self.power, self.channel, self.volume))









































