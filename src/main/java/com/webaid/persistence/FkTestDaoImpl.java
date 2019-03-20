package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.FkTestVO;

@Repository
public class FkTestDaoImpl implements FkTestDao {

	private static final String namespace="com.webaid.mappers.FkTestMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<FkTestVO> selectAll() {
		return session.selectList(namespace+".selectAll");
	}

}
