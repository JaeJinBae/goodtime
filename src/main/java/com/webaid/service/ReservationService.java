package com.webaid.service;

import java.util.List;

import com.webaid.domain.ReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface ReservationService {
	public List<ReservationVO> selectAll();
	public List<ReservationVO> selectByDate(String date);
	public List<ReservationVO> selectByFixDay(String day);
	public ReservationVO selectByRno(int rno);
	public List<ReservationVO> selectByNormalDateEno(SelectByDateEmployeeVO vo);
	public List<ReservationVO> selectByFixDayEno(SelectByDateEmployeeVO vo);
	public void register(ReservationVO vo);
}
