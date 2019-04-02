package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.ClinicVO;

@Repository
public class ClinicDaoImpl implements ClinicDao {
	
	private static final String namespace="com.webaid.mappers.ClinicMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<ClinicVO> selectAll() {
		return session.selectList(namespace+".selectAll");
	}

	@Override
	public ClinicVO selectOneByCno(int cno) {
		return session.selectOne(namespace+".selectOneByCno", cno);
	}

	@Override
	public List<ClinicVO> selectByCodeType(String code_type) {
		return session.selectList(namespace+".selectByCodeType", code_type);
	}
	
	@Override
	public void update(ClinicVO vo) {
		session.update(namespace+".update", vo);
	}

	@Override
	public void delete(int cno) {
		session.delete(namespace+".delete", cno);
	}

	

}
