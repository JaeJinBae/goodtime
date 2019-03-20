package com.webaid.domain;

public class EmployeeVO {
	private int eno;
	private String type;
	private String name;
	private String phone;
	private String birth;
	private String mail;
	private String gender;
	private String level;
	private String id;
	private String pw;
	private String memo;
	private String offday_fix;
	private String offday_normal;

	public EmployeeVO() {
		super();
	}

	public int getEno() {
		return eno;
	}

	public void setEno(int eno) {
		this.eno = eno;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getOffday_fix() {
		return offday_fix;
	}

	public void setOffday_fix(String offday_fix) {
		this.offday_fix = offday_fix;
	}

	public String getOffday_normal() {
		return offday_normal;
	}

	public void setOffday_normal(String offday_normal) {
		this.offday_normal = offday_normal;
	}

	@Override
	public String toString() {
		return "EmployeeVO [eno=" + eno + ", type=" + type + ", name=" + name + ", phone=" + phone + ", birth=" + birth
				+ ", mail=" + mail + ", gender=" + gender + ", level=" + level + ", id=" + id + ", pw=" + pw + ", memo="
				+ memo + ", offday_fix=" + offday_fix + ", offday_normal=" + offday_normal + "]";
	}

}
