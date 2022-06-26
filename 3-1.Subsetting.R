##### Subsetting by data type

### 1. 데이터 유형에 따른 '[' 연산자를 사용한 서브셋팅
##  a. atomic vector
##    --> object[양의정수] : 특정위치의 원소를 반환
##    --> object[양의실수] : object[floor(양의실수)]와 동일
##    --> object[음의정수] : 특정위치의 원소만 생략하고 반환
##    --> object[논리형벡터] : 대응하는 논리값이 TRUE인 곳의 요소를 반환
##   (* 논리형벡터가 원자벡터보다 짧으면 길이가 같아질때까지 반복/재사용; recycled rule)
##    --> object[NA] : NA 반환
##    --> object[] : 원래의 벡터를 반환
##    --> object[0] : 길이가 0인 벡터를 반환
##    --> object["value_name"] : 해당 이름을 가진 값을 반환

# Practice
x <- c(2.1, 4.2, 3.3, a=5.4) # 소수 첫번째가 각 원소가 나타나는 순서
x[c(3,1)]      #  3.3, 2.1
x[c(1,1)]      #  2.1, 2.1 
x[order(x)]    #  2.1, 3.3, 4.2, 5.4
x[c(2.1, 4.9)] #  4.2, 5.4
x[-c(2,3)]     #  2.1, 5.4
x[c(T,F)]      #  2.1, 3.3
x[c(3,2,NA)]   #  3.3, 4.2, NA
x[]            #  2.1, 4.2, 3.3, 5.4
x[0]           #  numeric(0)
x["a"]         #  5.4
x["b"]         #  NA (이름에 없는 이름으로 서브셋시 NA)


## b. List
##   --> list_object[양의정수] : 해당 위치의 원소를 리스트로 반환
##   --> list_object[양의실수] : list_object[floor(양의실수)]와 동일
##   --> list_object[음의정수] : 특정 위치의 원소만 생략하고 리스트로 반환
##   --> list_object[논리형벡터] : 대응하는 논리값이 TRUE인 곳의 요소를 반환
##   --> list_object[NA] : 원래의 리스트의 길이와 동일한 수의 NA 반환 (리스트로)
##   --> list_object[] : 해당 리스트 반환
##   --> list_object[0] : 길이가 0인 리스트를 반환
##   --> list_object["b"] : 해당 이름을 가진 원소를 리스트로 반환
##   "[["연산자와 "$"연산자는 리스트의 요소를 추출
##   --> list_object[1][[c(2,3)]] : 리스트의 첫번째 요소에 2,3 번째 값을 추출
##   --> list_object$a[2] : a의 이름을 가진 요소의 2번째 값을 추출

# Practice
y <- list(a=c(1,2,3), b=data.frame(iris[1:5,]),c=matrix(0, 3, 3))
y[2]      # b
y[2.3]    # b
y[-2]     # a, c
y[c(T,F)] # a, c
y[NA]     # NA, NULL
y[]       # a,b,c
y[0]      # list()
y["b"]    # b
y$a[2]    # 2


## c. Matrix & Array
##   --> 다중 벡터
##   --> 단일 벡터
##   --> 매트릭스
##   (* 각 차원에 쉼표로 구분된 1차원 인덱스를 추가함으로써 차원에 따른 인덱스 가능)
##   (* blank subsetting : 공백을 사용해 해당 차원의 모든 값을 유지)
##   (* R은 column-major order; 열 우선으로 처리/저장)
##   (* Matrix와 Array는 백터로 저장되나 차원을 부여해 표시한다고 생각하면 좋음)

# Practice
a <- matrix(1:9, nrow=3, dimnames = list(NULL, c("A","B","C"))); a
a[1:2, ]  # 1~2행과 모든열 표시
a[1, 2:3] # 1행과 2~3열 표시
a[c(T,F,T), c("B","A")] # 1,3행과 "B", "A"열 표시
a[-1, -2] # 1행을 제외한 2~3행과 2열을 제외한 1,3열 표시

vals <- outer(X=1:5, Y=letters[1:4], FUN=function(x,y){stringr::str_c(x,y,sep="")})
vals
vals[c(1,14)] # (1,1), (4,3) 원소 표시
vals[matrix(c(1,1,3,1,2,4), ncol=2, byrow=T)] # (1,1), (3,1), (2,4) 원소 표시


## d. DataFrame
##  --> list와 matrix 두가지 성질을 모두 가지고 있음
##  --> 한 개의 벡터로 서브셋팅하면 리스트처럼 작동
##  --> 두 개의 벡터로 서브셋팅하면 매트릭스처럼 작동

# Practice
df <- data.frame(x=1:3, y=3:1, z=letters[1:3]); df
df[df$x==2, ]    # 2행 1~3열 표시
df[3]            # 3열 표시
df$x             # x열 표시 (백터)
df[c("x","y")]   # x열, y열 표시 (데이터프레임)
df[, c("x","y")] # x열, y열 표시 (매트릭스)


## e. OOP object
## --> S3 객체 : 원자 벡터, 어레이, 리스트로 구성되어 있으므로 "[", "[[", "$"로 분리
## --> S4 객체 : @연산자 ($연산자와 비슷한 역할), slot() ([[와 동일한 역할)을 사용

