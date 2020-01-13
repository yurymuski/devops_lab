word = str(input())
a = word[::-1]
if word == a:
    print(a, "is palindrome")
else:
    print(a, "is not palindrome")
