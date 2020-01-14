#!/usr/bin/env ruby
=begin
task1
написать метод, который принимает аргументом объект типа Proc и возвращает время затраченное на выполнение
данного прока (примитивный бенчмаркинг).
    Текущее время можно узнать с помощью Time.now
=end

def benchmark(a)
  t1=Time.now
  a.call
  t2=Time.now
  p t2-t1
end
a = Proc.new {sleep 1}
benchmark(a)
#or
benchmark proc {sleep 1}

=begin
task2
дан массив: array = [1, 2, 3, 4] . Написать метод mega_sum , который поддерживает следующее использование:
mega_sum(array) # => 10 # простая сумма элементов
mega_sum(array, 10) # => 20 # сумма всёх элементов + переданное значение
mega_sum(array) { |i| i ** 2} => 30 # сумма элементов с применённым блоком
mega_sum(array, 10) { |i| i ** 2} => 40 # сумма элементов с применённым блоком + переданное значение Это всё
один метод!

=end

array = [1, 2, 3, 4]
def megasum(array, i=0)
  array_clone=array.clone
  array_clone.map! {|e| yield(e)} if block_given?
  puts array_clone.inject {|e, sum| sum + e } +i
end

megasum(array)
megasum(array, 10)
megasum(array) { |i| i ** 2}
megasum(array, 10) { |i| i ** 2}

=begin
task3
В диапазоне от 1 до 1_000, найти первое трёхзначное число у которого остаток деления на 7 равен 3
=end

def range_task
  number=(1..1000).detect { |i| (i.to_s.size >= 3) && (i%7==3) }
  puts "#{number} is the first 3 digit number we need"
end
range_task


=begin
task4
Написать метод, с двумя именнованными аргументами, а всеми остальными - не-обязательными (не ограничено
количеством). Если за методом следует блок, то вызвать его на каждом из не обязательных аргументов, если же блок не
следует вывести ‘ERROR”. Пример:

method_name(...) # => "ERROR"
method_name(..., 1, 2, 3) {|i| puts i}
1
2
3
=> nil

=end


def arguments(*args, named1:, named2:)
  if block_given?
    p args.map {|i| yield(i) }
  else
    puts "ERROR"
  end
end

arguments(1,2,3, named1:2, named2:3 ) { |i| puts i}



=begin
task5
Апгрейд стандартной библиотеки. Мы напишем метод, который будет возвращать все чётные числа, соответсвующие
переданному в блок условию:
                       Чтобы это работало, делаем так:
                                                      class Array
                                                        def ваш_метод
                                                          < code >
                                                        end
                                                      end
puts [1, 2, 3, 4, 5, 6, 7].ваш_метод { |i| i > 2}.inspect # => [4, 6]
puts [1, 2, 3, 4, 5, 6, 7].ваш_метод { |i| i > 10}.inspect # => nil
puts [2, 4, 6, 8, 10, 12, 7].ваш_метод {|i| i.between?(6, 12)}.inspect # => [6, 8, 10, 12]
=end

class Array
  def update()
    array = self.reject! { |i| i.odd? }
    array.select! { |val| yield(val) } if block_given?
    return array
  end
end

puts [1, 2, 3, 4, 5, 6, 7].update { |i| i > 2}.inspect
puts [1, 2, 3, 4, 5, 6, 7].update { |i| i > 10}.inspect
puts [2, 4, 6, 8, 10, 12, 7].update {|i| i.between?(6, 12)}.inspect