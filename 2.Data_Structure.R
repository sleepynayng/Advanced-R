##### Data Structure
### 1. Vector
##  --> 백터는 원자백터와 리스트로 구성
##  --> 백터의 속성 = 유형, 길이, 속성
##  --> atomic vector (동질적), list(이질적)

## 구조 확인
# 백터확인 --> is.vector
# 원자백터 --> is.atomic
# 리스트   --> is.list

library(magrittr)

myvec <- c(1,2,3,5)
mylist <- list(1, 2, 3) 
item <- list("vector"=myvec, "list"=mylist)

item %>% lapply(is.vector)
item %>% lapply(is.atomic)
item %>% lapply(is.list)

# NA = 길이가 1인 논리형 백터
# 유형 =  논리형, 정수형, 더블형, 문자형
# 동질적인 구조에서 값들은 유연한 유형으로 형변환됨(coercion)
# is.numeric --> 정수형과 더블형에서만 TRUE 반환
# 유형 확인 --> is.logical, is.integer, is.double, is.character
# 유형 변환 --> as.logical, as.integer, as.double, as.character
# 원자벡터 -> 리스트 : as.list
# 리스트 -> 원자백터 : unlist


## 속성 
#  --> 모든 객체는 객체에 관한 메타데이터를 저장하기 위해 임의의 속성을 가질 수 있음
#  --> attr(object, "attr_name")을 통해 개별 속성에 접근
#  --> attributes(object)을 통해 전체 속성에 접근
#  --> 속성은 리스트로 관리되나 대부분의 속성은 객체가 수정될때 상실된다
#  --> 이름(names), 차원(dimensions), 클래스(class)는 상실되지 않는 속성
#     --> 해당 속성은 attr로 접근하는 것이 아닌, names, dim, class 함수 사용

y <- c("chanmook", "찬묵", "LIM")
attr(y, "my_attribute") <- "THIS IS MY NAME"

print(attr(y, "my_attribute"))
print(attributes(y))
print(str(attributes(y))) 

## 속성 - 이름(names)
## 생성하는 방법
# 1. 객체를 만들때 각 값에 이름을 부여한 경우
# 2. 만들어진 객체에 names 함수를 사용해 이름을 부여하는 경우
# 3. setNames등의 함수를 사용해 백터의 수정된 사본을 생성할 때
## 특징
# 1. 이름이 유일할 필요는 없음
# 2. 백터의 모든 요소가 이름을 가질 필요는 없음
# 3. 벡터에 이름을 부여한 경우 문자 서브셋팅할 수 있음

## 팩터(factor)
#  --> 사전에 정의된 값만을 담고 있는 백터로 범주형 자료를 저장할때 주로 사용
#  --> 팩터는 class, levels의 두가지 속성을 이용하여 생성
#  --> 문자형 벡터가 아닌 정수형 벡터이다
x <- factor(c("a","b","b","a"), levels = c("a", "b"))
class(x)
levels(x)
c(factor("a"), factor("b")) # --> 팩터끼리 결합할 수 있다


### 2. 매트릭스와 어레이
## 생성하는 방법 
# 1. matrix, array 함수로 직접 생성
# 2. 기존 atomic vector의 dim 속성을 사용해 생성
# 3. 기존 객체에 rbind, cbind, abind 함수를 사용

a <- matrix(1:6, nrow=2, ncol=3); a
b <- array(1:12, dim = c(2,3,2)); b
c <- 1:6; dim(c) <- c(2,3); c

# 메트릭스의 차원에 이름 부여 --> rownames, colnames, dimnames
a <- matrix(1:6, nrow=2, ncol=3, dimnames = list(c("hi","there"), c(1,2,3))); a
a <- matrix(1:6, nrow=2, ncol=3, dimnames = list(NULL, c(1,2,3))); a

### 3. 데이터프레임
##   --> 내부적으로 동일한 길이를 가진 백터로 된 리스트
##   --> 2차원 구조로 리스트와 매트릭스의 속성을 모두 갖고 있다
##   --> data.frame()을 사용하여 생성
##   --> 기존 객체에 rbind, cbind 사용하여 생성
a <- data.frame(name="chanmook", grade=4)
is.list(a)
is.data.frame(a)
