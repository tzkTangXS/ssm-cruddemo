package tzk.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tzk.been.Employee;
import tzk.been.example.EmployeeExample;
import tzk.been.example.EmployeeExample.Criteria;
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
  /*  @Autowired
    EmployeeExample employeeExample;*/
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

    @Override
    public boolean isHasEmail(String email) {
        System.out.println(email);
        /**
         * 这里必须要手动new一个EmployeeExample对象。
         * 如果使用@Autowride注入，那么所指向的都是同意个对象。
         * 也就是说，employeeMapper.countByExample(employeeExample)的值永远不变
         * */
        EmployeeExample employeeExample = new EmployeeExample();
      Criteria criteria = employeeExample.createCriteria();
      criteria.andEmailEqualTo(email);
     long count = employeeMapper.countByExample(employeeExample);
        System.out.println("count = " + count);
        return count==0;
    }
}
