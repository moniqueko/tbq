package com.thebookquotes.TBQ.service;

import com.thebookquotes.TBQ.common.CommonResult;
import com.thebookquotes.TBQ.common.ErrorCode;
import com.thebookquotes.TBQ.common.ListResult;
import com.thebookquotes.TBQ.common.SingleResult;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ResponseService {

    public enum CommonResponse { //Description : enum으로 api 요청 결과에 대한 code, message를 정의

        SUCCESS(200,"200", "SUCCESS");

        int status;
        String code;
        String msg;

        CommonResponse(int status, String code, String msg) {
            this.status = status;
            this.code = code;
            this.msg = msg;
        }

        public int getStatus() {
            return status;
        }

        public String getCode() {
            return code;
        }

        public String getMsg() {
            return msg;
        }
    }


    // 단일 건 결과 처리
    public <T> SingleResult<T> getSingleResult(T data) {
        SingleResult<T> result = new SingleResult<>();
        result.setData(data);
        setSuccessResult(result); //아래 메서드 호출
        return result;
    }

    // 다중 건 결과 처리
    public <T> ListResult<T> getListResult(List<T> list) {
        ListResult<T> result = new ListResult<>();
        result.setData(list);
        setSuccessResult(result); //아래 메서드 호출
        return result;
    }

    private void setSuccessResult(CommonResult result) {

        result.setStatus(CommonResponse.SUCCESS.getStatus());
        result.setCode(CommonResponse.SUCCESS.getCode());
        result.setMessage(CommonResponse.SUCCESS.getMsg());
    }

    public <T> SingleResult<T> getSuccessResult() {
        SingleResult<T> result = new SingleResult<>();
        setSuccessResult(result);
        return result;
    }

    public <T> SingleResult<T> getFailResult(ErrorCode errorCode) {
        SingleResult<T> result = new SingleResult<>();

        result.setStatus(errorCode.getStatus());
        result.setCode(errorCode.getCode());
        result.setMessage(errorCode.getMessage());

        return result;
    }

    public <T> ListResult<T> getFailListResult(ErrorCode errorCode) {
        ListResult<T> result = new ListResult<>();

        result.setStatus(errorCode.getStatus());
        result.setCode(errorCode.getCode());
        result.setMessage(errorCode.getMessage());

        return result;
    }
}