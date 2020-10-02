## 문제 1.
## 10보다 작은 자연수 중에서 3 또는 5의 배수는
## 3,5,6,9가 존재해요! 이것들의 합은 23입니다.

## 1000보다 작은 자연수 중에서 3 또는 5의 배수들을
## 구해서 모두 합하면 얼마인가요?

## 정답 : 233168

def threeOrFiveHap() :
    sum = 0
    for i in range(1, 1001) :
        if i % 3 == 0 or i % 5 == 0 :
            sum += i
    return sum

threeOrFiveHap()


## 문제 2.
## 알파벳 대소문자로 된 문자열이 주어지면, 
## 이 문자열에서 가장 많이 사용된 알파벳이 
## 무엇인지 출력하는 프로그램을 작성하시오. 
## 단, 대소문자는 구별하지 않아요. 만약 동률이 존재하는 경우 
## 알파벳 순으로 제일 앞에 있는
## 문자를 출력하세요.

## 문자열) "This is a sample Program mississippi river"
## 문자열) "abcdabcdababccddcd"

## 정답 :  "This is a sample Program mississippi river" => I
## 정답 :  "abcdabcdababccddcd" => C

str = "This is a sample Program mississippi river"
str = "abcdabcdababccddcd"


def str_arrnage(str) :
    freq_dict = {}
    new_str = ''.join(str.split())
    factor = list(set(new_str))

    for fac in factor:
        freq_dict[fac] = str.count(fac)

    max_num = sorted(freq_dict.values(), reverse=True)[0]
    max_str_list = [key for key, value in freq_dict.items() if value == max_num]
    answer = sorted(max_str_list)[0]
    return answer


str_arrnage("This is a sample Program mississippi river")
str_arrnage("abcdabcdababccddcd")









## 문제 3.
## 로또 프로그램 작성 
## 5000원으로 로또복권을 5장 자동으로 구매합니다. 
## 이번 주 로또 당첨번호를 생성하여 로또 당첨을 확인하세요!
## 쉬운버전으로 먼저 작성합니다.  
## 6숫자가 다 맞으면 1등, 5개 맞으면 2등으로 처리합니다.
## 즉, 쉬운버전은 보너스 숫자는 없는 것으로 간주합니다.
## 쉬운버전을 해결했다면 
## 보너스 숫자를 이용하여 로또 당첨을 확인합니다.
## 보너스 숫자를 제외한 모든 숫자가 다 맞으면 1등,
## 보너스 숫자를 포함하여 6개의 숫자가 맞으면 2등,
## 보너스를 제외하고 5개의 숫자가 맞으면 3등으로 처리합니다.

## 쉬운버전의 출력은 1등 몇개, 2등 몇개, 3등 몇개, 
## 4등 몇개, 꽝 몇개로 출력
## 어려운버전의 출력은 1등 몇개, 2등 몇개, 3등 몇개, 
## 4등 몇개, 5등 몇개, 꽝 몇개로 출력

## 랜덤값을 도출하기 위해서는 다음의 코드를 이용한다.
import random

i = random.randint(1, 100)  # 1부터 100 사이의 임의의 정수 
f = random.random()  # 0부터 1 사이의 임의의 float
i = random.randrange(1, 101, 2)  # 1부터 100 사이의 임의의 짝수
i = random.randrange(10)  # 0부터 9 사이의 임의의 정수


# 쉬운버전 : 보너스숫자 X
# 1등 > 6개
# 2등 > 5개
# 3등 > 4개
# 4등 > 3개
# 꽝  > 2개이하

def NoBonusLotto(correct_lotto):
    result_all_lotto = [0, 0, 0, 0, 0]
    for i in range(5) :
        buy_lotto_num = [random.randint(1, 45) for _ in range(6)]

        correct_num = 0
        for j in range(6) :
            if buy_lotto_num[j] in correct_lotto :
                correct_num += 1

        result_all_lotto[i] = correct_num

    print('1등 :', result_all_lotto.count(6))
    print('2등 :', result_all_lotto.count(5))
    print('3등 :', result_all_lotto.count(4))
    print('4등 :', result_all_lotto.count(3))
    print('꽝  :', result_all_lotto.count(2) + result_all_lotto.count(1) + result_all_lotto.count(0))

correct_lotto = [3, 17, 18, 23, 36, 41]
NoBonusLotto(correct_lotto)


# 쉬운버전 : 보너스숫자 O
# 1등 > 보너스X and 6개
# 2등 > 보너스를 포함한 6개
# 3등 > 보너스를 제외한 5개
# 4등 > 보너스를 제외한 4개
# 5등 > 보너스를 제외한 3개
# 꽝  > 나머지 2개이하

