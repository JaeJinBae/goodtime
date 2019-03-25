package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.EmployeeVO;

public interface EmployeeDao {
	public List<EmployeeVO> selectAll();
	public EmployeeVO selectOneById(String id);
	public List<EmployeeVO> selectByType(String type);
}
