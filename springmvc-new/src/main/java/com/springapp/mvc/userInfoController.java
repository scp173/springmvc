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
    @RequestMapping(value = "/main", method = RequestMethod.POST)
    public void myMethod(HttpServletRequest request,
                          HttpServletResponse response,
                          String username, String password,String nickname,//如果和前台的一样一样简写成这样
                          ModelMap modelMap) throws Exception {
        username = new String(username.getBytes("iso8859-1"),"UTF-8");//编码问题 （服务器一帮都是iso的）
        nickname = new String(nickname.getBytes("iso8859-1"),"UTF-8");//编码问题 （服务器一帮都是iso的）
        System.out.println(username + ":" + password);
        PreparedStatement pst = null;
        DBhelper helper = new DBhelper("MyDB");
        try {
            String  insql="insert into userinfo(username,userpassword,usernickname) values(?,?,?)";
            pst = helper.conn.prepareStatement(insql);
            pst.setString(1,username);
            pst.setString(2,password);
            pst.setString(3,nickname);
            int  i = pst.executeUpdate();          //  helper.conn.commit();
            pst.close();
            helper.conn.close();
    if (i==1) {//插入数据库成功
        modelMap.put("loginUser", username);
        modelMap.put("msg", "I'm in session");
        modelMap.put("success","1");
        ObjectMapper mapper = new ObjectMapper();
        String jsonstr = mapper.writeValueAsString(modelMap);
        System.out.print(jsonstr);
        response.setCharacterEncoding("UTF-8");
        response.getWriter().println(jsonstr);
        response.flushBuffer();
    }else
    {
        modelMap.put("loginUser", username);
        modelMap.put("msg", "I'm in session");
        modelMap.put("success","0");
        ObjectMapper mapper = new ObjectMapper();
        String jsonstr = mapper.writeValueAsString(modelMap);
        System.out.print(jsonstr);
        response.setCharacterEncoding("UTF-8");
        response.getWriter().println(jsonstr);
        response.flushBuffer();

    }


        }catch (Exception e)
        {
            System.out.print(e);
            modelMap.put("loginUser", username);
            modelMap.put("msg", "I'm in session");
            modelMap.put("success","0");
            ObjectMapper mapper = new ObjectMapper();
            String jsonstr = mapper.writeValueAsString(modelMap);
            System.out.print(jsonstr);
            response.setCharacterEncoding("UTF-8");
            response.getWriter().println(jsonstr);
            response.flushBuffer();
        }

        //    return new ModelAndView("main",modelMap);
    }

}

