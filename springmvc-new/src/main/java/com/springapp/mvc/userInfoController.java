package com.springapp.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.io.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.Map;
import org.codehaus.jackson.map.ObjectMapper;
/**
 * Created by 111 on 16-6-9.
 */
@RestController
public class userInfoController {
    @RequestMapping(value = "/loginAction", method = RequestMethod.POST)
    public void myMethod(HttpServletRequest request,
                          HttpServletResponse response,
                         @RequestBody  String jstr,//如果和前台的一样一样简写成这样
                          ModelMap modelMap) throws Exception {
     //   code = new String(code.getBytes("iso8859-1"),"UTF-8");//编码问题 （服务器一帮都是iso的）
     //   nickname = new String(nickname.getBytes("iso8859-1"),"UTF-8");//编码问题 （服务器一帮都是iso的）
     //   System.out.println(code);
        //json转对象
        ObjectMapper mapper = new ObjectMapper();
     //   User user = mapper.readValue(jstr,User.class);

        PreparedStatement pst = null;
        DBhelper helper = new DBhelper("MyDB");
       // helper.insertsqlWithJsonstr(jstr,"userinfo");
        helper.findsqlWithJsonstr(jstr,"userinfo");

        try {
            String  insql="insert into userinfo(username,userpassword,usernickname) values(?,?,?)";
//            pst = helper.conn.prepareStatement(insql);
//            pst.setString(1,username);
//            pst.setString(2,password);
//            pst.setString(3,nickname);
//            int  i = pst.executeUpdate();          //  helper.conn.commit();
//            pst.close();
//            helper.conn.close();
//    if (i==1) {//插入数据库成功
//        modelMap.put("loginUser", username);
//        modelMap.put("msg", "I'm in session");
//        modelMap.put("success","1");
//        ObjectMapper mapper = new ObjectMapper();
//        String jsonstr = mapper.writeValueAsString(modelMap);
//        System.out.print(jsonstr);
//        response.setCharacterEncoding("UTF-8");
//        response.getWriter().println(jsonstr);
//        response.flushBuffer();
//    }else
//    {
        modelMap.put("loginUser", "aaa");
        modelMap.put("msg", "I'm in session");
        modelMap.put("success","0");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().println("");
        response.flushBuffer();

//    }


        }catch (Exception e)
        {
            System.out.print(e);
            modelMap.put("login","aaaa");
            modelMap.put("msg", "I'm in session");
            modelMap.put("success","0");
            String jsonstr = mapper.writeValueAsString(modelMap);
            System.out.print(jsonstr);
            response.setCharacterEncoding("UTF-8");
            response.getWriter().println(jsonstr);
            response.flushBuffer();
        }

        //    return new ModelAndView("main",modelMap);
    }

    @RequestMapping (value = "/registerAction",method = RequestMethod.POST)
    public void resigeraction(HttpServletRequest request,
                        HttpServletResponse response,
                              @RequestBody String code) throws Exception {
        System.out.print(code);
        ObjectMapper mapper = new ObjectMapper(); // can reuse, share globally
        Map<String,Object> modelMap = new HashMap<String, Object>();
        modelMap.put("loginUser", "aaa");
        modelMap.put("msg", "I'm in session");
        modelMap.put("success","0");
        String jsonstr = mapper.writeValueAsString(modelMap);
        System.out.print(jsonstr);
        response.setCharacterEncoding("UTF-8");
        response.getWriter().println(jsonstr);
        response.flushBuffer();

    }

}

