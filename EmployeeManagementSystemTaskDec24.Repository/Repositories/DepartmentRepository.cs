using EmployeeManagementSystemTaskDec24.Business.Entities;
using EmployeeManagementSystemTaskDec24.Repository.Interfaces;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace EmployeeManagementSystemTaskDec24.Repository.Repositories
{
    public class DepartmentRepository : IDepartmentRepository
    {
        private readonly string _connectionString;

        public DepartmentRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public IEnumerable<Department> GetAllDepartments()
        {
            var departments = new List<Department>();

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("GetAllDepartments", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        departments.Add(new Department
                        {
                            DepartmentID = reader.GetInt32(reader.GetOrdinal("DepartmentID")),
                            DepartmentName = reader.GetString(reader.GetOrdinal("DepartmentName")),
                            ManagerId = reader.GetInt32(reader.GetOrdinal("ManagerId")),
                            ManagerName = reader.GetString(reader.GetOrdinal("ManagerName")),
                            Budget = reader.GetDecimal(reader.GetOrdinal("Budget")),
                            avgscore = reader.GetDecimal(reader.GetOrdinal("avgscore"))
                        });
                    }
                }
            }

            return departments;
        }

        public Department GetDepartmentById(int id)
        {
            Department department = null;

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("GetDepartmentById", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@Id", id);

                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        department = new Department
                        {
                            DepartmentID = reader.GetInt32(reader.GetOrdinal("DepartmentID")),
                            DepartmentName = reader.GetString(reader.GetOrdinal("DepartmentName")),
                            ManagerId = reader.GetInt32(reader.GetOrdinal("ManagerId")),
                            ManagerName = reader.GetString(reader.GetOrdinal("ManagerName")),
                            Budget = reader.GetDecimal(reader.GetOrdinal("Budget")),
                        };
                    }
                }
            }

            return department;
        }

        public string AddDepartment(Department department)
        {
            string message = "";
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("AddDepartment", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@DepartmentName", department.DepartmentName);
                cmd.Parameters.AddWithValue("@Budget", department.Budget);

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

        public string UpdateDepartment(Department department)
        {
            string message = "";
            
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("AddManager", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@DepartmentID", department.DepartmentID);
                cmd.Parameters.AddWithValue("@ManagerId", department.ManagerId);

                cmd.ExecuteNonQuery();
            }
            return message;
        }
    }
}
