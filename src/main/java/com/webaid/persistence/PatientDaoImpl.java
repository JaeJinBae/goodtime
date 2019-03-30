package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.PatientVO;
import com.webaid.domain.SearchCriteria;

@Repository
public class PatientDaoImpl implements PatientDao {

	private static final String namespace="com.webaid.mappers.PatientMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<PatientVO> selectAll() {
		return session.selectList(namespace+".selectAll");
	}

	@Override
	public List<PatientVO> selectByName(String name) {
		return session.selectList(namespace+".selectByName", name);
	}

	@Override
	public PatientVO selectByPhone(String phone) {
		return session.selectOne(namespace+".selectByPhone", phone);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) {
		return session.selectOne(namespace+".listSearchCount", cri);
	}

}
