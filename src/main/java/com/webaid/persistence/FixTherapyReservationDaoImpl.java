package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.FixTherapyReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

@Repository
public class FixTherapyReservationDaoImpl implements FixTherapyReservationDao {

	private static final String namespace = "com.webaid.mappers.FixTherapyReservationMapper";

	@Autowired
	private SqlSession session;

	@Override
	public List<FixTherapyReservationVO> selectAll() {
		return session.selectList(namespace + ".selectAll");
	}

	@Override
	public List<FixTherapyReservationVO> selectByDate(String date) {
		return session.selectList(namespace + ".selectByDate", date);
	}

	@Override
	public FixTherapyReservationVO selectByRno(int rno) {
		return session.selectOne(namespace + ".selectByRno", rno);
	}

	@Override
	public List<FixTherapyReservationVO> selectByDateEno(SelectByDateEmployeeVO vo) {
		return session.selectList(namespace + ".selectByDateEno", vo);
	}

	@Override
	public void register(FixTherapyReservationVO vo) {
		session.insert(namespace + ".register", vo);
	}

}