def YesBonusLotto(correct_lotto, bonus_num):
    result_all_lotto = [0, 0, 0, 0, 0]
    first = second = third = fourth = fifth = remain = 0

    for i in range(5):
        buy_lotto_num = [random.randint(1, 45) for _ in range(6)]

        correct_bonus = 0
        if bonus_num in buy_lotto_num :
            correct_bonus = 1

        correct_num = 0

        for j in range(6):
            if buy_lotto_num[j] in correct_lotto :
                correct_num += 1

        result_all_lotto[i] = [correct_num, correct_bonus]


    list_13456 = [element for element, bonus in result_all_lotto if bonus == 0]
    list_2 =     [element for element, bonus in result_all_lotto if bonus == 1]


    first   = list_13456.count(6) + list_2.count(6)
    second  = list_2.count(5)
    third   = list_13456.count(5)
    fourth  = list_13456.count(4) + list_2.count(4)
    fifth   = list_13456.count(3) + list_2.count(3)
    remain  = list_13456.count(3) + list_13456.count(2) + list_13456.count(1) + list_13456.count(0) + list_2.count(2) + list_2.count(1) + list_2.count(0)

    print('1등 :', first)
    print('2등 :', second)
    print('3등 :', third)
    print('4등 :', fourth)
    print('꽝  :', remain)

correct_lotto = [3, 17, 18, 23, 36, 41]
bonus_num = 26

YesBonusLotto(correct_lotto, bonus_num)








##### 추가문제
##### 1등에 당첨될려면 평균적으로 얼마만큼의 돈을 투자해야 할까요?
##### 로또 1게임은 1000원입니다.







## 문제 4.
## 어떤 수를 소수의 곱으로만 나타내는 것을 소인수분해라 하고, 
## 이 소수들을 그 수의 소인수라고 합니다.
## 예를 들면 13195의 소인수는 5, 7, 13, 29 입니다.

## 600851475143의 소인수 중에서 가장 큰 수를 구하세요.

## 정답 : 6857 


def isPrime(n) :
    if n == 2:
        return True

    for i in range(2, int(n**(1/2))) :
        if n % i == 0 :
            return False
    else:
        return True



def max_prime_factor(n):
    prime_factor = []
    mok = n
    for i in range(2, int(n**(1/2))):
        if mok % i == 0:
            mok = mok // i
            prime_factor.append(i)

        if isPrime(mok):
            break
    prime_factor.append(mok)

    print('{}의 소인수는 {}입니다.' .format(n, prime_factor))

    return prime_factor[len(prime_factor)-1]


max_prime_factor(600851475143)

## 문제 5.
## 앞에서부터 읽을 때나 뒤에서부터 읽을 때나 모양이 
## 같은 수를 대칭수(palindrome)라고 부릅니다.

## 두 자리 수를 곱해 만들 수 있는 대칭수 중 
## 가장 큰 수는 9009 (= 91 × 99) 입니다.

## 세 자리 수를 곱해 만들 수 있는 가장 큰 대칭수를 구하세요

## 정답 : 906609


## 문제 6.
## 1 ~ 10 사이의 어떤 수로도 나누어 떨어지는 가장 작은 수는 2520입니다.
## 그러면 1 ~ 20 사이의 어떤 수로도 나누어 떨어지는 가장 작은 수는 얼마입니까?

## 정답 : 232792560


## 문제 7.
## 1부터 10까지 자연수를 각각 제곱해 더하면 다음과 같습니다 (제곱의 합).
## 1**2 + 2**2 + ... + 10**2 = 385

## 1부터 10을 먼저 더한 다음에 그 결과를 제곱하면 다음과 같습니다 (합의 제곱).
## (1 + 2 + ... + 10)**2 = 552 = 3025

## 따라서 1부터 10까지 자연수에 대해 "합의 제곱"과 "제곱의 합" 의 
## 차이는 3025 - 385 = 2640 이 됩니다.

## 그러면 1부터 100까지 자연수에 대해 "합의 제곱"과 "제곱의 합"의 차이는 
## 얼마입니까?

## 정답 : 25164150


## 문제 8.
## 소수를 크기 순으로 나열하면 2, 3, 5, 7, 11, 13, ... 과 같이 됩니다.

## 이 때 10,001번째의 소수를 구하세요.

## 정답 : 104743


## 문제 9.
## 양의 정수 n에 대하여, 다음과 같은 계산 과정을 반복하기로 합니다.

## n → n / 2 (n이 짝수일 때)
## n → 3 * n + 1 (n이 홀수일 때)

