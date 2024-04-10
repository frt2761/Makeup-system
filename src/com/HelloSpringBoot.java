package com;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


@SpringBootApplication

@EnableTransactionManagement

@RestController //相当于ResponseBody + Controller 任何一个方法都以json格式返回
@MapperScan("com.mapper")
public class HelloSpringBoot {
	
	@Value("${spring.resources.static-locations}")
	private String static_locations;
	
    @RequestMapping("/getMap")
    @ResponseBody
    public Map<Object,Object> getMap(){
        Map<Object,Object> m = new HashMap<Object, Object>();
        m.put(1, "a");
        m.put(2, "b");
        m.put(3, "c");
        return m;
    }
    //入口程序
    public static void main(String[] args) {
        //主函数运行springboot项目
        SpringApplication.run(HelloSpringBoot.class, args);
    }
}