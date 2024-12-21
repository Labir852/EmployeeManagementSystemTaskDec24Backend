using EmployeeManagementSystemTaskDec24.Business.Entities;
using System.Collections.Generic;

namespace EmployeeManagementSystemTaskDec24.Repository.Interfaces
{
    public interface IPerformanceReviewRepository
    {
        Task<IEnumerable<PerformanceReview>> GetAllPerformanceReviews();
        Task<PerformanceReview> GetPerformanceReviewById(int id);
        string AddPerformanceReview(PerformanceReview review);
        //Task UpdatePerformanceReview(PerformanceReview review);
        //Task DeletePerformanceReview(int id);

    }
}
