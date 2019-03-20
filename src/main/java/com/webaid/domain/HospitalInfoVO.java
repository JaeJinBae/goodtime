package com.webaid.domain;

public class HospitalInfoVO {
	private int no;
	private String day;
	private String start_time;
	private String end_time;
	private int lunch;
	private int dinner;

	public HospitalInfoVO() {
		super();
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public int getLunch() {
		return lunch;
	}

	public void setLunch(int lunch) {
		this.lunch = lunch;
	}

	public int getDinner() {
		return dinner;
	}

	public void setDinner(int dinner) {
		this.dinner = dinner;
	}

	@Override
	public String toString() {
		return "HospitalInfoVO [no=" + no + ", day=" + day + ", start_time=" + start_time + ", end_time=" + end_time
				+ ", lunch=" + lunch + ", dinner=" + dinner + "]";
	}

}
