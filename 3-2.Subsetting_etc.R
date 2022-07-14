##### Subsetting etc

### 1. Subsetting Operator (서브세팅 연산자)
###   --> 서브세팅 연산자에는 "$"와 "[[" 두 종류가 있음
###   --> [  : 지정된 원소를 리스트의 형태로 반환
###   --> [[ : "[" 연산자와 비슷하나 리스트가 아닌 해당 원소의 형태로 반환
###   --> $  : "[[" 연산자와 같이 원소의 형태로 반환하나 문자 서브세팅만 지원
###          : x$y는 x[["y", exact=F]]와 동일, 변수에 저장된 값으로 접근 불가능

###   --> "[[" 와 "$"의 차이점 : $는 부분 매칭을 지원 
###       (즉 abc 변수가 있을때 $a를 하면 $abc로 나옴, "[["원소에 exact=F 동일)

# Practice
myList <- list(a=1, b=letters, c=iris[1:3,])
print(myList)

myList[1]      # 리스트로 출력
myList["a"]    # 리스트로 출력

myList[[1]]    # 백터로 출력
myList[["a"]]  # 백터로 출력
myList$a       # 백터로 출력

myList[3]      # 리스트로 출력
myList[[3]]    # 데이터프레임으로 출력
myList$c       # 데이터프레임으로 출력

var <- "cyl"
mtcars$var      # mtcars[["var"]]로 작동하므로 NULL반환
mtcars[["var"]] # var이라는 변수가 없음
mtcars[[var]]   # mtcars[["cyl"]]로 작동하므로 정상적으로 반환

x <- list(abc=1)
x$a      # x[["a", exact=F]]라 abc 변수의 값을 단순형 서브세팅함
x[["a"]] # x[["a", exact=T]]이므로 정확하게 "a"의 변수의 값을 반환하나 없으므로 NULL
x[["a", exact=F]] 

recursiveList <- list(a = list(b = list(c = list( d = 1 ))))
print(recursiveList)
recursiveList[[c("a","b","c","d")]]       # 백터를 제공하면 재귀적으로 인덱싱
recursiveList[["a"]][["b"]][["c"]][["d"]] # 순차적으로 들어가는 방식


### 2. 단순형과 유지형 서브세팅
## a. 단순형 서브세팅 : 결과를 표현할 수 있는 가능한 단순한 데이터 구조를 반환
## b. 유지형 서브세팅 : 입력한 데이터 형태의 유형으로 결과를 출력
## 유형별 서브세팅
## --> 백터   : x[[1]] (단순형),  x[1] (유지형)
## --> 리스트 : x[[1]] (단순형),  x[1] (유지형)
## --> 팩터   : x[1:4, drop=T] (단순형), x[1:4] (유지형)
## --> 어레이 : x[1,] or x[,1] (단순형), x[1,, drop=F] or x[,1, drop=F] (유지형)
## --> 데이터프레임 : x[,1] or x[[1]] (단순형), x[,1,drop=F] or x[1] (유지형)

# practice
library(magrittr)
vec <- c("a"=3, "b"=4)
a["a"] %>% str()
a[["a"]] %>% str()
a[c("a","b")]    # 정상출력
a[[c("a","b")]]  # 오류 

lst <- list("a"=1, "b"=iris[1:3,])
lst["a"] %>% str()
lst[["a"]] %>% str()
lst[1:2]    # 정상출력
lst[[1:2]]  # 오류 

z <- factor(c("a", "b", "a", "c"), levels=c("a","b","c","d")); z
z[1:2]          # 값과 함께 a,b,c,d 레벨이 같이 출력 
z[1:2, drop=T]  # 값과 함께 a,b의 레벨만 출력

a <- matrix(1:4, nrow=2); a
a[1,,drop=T] # drop = T 하는 경우 차원의 길이가 1이면 그 차원을 삭제
a[1,,drop=F]
a[,1,drop=T]
a[,1,drop=F]

df <- data.frame(a=1:2, b=1:2); df
df[1]   # 데이터프레임 형식으로 1열 출력
df[[1]] # 벡터 형식으로 1열 출력 
df[,1,drop=T] # 벡터 형식으로 1열 출력
df[,1,drop=F] # 데이터 프레임 형식으로 1열 출력
df[,"a", drop=T] # 벡터 형식으로 이름이 a인 열을 출력
df[,"a", drop=F] # 데이터 프레임 형식으로 이름이 a인 열을 출력


### 2. 결측 및 범위 밖(OOB) 인덱스
###  --> "[]"   : vec[OOB] = NA,      list[OOB] = list(NULL)
###  --> "[[]]" : vec[[OOB]] = Error, list[[OOB]] = Error
###  --> "[]"   : vec[NA] = NA,       list[NA] = list(NULL)
###  --> "[[]]" : vec[[NA]] = Error,  list[[NA]] = NULL

vec <- 1:5
vec[6]
vec[[6]]
vec[NA]
vec[[NA]]

lst <- list("1"=letters[1:5], "2"=1:5)
lst[3]
lst[[3]]
lst[NA]
lst[[NA]]

### 3. 서브세팅과 할당
## --> 모든 서브세팅은 입력 벡터의 선택된 값을 수정하기 위해 할당과 결합될 수 있다
x <- 1:5
x[c(1,2)] <- 2:3; x
x[-1] <- 4:1; x
x[c(1,1)] <- 2:3; x
x[c(T,F,NA)] <- 1; x

## --> blank subsetting을 할당과 함께 사용시 원본 객체의 클래스와 구조를 유지한다
mtcars[] <- lapply(mtcars, as.integer); str(mtcars) # data.frame
mtcars <- lapply(mtcars, as.integer); str(mtcars) # list

## --> subsetting, allocation, NULL을 결합하여 리스트에서 요소 제거 가능
## --> 요소를 제거하는 것이 아닌 NULL로 바꾸고 싶으면 list(NULL)을 할당
x <- list(a=1, b=2)
x[["b"]] <- NULL; x # b의 요소가 제거됨
y <- list(a=1)
y["b"] <- list(NULL); y # b의 요소에는 NULL이 추가됨


### 4. 응용
# 단축어 변환 for vector
x <- c("m", "f", "u", "f", "f", "m", "m")
lookup <- c(m = "Male", f = "Female", u=NA)
lookup[x]
unname(lookup[x])

# 단축어 변환 for DataFrame
grades <- c(1,2,2,3,1)
info <- data.frame(
  grade = 3:1,
  desc = c("Excellent", "Good", "Poor"),
  fail = c(F,F,T)); info

info[match(grades, info$grade), ]
rownames(info) <- info$grade
info[as.character(grades), ]

# Random Sampling
df <- data.frame(x = rep(1:3, each=2), y=6:1, z=letters[1:6]); df
df[sample(nrow(df)), ]        # Sampling
df[sample(nrow(df),3), ]      # Sampling 
df[sample(nrow(df),rep=T), ]  # bootstrap sampling

# Ordering (순서화) : order()은 벡터를 입력으로 받아 서브세팅된 벡터가
#                   : 순서화되는 방법을 설명하는 정수형 벡터를 반환
x <- c("b", "c", "a")
order(x)    # [1] 3 1 2 --> 순서가 가장 빠른 원소는 3번째에 위치하고 있다
x[order(x)] # ordering 

df2 <- df[sample(nrow(df)), 3:1]
df2[order(df2$x), ]      # x가 작은순서대로 정렬
df2[, order(names(df2))] # 변수명이 작은순서대로 정렬