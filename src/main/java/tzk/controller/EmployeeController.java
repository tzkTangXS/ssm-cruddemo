package tzk.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import tzk.been.Employee;
import tzk.been.Msg;
import tzk.service.IEmployeeService;

import javax.validation.Valid;
import java.util.*;

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
     * 添加前验证邮箱是否已经存在,在点击添加之前
     * @return return:msg.success以存在。
     * msg.cod:100为真，200为假
     * */
    @RequestMapping("/addValidation")
    @ResponseBody
    public Msg addValidation(@RequestParam("email") String email){
        /*^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$*/
        String emailvalidationzz= "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$";
        if (!email.matches(emailvalidationzz)) {
            return msg.fail().add("msgValidation","邮箱格式不正确");
        }
     boolean judge = employeeService.isHasEmail(email);
     if(judge){

         return msg.success();
     }else {
         return msg.fail().add("msgValidation","邮箱以存在,不可用");
     }
    }
    /**
     * 添加方法
     * 添加后端校验(JSR303)导入Hibernate-validator包
     * ，前端防君子，后端防小人Q-Q)
     * */
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public Msg add(@Valid Employee employee, BindingResult result){
        Map<String,Object> map = new HashMap<>();
        if (result.hasErrors()) {
          Iterator<FieldError> iterator = result.getFieldErrors().iterator();
          while (iterator.hasNext()){
            FieldError fieldError = iterator.next();
              System.out.println(fieldError.getField());
              System.out.println(fieldError.getDefaultMessage());
              System.out.println("====================================");
            map.put(fieldError.getField(),fieldError.getDefaultMessage());
          }
          return msg.fail().add("fieldError",map);
        } else {
            boolean judge = employeeService.isHasEmail(employee.getEmail());
            if(judge){
                employeeService.add(employee);
                return msg.success();
            }else {
                return msg.fail().add("email","该邮箱已经存在");
            }

        }

    }
    /**
     * 登录
     * */
    @RequestMapping("/login")
    public String login(){
        return "/employee/list_2";
    }
}
