package com.thebookquotes.TBQ.interceptor;

import com.thebookquotes.TBQ.dto.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class LoginInterceptor implements HandlerInterceptor {
    private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        logger.info("LoginInterceptor - {}", "호출완료");

        HttpSession session = request.getSession();

        Member member = (Member) session.getAttribute("memberInfo");

        if(ObjectUtils.isEmpty(member)){
            response.sendRedirect("/login");
            return false;
        }else{
            session.setMaxInactiveInterval(30*60);
            return true;
        }
    }
}
