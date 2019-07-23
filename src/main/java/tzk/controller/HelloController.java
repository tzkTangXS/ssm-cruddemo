package tzk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-21   下午7:28
 */
@Controller
public class HelloController {
    @RequestMapping("/hello")
    public String skip(){
        return "hello";
    }
}
