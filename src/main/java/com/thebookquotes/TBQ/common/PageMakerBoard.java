package com.thebookquotes.TBQ.common;

public class PageMakerBoard {
    private int totalCount;
    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;
    private String keyword;
    private int displayPageNum = 10;
    private CriteriaBoard cri;
    private int totalPage;


    public PageMakerBoard() {}

    public String getKeyword() {
        return keyword;
    }
    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public PageMakerBoard(int totalCount, int startPage, int endPage, boolean prev, boolean next, CriteriaBoard cri,
                          int displayPageNum, int totalPage) {
        super();
        this.totalCount = totalCount;
        this.startPage = startPage;
        this.endPage = endPage;
        this.prev = prev;
        this.next = next;
        this.cri = cri;
        this.totalPage = totalPage;
        this.displayPageNum = displayPageNum;
    }

    public PageMakerBoard(int totalCount, int startPage, int endPage, boolean prev, boolean next, CriteriaBoard cri,
                          int displayPageNum, String keyword) { //검색어 추가
        super();
        this.totalCount = totalCount;
        this.startPage = startPage;
        this.endPage = endPage;
        this.prev = prev;
        this.next = next;
        this.cri = cri;
        this.displayPageNum = displayPageNum;
        this.keyword = keyword;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcDate();
    }

    private void calcDate() {
        endPage = (int) (Math.ceil(cri.getPage()/(double)displayPageNum) * displayPageNum);
        startPage = (endPage - displayPageNum) +1;
        int tempEndPage = (int) (Math.ceil(totalCount/(double)cri.getPageSize()));
        if(endPage > tempEndPage) endPage = tempEndPage;
        prev = (startPage == 1? false:true);
        next = (endPage * cri.getPageSize() >= totalCount? false:true);

    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public boolean isPrev() {
        return prev;
    }

    public void setPrev(boolean prev) {
        this.prev = prev;
    }

    public boolean isNext() {
        return next;
    }

    public void setNext(boolean next) {
        this.next = next;
    }

    public CriteriaBoard getCri() {
        return cri;
    }

    public void setCri(CriteriaBoard cri) { //변경
        this.cri = cri;
    }

    public int getDisplayPageNum() {
        return displayPageNum;
    }

    public void setDisplayPageNum(int displayPageNum) {
        this.displayPageNum = displayPageNum;
    }

    public void setTotalPage(int totalCount){
        this.totalPage = this.totalCount / 10;
    }
    public int getTotalPage() {
        return totalPage;
    }

    @Override
    public String toString() {
        return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", totalPage=" + totalPage + ", prev="
                + prev + ", next=" + next + ", cri=" + cri + ", displayPageNum=" + displayPageNum + "]";
    }
}