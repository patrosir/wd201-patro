class Todo < ActiveRecord::Base
  def self.overdue
    where("due_date < ?", Date.today)
  end

  def self.due_today
    where("due_date = ?", Date.today)
  end

  def self.due_later
    where("due_date > ?", Date.today)
  end

  def to_displayable_string
    flag =  if completed then "[X]" else "[ ]" end
    show_date = if due_date == Date.today then " " else due_date end
    "#{id}. #{flag} #{todo_text} #{show_date}"
  end

  def self.add_task(h)
    Todo.create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end

  def self.mark_as_complete(id)
    todo = Todo.find(id)
    todo.completed = true
    todo.save
    todo
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    overdue.map { |todo| puts todo.to_displayable_string }.join("\n")
    puts "\n\n"

    puts "Due Today\n"
    due_today.map { |todo| puts todo.to_displayable_string }.join("\n")
    puts "\n\n"

    puts "Due Later\n"
    due_later.map { |todo| puts todo.to_displayable_string }.join("\n")
    puts "\n\n"
  end
end
