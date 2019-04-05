package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.ReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

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

	@Override
	public List<ReservationVO> selectByFixDay(String day) {
		return session.selectList(namespace+".selectByFixDay", day);
	}

	@Override
	public List<ReservationVO> selectByNormalDateEno(SelectByDateEmployeeVO vo) {
		return session.selectList(namespace+".selectByNormalDateEno", vo);
	}

	@Override
	public List<ReservationVO> selectByFixDayEno(SelectByDateEmployeeVO vo) {
		return session.selectList(namespace+".selectByFixDayEno", vo);
	}
	
	@Override
	public void register(ReservationVO vo) {
		session.insert(namespace+".register", vo);
	}

}
