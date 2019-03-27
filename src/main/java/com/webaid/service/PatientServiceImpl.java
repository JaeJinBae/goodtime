package com.webaid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.PatientVO;
import com.webaid.persistence.PatientDao;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	private PatientDao dao;
	
	@Override
	public List<PatientVO> selectAll() {
		return dao.selectAll();
	}

	@Override
	public List<PatientVO> selectByName(String name) {
		return dao.selectByName(name);
	}

	@Override
	public PatientVO selectByPhone(String phone) {
		return dao.selectByPhone(phone);
	}

}
