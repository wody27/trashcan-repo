import re
n = int(input())
for _ in range(n):
    data=input()
    regex=re.compile("^((100+11*)|(01))*((100+11*)|(01))*((100+11*)|(01))*$")
    data_secured=regex.match(data)
    result="DANGER"
    if data_secured==None:
        result="PASS"
    print(result)

# (100+1+)+  계속 반복 
# (01)+ 계속 반복 
# 두개의 케이스 계속 반복 
# http://gskinner.com/RegExr/