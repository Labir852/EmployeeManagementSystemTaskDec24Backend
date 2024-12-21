using EmployeeManagementSystemTaskDec24.Repository.Interfaces;
using EmployeeManagementSystemTaskDec24.Business.Entities;
using Microsoft.AspNetCore.Mvc;

namespace EmployeeManagementSystemTaskDec24.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DepartmentController : ControllerBase
    {
        private readonly IDepartmentRepository _departmentRepository;

        public DepartmentController(IDepartmentRepository departmentRepository)
        {
            _departmentRepository = departmentRepository;
        }

        [HttpGet]
        public IActionResult GetAllDepartments()
        {
            var departments = _departmentRepository.GetAllDepartments();
            return Ok(departments);
        }

        [HttpGet("{id}")]
        public IActionResult GetDepartmentById(int id)
        {
            var department = _departmentRepository.GetDepartmentById(id);
            if (department == null)
                return NotFound();

            return Ok(department);
        }

        [HttpPost]
        public  IActionResult AddDepartment(Department department)
        {
           var response =  _departmentRepository.AddDepartment(department);
            return Ok(response);
        }

        [HttpPut("addManager/{id}")]
        public IActionResult UpdateDepartment(int id, Department department)
        {
            if (id != department.DepartmentID)
                return BadRequest("Department ID mismatch.");


            var response = _departmentRepository.UpdateDepartment(department);
            return Ok(response);
        }

        //[HttpDelete("{id}")]
        //public IActionResult DeleteDepartment(int id)
        //{
        //    var department = _departmentRepository.GetDepartmentById(id);
        //    if (department == null)
        //        return NotFound();

        //    _departmentRepository.DeleteDepartment(id);
        //    return NoContent();
        //}
    }
}
