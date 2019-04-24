package com.webaid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.FixTherapyReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;
import com.webaid.persistence.FixTherapyReservationDao;

@Service
public class FixTherapyReservationServiceImpl implements FixTherapyReservationService {
	@Autowired
	private FixTherapyReservationDao dao;

	@Override
	public List<FixTherapyReservationVO> selectAll() {
		return dao.selectAll();
	}

	@Override
	public List<FixTherapyReservationVO> selectByDate(String date) {
		return dao.selectByDate(date);
	}

	@Override
	public FixTherapyReservationVO selectByRno(int rno) {
		return dao.selectByRno(rno);
	}

	@Override
	public List<FixTherapyReservationVO> selectByDateEno(SelectByDateEmployeeVO vo) {
		return dao.selectByDateEno(vo);
	}

	@Override
	public List<FixTherapyReservationVO> selectByDatePno(FixTherapyReservationVO vo) {
		return dao.selectByDatePno(vo);
	}

	@Override
	public List<FixTherapyReservationVO> selectCompleteTotalCount(String rdate) {
		return dao.selectCompleteTotalCount(rdate);
	}

	@Override
	public void register(FixTherapyReservationVO vo) {
		dao.register(vo);
	}

	@Override
	public void updateDeskState(FixTherapyReservationVO vo) {
		dao.updateDeskState(vo);
	}

	@Override
	public void updateTherapistState(FixTherapyReservationVO vo) {
		dao.updateTherapistState(vo);
	}

	@Override
	public void updateInfo(FixTherapyReservationVO vo) {
		dao.updateInfo(vo);
	}

	@Override
	public void cancel(FixTherapyReservationVO vo) {
		dao.cancel(vo);
	}

}
