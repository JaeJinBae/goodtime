package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.PatientVO;

public interface PatientDao {
	public List<PatientVO> selectAll();
	public List<PatientVO> selectByName(String name);
	public PatientVO selectByPhone(String phone);
}
