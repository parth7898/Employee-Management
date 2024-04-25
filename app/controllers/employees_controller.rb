class EmployeesController < ApplicationController

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: { status: 'Employee created successfully' }, status: :created
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def tax_deduction
    employees = Employee.all
    tax_deductions = employees.map do |employee|
      yearly_salary = determine_annual_income(employee)
      tax_amount = evaluate_tax_rate(yearly_salary)
      cess_amount = cess_amount(yearly_salary)
      total_tax = tax_amount + cess_amount
      {
        employee_id: employee.employee_id,
        first_name: employee.first_name,
        last_name: employee.last_name,
        yearly_salary: yearly_salary,
        tax_amount: tax_amount,
        cess_amount: cess_amount,
        total_tax: total_tax
      }
    end
    render json: { tax_deductions: tax_deductions }, status: :ok
  end

  private

  def employee_params
    params.require(:employee).permit(:employee_id, :first_name, :last_name, :email, :phone_numbers, :doj, :salary)
  end

end
