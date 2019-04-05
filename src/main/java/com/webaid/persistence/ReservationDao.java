package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.ReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface ReservationDao {
	public List<ReservationVO> selectAll();
	public List<ReservationVO> selectByDate(String date);
	public List<ReservationVO> selectByFixDay(String day);
	public ReservationVO selectByRno(int rno);
	public List<ReservationVO> selectByNormalDateEno(SelectByDateEmployeeVO vo);
	public List<ReservationVO> selectByFixDayEno(SelectByDateEmployeeVO vo);
	public void register(ReservationVO vo);
}
