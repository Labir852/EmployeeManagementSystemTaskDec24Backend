using EmployeeManagementSystemTaskDec24.Business.Entities;
using System.Collections.Generic;

namespace EmployeeManagementSystemTaskDec24.Repository.Interfaces
{
    public interface IDepartmentRepository
    {
        IEnumerable<Department> GetAllDepartments();
        Department GetDepartmentById(int id);
        string AddDepartment(Department department);
        string UpdateDepartment(Department department);
    }
}
