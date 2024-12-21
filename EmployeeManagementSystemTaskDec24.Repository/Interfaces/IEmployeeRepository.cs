using EmployeeManagementSystemTaskDec24.Business.Entities;
using System.Collections.Generic;

namespace EmployeeManagementSystemTaskDec24.Repository.Interfaces
{
    public interface IEmployeeRepository
    {
        Task<IEnumerable<Employee>> GetAllEmployees(int page, int pageIndex);
        Employee GetEmployeeById(int id);
        Task<IEnumerable<Employee>> GetEmployeeByDepartmentId(int id);
        string AddEmployee(AddEmployee employee);
        string UpdateEmployee(Employee employee);
        string DeleteEmployee(int id);
        Task<IEnumerable<Employee>> SearchEmployees(string? searchQuery, int? departmentId, string? position, int page, int pageSize);
    }
}
