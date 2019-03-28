package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.ReservationVO;

@Repository
public class ReservationDaoImpl implements ReservationDao {
	
	private static final String namespace="com.webaid.mappers.ReservationMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<ReservationVO> selectAll() {
		return session.selectList(namespace+".selectAll");
	}

	@Override
	public List<ReservationVO> selectByDate(String date) {
		return session.selectList(namespace+".selectByDate", date);
	}

	@Override
	public ReservationVO selectByRno(int rno) {
		return session.selectOne(namespace+".selectByRno", rno);
	}

}
