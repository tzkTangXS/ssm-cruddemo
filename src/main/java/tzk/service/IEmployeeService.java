package tzk.service;

import tzk.been.Employee;

import java.util.List;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-22   下午7:45
 */
public interface IEmployeeService {
   List<Employee> getAll();
   void deletebyId(int id);
   void updata();
   void add(Employee employee);
}
