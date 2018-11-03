package wangwei.wei.jenkins.test.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Auther: weiwei wang
 * @Date: 2018/10/25
 * @Description:
 */

@RestController
public class TestController {

    @RequestMapping("/test")
    private String index(){
        return "Hello Jenkins ！";
    }
}
