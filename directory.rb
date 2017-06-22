@students = [] # empty array accessible to all methods
$line_width = 100
$default_cohort = :November
$months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the student array
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:country], student[:height], student[:hobby]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students (filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country, height, hobby = line.chomp.split(",")
    add_student({name: name, cohort: cohort.to_sym, country: country, height: height, hobby: hobby})
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} records from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist"
    exit # quits the program
  end
end

def add_student (student)
  @students << student
end

def interactive_menu
  students = []
  loop do
    # print the menu of options
    print_menu
    # read input and save to a variable
    selection = STDIN.gets.chomp
    # do what the user has asked
    process(selection)
  end
end

def process(selection)
  case selection
    when "1"
      # input students
      input_students
    when "2"
      # show students
      show_students
    when "3"
      # save students
      save_students
    when "4"
      #load students
      load_students
    when "9"
      # exit program
      exit
    else
      puts "I don't know what you meant, please try again"
  end
end

def print_menu
  puts "1. Input new students"
  puts "2. Show existing students"
  puts "3. Save the list to students.csv"
  puts "4. Load students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "-------------".center($line_width)
end

def print_students_list
  if @students.empty?
    puts "No students in database!"
    return
  end
  @students.sort_by! {|s| s[:cohort] }
  @students.each_with_index do | student, i |
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort), birthplace: #{student[:country]}, height: #{student[:height]}cm, favourite hobby: #{student[:hobby]}.".ljust($line_width)
  end
end

def print_footer
  if @students.empty?
    puts "No students in database!"
    return
  end
  print "Overall, we have #{@students.count} great "
  puts @students.count == 1 ? "student" : "students"
end

def input_students
  puts "Please enter the student's first name"
  puts "To quit instead, hit return without typing"
  # get the first names
  name = STDIN.gets.gsub(/\n/, "")
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "What cohort is #{name} in?"
    cohort = nil
    until $months.include?(cohort)
      cohort = STDIN.gets.gsub(/\n/, "").capitalize
      puts "Not a valid cohort, please enter a month, or hit return to register the default cohort (#{$default_cohort})" if !$months.include?(cohort.to_sym) && cohort != ""
      cohort = $default_cohort if cohort == ""
      cohort = cohort.to_sym
    end
    puts "What is #{name}'s favourite hobby?"
    hobby = STDIN.gets.gsub(/\n/, "")
    puts "What is #{name}'s height in cm?"
    height = STDIN.gets.gsub(/\n/, "")
    puts "What is #{name}'s country of birth?"
    country = STDIN.gets.gsub(/\n/, "")
    add_student({name: name, cohort: cohort.to_sym, country: country, height: height, hobby: hobby})
    print "Now we have #{@students.count} "
    puts @students.count == 1 ? "student" : "students"
    # get another name from the user
    puts "Please enter the next student's first name"
    puts "If you've finished adding students, hit return without typing instead"
    name = STDIN.gets.gsub(/\n/, "")
  end
end

#nothing happens untill we call these methods
try_load_students
interactive_menu
