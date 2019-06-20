package com.webaid.domain;

public class ReservationGroupVO implements Comparable<ReservationGroupVO> {
	//선택한 날짜의 모든 예약vo들을 합치기 위한 vo
	private int pno;
	private String pname;
	private int chartNo;
	private String clinicName;
	private String rtype;
	private String rdate;
	private String rtime;

	public ReservationGroupVO() {
		super();
	}

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getChartNo() {
		return chartNo;
	}

	public void setChartNo(int chartNo) {
		this.chartNo = chartNo;
	}

	public String getClinicName() {
		return clinicName;
	}

	public void setClinicName(String clinicName) {
		this.clinicName = clinicName;
	}

	public String getRtype() {
		return rtype;
	}

	public void setRtype(String rtype) {
		this.rtype = rtype;
	}

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public String getRtime() {
		return rtime;
	}

	public void setRtime(String rtime) {
		this.rtime = rtime;
	}

	@Override
	public String toString() {
		return "ReservationGroupVO [pno=" + pno + ", pname=" + pname + ", chartNo=" + chartNo + ", clinicName="
				+ clinicName + ", rtype=" + rtype + ", rdate=" + rdate + ", rtime=" + rtime + "]";
	}

	@Override
	public int compareTo(ReservationGroupVO o) {
		return this.pname.compareTo(o.pname);
	}

}
