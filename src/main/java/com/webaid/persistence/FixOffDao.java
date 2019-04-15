package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.FixOffVO;
import com.webaid.domain.SearchCriteriaRR;

public interface FixOffDao {
	public List<FixOffVO> selectAll();
	public List<FixOffVO> listSearch(SearchCriteriaRR cri);
	public int listSearchCount(SearchCriteriaRR cri);
	public void register(FixOffVO vo);
	public void update(FixOffVO vo);
}
