using EmployeeManagementSystemTaskDec24.Business.Entities;
using System.Collections.Generic;

namespace EmployeeManagementSystemTaskDec24.Repository.Interfaces
{
    public interface IEmployeeRepository
    {
        Task<IEnumerable<Employee>> GetAllEmployees(int page, int pageIndex);
        Employee GetEmployeeById(int id);
        void AddEmployee(Employee employee);
        void UpdateEmployee(Employee employee);
        void DeleteEmployee(int id);
    }
}
