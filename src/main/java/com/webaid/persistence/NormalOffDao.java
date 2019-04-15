package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.NormalOffVO;
import com.webaid.domain.SearchCriteriaRR;

public interface NormalOffDao {
	public List<NormalOffVO> selectAll();
	public List<NormalOffVO> listSearch(SearchCriteriaRR cri);
	public int listSearchCount(SearchCriteriaRR cri);
	public void register(NormalOffVO vo);
	public void update(NormalOffVO vo);
}
