



# 회문(palindrome)
# 단어를 거꾸로 읽어도 꺼꾸로 읽지 않은 결과와 같은 단어 또는 문장
# 예를들어 level, sos, rotator, 'nurses run'
# 회문을 알기 위해서는 기준점이 필요하다. 첫 글자와 마지막 글자를 비교
# 반복문



# str = 'jslim9413'
# idx = len(str) // 2
# print(str[idx])



# 특정단어가 들어 왔을때 이 단어가 회문인지 아닌지를 검사하는 함수를 만들어보려한다.

# 강사님 강의중 구현한 코드
def isPalindrome():
    word = input('단어를 입력하세요 :')
    isFlag = False
    for i in range(len(word) // 2):
        if word[i] != word[-(i+1)]:
            break
    else:
        isFlag = True
    return isFlag


# 내가구현
def isPalindrome2():
    word = input('단어를 입력하시요 :')
    isFlag = False
    k = len(word) // 2

    if word[0:k] == word[::-1][0:k]:
        isFlag = True
    return isFlag


# 강사님구현
def reversedPalindrome():
    word = input('단어를 입력하세요 :')
    return word == word[::-1]





# Palindrome 실습

# 딘아기 즐 단위로 저장된 파일에서
# 회문인 단어를 각 줄에 출력하라
# 단) 파일에서 읽은 단어는 \n이 붙어 있으므로 \n을 제외한 뒤 회문인지를 판단하여야함
# 단어사이 줄 바꿈이 두번 일어나면 안됨

def palindromeFunc():
    with open('./word/palindrome_words.txt', 'r') as file:
        words = file.read().split()
        result_list = [word for word in words if word == word[::-1]]

    for word in result_list:
        print(word)


























































































