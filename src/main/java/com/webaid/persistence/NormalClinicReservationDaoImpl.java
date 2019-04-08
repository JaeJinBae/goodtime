package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.NormalClinicReservationVO;
import com.webaid.domain.SelectByDateEmployeeVO;

@Repository
public class NormalClinicReservationDaoImpl implements NormalClinicReservationDao {

	private static final String namespace = "com.webaid.mappers.NormalClinicReservationMapper";

	@Autowired
	private SqlSession session;

	@Override
	public List<NormalClinicReservationVO> selectAll() {
		return session.selectList(namespace + ".selectAll");
	}

	@Override
	public List<NormalClinicReservationVO> selectByDate(String date) {
		return session.selectList(namespace + ".selectByDate", date);
	}

	@Override
	public NormalClinicReservationVO selectByRno(int rno) {
		return session.selectOne(namespace + ".selectByRno");
	}

	@Override
	public List<NormalClinicReservationVO> selectByDateEno(SelectByDateEmployeeVO vo) {
		return session.selectList(namespace + ".selectByDateEno", vo);
	}

	@Override
	public void register(NormalClinicReservationVO vo) {
		session.insert(namespace + ".register", vo);
	}

}
