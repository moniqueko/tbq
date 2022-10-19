package com.thebookquotes.TBQ.web.maxim;

import com.thebookquotes.TBQ.common.SingleResult;
import com.thebookquotes.TBQ.dto.Maxim;
import com.thebookquotes.TBQ.dto.Member;
import com.thebookquotes.TBQ.service.ResponseService;
import com.thebookquotes.TBQ.service.maxim.MaximService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class MaximRestController {
    private static final Logger LOGGER = LoggerFactory.getLogger(MaximRestController.class);
    private final MaximService maximService;
    private final ResponseService responseService;

    @PostMapping("/addMaxim")
    public SingleResult<?> addMaxim(Maxim maxim, HttpSession session) {
        Member member = (Member) session.getAttribute("memberInfo");

        if(member.getMemberGrant()==1){
            maximService.insertMaxim(maxim);
            LOGGER.info("Write Complete");
        }

    return responseService.getSuccessResult();
    }
}