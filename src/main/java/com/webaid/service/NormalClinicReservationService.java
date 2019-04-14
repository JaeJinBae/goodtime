package com.webaid.service;

import java.util.List;

import com.webaid.domain.NormalClinicReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface NormalClinicReservationService {
	public List<NormalClinicReservationVO> selectAll();
	public List<NormalClinicReservationVO> selectByDate(String date);
	public NormalClinicReservationVO selectByRno(int rno);
	public List<NormalClinicReservationVO> selectByDateEno(SelectByDateEmployeeVO vo);
	public void register(NormalClinicReservationVO vo);
	public void updateDeskState(NormalClinicReservationVO vo);
	public void updateInfo(NormalClinicReservationVO vo);
	public void cancel(NormalClinicReservationVO vo);
}
