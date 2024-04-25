class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def determine_annual_income(employee)
		doj = employee.doj
		current_date = Date.today
		months_worked = (current_date.year - doj.year) * 12 + current_date.month - doj.month
		months_worked -= 1 if current_date.day < doj.day # Deduct a month if the DOJ is in the future for the current month
		months_worked = 0 if months_worked < 0 # Handle cases where DOJ is in the future
		total_salary = employee.salary * months_worked
		total_salary
	end

	def calculate_loss_of_pay_per_day(salary)
		loss_of_pay_per_day = salary / 30.0
		loss_of_pay_per_day
	end

  def evaluate_tax_rate(yearly_salary)
    case yearly_salary
    when 0..250000
      0
    when 250001..500000
      (yearly_salary - 250000) * 0.05
    when 500001..1000000
      12500 + (yearly_salary - 500000) * 0.1
    else
      62500 + (yearly_salary - 1000000) * 0.2
    end
  end

  def cess_amount(yearly_salary)
		excess_amount = yearly_salary - 2500000
		if excess_amount > 0
			cess_amount = excess_amount * 0.02
		else
			cess_amount = 0
		end
		cess_amount
	end
  
end
