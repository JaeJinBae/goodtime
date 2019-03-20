package com.webaid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.FkTestVO;
import com.webaid.persistence.FkTestDao;

@Service
public class FkTestServiceImpl implements FkTestService {

	@Autowired
	private FkTestDao dao;
	
	@Override
	public List<FkTestVO> selectAll() {
		return dao.selectAll();
	}

}
