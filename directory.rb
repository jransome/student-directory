# put students into an array
students = [
   ["Dr. Hannibal Lecter", :november],
   ["Darth Vader", :november],
   ["Nurse Ratched", :november],
   ["Michael Corleone", :november],
   ["Alex DeLarge", :november],
   ["The Wicked Witch of the West", :november],
   ["Terminator", :november],
   ["Freddy Krueger", :november],
   ["The Joker", :november],
   ["Joffrey Baratheon", :november],
   ["Norman Bates", :november]
]

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each do |student|
    puts "#{student[0]} (#{student[1]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

#nothing happens untill we call these methods
print_header
print(students)
print_footer(students)
