package com.webaid.service;

import java.util.List;

import com.webaid.domain.PatientVO;
import com.webaid.domain.SearchCriteria;

public interface PatientService {
	public List<PatientVO> selectAll();
	public List<PatientVO> selectByName(String name);
	public PatientVO selectByPhone(String phone);
	public List<PatientVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri);
}
