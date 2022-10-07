package com.thebookquotes.TBQ.service.maxim.impl;

import com.thebookquotes.TBQ.dto.Maxim;
import com.thebookquotes.TBQ.mapper.MaximMapper;
import com.thebookquotes.TBQ.service.maxim.MaximService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class MaximServiceImpl implements MaximService {
    @Resource
    MaximMapper mapper;

    @Override
    public List<Maxim> maximList() {
        return mapper.maximList();
    }

    @Override
    public void insertMaxim(Maxim maxim) {
        mapper.insertMaxim(maxim);
    }

}