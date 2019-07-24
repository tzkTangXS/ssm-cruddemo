package tzk.controller;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tzk.been.Msg;
import tzk.service.IDepartmentService;

import java.util.List;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-23   下午11:21
 */
@Controller
@RequestMapping("/department")
public class DepartmentController {
    @Autowired
    IDepartmentService departmentService;

    @Autowired
    Msg msg;
    /**
    * 用于给用户界面的添加和修改功能传递消息。实现下拉列表。
    * */
    @RequestMapping("/getAll")
    @ResponseBody
    public Msg getAll(){
        List list = departmentService.getAll();
    return msg.success().add("departments",list);
    }

}
