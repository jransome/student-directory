def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students, starting_letter)
  i = 0
  while i < students.length
    if students[i][:name][0].downcase == starting_letter.downcase && students[i][:name].length < 12
      puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)"
    end
    i += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  # get the first names
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
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
