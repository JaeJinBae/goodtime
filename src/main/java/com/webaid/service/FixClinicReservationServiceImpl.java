package com.webaid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.FixClinicReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;
import com.webaid.persistence.FixClinicReservationDao;

@Service
public class FixClinicReservationServiceImpl implements FixClinicReservationService {
	@Autowired
	private FixClinicReservationDao dao;

	@Override
	public List<FixClinicReservationVO> selectAll() {
		return dao.selectAll();
	}

	@Override
	public List<FixClinicReservationVO> selectByDate(String date) {
		return dao.selectByDate(date);
	}

	@Override
	public FixClinicReservationVO selectByRno(int rno) {
		return dao.selectByRno(rno);
	}

	@Override
	public List<FixClinicReservationVO> selectByDateEno(SelectByDateEmployeeVO vo) {
		return dao.selectByDateEno(vo);
	}

	@Override
	public void register(FixClinicReservationVO vo) {
		dao.register(vo);

	}

}
