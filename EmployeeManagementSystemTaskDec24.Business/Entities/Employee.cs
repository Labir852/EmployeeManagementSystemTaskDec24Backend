namespace EmployeeManagementSystemTaskDec24.Business.Entities
{
    public class Employee
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string DepartmentName { get; set; }
        public int DepartmentId { get; set; }
        public string Position { get; set; }
        public DateTime JoiningDate { get; set; }
        public string Status { get; set; }
        public string Deleted { get; set; }
    }
}
