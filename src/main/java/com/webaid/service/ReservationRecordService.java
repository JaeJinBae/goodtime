package com.webaid.service;

import java.util.List;

import com.webaid.domain.ReservationRecordVO;
import com.webaid.domain.SearchCriteriaRR;

public interface ReservationRecordService {
	public List<ReservationRecordVO> selectAll();
	public List<ReservationRecordVO> selectByPno(int pno);
	public List<ReservationRecordVO> selectCompleteTherapyByPno(int pno);
	public List<ReservationRecordVO> selectCompleteClinicByPno(int pno);
	public List<ReservationRecordVO> listSearch(SearchCriteriaRR cri);
	public int listSearchCount(SearchCriteriaRR cri);
	public void register(ReservationRecordVO vo);
	public void updateReceptionInfo(ReservationRecordVO vo);
	public void updateTherapyInfo(ReservationRecordVO vo);
	public void updateRdateRtime(ReservationRecordVO vo);
}
