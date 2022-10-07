package com.thebookquotes.TBQ.mapper;
import com.thebookquotes.TBQ.dto.Maxim;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface MaximMapper {
    List<Maxim> maximList();
    void insertMaxim(Maxim maxim);
}