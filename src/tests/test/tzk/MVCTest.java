package tzk;

import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import tzk.been.Employee;

import java.util.List;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-22   下午8:43
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcher-servlet.xml"})
public class MVCTest {
//    传入springmvc的ioc
    @Autowired/*本身只能自动装配ioc容器里的，要想装配ioc容器本身，得在来上加一个注释@WebAppConfiguration*/
    WebApplicationContext context;
    /*虚拟MVC请求，获得结果*/
    MockMvc mockMvc;
    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage() throws Exception {
        /*模拟请求，拿到返回值*/
        MvcResult result =mockMvc.perform(MockMvcRequestBuilders.get("/employee/getAll.do").param("pageN","6")).andReturn();
        /*取出pageInfo*/
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码"+pageInfo.getPageNum());
        System.out.println("总页数"+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.println("连续显示页");
        int[] n = pageInfo.getNavigatepageNums();
        for (int i : n) {
            System.out.println(i);

        }

        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println("employee = " + employee);
        }

    }
    
}
