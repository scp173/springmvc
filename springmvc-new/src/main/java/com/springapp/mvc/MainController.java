package com.springapp.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by lijiangang on 16/6/13.
 */
@Controller
public class MainController {
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public  String loginView(ModelMap map)
    {
        System.out.println("makeup~~");
        return "hello";
    }
    @RequestMapping (value = "/register", method = RequestMethod.GET)
    public  String register()
    {
        System.out.println("makeup~~");
        return "register";
    }
}
