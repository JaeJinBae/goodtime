package com.webaid.domain;

public class PatientVO {
	private int cno;
	private String name;
	private String phone;
	private String birth;
	private String gender;
	private String mail;
	private String main_doctor;
	private String main_therapist;
	private String sub_therapist;
	private String memo;
	private String activation;

	public PatientVO() {
		super();
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

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
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

	public String getSub_therapist() {
		return sub_therapist;
	}

	public void setSub_therapist(String sub_therapist) {
		this.sub_therapist = sub_therapist;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getActivation() {
		return activation;
	}

	public void setActivation(String activation) {
		this.activation = activation;
	}

	@Override
	public String toString() {
		return "PatientVO [cno=" + cno + ", name=" + name + ", phone=" + phone + ", birth=" + birth + ", gender="
				+ gender + ", mail=" + mail + ", main_doctor=" + main_doctor + ", main_therapist=" + main_therapist
				+ ", sub_therapist=" + sub_therapist + ", memo=" + memo + ", activation=" + activation + "]";
	}

}
