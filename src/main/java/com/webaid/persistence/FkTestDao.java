package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.FkTestVO;

public interface FkTestDao {
	public List<FkTestVO> selectAll();
	
}
