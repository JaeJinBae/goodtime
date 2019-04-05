package com.webaid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.ReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;
import com.webaid.persistence.ReservationDao;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationDao dao;
	
	@Override
	public List<ReservationVO> selectAll() {
		return dao.selectAll();
	}

	@Override
	public List<ReservationVO> selectByDate(String date) {
		return dao.selectByDate(date);
	}

	@Override
	public ReservationVO selectByRno(int rno) {
		return dao.selectByRno(rno);
	}

	@Override
	public List<ReservationVO> selectByFixDay(String day) {
		return dao.selectByFixDay(day);
	}

	@Override
	public List<ReservationVO> selectByNormalDateEno(SelectByDateEmployeeVO vo) {
		return dao.selectByNormalDateEno(vo);
	}

	@Override
	public List<ReservationVO> selectByFixDayEno(SelectByDateEmployeeVO vo) {
		return dao.selectByFixDayEno(vo);
	}
	
	@Override
	public void register(ReservationVO vo) {
		dao.register(vo);
	}

}
