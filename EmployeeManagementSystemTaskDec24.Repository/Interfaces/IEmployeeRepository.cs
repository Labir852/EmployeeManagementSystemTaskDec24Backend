using EmployeeManagementSystemTaskDec24.Business.Entities;
using System.Collections.Generic;

namespace EmployeeManagementSystemTaskDec24.Repository.Interfaces
{
    public interface IEmployeeRepository
    {
        Task<IEnumerable<Employee>> GetAllEmployees(int page, int pageIndex);
        Employee GetEmployeeById(int id);
        string AddEmployee(Employee employee);
        string UpdateEmployee(Employee employee);
        string DeleteEmployee(int id);
    }
}
