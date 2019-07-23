package tzk.been;

import java.util.HashMap;
import java.util.Map;

/**
 * @auther 唐智科(tzk)
 * @computerName tzk
 * @DATA 19-7-23   下午12:46
 */
public class Msg {
    /*100为成功，200为失败*/
    private int cod;
    /*提示消息*/
    private String msg;
    /*返回给用户的数据*/
    Map<String,Object> data = new HashMap();



    public Msg success(){
        this.cod=100;
        this.msg="处理成功";
        return this;
    }
    public Msg fail(){
        this.cod=200;
        this.msg="处理失败";
        return this;
    }
    public Msg add(String key,Object value){
         this.getData().put(key,value);
        return  this;
    }
    public int getCod() {
        return cod;
    }

    public void setCod(int cod) {
        this.cod = cod;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

}
