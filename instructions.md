# Company Audit / Time Tracker


## Preparation:

1. `git clone https://github.com/turingschool-examples/company-audit`


## Workflow Requirements

2. You are REQUIRED to commit and push all code, working or not, every TWENTY (20) MINUTES.
1. You are ENCOURAGED to build a new branch for EACH ITERATION and merge the code into your master branch.
3. You can use the included `Rakefile` to run your tests using `rake`.


## Background

You work for a company which tracks employee work time on a project-by-project basis. You've been asked to write an analysis tool to track time worked by employees and by project, and look for errors/anomalies in the data.

You will write an application that will read CSV data (provided in the repo) of employee names and roles, projects, and time worked. The application should provide an analysis of when projects were started and finished and how many days it took plus hours worked, an analysis of how busy employees were on projects, and determine invalid days/times that an employee claimed to have worked on a project.


## CSV Data

### employees.csv

This file contains employee ID numbers, employee name, role, date hired, and date terminated

### projects.csv

This file contains project ID numbers, project name, date started and date ended

### timesheets.csv

This file contains employee IDs, project IDs, date worked, and number of minutes the employee spent working on that project on that day

---

## Iteration 0: Using the Date Handler module provided

You are given a `DateHandler` module that you will need to be comfortable using. You will not need to use this module as a mix-in, so you will not need to `include` it in any new code you write. This module was built to show you a practical example of how to use a class within a module as well as calling other static module methods.

The module will already support the following interactions:

```ruby
require 'date'
require './modules/date_handler_module'

my_date = Date.new(2018, 2, 28) # February 28, 2018
# => #<Date: 2018-02-28 ((2458178j,0s,0n),+0s,2299161j)>
dh = DateHandler::DHDate(my_date)
# => #<DateHandler::DHDate:0x00007f941a09d840 @date=#<Date: 2018-02-28 ((2458178j,0s,0n),+0s,2299161j)>>

start_date = Date.new(2018, 1, 1) # January 1, 2018
=> #<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>
end_date = Date.new(2018, 3, 31) # March 31, 2018
=> #<Date: 2018-03-31 ((2458209j,0s,0n),+0s,2299161j)>

dh.date_between(start_date, end_date)
=> true
```

The DateHandler module also has some static module methods you can call directly without needing to instantiate the `DHDate` class first.

```ruby
start_date = Date.new(2018, 1, 1) # January 1, 2018
end_date = Date.new(2018, 3, 31) # March 31, 2018
DateHandler.days_between(start_date, end_date)
=> 89

minutes_worked = 234
DateHandler.minutes_conversion(minutes_worked)
=> { hours: 3, minutes: 54 }

date_string = '2018-01-13'
DateHandler.string_to_date(date_string)
=> #<Date: 2018-01-13 ((2458132j,0s,0n),+0s,2299161j)>
```

---

## Iteration 1: Employees, Projects, and Timesheets

