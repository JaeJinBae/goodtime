package com.webaid.service;

import java.util.List;

import com.webaid.domain.ReservationUpdateRecordVO;
import com.webaid.domain.SearchCriteria;

public interface ReservationUpdateRecordService {
	public List<ReservationUpdateRecordVO> selectAll();
	public List<ReservationUpdateRecordVO> listSearch(SearchCriteria cri);
	public int listSearchCount(SearchCriteria cri);
	public void register(ReservationUpdateRecordVO vo);
}
