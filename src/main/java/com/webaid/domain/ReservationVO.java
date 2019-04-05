package com.webaid.domain;

public class ReservationVO {
	private int rno;
	private int pno;
	private int eno;
	private String memo;
	private String clinic;
	private String rtype;
	private String normal_date;
	private String normal_rtime;
	private String fix_day;
	private String fix_rtime;
	private String fix_day_start;
	private String fix_day_end;
	private String writer;
	private String regdate;
	private String updatedate;
	private String updatewriter;
	private String desk_state;
	private String therapist_state;
	private String result;

	public ReservationVO() {
		super();
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public int getEno() {
		return eno;
	}

	public void setEno(int eno) {
		this.eno = eno;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getClinic() {
		return clinic;
	}

	public void setClinic(String clinic) {
		this.clinic = clinic;
	}

	public String getRtype() {
		return rtype;
	}

	public void setRtype(String rtype) {
		this.rtype = rtype;
	}

	public String getNormal_date() {
		return normal_date;
	}

	public void setNormal_date(String normal_date) {
		this.normal_date = normal_date;
	}

	public String getNormal_rtime() {
		return normal_rtime;
	}

	public void setNormal_rtime(String normal_rtime) {
		this.normal_rtime = normal_rtime;
	}

	public String getFix_day() {
		return fix_day;
	}

	public void setFix_day(String fix_day) {
		this.fix_day = fix_day;
	}

	public String getFix_rtime() {
		return fix_rtime;
	}

	public void setFix_rtime(String fix_rtime) {
		this.fix_rtime = fix_rtime;
	}

	public String getFix_day_start() {
		return fix_day_start;
	}

	public void setFix_day_start(String fix_day_start) {
		this.fix_day_start = fix_day_start;
	}

	public String getFix_day_end() {
		return fix_day_end;
	}

	public void setFix_day_end(String fix_day_end) {
		this.fix_day_end = fix_day_end;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}

	public String getUpdatewriter() {
		return updatewriter;
	}

	public void setUpdatewriter(String updatewriter) {
		this.updatewriter = updatewriter;
	}

	public String getDesk_state() {
		return desk_state;
	}

	public void setDesk_state(String desk_state) {
		this.desk_state = desk_state;
	}

	public String getTherapist_state() {
		return therapist_state;
	}

	public void setTherapist_state(String therapist_state) {
		this.therapist_state = therapist_state;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	@Override
	public String toString() {
		return "ReservationVO [rno=" + rno + ", pno=" + pno + ", eno=" + eno + ", memo=" + memo + ", clinic=" + clinic
				+ ", rtype=" + rtype + ", normal_date=" + normal_date + ", normal_rtime=" + normal_rtime + ", fix_day="
				+ fix_day + ", fix_rtime=" + fix_rtime + ", fix_day_start=" + fix_day_start + ", fix_day_end="
				+ fix_day_end + ", writer=" + writer + ", regdate=" + regdate + ", updatedate=" + updatedate
				+ ", updatewriter=" + updatewriter + ", desk_state=" + desk_state + ", therapist_state="
				+ therapist_state + ", result=" + result + "]";
	}

}
