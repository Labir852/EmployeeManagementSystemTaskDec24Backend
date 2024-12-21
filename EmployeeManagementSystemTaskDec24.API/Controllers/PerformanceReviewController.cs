using EmployeeManagementSystemTaskDec24.Business.Entities;
using EmployeeManagementSystemTaskDec24.Repository.Interfaces;
using EmployeeManagementSystemTaskDec24.Repository.Repositories;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class PerformanceReviewController : ControllerBase
{
    private readonly IPerformanceReviewRepository _repository;

    public PerformanceReviewController(IPerformanceReviewRepository repository)
    {
        _repository = repository;
    }

    [HttpGet]
    public async Task<IActionResult> GetAllPerformanceReviews()
    {
        var reviews = await _repository.GetAllPerformanceReviews();
        return Ok(reviews);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetPerformanceReviewById(int id)
    {
        var review = await _repository.GetPerformanceReviewById(id);
        if (review == null)
            return NotFound();

        return Ok(review);
    }

    [HttpPost]
    public IActionResult AddPerformanceReview(PerformanceReview review)
    {
        var response = _repository.AddPerformanceReview(review);
        return Ok(response);
    }

    //[HttpPut]
    //public async Task<IActionResult> UpdatePerformanceReview([FromBody] PerformanceReview review)
    //{
    //    await _repository.UpdatePerformanceReview(review);
    //    return NoContent();
    //}

    //[HttpDelete("{id}")]
    //public async Task<IActionResult> DeletePerformanceReview(int id)
    //{
    //    await _repository.DeletePerformanceReview(id);
    //    return NoContent();
    //}
}
