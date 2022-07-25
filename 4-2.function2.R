##### Useful Function 2 : 공통적인 데이터 구조

### 날짜&시간
# ISOdate, ISOdatetime : wrappers to create date or datetime from numeric representation
# strftime : convert objects from the classes "POSIXlt", "POSIXct" to character vector
# strptime : convert character vector to class "POSIXlt"
# Sys.time : 시스템의 현재 시간을 반환
# date : Return a character string of the current system date and time
# difftime(time1, time2, units) : Time intervals creation
# POSIXlt 원소에서 객체 추출 : weekdays, months, quarters, julian
ISOdate(year=2022, month=7, day=23, hour=17, min=3, sec=53)
ISOdatetime(year=2022, month=7, day=23, hour=17, min=4, sec=22, tz = "Asia/seoul")
strftime("2022-07-23 17:04:22 KST")
strptime("2022-07-23", format="%Y-%m-%d")
Sys.time(); date()
difftime(time1 = "2022-07-23", time2 = "1997-03-12")
julian(Sys.time()); weekdays(Sys.time()); months(Sys.time()); quarters(Sys.time())


### 문자조작
## grep계열 : grep, grepl, regexpr, gregexpr, regexc, gregexec
#    --> search for matches to argument pattern
## sub계열  : sub, gsub 
#    --> perform replacement of the first and all matches
# strsplit : split에 지정된 문자열을 기준으로 문장 분리
# chartr   : old와 new에 지정된 글자를 1대1 대응으로
#          : x에 각 문자를 대응되는 문자로 변환
# nchar, tolower, toupper, substr, paste
banana <- c("banana", "bananas", "BANANA", "bani")
grep(pattern=".a", x=banana)  # 1,2,4
grepl(pattern=".a", x=banana) # T,T,F,T
sub(pattern=".a", replacement = "!", x=banana)
gsub(pattern=".a", replacement = "!", x=banana)
strsplit(x="안녕하세요.반갑습니다.", split = "\\.")

x <- "MiXeD cAsE 123"
chartr("iXs", "why", x)
chartr("a-cX", "D-Fw", x)


### 팩터
# factor : factor(x, levels, label = levels, ordered, exclude)
# levels(factor_object) : 팩터의 범주를 출력
# nlevels(factor_object) : 팩터의 범주 수를 출력
# reorder, relevel
# cut : cut(x, breaks), breaks가 단일백터이면 해당 입력만큼 구간을 나눔
#                       breaks가 2개 이상의 백터이면 해당 값이 구간의 시작과 끝을 이룸
# findInterval(x, vec), vec에 나오는 값을 기준으로 설정된 구간을 x에 적용하여 구간 출력
#                     , cut과 유사하나 -Inf, Inf와 같은 지정 없이 작동
# interaction(f1, f2) : computes a factor which represents the interaction of the given factors
f <- factor(x=c("a","b","a","c"), levels=letters, 
            labels = 1:26); f
levels(f)
nlevels(f)
cut(2:18, breaks=c(5,10,15))
findInterval(2:18, vec=c(5,10,15))


### 어레이
# array : array(data=NA, dim=length(data), dimnames=NULL)
# dim   : retrieve or set the dimension of an object
# dimnames : retrieve or set the dimnames of an object
#   --> dimnames(x) <- value 대신 provideDimnames(x, sep="", base=list(LETTERS)) 사용 가능
# aperm : Transpose an array by permuting its dimensions and optionally resizing it
