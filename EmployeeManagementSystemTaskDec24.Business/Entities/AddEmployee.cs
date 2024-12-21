using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmployeeManagementSystemTaskDec24.Business.Entities
{
    public class AddEmployee
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public int DepartmentId { get; set; }
        public string Position { get; set; }
        public DateTime JoiningDate { get; set; }
        public string Status { get; set; }
    }
}
