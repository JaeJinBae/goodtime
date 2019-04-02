package com.webaid.persistence;

import java.util.List;

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
	public List<EmployeeVO> selectAll() {
		return session.selectList(namespace+".selectAll");
	}

	@Override
	public EmployeeVO selectOneById(String id) {
		return session.selectOne(namespace+".selectOneById", id);
	}
	
	@Override
	public List<EmployeeVO> selectByType(String type) {
		return session.selectList(namespace+".selectByType", type);
	}

	@Override
	public EmployeeVO selectByEno(int eno) {
		return session.selectOne(namespace+".selectByEno", eno);
	}

}
