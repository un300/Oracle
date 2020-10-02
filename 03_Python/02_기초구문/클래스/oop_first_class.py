


# object class = root class라고 함
# default 값으로 상속받는 class


class Student(object):

    msg = '나는 전역 변수 이지만, 인스턴스 소유가아닌 클래스 소속이야~'  # __init__(생성자)에서 선언되지 않았기에,
                                                                # msg는 class 소유 변수이다.

    def __init__(self, name):       # 여기서 self는 instance의 소유를 뜻한다 즉, name은 instance 소유 변수이다
        self.name = name

    def hardStudy(self):        # 여기서도 self는 instance의 소유를 뜻한다. 즉, hardStudy 함수는 instance 소유 함수이다.
        return '오늘도 열공햤다~ 이제 5시가 된다. 야호^^..'





