Our application will need to process employee, project, and timesheet objects. (you'll read these from a file soon)

We'll follow this interaction patterns to build objects and test their attributes:

```ruby
require './lib/employee'

employee_id = '5'
name = 'Sally Jackson'
role = 'Engineer'
start_date = '2015-01-01'
end_date = '2018-01-01'
employee = Employee.new(employee_id, name, role, start_date, end_date)
=> #<Employee...>

# make sure to convert all ID values to integers
employee.id.class
=> Integer
employee.name
=> "Sally Jackson"
employee.role
=> "Engineer"
employee.start_date
=> #<Date: 2015-01-01 ((2457024j,0s,0n),+0s,2299161j)>
employee.end_date
=> #<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>
```

And for projects:
```ruby
require './lib/project'
project_id = '123'
name = 'Widget Maker'
start_date = '2015-01-01'
end_date = '2018-01-01'
project = Project.new('123', 'Widget Maker', '2015-01-01', '2018-01-01')
=> #<Project...>

# make sure to convert all ID values to integers
project.id.class
=> Integer
project.name
=> "Widget Maker"
project.start_date
=> #<Date: 2015-01-01 ((2457024j,0s,0n),+0s,2299161j)>
project.end_date
=> #<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>
```

And for timesheets:

```ruby
require './lib/timesheet'

employee_id = '5'
project_id = '7'
date = '2015-01-01'
minutes = '120'
timesheet = Timesheet.new(employee_id, project_id, date, minutes)
=> #<Timesheet...>

# make sure to convert all ID values to integers
timesheet.employee_id.class
=> Integer
timesheet.project_id.class
=> Integer
timesheet.date
=> #<Date: 2015-01-01 ((2457024j,0s,0n),+0s,2299161j)>
timesheet.minutes.class
=> Integer
```

---

### Iteration 2: Building a Company

From this point on you will only be given general descriptions of what methods should do. The implementation is up to you, as long as you return data as expected.


```ruby
company = Company.new
=> #<Company...>
company.employees
[]
company.projects
[]
company.timesheets
[]
```

#### company.load_employees(filename)

- Parameters: String
- Returns: Hash

Read all data from `filename` in CSV format. Only add its contents to `company.employees` if ALL data in the file is valid. If any data is invalid, you should immediately return an error INSTEAD of saving the data. A test file for bad employee data has been provided.

This method should return a hash. A `success` key in the hash will contain a boolean letting us know if the whole file imported correctly or not. An `error` key, if `success` is false, will tell us why the import failed.

Return value examples:
```
{success: true, error: nil}
{success: false, error: 'bad data'}
```

#### company.load_projects(filename)

- Parameters: String
- Returns: Hash

Read all data from `filename` in CSV format. Only add its contents to `company.projects` if ALL data in the file is valid. If any data is invalid, you should immediately return an error INSTEAD of saving the data. A test file for bad project data has been provided.

This method should return a hash. A `success` key in the hash will contain a boolean letting us know if the whole file imported correctly or not. An `error` key, if `success` is false, will tell us why the import failed.


Return value examples:
```
{success: true, error: nil}
{success: false, error: 'bad data'}
```

#### company.load_timesheets(filename)

- Parameters: String
- Returns: Hash

Read all data from `filename` in CSV format. Only add its contents to `company.timesheets` if ALL data in the file is valid. If any data is invalid, you should immediately return an error INSTEAD of saving the data. A test file for bad timesheet data has been provided.

This method should return a hash. A `success` key in the hash will contain a boolean letting us know if the whole file imported correctly or not. An `error` key, if `success` is false, will tell us why the import failed.


Return value examples:
```
{success: true, error: nil}
{success: false, error: 'bad data'}
```

---

### Iteration 3: Searching our Data

Now that we have data loaded, let's be sure that we can do some searches. The implementation is up to you, as long as you return data as expected.


#### company.find_employee_by_id(employee_id)

- Parameters: Integer
- Returns: Employee object, or nil

This method should return a matching `Employee` object for the `employee_id` passed to the method. Return a `nil` if there is no match.


#### company.find_project_by_id(project_id)

- Parameters: Integer
- Returns: Project object, or nil

This method should return a matching `Project` object for the `project_id` passed to the method. Return a `nil` if there is no match.


---

## Iteration 4: Auditing the Company

To begin auditing the company, we will need to set up a `Company` object and add our CSV data. The final implementation is up to you, as long as you return data as expected.

```ruby
audit = Audit.new
=> #<Audit...>
company = Company.new
=> #<Company...>
company.load_employees('./data/employees.csv')
=> {:success=>true, :error=>nil}
company.load_projects('./data/projects.csv')
=> {:success=>true, :error=>nil}
company.load_timesheets('./data/timesheets.csv')
=> {:success=>true, :error=>nil}
```

#### audit.load_company(company)

- Parameters: Company object
- Returns: Company object

This method will give all other `audit` methods access to the company's details. Since there are no audit methods which allow you to re-load company details, you will need to load all CSV data into the company before you call this method.


#### audit.were_invalid_days_worked

- Parameters: None
- Returns: String

This method will analyze all timesheets to determine if they are valid. You ARE ALLOWED to extract functionality into helper methods provided they are completely unit tested AND that you have an integration test for this method.

Reasons a timesheet could be declared invalid:

- an employee_id is not valid
- a project_id is not valid
- an employee is attempting to bill time before or after the project start/end dates
- an employee was working on a weekend; we value our work-life balance, employees are not allowed to work weekends

The exact format of the report will look like this:

```
Invalid Days Worked:
John Smith worked on Widgets on 2016-02-20, it was a weekend
```

Use existing `company` methods to look up employee names and project names.

If no invalid timesheets are found, your output should look like this instead:

```
Invalid Days Worked:
None
```

---

## Extensions

Extensions are not required to pass the project, and should NOT be implemented until all previous requirements of the project are fully met.

1. Build `audit.project_report`

- Parameters: None
- Returns: String

This method will analyze all projects and generate a report of how long each project was worked on (examples given below). You ARE ALLOWED to extract functionality into helper methods provided they are completely unit tested AND that you have an integration test for this method.

The report output should NOT include invalid timesheet data.

Output expectation:

```
Project Audit:

Widgets
---
Duration: 181 days (2016-01-01 through 2016-06-30)
Hours worked (rounded):
Manager: 8 hours
Engineer: 24 hours

More Widgets
---
Duration: 232 days (2016-12-01 through 2017-07-21)
Hours worked (rounded):
Manager: 4 hours
Engineer: 32 hours

```

2. List all projects worked on in a date range, possibly using notation like "1H2017" for "first half of 2017" or "Q42016" for the Q4 months of 2016, and so on.

3. List all employees who worked in a given date range. For example, your method would be given a start and end date and determine which employees were employed at the company during that time.

---

---

# Evaluation Rubric

The project will be assessed with the following guidelines:

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 1. Ruby Syntax & Style

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

- [ ] Applies appropriate attribute encapsulation
- [ ] Developer creates instance and local variables appropriately
- [ ] Idiomatic naming conventions followed
- [ ] Ruby methods used are logical and readable
- [ ] Developer implements best-choice enumerable methods
- [ ] Code is indented properly
- [ ] Code does not exceed 80 characters per line


### 2. Breaking Logic into Components

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

- [ ] Code is effectively broken into methods & classes
- [ ] Developer has no more than 2 methods over 10 lines
- [ ] No methods break the principle of SRP


### 3. Test-Driven Development

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

- [ ] Each method is unit tested
- [ ] Functionality is accurately covered
- [ ] Tests implement Ruby syntax & style
- [ ] Balances unit and integration tests
- [ ] Evidence of edge case testing


### 4. Version Control

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

- [ ] Developer created a branch for each iteration
- [ ] Developer commits at a pace of at least 3 commits per hour


### 5. Completed Functionality

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

- [ ] Iteration 1 complete
- [ ] Iteration 2 complete
- [ ] Iteration 3 complete
- [ ] Iteration 4 complete
- [ ] One or more Extensions complete