#!/usr/bin/env ruby

=begin
Main Task
Написать скрипт, который выводит последовательность чисел Фибонначи
=end

n = ARGV.shift.to_i
a = 0
b = 1
n.times do
  print "#{a} "
  a, b = b, a + b
end


=begin
task1
Создать переменную для строки "dniMyMdegnahCybuR" . Написать однострочную инструкцию, которая поменяет порядок
букв на противоположный и понизит все буквы в регистре кроме первой. Вывести результат. Значение переменной должно
быть изменено.
=end
puts "\nstring reverse"
mind_string = 'dniMyMdegnahCybuR'
mind_string.reverse!.capitalize!
puts mind_string

=begin
task2
Дано семизначное число. Вывести на экран число, где первая цифра стала последней, вторая - предпоследней и тд.
=end
puts "Enter 7digits number"
def number7(n)
  if n.size == 7
    puts n.reverse.to_i
  else
    puts "Number is not 7 digits, enter correct number"
    number7(n = gets.chomp)
  end
end
number7(n = gets.chomp)


=begin
task3
Дано целое число. Найти и вывести сумму его цифр.
=end
puts "Enter number no sum elements"
number=gets
sum=0
number.to_i.to_s.each_char { |char| sum += char.to_i}
puts sum


=begin
task4
Дана строка. Необходимо подсчитать количество букв "а" в этой строке (независимо от регистра)
=end
puts "Enter string for 'aA' checking"
a_check=gets
puts "Aa is mentioned #{a_check.count('aA')} times"


=begin
task5
Дана строка. Проверить, является ли она палиндромом
=end
puts "Enter word to palindrome check"
palindrome=gets.chomp
puts palindrome == palindrome.reverse ? "palindrome" : "not palindrome"

=begin
task6
Вывести на экран числа от 10 до 3 не влючая 5, причём числа, кратные 3м, вывести в квадрате
=end
puts "Edited array"
a=(3..10).to_a
a.delete(5)
print a.map { |elem| if elem%3==0
                       elem**2
                     else elem
                     end}.reverse


=begin
task7
Дан хэш:
shop = {
milk: 10,
bread: 8,
cornflakes: 12,
ice_cream: 15,
pie: 20
}
Ответить на вопрос: если ли в магазине какой-либо продукт с ценой в 15?
=end

shop = {milk: 10, bread: 8, cornflakes: 12, ice_cream: 15, pie: 20}
puts  "\nShop price check: #{shop.value?(15)}"


=begin
task8
дан массив ar = [1, 6,1,8,2,-1,3,5] .
Прибавить 100 к его максимальному элементу.
=end
ar = [1, 6,1,8,2,-1,3,5]
ar[ar.index(ar.max)]= ar.max + 100
print "Edited array #{ar}"


=begin
task9
Дан массив: ar = [7, 3, [4, 5, 1], 1, 9, [2, 8, 1]]
Вывести отсортированный по убыванию массив из уникальных элементов начального массива.
=end
ar = [7, 3, [4, 5, 1], 1, 9, [2, 8, 1]]
puts "\nSorted array #{ar.flatten!.uniq!.sort.reverse!}"


