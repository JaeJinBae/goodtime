package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.NormalTherapyReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

@Repository
public class NormalTherapyReservationDaoImpl implements NormalTherapyReservationDao {

	private static final String namespace = "com.webaid.mappers.NormalTherapyReservationMapper";

	@Autowired
	private SqlSession session;

	@Override
	public List<NormalTherapyReservationVO> selectAll() {
		return session.selectList(namespace + ".selectAll");
	}

	@Override
	public List<NormalTherapyReservationVO> selectByDate(String date) {
		return session.selectList(namespace + ".selectByDate", date);
	}

	@Override
	public NormalTherapyReservationVO selectByRno(int rno) {
		return session.selectOne(namespace + ".selectByRno", rno);
	}

	@Override
	public List<NormalTherapyReservationVO> selectByDateEno(SelectByDateEmployeeVO vo) {
		return session.selectList(namespace + ".selectByDateEno", vo);
	}

	@Override
	public void register(NormalTherapyReservationVO vo) {
		session.insert(namespace + ".register", vo);
	}

	@Override
	public void updateDeskState(NormalTherapyReservationVO vo) {
		session.update(namespace + ".updateDeskState", vo);
	}

	@Override
	public void updateInfo(NormalTherapyReservationVO vo) {
		session.update(namespace + ".updateInfo", vo);
	}

	@Override
	public void cancel(NormalTherapyReservationVO vo) {
		session.update(namespace + ".cancel", vo);
	}

}
