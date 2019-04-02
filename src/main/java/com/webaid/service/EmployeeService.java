package com.webaid.service;

import java.util.List;

import com.webaid.domain.EmployeeVO;

public interface EmployeeService {
	public List<EmployeeVO> selectAll();
	public EmployeeVO selectOneById(String id);
	public List<EmployeeVO> selectByType(String type);
	public EmployeeVO selectByEno(int eno);
}
