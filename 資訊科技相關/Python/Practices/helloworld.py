import random

print('Hello World')

if 5 > 2:
  print("5 is grater than 2")

'''我是多行註解1
我是多行註解2
我是多行註解3
'''

a = str(3) # a will be '3'
b = int(3) # b will be 3
c = float(3) # c will be 3.0

print(type(a))
print(type(b))
print(type(c))

# unpacking(1)
fruits = ['apple','banana','orange']
d , e ,f = fruits
print(d)
print(e)
print(f)

# unpacking(2)
i , j , k = 'cat'
print(i) #c
print(j) #a
print(k) #t

# one value to multiple variables
i = j = k = 'dog'
print(i) #dog
print(j) #dog
print(k) #dog

# multiple values to multiple variables
i , j , k = '台北', '台中', '台南'
print(i)
print(j)
print(k)

# OK
x = "Buy " 
y = 5 
z = "apples"
print(x, y, z)

# Error, 使用print()時, 不能用 + 把字串和數字結合, 但可以用 [,] 把字串和數字結合
# x = "Buy " 
# y = 5 
# z = "apples"
# print(x + y + z)

# (全域變數與區域變數同名時, 並不會互相干擾)
# x = "awesome"
# def myfunc():
#   x = "fantastic"
#   print("Python is " + x) # x => fantastic

# myfunc()
# print("Python is " + x) # x => awesome

# (2)全域變數變成函式內區域變數使用
# x = "awesome"
# def myfunc():
#   global x
#   x = "fantastic"

# myfunc()
# print("Python is " + x) 

# (1)使區域變數變成全域變數
def myfunc():
  global x
  x = "fantastic"
myfunc()
print("Python is " + x) 


x = 35e3
y = 12E4
z = -87.7e100
print(x)
print(y)
print(z)

x = 3+5j
y = 5j
z = -5j
print(x)
print(y)
print(z)

print(random.randrange(1,100))
