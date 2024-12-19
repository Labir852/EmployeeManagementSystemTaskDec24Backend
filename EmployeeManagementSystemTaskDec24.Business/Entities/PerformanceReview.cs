namespace EmployeeManagementSystemTaskDec24.Business.Entities
{
    public class PerformanceReview
    {
        public int Id { get; set; }
        public int EmployeeId { get; set; }
        public DateTime ReviewDate { get; set; }
        public int Score { get; set; }
        public string Notes { get; set; }
    }
}
