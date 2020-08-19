

class Student(object): # 모든 클래스는 최상위 클래스인 object 클래스를 상속받는다.
                       # 그러므로 부모가 가지고 있는 object클래스의 메소드를 자식 클래스에서 재 정의하여 사용할 수 있다.


    def __init__(self, name = None, age = None, job = None, gender = None):    # 인스턴스 생성시, 매개변수를 입력하지 않을때를 고려하여 구현한 intializer라고 할 수 있다

        if name == None:
            self.name   = '입력안함'
        if age == None:
            self.age    = '입력안함'
        if job == None:
            self.job    = '입력안함'
        if gender == None:
            self.gender = '입력안함'
            return

        self.name   = name
        self.age    = age
        self.job    = job
        self.gender = gender


    def stuInfo(self):              # self의 정의는 뭐다? 클래스가 아니라 인스턴스의 소유임을 나타내는 것이다.
        print('이름 : {}, 나이 : {}, 직업 : {}, 성별 : {}' .format(self.name, self.age, self.job, self.gender))












class Stu(object):

    scholarship_rate = 3.5  # 인스턴스 소유의 변수가 아니라 클래스 소유의 변수이다
                            # 그러므로 scholarship_rate 변수는 클래스의 이름을 명시하여 접근하여야한다!!
                            # Stu.scholarship_rate  << 이런식으로 접근!

# 인스턴스 소유 변수

# __init__(self) 메소드 내에서 정의한 변수는 self라는 키워드로 정의된 메소드 내에서 정의된 변수이기에,
# 클래스 소속이 아니라 인스턴스 소속이다.
# 그렇기 때문에 __init__ 내에서 선언한 변수는 (인스턴스이름).(변수명)으로 접근해야한다!

# 클래스 소유 변수

# 반대로 __init__(self) 메소드 외에서 정의한 변수(우리의 경우 scholarship_rate)는 self라는 키워드로 정의된
# 메소드 외에서 정의된 변수이기에
# 인스턴스 소속이 아니라 클래스 소속이다.!
# 그렇기 때문에 __init__ 외에서 선언한 변수는 (클래스이름).(변수명)으로 접근하여야한다.

# 주의점!!
# 클래스 소유의 변수는 (클래스로부터 생성한 인스턴스이름).(변수명)으로 접근 할 수 있긴하다.
# 예를들어, value1 이라는 클래스 변수를 가진 (클래스1)에서 (인스턴스1), (인스턴스2)를 생성했을때,
# (인스턴스1).value1, (인스턴스2).value1 이런식으로 (클래스1).value1의 값과 동일한 값에 접근이 가능하다.
# 하지만, (인스턴스1).value1, (인스턴스2).value1의 값은 (클래스1).value1의 값과 같은 주소를 공유하기 때문에,
# (인스턴스1).value1, (인스턴스2).value1, (클래스1).value1 세개 중 임의의 하나를 골라 값을 바꿔버리면,
# (인스턴스1).value1, (인스턴스2).value1, (클래스1).value1 세개 모두의 값이 동시에 값이 바껴버린다.


    def __init__(self, name = None, grade = None):
        if name == None:
            self.name   = '입력안함'
        if grade == None:
            self.grade  = '입력안함'
            return

        self.name   = name
        self.grade  = grade

    def stuInfo(self):
        return '이름 : {}, 학점 : {}' .format(self.name, self.grade)

    def isScholarship(self):
        if self.grade >= Stu.scholarship_rate :
            return True
        else :
            return False







class Teacher(object):

    clss_variable = '저는 클래스 변수입니다.'

    def __init__(self, name, salary, survey):
        self.name   = name
        self.salary = salary
        self.survey = survey


    def working(self):
        print('지금 열심히 객채지향 프로그램을 강의하고 있습니다.')

    def salaryInfo(self):
        print('{}님의 급여는 {}입니다.' .format(self.name, self.salary))

    def surveyInfo(self):
        print('참 잘했어요~~ 칭찬합니다. ^*^')

    def printClassVariable(self):
        print(Teacher.class_variable)



    @staticmethod  ## 만약 인스턴스에 소속된 함수가 아니라 클래스에 소속된 함수를 만들기 위해서는
                   ## 함수 정의 전에 '@staticmethod'를 선언하고 함수에 'self'를 제외한체, 함수를 구현하면 된다.
    def classFunction():
        print(Teacher.class_variable)





































