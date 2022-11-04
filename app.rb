class App < Sinatra::Base

  def fib(n)
    n < 2 ? n : fib(n-1) + fib(n-2)
  end

  trivia = {
    "who played James Bond in the film Dr No" => "Sean Connery",
    "who is the Prime Minister of Great Britain" => "Rishi Sunak",
    "what currency did Spain use before the Euro" => "Peseta",
    "what colour is a banana" => "yellow",
    "which city is the Eiffel tower in" => "Paris"
  }

  get '/' do
    question = params['q']
    puts question
    if question =~ /which of the following numbers is the largest/
      numbers = question.split(':')[2].split(', ').map(&:to_i)
      answer = numbers.max
      puts "largest number is #{answer}"
      answer.to_s
    elsif question =~ /which of the following numbers is both a square and a cube: /
      numbers = question.split(':')[2].split(', ').map(&:to_i)
      answer = numbers.find {|n| Math.sqrt(n) % 1 == 0 && Math.cbrt(n) % 1 == 0}
      answer.to_s
    elsif question =~ /what is the (\d+).. number in the Fibonacci sequence/
      n = $1.to_i
      answer = fib(n)
      answer.to_s
    elsif question =~ /which of the following numbers are primes: /
      numbers = question.split(':')[2].split(', ').map(&:to_i)
      answer = numbers.select {|n| (2..n-1).none? {|i| n % i == 0}}
      answer.join(', ')
    elsif question =~ /what is (\d+) to the power of (\d+)/
       answer = $1.to_i ** $2.to_i
       answer.to_s
    elsif question =~ /what is (\d+) plus (\d+) plus (\d+)/
      answer = $1.to_i + $2.to_i + $3.to_i
      answer.to_s
    elsif question =~ /what is (\d+) multiplied by (\d+) plus (\d+)/
      answer = $1.to_i * $2.to_i + $3.to_i
      answer.to_s
    elsif question =~ /what is (\d+) plus (\d+) multiplied by (\d+)/
      answer = $1.to_i + $2.to_i * $3.to_i
      answer.to_s
    elsif question =~ /what is (\d+) plus (\d+)/
      answer = $1.to_i + $2.to_i
      answer.to_s
    elsif question =~ /what is (\d+) minus (\d+)/
      answer = $1.to_i - $2.to_i
      answer.to_s
    elsif question =~ /what is (\d+) multiplied by (\d+)/
      answer = $1.to_i * $2.to_i
      answer.to_s
    else
      question = question.split(':')[1].strip
      answer = trivia[question]
      if answer == nil
        puts "I don't know"
      else
        answer
      end
    end
  end
end