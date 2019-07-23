package tzk.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tzk.been.Department;
import tzk.dao.DepartmentMapper;
import tzk.service.IDepartmentService;

import javax.persistence.Id;
import java.util.List;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-22   下午7:45
 */
@Service
public class DepartmentService implements IDepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    @Override
    public List<Department> getAll() {
        return departmentMapper.selectByExample(null);
    }

    @Override
    public void deletebyId(int id) {

    }

    @Override
    public void updata() {

    }

    @Override
    public void add(Department department) {

    }
}
