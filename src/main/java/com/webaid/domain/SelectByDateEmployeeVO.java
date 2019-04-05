package com.webaid.domain;

public class SelectByDateEmployeeVO {
	private String normal_date;
	private String fix_day;
	private int eno;

	public SelectByDateEmployeeVO() {
		super();
	}

	public String getNormal_date() {
		return normal_date;
	}

	public void setNormal_date(String normal_date) {
		this.normal_date = normal_date;
	}

	public String getFix_day() {
		return fix_day;
	}

	public void setFix_day(String fix_day) {
		this.fix_day = fix_day;
	}

	public int getEno() {
		return eno;
	}

	public void setEno(int eno) {
		this.eno = eno;
	}

	@Override
	public String toString() {
		return "SelectByDateEmployeeVO [normal_date=" + normal_date + ", fix_day=" + fix_day + ", eno=" + eno + "]";
	}

	
}
