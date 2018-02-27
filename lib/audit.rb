# frozen_string_literal: true

# Defines an auditor
class Audit
  def load_company(company)
    @company = company
  end

  def were_invalid_days_worked
    output = ['Invalid Days Worked:']
    @company.timesheets.each do |timesheet|
      employee = @company.find_employee_by_id timesheet.employee_id
      project = @company.find_project_by_id timesheet.project_id

      employee_check = invalid_employee?(employee, project, timesheet)
      unless employee_check == true
        output.push employee_check
        next
      end

      project_check = invalid_project?(employee, project, timesheet)
      unless project_check == true
        output.push project_check
        next
      end

      did_work_outside_dates = outside_dates?(employee, project, timesheet)
      unless did_work_outside_dates == true
        output.push did_work_outside_dates
        next
      end

      weekend_check = did_work_weekend?(employee, project, timesheet)
      output.push weekend_check unless weekend_check == true
    end
    output.push('None') if output.length == 1
    output.join("\n")
  end

  def invalid_employee?(employee, project, timesheet)
    unless employee
      return [
        "Unknown employee #{timesheet.employee_id} ",
        "worked on #{project.name} on #{timesheet.date}"
      ].join
    end
    true
  end

  def invalid_project?(employee, project, timesheet)
    unless project
      return [
        "#{employee.name} worked on unknown project ",
        "#{timesheet.project_id} on #{timesheet.date}"
      ].join
    end
    true
  end

  def outside_dates?(employee, project, timesheet)
    unless project.valid_date(timesheet.date)
      return [
        "#{employee.name} worked on #{project.name} ",
        "outside of project dates on #{timesheet.date}"
      ].join
    end
    true
  end

  def did_work_weekend?(employee, project, timesheet)
    unless timesheet.date.saturday? || timesheet.date.sunday?
      return [
        "#{employee.name} worked on #{project.name} ",
        "on #{timesheet.date}, it was a weekend"
      ].join
    end
    true
  end
end
