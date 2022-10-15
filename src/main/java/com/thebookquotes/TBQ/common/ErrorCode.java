package com.thebookquotes.TBQ.common;

public enum ErrorCode {
    //TODO: COMMON
    PARAMETER_IS_EMPTY(400, "400", "Parameter is empty"),
    NO_MATCHING_DATA(401, "401", "There is no matching data"),
    NULL_EXCEPTION(402, "402", "NULL input"),
    NO_PARAMETERS(404, "404", "No parameters"),
    NOT_FOLLOW_REGEX(404, "405", "Parameter is following RegExp"),
    DUPLICATION_ERROR(406, "406", "Duplication Error"),
    NO_INPUT_DATA(410, "410", "There is no input data"),
    NO_FILE(412, "412", "There is no uploaded file"),
    ;

    private final String code;
    private final String message;
    private int status;

    ErrorCode(final int status, final String code, final String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }

    public String getMessage() {
        return this.message;
    }

    public String getCode() {
        return code;
    }

    public int getStatus() {
        return status;
    }
}