## 13에 대하여 위의 규칙을 적용해보면 아래처럼 10번의 과정을 통해 1이 됩니다.

## 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

## 아직 증명은 되지 않았지만, 이런 과정을 거치면 어떤 수로 시작해도 
## 마지막에는 1로 끝나리라 생각됩니다. 
## (이런 수들을 우박수 hailstone sequence라 합니다.)

## 그러면, 백만(1,000,000) 이하의 수로 시작했을 때 1까지 도달하는데 
## 가장 긴 과정을 거치는 숫자는 얼마입니까?
## 계산 과정 도중에는 숫자가 백만을 넘어가도 괜찮습니다.

## 정답 : 


## 문제 10.
## 다음과 같은 특성을 갖는 숫자의 개수를 찾는 기능을 구현합니다.
## 입력으로 두개의 숫자( x, y )를 이용합니다. 
## - 두 개의 숫자 x와 y를 이용하여,
##   x초과 y미만의 숫자 중 각 자리의 숫자를 모두 더한 값이 5의 배수가 
##   되는 숫자를 찾습니다.
## - 숫자들을 모두 찾은 후 해당 숫자가 총 몇 개인지를 출력합니다.

## 예1) 두 개의 숫자 1과 100이 주어졌을 경우,
##      1초과 100미만의 숫자 중 각 자리의 숫자를 모두 더한 값이 5의 배수가 
##      되는 숫자를 찾습니다.
##      - 20의 경우 각 자리 숫자를 모두 더한 값이 2이므로, 적합하지 않다.
##      - 23의 경우 각 자리 숫자를 모두 더한 값이 5이므로, 적합하다.
##      [총 개수] 19

## 예2) 두 개의 숫자 5와 500이 주어졌을 경우,
##      5초과 500미만의 숫자 중 각 자리의 숫자를 모두 더한 값이 5의 배수가 
##      되는 숫자를 찾습니다.
##      [총 개수] 98

## 입력으로 주어지는 두 개의 수 : 100 10000

## 정답 : 예제의 결과가 출력되도록 코드 작성


## 문제 11.
## 6자리 이상 9자리 미만의 수를 입력으로 사용합니다.

## 수의 중앙을 기준으로 두 개의 수로 분리한 후 큰 수를 선택한다.
## - 수의 숫자개수가 홀수 개인 경우 수의 중앙 숫자를 기준으로 
##   왼쪽과 오른쪽 수로 분리
## - 수의 숫자개수가 짝수 개인 경우 수를 반으로 나누어 
##   왼쪽과 오른쪽 수로 분리
## 예1) 1234567 -> (123, 567) -> (567)
## 예2) 34217869 -> (3421, 7869) ->(7869)

## 입력으로 제공된 수를 더 이상 두 개의 수로 분리할 수 없을 때까지 
## 과정을 반복하여 남은 최종 숫자를 구해 출력한다.
## 예1) 567 -> (5, 7) -> (7)
## 예2) 7869 -> (78, 69) -> (78) -> (7, 8) -> (8)

## 정답 : 예제의 결과가 출력되도록 코드 작성


## 문제 12.
## 입력으로 제공되는 숫자열에서 짝수와 홀수를 추출하여 새로운 숫자열을 생성한다.
## 1) 입력된 숫자열에서 짝수와 홀수를 순서대로 추출한다.
##    [입력] 78235169
##    [짝수 추출] 826
##    [홀수 추출] 73519
## 2) 추출된 짝수의 뒤에 추출된 홀수를 연결하여 새로운 숫자열을 생성한다.
##    [짝수와 홀수 연결] 82673519

## 결과숫자열을 앞에서부터 순서대로 뺄셈 연산 또는 덧셈 연산 한다.
## 숫자열의 앞에서 부터 순서대로 뺄셈 연산한다. 
## 단, 앞선 연산 결과가 0 이하이면 그 차례에는 덧셈 연산한다. 
## [결과 숫자열] 82673519
## [각 수의 연산 순서와 방법]
##   8 - 2 = 6
##   6 – 6 = 0
##   0 + 7 = 7 (앞의 연산 결과가 0 이하이므로 덧셈 연산한다.)
##   7 – 3 = 4
##   4 – 5 = -1
##  -1 + 1 = 0 (앞의 연산 결과가 0 이하이므로 덧셈 연산한다.)
##   0 + 9 = 9 (앞의 연산 결과가 0 이하이므로 덧셈 연산한다.)
## [연산 결과] 9

## [입력]: 78235169
## [출력]: 9

## [입력]: 693756874
## [출력]: 7

## 정답 : 예제의 결과가 출력되도록 코드 작성
