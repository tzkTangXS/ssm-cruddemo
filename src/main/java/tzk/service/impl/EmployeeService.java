package tzk.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tzk.been.Employee;
import tzk.dao.EmployeeMapper;
import tzk.service.IEmployeeService;

import java.util.List;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-22   下午7:46
 */
@Service
public class EmployeeService implements IEmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectWithDepartmentByExample(null);
    }

    @Override
    public void deletebyId(int id) {

    }

    @Override
    public void updata() {

    }

    @Override
    public void add(Employee employee) {
    employeeMapper.insertSelective(employee);
    }
}
