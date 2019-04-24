package com.webaid.service;

import java.util.List;

import com.webaid.domain.NormalTherapyReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface NormalTherapyReservationService {
	public List<NormalTherapyReservationVO> selectAll();
	public List<NormalTherapyReservationVO> selectByDate(String date);
	public NormalTherapyReservationVO selectByRno(int rno);
	public List<NormalTherapyReservationVO> selectByDateEno(SelectByDateEmployeeVO vo);
	public List<NormalTherapyReservationVO> selectByDatePno(NormalTherapyReservationVO vo);
	public List<NormalTherapyReservationVO> selectCompleteTotalCount(String rdate);
	public void register(NormalTherapyReservationVO vo);
	public void updateDeskState(NormalTherapyReservationVO vo);
	public void updateTherapistState(NormalTherapyReservationVO vo);
	public void updateInfo(NormalTherapyReservationVO vo);
	public void cancel(NormalTherapyReservationVO vo);
}
