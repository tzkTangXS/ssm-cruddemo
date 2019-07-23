package tzk;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import tzk.been.Department;
import tzk.been.Employee;
import tzk.dao.DepartmentMapper;
import tzk.dao.EmployeeMapper;

import javax.ws.rs.core.Context;
import java.util.UUID;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-22   下午2:36
 * 使用spring的单元测试,用spring-test包
 */
/*指定junit单元测试模块,所有@Test标签都是由其运行.现在用的是spring的junit单元测试模块.*/
@RunWith(SpringJUnit4ClassRunner.class)
/*指定spring配置文件位置,自动创建springIOC容器*/
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    /**
     *DepartmentMapper
     */
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testDepartmentCRUD(){
        /*先运行一遍看能不能输出,成功了,再进一步测试*/
        System.out.println("departmentMapper = " + departmentMapper);
        /*******************************CRUD测试***********************/
        /*插入部门*/
       /* Department department = new Department(null,"java开发部");
        departmentMapper.insertSelective(department);
        department.setDeptName("c语言开发部");
        departmentMapper.insertSelective(department);*/
        /*删除*/
        departmentMapper.deleteByPrimaryKey(4);
    }
    @Test
    public void testEmployeeCRUD(){
        System.out.println("employeeMapper = " + employeeMapper);
        /***********************CRUD**************************/
//        Employee employee = new Employee(1,"天河","F","@wreqqw",3);
        /*更新*/
//        employeeMapper.updateByPrimaryKeySelective(employee);
        /*批量插入*/
        EmployeeMapper employeeMapper1 = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 66; i++) {
//            String uuname = UUID.randomUUID().toString()+i;
//            employeeMapper1.insertSelective(new Employee(uuname,"F","@tzk.com",null));
                employeeMapper1.updateByPrimaryKey(new Employee(i,"大河","f","@com",2));
        }
    }
}
