package com.webaid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webaid.domain.NormalOffVO;
import com.webaid.domain.SearchCriteriaRR;
import com.webaid.persistence.NormalOffDao;

@Service
public class NormalOffServiceImpl implements NormalOffService {

	@Autowired
	private NormalOffDao dao;
	
	@Override
	public List<NormalOffVO> selectAll() {
		return dao.selectAll();
	}

	@Override
	public List<NormalOffVO> listSearch(SearchCriteriaRR cri) {
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteriaRR cri) {
		return dao.listSearchCount(cri);
	}

	@Override
	public void register(NormalOffVO vo) {
		dao.register(vo);
	}

	@Override
	public void update(NormalOffVO vo) {
		dao.update(vo);
	}

}
