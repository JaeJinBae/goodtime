package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.ReservationRecordVO;

@Repository
public class ReservationRecordDaoImpl implements ReservationRecordDao {

	private static final String namespace="com.webaid.mappers.ReservationRecordMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<ReservationRecordVO> selectAll() {
		return session.selectList(namespace+".selectAll");
	}

	@Override
	public void register(ReservationRecordVO vo) {
		session.insert(namespace+".register", vo);
	}

	@Override
	public void updateReceptionInfo(ReservationRecordVO vo) {
		session.update(namespace+".updateReceptionInfo", vo);
	}

	@Override
	public void updateTherapyInfo(ReservationRecordVO vo) {
		session.update(namespace+".updateTherapyInfo", vo);
	}

}
