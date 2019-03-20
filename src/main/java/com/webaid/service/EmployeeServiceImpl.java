package com.webaid.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.EmployeeVO;
import com.webaid.domain.IdPwVO;
import com.webaid.persistence.EmployeeDao;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeDao dao;
	
	@Override
	public EmployeeVO selectOneById(String id) {
		return dao.selectOneById(id);
	}

}
