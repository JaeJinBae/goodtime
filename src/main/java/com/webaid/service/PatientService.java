package com.webaid.service;

import java.util.List;

import com.webaid.domain.PatientVO;

public interface PatientService {
	public List<PatientVO> selectAll();
	public List<PatientVO> selectByName(String name);
	public PatientVO selectByPhone(String phone);
}
