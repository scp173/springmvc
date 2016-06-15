package com.springapp.mvc;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.io.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import org.codehaus.jackson.map.ObjectMapper;
/**
 * Created by 111 on 16-6-9.
 */
@RestController
public class userInfoController {
//
//    @RequestMapping(value = "/main", method = RequestMethod.POST)
//    public void testData(String username, String password
//                                       ,HttpServletRequest request
//                                       , HttpServletResponse response) throws IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        String jsonStr=null;
//        // can reuse, share globally
//        ModelMap modelMap = new ModelMap()   ;
//        modelMap.put("loginUser", username);
//        modelMap.put("msg", "I'm in session");
//        ObjectMapper mapper = new ObjectMapper();
//        String jsonstr = mapper.writeValueAsString(modelMap);
//        System.out.println(jsonstr);
//        PrintWriter pw = null;
//        try {
//            pw = response.getWriter();
//            } catch (IOException e) {
//            System.out.print(e);
//            }
//        pw.print(jsonStr);
//        pw.flush();
//        pw.close();
//
//    }


    @RequestMapping(value = "/main", method = RequestMethod.POST)
    public void myMethod(HttpServletRequest request,
                          HttpServletResponse response,
                          String username, String password,//如果和前台的一样一样简写成这样
                          ModelMap modelMap) throws Exception {
        username = new String(username.getBytes("iso8859-1"),"UTF-8");//编码问题 （服务器一帮都是iso的）
        System.out.println(username + ":" + password);
        modelMap.put("loginUser", username);
        modelMap.put("msg", "I'm in session");
        ObjectMapper mapper = new ObjectMapper();
        String jsonstr = mapper.writeValueAsString(modelMap);
        System.out.print(jsonstr);
        response.setCharacterEncoding("UTF-8");
        response.getWriter().println(jsonstr);
        response.flushBuffer();

    //    return new ModelAndView("main",modelMap);
    }

//    @RequestMapping(value = "/main", method = RequestMethod.GET)
//    public  String loginView(ModelMap map)
//    {
//        System.out.println("makeup~~");
//        return "hello";
//    }
    @RequestMapping("/makeup")
    public  String baby(ModelMap map)
    {
        System.out.println("makeup~~");
        return "hello";
    }
}
