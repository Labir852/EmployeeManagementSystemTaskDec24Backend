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
                            Id = (int)reader["Id"],
                            Name = reader["Name"].ToString(),
                            ManagerId = (int)reader["ManagerId"],
                            Budget = (decimal)reader["Budget"]
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
                            Id = (int)reader["Id"],
                            Name = reader["Name"].ToString(),
                            ManagerId = (int)reader["ManagerId"],
                            Budget = (decimal)reader["Budget"]
                        };
                    }
                }
            }

            return department;
        }

        public void AddDepartment(Department department)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("AddDepartment", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@Name", department.Name);
                cmd.Parameters.AddWithValue("@ManagerId", department.ManagerId);
                cmd.Parameters.AddWithValue("@Budget", department.Budget);

                cmd.ExecuteNonQuery();
            }
        }

        public void UpdateDepartment(Department department)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("UpdateDepartment", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@Id", department.Id);
                cmd.Parameters.AddWithValue("@Name", department.Name);
                cmd.Parameters.AddWithValue("@ManagerId", department.ManagerId);
                cmd.Parameters.AddWithValue("@Budget", department.Budget);

                cmd.ExecuteNonQuery();
            }
        }
    }
}
