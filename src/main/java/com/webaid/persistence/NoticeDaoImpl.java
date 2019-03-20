package com.webaid.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webaid.domain.NoticeVO;
import com.webaid.domain.SearchCriteria;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	
	private static final String namespace="com.webaid.mappers.NoticeMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<NoticeVO> selectAll() {
		return session.selectList(namespace+".selectAll");
	}

	@Override
	public NoticeVO selectOne(int bno) {
		return session.selectOne(namespace+".selectOne", bno);
	}

	@Override
	public void insert(NoticeVO vo) {
		session.insert(namespace+".insert", vo);
	}

	@Override
	public void update(NoticeVO vo) {
		session.update(namespace+".update", vo);
	}
	
	@Override
	public void updateCnt(int bno) {
		session.update(namespace+".updateCnt", bno);
	}

	@Override
	public void delete(int bno) {
		session.delete(namespace+".delete",bno);
		
	}

	@Override
	public List<NoticeVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(namespace+".listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace+".listSearchCount", cri);
	}

}
