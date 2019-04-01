package com.webaid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.ClinicVO;
import com.webaid.persistence.ClinicDao;

@Service
public class ClinicServiceImpl implements ClinicService {

	@Autowired
	private ClinicDao dao;
	
	@Override
	public List<ClinicVO> selectAll() {
		return dao.selectAll();
	}

	@Override
	public ClinicVO selectOneByCno(int cno) {
		return dao.selectOneByCno(cno);
	}

	@Override
	public void update(ClinicVO vo) {
		dao.update(vo);
	}

	@Override
	public void delete(int cno) {
		dao.delete(cno);
	}

}
