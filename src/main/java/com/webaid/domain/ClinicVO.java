package com.webaid.domain;

public class ClinicVO {
	private int cno;
	private String code_type;
	private String code_name;
	private String time;
	private String color;

	public ClinicVO() {
		super();
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public String getCode_type() {
		return code_type;
	}

	public void setCode_type(String code_type) {
		this.code_type = code_type;
	}

	public String getCode_name() {
		return code_name;
	}

	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	@Override
	public String toString() {
		return "ClinicVO [cno=" + cno + ", code_type=" + code_type + ", code_name=" + code_name + ", time=" + time
				+ ", color=" + color + "]";
	}

}
