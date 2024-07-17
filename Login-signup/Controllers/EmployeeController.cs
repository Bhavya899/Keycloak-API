using Login_signup.Class;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Npgsql;
using System.Data;

namespace Login_signup.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeeController : ControllerBase
    {
        private readonly NpgsqlConnection _connection;

        public EmployeeController(NpgsqlConnection connection)
        {
            _connection = connection;
        }

        [HttpGet("displayEmployee")]
        public IActionResult GetAllEmployees()
        {
            var employeeList = new List<Employee>();

            try
            {

                    _connection.Open();

                    using (var command = new NpgsqlCommand("SELECT * FROM public.read_all_employees()", _connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                var employee = new Employee
                                {
                                    EmployeeId = reader.GetInt32(0),
                                    FirstName = reader.GetString(1),
                                    LastName = reader.GetString(2),
                                    Age = reader.GetInt32(3),
                                    Salary = reader.GetInt32(4)
                                };
                                employeeList.Add(employee);
                            }
                        }
                    }
                
            }
            catch (Exception ex)
            {
                // Log the exception (you can replace this with your logging framework)
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }

            return Ok(employeeList);
        }
        [HttpPost("addEmployee")]
        public IActionResult AddEmployee([FromBody] Employee employee)
        {
            try
            {
                  _connection.Open();

                    using (var command = new NpgsqlCommand("select public.add_employee(@p_first_name, @p_last_name, @p_age, @p_salary)", _connection))
                    {
                        command.Parameters.AddWithValue("p_first_name", employee.FirstName);
                        command.Parameters.AddWithValue("p_last_name", employee.LastName);
                        command.Parameters.AddWithValue("p_age", employee.Age);
                        command.Parameters.AddWithValue("p_salary", employee.Salary);

                        command.ExecuteNonQuery();
                    }
                
            }
            catch (Exception ex)
            {
                // Log the exception (you can replace this with your logging framework)
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }

            var response = new { status = "success", message = "added succusfully" };
            return Ok(JsonConvert.SerializeObject(response));
        }

        [HttpGet("getEmployee/{employeeId}")]
        public IActionResult GetEmployeeById(int employeeId)
        {
            try
            {
                _connection.Open();

                using (var command = new NpgsqlCommand("SELECT * FROM public.read_employee(@p_employee_id)", _connection))
                {
                    command.Parameters.AddWithValue("p_employee_id", employeeId);
                    command.CommandType = CommandType.Text;

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            var employee = new Employee
                            {
                                EmployeeId = Convert.ToInt32(reader["employee_id"]),
                                FirstName = reader["first_name"].ToString(),
                                LastName = reader["last_name"].ToString(),
                                Age = Convert.ToInt32(reader["age"]),
                                Salary = Convert.ToInt32(reader["salary"]),

                            };

                            return Ok(employee);
                        }
                        else
                        {
                            return NotFound("Employee not found");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception (you can replace this with your logging framework)
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }
        }



        [HttpDelete("deleteEmployee/{id}")]
        public IActionResult DeleteEmployee(int id)
        {
            try
            {

                _connection.Open();

                using (var command = new NpgsqlCommand("select public.delete_employee(@p_employee_id)", _connection))
                {
                    command.Parameters.AddWithValue("p_employee_id", id);
                    command.ExecuteNonQuery();
                }
            }

            catch (Exception ex)
            {
                // Log the exception (you can replace this with your logging framework)
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }

            var response = new { status = "success", message = "deleted succusfully" };
            return Ok(JsonConvert.SerializeObject(response));
        }
            [HttpPut("updateEmployee/{EmployeeId}")]
        public IActionResult UpdateEmployee(int EmployeeId,[FromBody] Employee employee)
        {
            try
            {
                
                    _connection.Open();

                    using (var command = new NpgsqlCommand("select public.update_employee(@p_employee_id, @p_first_name, @p_last_name, @p_age, @p_salary)", _connection))
                    {
                        command.Parameters.AddWithValue("p_employee_id",EmployeeId);
                        command.Parameters.AddWithValue("p_first_name", employee.FirstName);
                        command.Parameters.AddWithValue("p_last_name", employee.LastName);
                        command.Parameters.AddWithValue("p_age", employee.Age);
                        command.Parameters.AddWithValue("p_salary", employee.Salary);

                        command.ExecuteNonQuery();
                    }
                
            }
            catch (Exception ex)
            {
                // Log the exception (you can replace this with your logging framework)
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }
            var response = new { status = "success", message = "update succusfully" };
            return Ok(JsonConvert.SerializeObject(response));
        }
    }
}
