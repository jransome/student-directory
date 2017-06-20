def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students, starting_letter)
  i = 0
  while i < students.length
    puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort), birthplace: #{students[i][:country]}, height: #{students[i][:height]}cm, favourite hobby: #{students[i][:hobby]}."
    i += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  puts "Please enter the student's first name"
  puts "To quit instead, hit return without typing"
  #create an empty array
  students = []
  # get the first names
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    puts "What is #{name}'s favourite hobby?"
    hobby = gets.chomp
    puts "What is #{name}'s height in cm?"
    height = gets.chomp
    puts "What is #{name}'s country of birth?"
    country = gets.chomp
    students << {name: name, hobby: hobby, height: height, country: country, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    puts "Please enter the next student's first name"
    puts "If you've finished adding students, hit return without typing instead"
    name = gets.chomp
  end
  # return array of students
  students
end

#nothing happens untill we call these methods
students = input_students
print_header
print(students, "M")
print_footer(students)
