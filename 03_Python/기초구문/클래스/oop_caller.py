

# OOP(Object Oriented Programming)

# 현실세계에 있는 Object를 파이썬 상의 instance로 만들고 싶다
# 이때 Object와 instance사이에 존재하는 것이 class 이다.
# 현실세계에 존재하는 Object의 특징을 가지고 있는 class가
# instance를 찍어내는 형태라고 할 수 있다
# 그래서 instance는 붕어빵, class는 붕어빵 틀이라고 예를 많이 들고 있는 것이다.



# 포함관계
# 함수 < 클래스 < 모듈 < 패키지





# OOP(Object Oriented Programming) 특징
# 캡슐화
# 상속
# 다형성
# 추상화
### 위 4가지 특성이 다 들어나야 객체지향 프로그래밍이다.
## 현업에서는 파이썬을 가지고 위에 나열한 파이썬의 특징을 잘 살리지 못한체
## 절차적이고 구조적인 작업을 시행하는 사람들이 많다.




## 앞으로 우리가 클래스를 만들때 '응집력'이 높은 클래스를 만들어야한다
## 여기서 응집력(코헤이징)이란??
## class 내부의 결합력은 강한 결합을 지향해야한다는 말이다!
## 반대로!
## class 간의 결합력이 약한 결합을 지향해야한다!!!

# 왜냐하면?
# 만약 A와 B라는 class의 결합력(연결정도)가 높을 때,
# class A에서 코드 수정이 이루어지면
# class B에서도 코드 수정이 불가피하기 때문이다!!

# 정리하면, class 내부는 강한 결합(응집력이 강하다)
# class 외부는 약한 결합




# class의 구성요소
# 멤버변수 - 자료 저장
# 생성(Constructor) - 객체 생성시 호출되는 일급(__init__)함수
# 함수(function) - 자료처리를 위한 함수

























from service.oop import oop_first_class as oop



# 학생의 이름 학년평점을 저장한다면?

# class를 사용하지 않을 때 : 관리가 편하지 않다.
stu_name1 = '섭섭해'
stu_grade1 = 4.5

stu_name2 = '섭섭아'
stu_grade2 = 4.0

stu_name3 = '섭순이'
stu_grade3 = 3.7


# class를 사용할 때

stu = oop.Student('LeeJaeWon')   # instance 생성
print(stu.name)
print(stu.hardStudy())

student_list = []
student_list.append(oop.Student('Michael'))
student_list.append(oop.Student('Mike'))
student_list.append(oop.Student('Pual'))
print(student_list)



























