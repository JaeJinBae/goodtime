package com.webaid.service;

import java.util.List;

import com.webaid.domain.ReservationRecordVO;

public interface ReservationRecordService {
	public List<ReservationRecordVO> selectAll();
	public void register(ReservationRecordVO vo);
	public void updateReceptionInfo(ReservationRecordVO vo);
	public void updateTherapyInfo(ReservationRecordVO vo);
}
