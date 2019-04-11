package com.webaid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.ReservationRecordVO;
import com.webaid.persistence.ReservationRecordDao;

@Service
public class ReservationRecordServiceImpl implements ReservationRecordService {
	
	@Autowired
	private ReservationRecordDao dao;
	
	@Override
	public List<ReservationRecordVO> selectAll() {
		return dao.selectAll();
	}

	@Override
	public void register(ReservationRecordVO vo) {
		dao.register(vo);
	}

	@Override
	public void updateReceptionInfo(ReservationRecordVO vo) {
		dao.updateReceptionInfo(vo);
	}

	@Override
	public void updateTherapyInfo(ReservationRecordVO vo) {
		dao.updateTherapyInfo(vo);
	}

}
