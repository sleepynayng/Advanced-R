##### Useful Function in R

### 첫 번째로 배우게 될 함수
utils::help   # document에 대한 접근을 제공하는 함수 ?function_name과 동일
utils::str    # R 객체의 내부 구조, 진단 기능 및 요약을 간결하게 표시

### 매칭 연산자
# x %in% table --> table 집합에 x와 같은 원소가 있으면 T 반환
# match(x, table) --> table 집합에 x와 같은 원소의 위치를 반환
"j" %in% letters    # TRUE
match("j", letters) # 10 (j는 letters 10번째에 위치)

### 할당 연산자 : =, <-, <<- 
# =와 <- 연산자는 연산자가 평가되는 환경에 할당
#  (* 대신 <- 연산자가 = 연산자보다 우선순위가 높다)
#  (* = 연사자는 명령의 최상의 수준에서만 사용가능)
#  (* <- 연산자는 어느곳에서나 사용가능하므로 함수 호출과 할당 동시에 가능)
# <<- 연산자는 함수내부에서 주로 사용되며 함수내 환경에서 할당이
#     아닌 전역환경에서 할당ppp
median(x = 1:10)
median(x <- 1:10)  

x = 10
myplus1 <- function(value){ x <- value+1; x}
myplus1(value=11) ; print(x)

x = 10
myplus1_global <- function(value){ x <<- value + 1; x}
myplus1_global(value=11); print(x)

### 주요 연산자 1 : with, within
# with : with(object, expr), 데이터 프레임 또는 리스트 내 필드를 
#        서브세팅 연산자 없이 객체 내부의 원소에 접근할 수 있게 하는 함수
library(magrittr)
iris$Sepal.Length %>% mean
with(iris, expr=mean(Sepal.Length))

# within : with(object, expr), with와 비슷하나 데이터 수정 기능 제공
score <- data.frame( name = c("mook", "sky", "woong"), test=c(100, 98, NA))
within(score, expr = {
  test = ifelse(is.na(test), 60, test)
  print(mean(test))})


### 주요 연산자 2 : assign, get
# assign(x, value, pos, envir) : 설정된 환경에 x라는 변수에 value의 값을 할당
for(i in 1:10){
  varname <- stringr::str_c("student", i, sep="")
  assign(varname, runif(n=1, min=0, max=1))}
print(student1); print(student4); print(student9)

# get(x, pos, envir) : 설정된 환경에서 x에 주어진 문자에 바인딩 된 객체에 접근
get("student2")
get("mean")

envir1 <- new.env()
assign("envir1.object1", as.list(LETTERS), envir = envir1)
get("envir1.object1", pos=-1)       # 작업 환경에는 해당 객체가 존재하지 않음
get("envir1.object1", envir=envir1) # 생성한 객체에서는 해당 객체가 존재


### 주요 연산자 3 : 비교 및 대조 함수
# all.equal : x와 y의 "near equality"를 검증하는 함수
#           : 차이가 있으면 FALSE를 반환하는 것이 아닌 차이점에 관한 보고를 제공 
#           : if문에 사용할때는 isTRUE(all.equal(...)) or identical 사용 권장
# identical : x와 y의 "exact equality"를 검증하는 함수
#           : TRUE/FALSE 반환하며 environments equality도 테스트
x = c(1:9,11)
y = c(1,2,3,4,5,6,7,8,9,10)
all.equal(x,y)          # Mean relative difference : 0.0909
isTRUE(all.equal(x,y, tolerance = 2))  # TURE
identical(x,y)          # FALSE


### 주요 연산자 4 : NA 체크 함수
# is.na : 어떤 원소가 na인지 가리키는 함수
# anyNA : any(is.na(x))와 동일한 기능으로 na가 하나라도 있으면 TRUE 반환
# complete.cases : 관측치에 missing value가 있으면 해당 케이스의 결과는 FALSE
#                : 주로 데이터프레임 이나 행렬에 적용
is.na(c(1,NA))
anyNA(c(1,NA))
complete.cases(airquality)


### 사용자 정의 함수 : function(arglist) expr
# 인수 목록의 이름은 따옴표로 묶인 비표준 이름을 지원
# 값이 없으면 NULL을 반환하나 평가된(계산된) 표현이 있으면 해당 값을 반환
# return을 사용하지 않을 경우 마지막으로 평가된 표현이 반환

## 사용자 정의 함수에 사용되는 유용한 기능
# invisible : invisible(x), return a invisible copy of an object
# missing : test whether a value was sepcificed as an argument to function
# match.arg : matches a character arg against a table of canidate values
center <- function(x, type = c("mean", "median", "trimmed")){
  type <- match.arg(type)
  switch(type, "mean" = mean(x), "median" = median(x), trimmed = mean(x, trim=.1))}
center(1:10, type="mea")
center(1:10, type="mean")


