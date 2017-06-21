$line_width = 100
$default_cohort = :November
$months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "-------------".center($line_width)
end

def print_directory(students)
  students.sort_by! {|s| s[:cohort] }
  students.each_with_index do | student, i |
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort), birthplace: #{student[:country]}, height: #{student[:height]}cm, favourite hobby: #{student[:hobby]}.".ljust($line_width)
  end
end

def print_footer(students)
  print "Overall, we have #{students.count} great "
  puts students.count == 1 ? "student" : "students"
end

def input_students
  puts "Please enter the student's first name"
  puts "To quit instead, hit return without typing"
  #create an empty array
  students = []
  # get the first names
  name = gets.gsub(/\n/, "")
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "What cohort is #{name} in?"
    cohort = nil
    until $months.include?(cohort)
      cohort = gets.gsub(/\n/, "").capitalize
      puts "Not a valid cohort, please enter a month, or hit return to register the default cohort (#{$default_cohort})" if !$months.include?(cohort.to_sym) && cohort != ""
      cohort = $default_cohort if cohort == ""
      cohort = cohort.to_sym
    end
    puts "What is #{name}'s favourite hobby?"
    hobby = gets.gsub(/\n/, "")
    puts "What is #{name}'s height in cm?"
    height = gets.gsub(/\n/, "")
    puts "What is #{name}'s country of birth?"
    country = gets.gsub(/\n/, "")
    students << {name: name, hobby: hobby, height: height, country: country, cohort: cohort}
    print "Now we have #{students.count} "
    puts students.count == 1 ? "student" : "students"
    # get another name from the user
    puts "Please enter the next student's first name"
    puts "If you've finished adding students, hit return without typing instead"
    name = gets.gsub(/\n/, "")
  end
  # return array of students
  students
end

#nothing happens untill we call these methods
students = input_students
print_header
print_directory(students)
print_footer(students)
