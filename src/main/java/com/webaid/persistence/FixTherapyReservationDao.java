package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.FixTherapyReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface FixTherapyReservationDao {
	public List<FixTherapyReservationVO> selectAll();
	public List<FixTherapyReservationVO> selectByDate(String date);
	public FixTherapyReservationVO selectByRno(int rno);
	public List<FixTherapyReservationVO> selectByDateEno(SelectByDateEmployeeVO vo);
	public List<FixTherapyReservationVO> selectByDatePno(FixTherapyReservationVO vo);
	public List<FixTherapyReservationVO> selectCompleteTotalCount(String rdate);
	public void register(FixTherapyReservationVO vo);
	public void updateDeskState(FixTherapyReservationVO vo);
	public void updateTherapistState(FixTherapyReservationVO vo);
	public void updateInfo(FixTherapyReservationVO vo);
	public void cancel(FixTherapyReservationVO vo);
}
