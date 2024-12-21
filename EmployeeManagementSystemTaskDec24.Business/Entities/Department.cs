namespace EmployeeManagementSystemTaskDec24.Business.Entities
{
    public class Department
    {
        public int DepartmentID { get; set; }
        public string DepartmentName { get; set; }
        public int ManagerId { get; set; }
        public string ManagerName { get; set; }
        public decimal Budget { get; set; }
        public decimal avgscore { get; set; }
    }
}
