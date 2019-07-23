package tzk.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import tzk.been.Employee;
import tzk.been.Msg;
import tzk.service.IEmployeeService;

import java.util.ArrayList;
import java.util.List;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-22   下午8:21
 */
@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    IEmployeeService employeeService;
    @Autowired
    Msg msg;
    @RequestMapping("/getAll")
    public String getAll(Model model, @RequestParam(value = "pn",defaultValue = "1") Integer pageN){
        /*6:一页显示6行数据*/
        PageHelper.startPage(pageN,6);
        List<Employee> list = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
        PageInfo pageInfo = new PageInfo(list,5);
        model.addAttribute("pageInfo",pageInfo);
        return "/employee/list";
    }

    /**
     * 通过json实现平台无关性
     * @ResponseBody会自动将PageInfo转换为json
     */
    @RequestMapping("/showAll")
    @ResponseBody
    public Msg showAll(@RequestParam(value = "pn",defaultValue = "1") Integer pageNumber){
        /**
         * 1.得到页数，设置每页行数
         * 2.从数据库查询数据
         * 3.将查到的数据给PageInfo对象，并设置连续显示页数
         * 4.返回PageInfo对象
         * =====改:=====
         * 5.由于PageInfo通用性不高，自己在been包下定义一个消息类，用来返回。
         */
        PageHelper.startPage(pageNumber,6);
        List<Employee> list = employeeService.getAll();
        if(list.size()<0){
            return msg.fail();
        }
        PageInfo pageInfo = new PageInfo(list,5);
        return msg.success().add("pageInfo",pageInfo);
    }
    /**
     * 添加方法
     * */
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public Msg add(Employee employee){
        employeeService.add(employee);
        return msg.success();
    }
}
