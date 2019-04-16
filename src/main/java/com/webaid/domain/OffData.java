package com.webaid.domain;

public class OffData {
	private String yearmonth;
	private String select_date;

	public OffData() {
		super();
	}

	public String getYearmonth() {
		return yearmonth;
	}

	public void setYearmonth(String yearmonth) {
		this.yearmonth = yearmonth;
	}

	public String getSelect_date() {
		return select_date;
	}

	public void setSelect_date(String select_date) {
		this.select_date = select_date;
	}

	@Override
	public String toString() {
		return "OffData [yearmonth=" + yearmonth + ", select_date=" + select_date + "]";
	}

}
