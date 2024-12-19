using EmployeeManagementSystemTaskDec24.Business.Entities;
using EmployeeManagementSystemTaskDec24.Repository.Interfaces;
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

    //[HttpGet]
    //public async Task<IActionResult> GetAllPerformanceReviews()
    //{
    //    var reviews = await _repository.GetAllPerformanceReviews();
    //    return Ok(reviews);
    //}

    [HttpGet("{id}")]
    public async Task<IActionResult> GetPerformanceReviewById(int id)
    {
        var review = await _repository.GetPerformanceReviewById(id);
        if (review == null)
            return NotFound();

        return Ok(review);
    }

    [HttpPost]
    public async Task<IActionResult> AddPerformanceReview([FromBody] PerformanceReview review)
    {
        await _repository.AddPerformanceReview(review);
        return CreatedAtAction(nameof(GetPerformanceReviewById), new { id = review.Id }, review);
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
