package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.ReservationRecordVO;

public interface ReservationRecordDao {
	public List<ReservationRecordVO> selectAll();
	public void register(ReservationRecordVO vo);
	public void updateReceptionInfo(ReservationRecordVO vo);
	public void updateTherapyInfo(ReservationRecordVO vo);
}
