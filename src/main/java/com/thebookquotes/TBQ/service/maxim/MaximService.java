package com.thebookquotes.TBQ.service.maxim;

import com.thebookquotes.TBQ.dto.Maxim;

import java.util.List;

public interface MaximService {
    List<Maxim> maximList();
    void insertMaxim(Maxim maxim);
}
