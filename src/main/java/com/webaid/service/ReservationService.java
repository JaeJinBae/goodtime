package com.webaid.service;

import java.util.List;

import com.webaid.domain.ReservationVO;

public interface ReservationService {
	public List<ReservationVO> selectAll();
	public List<ReservationVO> selectByDate(String date);
}
