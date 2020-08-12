

# python boolean
# True / False

a = 5
b = 0

print(a & b)    ## 2진수로 바꾸어보면..
                ## a = 0101
                ## b = 0000
                ## > 0101 & 0000 > 0000(False)
print('bool', bool(a & b))      ## 그래서 이 값은 False
print('boll', bool(1))


# 비어있지 않은 데이터는 True를 반환
print('bool (1, 2, 3)', bool((1, 2, 3)))

# 비어있는 데이터는 False를 반환
temp = {}
print('bool {}', bool(temp))


# not
print('bool not', bool(not 1))
print('bool not', bool(not 0))



trueFlag = True
falseFlag = False
print( int(trueFlag) )
print( int(falseFlag) )



print(trueFlag & falseFlag)
print(trueFlag | falseFlag)



