package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.NormalTherapyReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface NormalTherapyReservationDao {
	public List<NormalTherapyReservationVO> selectAll();
	public List<NormalTherapyReservationVO> selectByDate(String date);
	public NormalTherapyReservationVO selectByRno(int rno);
	public List<NormalTherapyReservationVO> selectByDateEno(SelectByDateEmployeeVO vo);
	public void register(NormalTherapyReservationVO vo);
}
