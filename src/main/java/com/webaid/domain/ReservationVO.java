package com.webaid.domain;

public class ReservationVO {
	private int rno;
	private int cno;
	private String name;
	private String phone;
	private String birth;
	private String gender;
	private String memo;
	private String main_doctor;
	private String main_therapist;
	private String rtype;
	private String normal_day;
	private String fix_day_start;
	private String fix_day_end;

	public ReservationVO() {
		super();
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getMain_doctor() {
		return main_doctor;
	}

	public void setMain_doctor(String main_doctor) {
		this.main_doctor = main_doctor;
	}

	public String getMain_therapist() {
		return main_therapist;
	}

	public void setMain_therapist(String main_therapist) {
		this.main_therapist = main_therapist;
	}

	public String getRtype() {
		return rtype;
	}

	public void setRtype(String rtype) {
		this.rtype = rtype;
	}

	public String getNormal_day() {
		return normal_day;
	}

	public void setNormal_day(String normal_day) {
		this.normal_day = normal_day;
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

	@Override
	public String toString() {
		return "ReservationVO [rno=" + rno + ", cno=" + cno + ", name=" + name + ", phone=" + phone + ", birth=" + birth
				+ ", gender=" + gender + ", memo=" + memo + ", main_doctor=" + main_doctor + ", main_therapist="
				+ main_therapist + ", rtype=" + rtype + ", normal_day=" + normal_day + ", fix_day_start="
				+ fix_day_start + ", fix_day_end=" + fix_day_end + "]";
	}

}
