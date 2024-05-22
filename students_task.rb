require 'date'

module Validation
  def match(pattern, text)
    pattern.match?(text)
  end

  def date_in_range(from, to, date)
    from <= date && date <= to
  end

  def validate_name(name, field)
    raise ArgumentError, "#{field} is invalid" unless match(/\A[A-Z][a-z]*\z/, name)
    name
  end

  def validate_date(date)
    parsed_date = Date.parse(date)
    today = Date.today
    raise ArgumentError, "Date of birth is out of valid range" unless date_in_range(Date.new(1900, 1, 1), today, parsed_date)
    parsed_date
  end

  def validate_student_id(id)
    raise ArgumentError, "Student ID is invalid" unless match(/\A\d{6}\z/, id)
    id
  end

  def validate_group_name(name)
    raise ArgumentError, "Group name is invalid" unless match(/\A\d+\z/, name)
    name
  end

  module_function :match, :date_in_range, :validate_name, :validate_date, :validate_student_id, :validate_group_name
end

class Student
  include Validation

  attr_accessor :first_name, :last_name, :birth_date, :student_id

  def initialize(first_name, last_name, birth_date, student_id)
    @first_name = validate_name(first_name, 'First name')
    @last_name = validate_name(last_name, 'Last name')
    @birth_date = validate_date(birth_date)
    @student_id = validate_student_id(student_id)
  end
end

class Group
  include Validation

  attr_accessor :name, :students

  def initialize(name)
    @name = validate_group_name(name)
    @students = []
  end

  def add_student(student)
    @students << student
  end
end

begin
  student1 = Student.new('John', 'Doe', '2000-05-15', '123456')
  student2 = Student.new('Jane', 'Smith', '1999-11-20', '654321')
  student3 = Student.new('Alice', 'Johnson', '2001-02-10', '234567')
  student4 = Student.new('Bob', 'Brown', '1998-07-30', '345678')
  student5 = Student.new('Charlie', 'Davis', '2000-08-25', '456789')

  group1 = Group.new('402')
  group2 = Group.new('422')

  group1.add_student(student1)
  group1.add_student(student2)
  group1.add_student(student3)

  group2.add_student(student4)
  group2.add_student(student5)

  def find_student_by_id(groups, student_id)
    groups.each do |group|
      group.students.each do |student|
        return student if student.student_id == student_id
      end
    end
    nil
  end

  found_student = find_student_by_id([group1, group2], '345678')
  puts "Found student: #{found_student.first_name} #{found_student.last_name}" if found_student

  [group1, group2].each do |group|
    group.students.sort_by! { |student| [student.first_name, student.last_name] }
  end

  [group1, group2].each do |group|
    puts "Students in #{group.name}:"
    group.students.each do |student|
      puts "#{student.first_name} #{student.last_name}"
    end
  end

rescue ArgumentError => e
  puts "Error: #{e.message}"
end
