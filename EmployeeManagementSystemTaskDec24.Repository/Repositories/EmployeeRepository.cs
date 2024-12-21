using Dapper;
using EmployeeManagementSystemTaskDec24.Business.Entities;
using EmployeeManagementSystemTaskDec24.Repository.Interfaces;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace EmployeeManagementSystemTaskDec24.Repository.Repositories
{
    public class EmployeeRepository : IEmployeeRepository
    {
        private readonly string _connectionString;

        public EmployeeRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<IEnumerable<Employee>> GetAllEmployees(int page, int pageSize)
        {
            List<Employee> employees = new List<Employee>();

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                using (var command = new SqlCommand("GetAllEmployees", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    command.Parameters.AddWithValue("@Page", page);
                    command.Parameters.AddWithValue("@PageSize", pageSize);

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            var employee = new Employee
                            {
                                Id = reader.GetInt32(reader.GetOrdinal("EmployeeId")),
                                Name = reader.GetString(reader.GetOrdinal("Name")),
                                Phone = reader.GetString(reader.GetOrdinal("Phone")),
                                DepartmentName = reader.GetString(reader.GetOrdinal("DepartmentName")),
                                DepartmentId = reader.GetInt32(reader.GetOrdinal("DepartmentID")),
                                Email = reader.GetString(reader.GetOrdinal("Email")),
                                Position = reader.GetString(reader.GetOrdinal("Position")),
                                JoiningDate =  reader.GetDateTime(reader.GetOrdinal("JoiningDate"))

                                // Map other columns as needed
                            };
                            employees.Add(employee);
                        }
                    }
                }
            }

            return employees;
        }


        public Employee GetEmployeeById(int id)
        {
            Employee employee = null;

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("GetEmployeeById", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@Id", id);

                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        employee = new Employee
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("EmployeeId")),
                            Name = reader.GetString(reader.GetOrdinal("Name")),
                            Phone = reader.GetString(reader.GetOrdinal("Phone")),
                            DepartmentName = reader.GetString(reader.GetOrdinal("DepartmentName")),
                            Email = reader.GetString(reader.GetOrdinal("Email")),
                            Position = reader.GetString(reader.GetOrdinal("Position")),
                            JoiningDate = reader.GetDateTime(reader.GetOrdinal("JoiningDate"))

                        };
                    }
                }
            }

            return employee;
        }

            public async Task<IEnumerable<Employee>> GetEmployeeByDepartmentId(int id)
            {
                List<Employee> employees = new List<Employee>();

                using (var connection = new SqlConnection(_connectionString))
                {
                    await connection.OpenAsync();

                    using (var command = new SqlCommand("GetEmployeeByDept", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@Id", id);

                    using (var reader = await command.ExecuteReaderAsync())
                        {
                            while (await reader.ReadAsync())
                            {
                                var employee = new Employee
                                {
                                    Id = reader.GetInt32(reader.GetOrdinal("EmployeeId")),
                                    Name = reader.GetString(reader.GetOrdinal("Name")),
                                    Phone = reader.GetString(reader.GetOrdinal("Phone")),
                                    DepartmentName = reader.GetString(reader.GetOrdinal("DepartmentName")),
                                    DepartmentId = reader.GetInt32(reader.GetOrdinal("DepartmentID")),
                                    Email = reader.GetString(reader.GetOrdinal("Email")),
                                    Position = reader.GetString(reader.GetOrdinal("Position")),
                                    JoiningDate = reader.GetDateTime(reader.GetOrdinal("JoiningDate"))

                                    // Map other columns as needed
                                };
                                employees.Add(employee);
                            }
                        }
                    }
                }

                return employees;
            }

            public string AddEmployee(AddEmployee employee)
        {
            string message = "";
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("AddEmployee", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@Name", employee.Name);
                cmd.Parameters.AddWithValue("@Email", employee.Email);
                cmd.Parameters.AddWithValue("@Phone", employee.Phone);
                cmd.Parameters.AddWithValue("@Department", employee.DepartmentId);
                cmd.Parameters.AddWithValue("@Position", employee.Position);
                cmd.Parameters.AddWithValue("@JoiningDate", employee.JoiningDate);
                cmd.Parameters.AddWithValue("@Status", employee.Status);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        message = reader["Message"].ToString();
                    }
                    else
                    {
                        message = "No message returned from the database.";
                    }
                }
            }

            return message;
        }

        public string UpdateEmployee(Employee employee)
        {
            string message = "";
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("UpdateEmployee", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@Id", employee.Id);
                cmd.Parameters.AddWithValue("@Name", employee.Name);
                cmd.Parameters.AddWithValue("@Email", employee.Email);
                cmd.Parameters.AddWithValue("@Phone", employee.Phone);
                cmd.Parameters.AddWithValue("@Department", employee.DepartmentId);
                cmd.Parameters.AddWithValue("@Position", employee.Position);
                cmd.Parameters.AddWithValue("@JoiningDate", employee.JoiningDate);
                cmd.Parameters.AddWithValue("@Status", employee.Status);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        message = reader["Message"].ToString();
                    }
                    else
                    {
                        message = "No message returned from the database.";
                    }
                }
            }

            return message;
        }

        public string DeleteEmployee(int id)
        {
            string message = "";
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("DeleteEmployee", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@Id", id);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        message = reader["Message"].ToString();
                    }
                    else
                    {
                        message = "No message returned from the database.";
                    }
                }
            }

            return message;
        }

        public async Task<IEnumerable<Employee>> SearchEmployees( string? searchQuery,int? departmentId,string? position,int page, int pageSize)
                    {
                        using (SqlConnection conn = new SqlConnection(_connectionString))
                        {
                            conn.Open();

                            var employees = await conn.QueryAsync<Employee>("SearchEmployees",
                                new
                                {
                                    SearchQuery = searchQuery,
                                    DepartmentID = departmentId,
                                    Position = position,
                                    Page = page,
                                    PageSize = pageSize
                                },
                                commandType: CommandType.StoredProcedure
                            );

                            return employees;
                        }
                    }

    }
}
