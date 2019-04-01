package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.PatientVO;
import com.webaid.domain.SearchCriteria;

public interface PatientDao {
	public List<PatientVO> selectAll();
	public PatientVO selectByPno(String pno);
	public List<PatientVO> selectByName(String name);
	public PatientVO selectByPhone(String phone);
	public List<PatientVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri);
	public void update(PatientVO vo);
}
