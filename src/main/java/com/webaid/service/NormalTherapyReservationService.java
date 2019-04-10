package com.webaid.service;

import java.util.List;

import com.webaid.domain.NormalTherapyReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface NormalTherapyReservationService {
	public List<NormalTherapyReservationVO> selectAll();
	public List<NormalTherapyReservationVO> selectByDate(String date);
	public NormalTherapyReservationVO selectByRno(int rno);
	public List<NormalTherapyReservationVO> selectByDateEno(SelectByDateEmployeeVO vo);
	public void register(NormalTherapyReservationVO vo);
	public void updateDeskState(int rno);
}
