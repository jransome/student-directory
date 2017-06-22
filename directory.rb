@students = [] # empty array accessible to all methods
$line_width = 100
$default_cohort = :November
$months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the student array
  @students.each do |student|
    file.puts student.values.join(",")
  end
  file.close
  puts "Student directory saved!"
end

def load_students (filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country, height, hobby = line.chomp.split(",")
    add_student({name: name, cohort: cohort.to_sym, country: country, height: height, hobby: hobby})
  end
  file.close
  puts "Loaded #{@students.count} records from #{filename}"
end

def try_load_students(filename = ARGV.first)# first argument from the command line by default
  if filename.nil? || filename.empty?
    load_students
    return
  end
  if File.exists?(filename)
    load_students(filename)
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist"
  end
end

def add_student (student)
  @students << student
end

def interactive_menu
  students = []
  loop do
    puts
    puts "MENU".center($line_width)
    # print the menu of options
    print_menu
    # read input and save to a variable
    selection = get_input
    # do what the user has asked
    process(selection)
  end
end

def process(selection)
  case selection
    when "1"
      # input students
      puts "Getting ready to input students..."
      input_students
    when "2"
      # show students
      puts "Showing student directory..."
      show_students
    when "3"
      # save students
      puts "Saving student directory..."
      save_students
    when "4"
      #load students
      puts "Please enter a filename. To load students.csv, hit return without typing"
      filename = get_input
      try_load_students(filename)
    when "9"
      # exit program
      puts "Bye!"
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
  if @students.empty?
    puts "No students in database!"
    return
  end
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "-------------".center($line_width)
end

def print_students_list
  @students.sort_by! {|s| s[:cohort] }
  @students.each_with_index do | student, i |
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort), birthplace: #{student[:country]}, height: #{student[:height]}cm, favourite hobby: #{student[:hobby]}.".ljust($line_width)
  end
end

def print_footer
  print "Overall, we have #{@students.count} great "
  puts @students.count == 1 ? "student" : "students"
end

def get_input
  STDIN.gets.gsub(/\n/, "")
end

def get_student_attribute (question)
  puts question
  get_input
end

def confirm_student_input
  print "Now we have #{@students.count} "
  puts @students.count == 1 ? "student" : "students"
end

def get_valid_cohort (name)
  cohort = nil
  puts "What cohort is #{name} in?"
  until $months.include?(cohort)
    cohort = get_input.capitalize
    puts "Not a valid cohort, please enter a month, or hit return to register the default cohort (#{$default_cohort})" if !$months.include?(cohort.to_sym) && cohort != ""
    cohort == "" ? cohort = $default_cohort : cohort = cohort.to_sym
    return cohort
  end
end

def input_students
  # get the first name
  name_question = "Please enter the next student's first name\nTo quit instead, hit return without typing"
  name = get_student_attribute(name_question)
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get all attributes
    cohort = get_valid_cohort(name)
    puts cohort.inspect
    hobby = get_student_attribute("What is #{name}'s favourite hobby?")
    height = get_student_attribute("What is #{name}'s height in cm?")
    country = get_student_attribute("What is #{name}'s country of birth?")
    # add the student to the directory array
    add_student({name: name, cohort: cohort, country: country, height: height, hobby: hobby})
    # confirm input and get another name from the user
    confirm_student_input
    name = get_student_attribute(name_question)
  end
end

#nothing happens untill we call these methods
try_load_students
interactive_menu
