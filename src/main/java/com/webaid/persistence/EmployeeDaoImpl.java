package com.webaid.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.EmployeeVO;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {

	private static final String namespace="com.webaid.mappers.EmployeeMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public EmployeeVO selectOneById(String id) {
		return session.selectOne(namespace+".selectOneById", id);
	}

}
