﻿using EmployeeManagementSystemTaskDec24.Repository.Interfaces;
using EmployeeManagementSystemTaskDec24.Business.Entities;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Azure;

namespace EmployeeManagementSystemTaskDec24.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EmployeeController : ControllerBase
    {
        private readonly IEmployeeRepository _employeeRepository;

        public EmployeeController(IEmployeeRepository employeeRepository)
        {
            _employeeRepository = employeeRepository;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllEmployees([FromQuery] int page = 1, [FromQuery] int pageSize = 10)
        {
            var employees = await _employeeRepository.GetAllEmployees(page, pageSize);
            return Ok(employees);
        }

        [HttpGet("{id}")]
        public IActionResult GetEmployeeById(int id)
        {
            var employee = _employeeRepository.GetEmployeeById(id);
            if (employee == null)
                return NotFound();

            return Ok(employee);
        }

        [HttpPost]
        public IActionResult AddEmployee(Employee employee)
        {
            var response = _employeeRepository.AddEmployee(employee);
            return Ok(response);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateEmployee(int id, Employee employee)
        {
            if (id != employee.Id)
                return BadRequest("Employee ID mismatch.");

            var existingEmployee = _employeeRepository.GetEmployeeById(id);
            if (existingEmployee == null)
                return NotFound();

           var response =  _employeeRepository.UpdateEmployee(employee);
            return Ok(response);
        }

        [HttpPost("{id}")]
        public IActionResult DeleteEmployee(int id)
        {
            var employee = _employeeRepository.GetEmployeeById(id);
            if (employee == null)
                return NotFound();

           var response= _employeeRepository.DeleteEmployee(id);
            return Ok(response);
        }
    }
}
