package com.webaid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.NormalTherapyReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;
import com.webaid.persistence.NormalTherapyReservationDao;

@Service
public class NormalTherapyReservationServiceImpl implements NormalTherapyReservationService {
	@Autowired
	private NormalTherapyReservationDao dao;

	@Override
	public List<NormalTherapyReservationVO> selectAll() {
		return dao.selectAll();
	}

	@Override
	public List<NormalTherapyReservationVO> selectByDate(String date) {
		return dao.selectByDate(date);
	}

	@Override
	public NormalTherapyReservationVO selectByRno(int rno) {
		return dao.selectByRno(rno);
	}

	@Override
	public List<NormalTherapyReservationVO> selectByDateEno(SelectByDateEmployeeVO vo) {
		return dao.selectByDateEno(vo);
	}

	@Override
	public void register(NormalTherapyReservationVO vo) {
		dao.register(vo);
	}

}