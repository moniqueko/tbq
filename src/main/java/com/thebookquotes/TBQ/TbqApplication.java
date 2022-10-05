package com.thebookquotes.TBQ;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.annotation.PostConstruct;
import java.util.TimeZone;

@SpringBootApplication
@MapperScan(basePackages = "com.thebookquotes.TBQ.mapper")
public class TbqApplication {

	public static void main(String[] args) {
		SpringApplication.run(TbqApplication.class, args);
	}

	@PostConstruct
	public void started() {
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
	}
}
