namespace EmployeeManagementSystemTaskDec24.Business.Entities
{
    public class Department
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int ManagerId { get; set; }
        public decimal Budget { get; set; }
    }
}
