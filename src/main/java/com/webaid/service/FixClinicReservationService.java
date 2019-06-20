package com.webaid.service;

import java.util.List;

import com.webaid.domain.FixClinicReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface FixClinicReservationService {
	public List<FixClinicReservationVO> selectAll();
	public List<FixClinicReservationVO> selectByDate(String date);
	public FixClinicReservationVO selectByRno(int rno);
	public List<FixClinicReservationVO> selectByDateEno(SelectByDateEmployeeVO vo);
	public List<FixClinicReservationVO> selectByDatePno(FixClinicReservationVO vo);
	public void register(FixClinicReservationVO vo);
	public void updateDeskState(FixClinicReservationVO vo);
	public void updateInfo(FixClinicReservationVO vo);
	public void cancel(FixClinicReservationVO vo);
	public void deleteByRno(int rno);
}
