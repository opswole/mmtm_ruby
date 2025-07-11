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

  def initialize(name, grades)
    @name = name
    @grades = grades
  end

  def gpa
    grade_total = grades.map { |grade| grade_point(grade) }.sum(0.0)
    avg = grade_total / grades.length
    p avg
  end

  def announcement
    p name
    "#{name} scores an average of #{}"
  end

  private

  def grade_point grade
    grades = {
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

    grades[grade]

  end
end

## Tests

tests = [
  { in: { name: 'Andy',  grades: ["A"] }, out: { gpa: 4, announcement: "Andy scored an average of 4.0"  } },
  { in: { name: 'Beryl',  grades: ["A", "B", "C"] }, out: { gpa: 3.1, announcement: "Beryl scored an average of 3.1"  } },
  { in: { name: 'Chris',  grades: ["B-", "C+"] }, out: { gpa: 2.5, announcement: "Chris scored an average of 2.5"  } },
  { in: { name: 'Dan',  grades: ["A", "A-", "B-"] }, out: { gpa: 3.5, announcement: "Dan scored an average of 3.5"  } },
  { in: { name: 'Emma',  grades: ["A", "B+", "F"] }, out: { gpa: 2.4, announcement: "Emma scored an average of 2.4"  } },
  { in: { name: 'Frida',  grades: ["E", "E-"] }, out: { gpa: 0.3, announcement: "Frida scored an average of 0.3"  } },
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