### Closure(클로저) : function written by functions
# 함수 기능은 동일하지만 primitive function과 구분하기 위해 클로져라고 한다
# --> annoymous fuctions는 클로저를 만들기 위해 자주 사용 
# --> closure는 코드에서 중복을 제거하는데 사용가능
# --> closure는 R 환경의 함수 내에서 함수를 생성하는데 사용가능

### Closures(클로져)의 세가지 구성 
# 1. formals(형식)     : argument list
# 2. body(몸체)        : expr
# 3. environment(환경) : provide the enclosure of the evaluation frame
#                      : when closure is used

# named function
addnum <- function(a,b){a+b}
addnum(2,3)

# same take with closure
(function(a,b){a+b})(2,3)

# using closure in primitive function
maxval <- function(a,b){
  (function(a,b){ return(max(a,b)) })(a,b)}; maxval(c(1,10,5), c(2,11))

### 논리형과 집합
# &(and), &&(and), |(or), ||(or)
# --> shorter forms performs elementwise comparisons
# --> longer forms evalute left to right, proceeding only unit result is determined
x <- c(T,F,T,F); y <- c(F,T,T,F)
x & y
x && y

# all : 모든 논리형 백터가 T인 경우만 TRUE 반환
# any : 논리형 백터에서 적어도 하나의 T가 있어도 TRUE 반환
# which : Give the TRUE indices of a logical object, allowing for array indices
# intersect(교지합), union(합집합), setdiff(차집합), setequal(집합의 동등성)

### 백터와 메트릭스
# 생성 : c, rep, rep_len, seq, seq_len, seq_along, rev, sample
# 생성 : matrix, cbind, rbind, as.matrix
# 속성 : length, dim, ncol, nrow, name, colnames, rownames
# 특별 : t(전치함수), diag(대각함수), sweep(함수적용)

### 분포와 관련된 함수
# 베타함수 : beta(a,b), lbeta(a,b)
# 감마함수 : gamma(x), lgamma(x)
# 조합 : choose(n,k) --> nCk, 
#      : combn(x, m) --> x에서 m개를 뽑은 원소의 가능한 모든 조합
# 팩토리얼 : factorial(x)

### 리스트와 데이터프레임
# 생성 : list, unlist, data.frame, as.data.frame
# 함수 : split(x, f, drop=F) (divide data in the vector x into groups defined by f)
# 함수 : expand.grid(...) (create df from all combination of factor r.v)
library(magrittr)
x=round(runif(10)*10,2)
f=stringr::str_c("class", c(1,2,3,3,2,
                            3,1,3,2,1), sep="") %>% as.factor()
split(x, f)
expand.grid(x=seq(from=0,to=1,by=0.1), grade=LETTERS[1:4], class=c("Class1","Class2"))

### 흐름제어(control flow)
# 조건문1 : if(cond) expr
# 조건문2 : if(cond) cons.expr else alt.expr
# 조건문3 : ifelse(test, yes, no)
# 조건문4 : switch(EXPR, ...) (* ... : the list of alternatives)
# ---------------------------------------------------------------------------------
# 반목문1 : for(var in seq) expr --> var이 seq에 있는 원소를 차례로 받아 expr 실행
# 반복문2 : while(cond) expr --> cond이 참인동안 expr 반복
# 반복문3 : repeat expr --> expr을 무한하게 반복 
# ---------------------------------------------------------------------------------
# break --> breaks out of a for, while or repeat loop
# next  --> halts the processing of the current iteration and advances the looping index

### Apply 계열 함수
# apply(X, MARGIN, FUN, simplify=T) 
#   --> return values obtained by applying a function to margins of an array or matrix
# lapply(X, FUN, ...), sapply(X, FUN, ..., simplify=T), vapply(X, FUN, FUN.VALUE)
#   --> lapply : 리스트의 원소별로 함수를 적용한 값을 리스트로 반환
#   --> sapply : 리스트의 원소별로 함수를 적용한 값을 백터나 메트릭스로 반환
#   --> vapply : sapply와 유사하나 미리 지정된 타입의 형태로 객체를 반환하므로 안전함
# replicate(n, expr, simplify = "array")
#   --> wrapper of the common use of sapply for repeated evaluation of an expression
# tapply(X, INDEX, FUN, simplify=T)
#   --> apply a function over a ragged array
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE)); x
lapply(x, mean)
sapply(x, mean)
i39 <- sapply(3:9, seq); i39
sapply(i39, fivenum)
vapply(i39, fivenum, FUN.VALUE = c("a"=0,"b"=10,"c"=20,"d"=30,"e"=40), USE.NAMES=F)
groups <- as.factor(rbinom(32, n = 5, prob = 0.4)); groups
tapply(groups, groups, length)
replicate(n=10, expr=sample(x=letters, size=5))
