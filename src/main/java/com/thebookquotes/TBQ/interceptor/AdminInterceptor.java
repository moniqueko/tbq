package com.thebookquotes.TBQ.interceptor;

import com.thebookquotes.TBQ.dto.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class AdminInterceptor implements HandlerInterceptor {
    private static final Logger logger = LoggerFactory.getLogger(AdminInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        logger.info("AdminAccess - {}", "AdminVerification 접근");

        HttpSession session = request.getSession();

        Member member = (Member) session.getAttribute("memberInfo");

        if(member.getMemberGrant()!=1){
            response.sendRedirect("/error");
            return false;
        }else{
            session.setMaxInactiveInterval(30*60);
            return true;
        }
    }
}
