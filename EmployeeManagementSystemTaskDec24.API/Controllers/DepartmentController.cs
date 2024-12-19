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
        public IActionResult AddDepartment(Department department)
        {
            _departmentRepository.AddDepartment(department);
            return CreatedAtAction(nameof(GetDepartmentById), new { id = department.Id }, department);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateDepartment(int id, Department department)
        {
            if (id != department.Id)
                return BadRequest("Department ID mismatch.");

            var existingDepartment = _departmentRepository.GetDepartmentById(id);
            if (existingDepartment == null)
                return NotFound();

            _departmentRepository.UpdateDepartment(department);
            return NoContent();
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
