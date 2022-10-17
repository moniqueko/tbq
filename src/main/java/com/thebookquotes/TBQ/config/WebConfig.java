package com.thebookquotes.TBQ.config;

import com.thebookquotes.TBQ.interceptor.AdminInterceptor;
import com.thebookquotes.TBQ.interceptor.LoginInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@RequiredArgsConstructor
public class WebConfig implements WebMvcConfigurer {
    private final HandlerInterceptor loginInterceptor;
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/resources/**")
                .addResourceLocations("/resources/")
        ;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/addBook")
                .addPathPatterns("/editBook")
                .addPathPatterns("/myBook")
                .addPathPatterns("/memberList")
                .addPathPatterns("/boardAdmin")
                .excludePathPatterns("/join")
                .excludePathPatterns("/view");

        registry.addInterceptor(new AdminInterceptor())
                .addPathPatterns("/admin/**")
                .addPathPatterns("/memberList")
                .addPathPatterns("/boardAdmin");

    }
}