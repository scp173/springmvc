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
import java.sql.ResultSet;
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
                         @RequestBody  String jstr//如果和前台的一样一样简写成这样
                         ) throws Exception {
        jstr = new String(jstr.getBytes("iso8859-1"),"UTF-8");//编码问题 （服务器一帮都是iso的）
        //json转对象
        jstr =  java.net.URLDecoder.decode(jstr,"utf-8");
        ObjectMapper mapper = new ObjectMapper();
     //   User user = mapper.readValue(jstr,User.class);
        DBhelper helper = new DBhelper("MyDB");
        ResultSet resultSet =  helper.findsqlWithJsonstr(jstr,"userinfo");
        ModelMap resultMap = new ModelMap();

        if (resultSet!=null) {

           String nickname =  resultSet.getString("nickname");
            resultMap.put("nickname", nickname);
            resultMap.put("msg", "loginok");
            resultMap.put("success", "1");
            String jsonstr = mapper.writeValueAsString(resultMap);
            System.out.print(jsonstr);
            response.setCharacterEncoding("UTF-8");
            response.getWriter().println(jsonstr);
            response.flushBuffer();
        }else
        {
            resultMap.put("nickname", "");
            resultMap.put("msg", "loginok");
            resultMap.put("success", "0");
            String jsonstr = mapper.writeValueAsString(resultMap);
            System.out.print(jsonstr);
            response.setCharacterEncoding("UTF-8");
            response.getWriter().println(jsonstr);
            response.flushBuffer();

        }
        helper.pst.close();
        helper.conn.close();

        //    return new ModelAndView("main",modelMap);
    }

    @RequestMapping (value = "/registerAction",method = RequestMethod.POST)
    public void resigeraction(HttpServletRequest request,
                        HttpServletResponse response,
                              @RequestBody String jstr) throws Exception {

        jstr = new String(jstr.getBytes("iso8859-1"),"UTF-8");//编码问题 （服务器一帮都是iso的）
        jstr =  java.net.URLDecoder.decode(jstr,"utf-8");

        ObjectMapper mapper = new ObjectMapper();
        //   User user = mapper.readValue(jstr,User.class);
        DBhelper helper = new DBhelper("MyDB");

        int success =  helper.insertsqlWithJsonstr(jstr,"userinfo");
        ModelMap resultMap = new ModelMap();

        if (success == 1)
        {
            Map<String, String> map = mapper.readValue(jstr, Map.class);

            resultMap.put("nickname", map.get("nickname"));
            resultMap.put("username", map.get("username"));

            resultMap.put("msg", "registerok");
            resultMap.put("success", "1");
            String jsonstr = mapper.writeValueAsString(resultMap);

            response.setCharacterEncoding("UTF-8");
            response.getWriter().println(jsonstr);
            response.flushBuffer();

        }else {
            resultMap.put("nickname", "");
            resultMap.put("msg", "registerfaild");
            resultMap.put("success","0");
            String jsonstr = mapper.writeValueAsString(resultMap);

            response.setCharacterEncoding("UTF-8");
            response.getWriter().println(jstr);
            response.flushBuffer();


        }
        helper.pst.close();
        helper.conn.close();



    }

}

