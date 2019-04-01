package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.ClinicVO;

public interface ClinicDao {
	public List<ClinicVO> selectAll();
	public ClinicVO selectOneByCno(int cno);
	public void update(ClinicVO vo);
	public void delete(int cno);
}
