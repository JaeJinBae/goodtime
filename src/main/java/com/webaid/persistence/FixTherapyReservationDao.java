package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.FixTherapyReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface FixTherapyReservationDao {
	public List<FixTherapyReservationVO> selectAll();
	public List<FixTherapyReservationVO> selectByDate(String date);
	public FixTherapyReservationVO selectByRno(int rno);
	public List<FixTherapyReservationVO> selectByDateEno(SelectByDateEmployeeVO vo);
	public void register(FixTherapyReservationVO vo);
	public void updateDeskState(int rno);
}
