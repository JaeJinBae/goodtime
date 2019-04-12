package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.ReservationRecordVO;
import com.webaid.domain.SearchCriteriaRR;

public interface ReservationRecordDao {
	public List<ReservationRecordVO> selectAll();
	public List<ReservationRecordVO> listSearch(SearchCriteriaRR cri);
	public int listSearchCount(SearchCriteriaRR cri);
	public void register(ReservationRecordVO vo);
	public void updateReceptionInfo(ReservationRecordVO vo);
	public void updateTherapyInfo(ReservationRecordVO vo);
}
