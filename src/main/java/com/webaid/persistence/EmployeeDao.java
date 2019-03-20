package com.webaid.persistence;

import com.webaid.domain.EmployeeVO;

public interface EmployeeDao {
	public EmployeeVO selectOneById(String id);
}
