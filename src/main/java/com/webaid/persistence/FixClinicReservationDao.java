package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.FixClinicReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

public interface FixClinicReservationDao {
	public List<FixClinicReservationVO> selectAll();
	public List<FixClinicReservationVO> selectByDate(String date);
	public FixClinicReservationVO selectByRno(int rno);
	public List<FixClinicReservationVO> selectByDateEno(SelectByDateEmployeeVO vo);
	public void register(FixClinicReservationVO vo);
	public void updateDeskState(FixClinicReservationVO vo);
	public void updateInfo(FixClinicReservationVO vo);
	public void cancel(FixClinicReservationVO vo);
}
