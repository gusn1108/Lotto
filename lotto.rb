require 'open-uri'
require 'json'
require 'awesome_print'
page = open("http://www.nlotto.co.kr/common.do?method=getLottoNumber")

lotto_read = page.read

lotto_json = JSON.parse(lotto_read)



winning_nums = Array.new #플레이스홀드를 해둔것이다. 뭔가를 할거지만 지금은 아니다.

winning_nums.push(lotto_json["drwtNo1"])
winning_nums.push(lotto_json["drwtNo2"])
winning_nums.push(lotto_json["drwtNo3"])
winning_nums.push(lotto_json["drwtNo4"])
winning_nums.push(lotto_json["drwtNo5"])
winning_nums.push(lotto_json["drwtNo6"])


winning_nums.push(lotto_json["bnusNo"]) #지금 배열에 하나하나씩 다 넣은것이다.


random_nums = Array.new # 임시 저장
random_nums_final = Array.new #7개번호 저장할 배열
for i in 1..45
    random_nums.push(i)
end

yes_or_no = "yes" 

while yes_or_no =="yes" #여기서부터 끝까지가 while 구문이다.



random_nums.shuffle! #랜덤으로 뒤섞는다.
random_nums_final=random_nums[0..6] #7개를 저장 #0부터 6개까지 배열을 자른것이다.

count = 0 
bNusCnt = 0 # 보너스 카운트

random_nums_final.sort!
winning_nums.sort!

print "\n뽑은 번호 : "
random_nums_final.each do
    |x|
    print "#{x} ,"
end
print "\n당첨 번호 :"
winning_nums.each do
   |x|
   print "#{x} ,"
end

for i in 0..5 #카운트하는부분을 for 두번으로 했다. 전체를 비교하는 것이다.
    
    for j in 0..5
             
        if winning_nums[i]==random_nums_final[j] #중복으로 뽑힐수도 있다.
            count+=1
        end
    end
    
end

if winning_nums[6]==random_nums_final[6] #보너스카운트를 하는 부분
    bNusCnt=1
end



print "\n "

puts count
puts bNusCnt

if count==6
    puts "1등입니다."
elsif count==5 && bNusCnt==1 #&& 두가지 조건이 참일때 출력
    puts "2등입니다."
elsif count==5
    puts "3등입니다"
elsif count==4
    puts "4등입니다."
elsif count==3
    puts "5등입니다."
end

    
    puts "다시하시겠어요 ? 그럼 yes 입력"
    yes_or_no=gets.chomp
    
end
