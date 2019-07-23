package tzk.service;

import tzk.been.Department;


import java.util.List;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-22   下午7:44
 */
public interface IDepartmentService {
    List<Department> getAll();
    void deletebyId(int id);
    void updata();
    void add(Department department);
}
