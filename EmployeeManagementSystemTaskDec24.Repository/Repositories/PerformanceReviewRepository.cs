using EmployeeManagementSystemTaskDec24.Business.Entities;
using EmployeeManagementSystemTaskDec24.Repository.Interfaces;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace EmployeeManagementSystemTaskDec24.Repository.Repositories
{
    public class PerformanceReviewRepository : IPerformanceReviewRepository
    {
        private readonly string _connectionString;

        public PerformanceReviewRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        //public Task<IEnumerable<PerformanceReview>> GetAllPerformanceReviews()
        //{
        //    var reviews = new List<PerformanceReview>();

        //    using (SqlConnection conn = new SqlConnection(_connectionString))
        //    {
        //        conn.Open();
        //        SqlCommand cmd = new SqlCommand("GetReviewsByEmployeeId", conn)
        //        {
        //            CommandType = CommandType.StoredProcedure
        //        };
        //        //cmd.Parameters.AddWithValue("@EmployeeId", employeeId);

        //        using (var reader = cmd.ExecuteReader())
        //        {
        //            while (reader.Read())
        //            {
        //                reviews.Add(new PerformanceReview
        //                {
        //                    Id = (int)reader["Id"],
        //                    EmployeeId = (int)reader["EmployeeId"],
        //                    ReviewDate = (DateTime)reader["ReviewDate"],
        //                    Score = (int)reader["Score"],
        //                    Notes = reader["Notes"].ToString()
        //                });
        //            }
        //        }
        //    }

        //    return reviews;
        //}
        public async Task<PerformanceReview> GetPerformanceReviewById(int id)
        {
            PerformanceReview review = null; // Change from List<PerformanceReview> to a single object

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();
                SqlCommand cmd = new SqlCommand("GetReviewsByEmployeeId", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@EmployeeId", id);

                using (var reader = await cmd.ExecuteReaderAsync()) // Await the async version of ExecuteReader
                {
                    if (await reader.ReadAsync()) // Use async version of Read
                    {
                        review = new PerformanceReview
                        {
                            Id = (int)reader["Id"],
                            EmployeeId = (int)reader["EmployeeId"],
                            ReviewDate = (DateTime)reader["ReviewDate"],
                            Score = (int)reader["Score"],
                            Notes = reader["Notes"].ToString()
                        };
                    }
                }
            }

            return review; // Return a single review (or null if no record is found)
        }


        public Task AddPerformanceReview(PerformanceReview review)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("AddPerformanceReview", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@EmployeeId", review.EmployeeId);
                cmd.Parameters.AddWithValue("@ReviewDate", review.ReviewDate);
                cmd.Parameters.AddWithValue("@Score", review.Score);
                cmd.Parameters.AddWithValue("@Notes", review.Notes);

                cmd.ExecuteNonQuery();
            }
            return Task.CompletedTask;
        }
    }
}
