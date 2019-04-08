package com.webaid.domain;

public class NormalTherapyReservationVO {

	private int rno;
	private int pno;
	private int eno;
	private String memo;
	private String clinic;
	private String rtype;
	private String rdate;
	private String rtime;
	private String writer;
	private String regdate;
	private String updatewriter;
	private String updatedate;
	private String desk_state;
	private String therapist_state;
	private String result;
	private String result_memo;

	public NormalTherapyReservationVO() {
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

	public String getUpdatewriter() {
		return updatewriter;
	}

	public void setUpdatewriter(String updatewriter) {
		this.updatewriter = updatewriter;
	}

	public String getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
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

	public String getResult_memo() {
		return result_memo;
	}

	public void setResult_memo(String result_memo) {
		this.result_memo = result_memo;
	}

	@Override
	public String toString() {
		return "NormalTherapyReservationVO [rno=" + rno + ", pno=" + pno + ", eno=" + eno + ", memo=" + memo
				+ ", clinic=" + clinic + ", rtype=" + rtype + ", rdate=" + rdate + ", rtime=" + rtime + ", writer="
				+ writer + ", regdate=" + regdate + ", updatewriter=" + updatewriter + ", updatedate=" + updatedate
				+ ", desk_state=" + desk_state + ", therapist_state=" + therapist_state + ", result=" + result
				+ ", result_memo=" + result_memo + "]";
	}

}
