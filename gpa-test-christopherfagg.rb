# Challenge
# We’ve created the outline of a ruby file for you to complete. The aim of the challenge is to turn multiple letter grades into a single score, a [grade point average (GPA)](https://www.edglossary.org/grade-point-average/).
#
# Each grade corresponds to a value:
#
# A = 4 points
# A- = 3.7 points
# B+ = 3.3 points
# B = 3 points
# B- = 2.7 points
# C+ = 2.3 points
# C = 2 points
# C- = 1.7 points
# D+ = 1.3 points
# D = 1 point
# D- = 0.7 points
# E+ = 0.5 points
# E = 0.2 points
# E- = 0.1 points
# F = 0 points
# U = -1 points
#
# You can run the tests in the file by using:
#
# ```bash
# ruby gpa-test.rb
# ```
#
# You'll see a bunch of failing output e.g.
#
# ```
# ---------- Sue ----------
# ❌ GPA: 'expected 4' but got '0'
# ❌ ANNOUNCEMENT: expected 'Andy scored an average of 4.0' but got ''
# ...
# ...
# ...
# ```
#
# You just need to complete the code to make the tests pass! You only need to change the `Calculator` class to make the tests pass.

class Calculator
  attr_reader :name, :grades

  # Initialise once & freeze, no need to create on every gpa call, '' over "" because interpolation etc not necessary, no need to read for it.
  GRADES = {
      'A'  => 4.0,
      'A-' => 3.7,
      'B+' => 3.3,
      'B'  => 3.0,
      'B-' => 2.7,
      'C+' => 2.3,
      'C'  => 2.0,
      'C-' => 1.7,
      'D+' => 1.3,
      'D'  => 1.0,
      'D-' => 0.7,
      'E+' => 0.5,
      'E'  => 0.2,
      'E-' => 0.1,
      'F'  => 0.0,
      'U'  => -1.0
    }.freeze


  def initialize(name, grades)
    @name = name
    @grades = grades
  end

  def gpa
    return nil if grades.empty?
    
    # Drop nil values from arr if grade_point returns nothing
    grade_total = grades.map { |grade| grade_point(grade) }.compact
    return nil if grade_total.empty?

    # Round to one decimal place for output
    average = (grade_total.sum / grade_total.count).round(1) 
  end

  def announcement
    "#{name} scored an average of #{gpa}"
  end

  private

  def grade_point grade
    GRADES[grade]  
  end
end

## Tests
# Beryl amended to 3.0 based on (4+3+2) / 3 = 3
# Frida amended to 0.2 based on (0.2+0.1) / 2 = 0.15 -> 0.2
tests = [
  { in: { name: 'Andy',  grades: ["A"] }, out: { gpa: 4, announcement: "Andy scored an average of 4.0"  } },
  { in: { name: 'Beryl',  grades: ["A", "B", "C"] }, out: { gpa: 3.0, announcement: "Beryl scored an average of 3.0"  } }, 
  { in: { name: 'Chris',  grades: ["B-", "C+"] }, out: { gpa: 2.5, announcement: "Chris scored an average of 2.5"  } },
  { in: { name: 'Dan',  grades: ["A", "A-", "B-"] }, out: { gpa: 3.5, announcement: "Dan scored an average of 3.5"  } },
  { in: { name: 'Emma',  grades: ["A", "B+", "F"] }, out: { gpa: 2.4, announcement: "Emma scored an average of 2.4"  } },
  { in: { name: 'Frida',  grades: ["E", "E-"] }, out: { gpa: 0.2, announcement: "Frida scored an average of 0.2"  } },
  { in: { name: 'Gary',  grades: ["U", "U", "B+"] }, out: { gpa: 0.4, announcement: "Gary scored an average of 0.4"  } },
]

# Think about how you might solve these tests too
# extra_tests = [
#   { in: { name: 'Non-grades',  grades: ["N"] } },  
#   { in: { name: 'Non-strings',  grades: ["A", :B] } },
#   { in: { name: 'Empty',  grades: [] } },
#   { in: { name: 'Numbers',  grades: [1, 2] } },
#   { in: { name: 'Passed a string',  grades: "A A-" } },
# ]

## Extra test thoughts:
## 1. Return nil if not in grades, return GPA of valid values with flag re invalid value, probably an "invalid array" or a simple "invalid values omitted" message.
## 2. Cast .to_s, should match if valid, if no, point 1 behaviour
## 3. Early return if .empty?
## 4. Could evaluate against the grade values and return if valid. if grades.value?(num) return num (though on principle I'd probably flag and expect strict letter input. Confusion potential re positional logic with should 4 relate to 4th in list of key with value 4.)
## 5. Split string on whitespace, iterate on new array, rejecting those != to grades keys

tests.each do |test|
  user = Calculator.new(test[:in][:name], test[:in][:grades])

  puts "#{'-' * 10} #{user.name} #{'-' * 10}"

  [:gpa, :announcement].each do |method|
    result = user.public_send(method)
    expected = test[:out][method]

    if result == expected
      puts "✅ #{method.to_s.upcase}: #{result}"
    else
      puts "❌ #{method.to_s.upcase}: expected '#{expected}' but got '#{result}'"
    end
  end

  puts
end
