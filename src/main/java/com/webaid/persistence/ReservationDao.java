package com.webaid.persistence;

import java.util.List;

import com.webaid.domain.ReservationVO;

public interface ReservationDao {
	public List<ReservationVO> selectAll();
	public List<ReservationVO> selectByDate(String date);
}
