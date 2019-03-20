package com.webaid.domain;

public class AdviceVO {
	private String cname;
	private String pname;
	private String phone;
	private String email;
	private String budget;
	private String content;

	public AdviceVO() {
		super();
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBudget() {
		return budget;
	}

	public void setBudget(String budget) {
		this.budget = budget;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "AdviceVO [cname=" + cname + ", pname=" + pname + ", phone=" + phone + ", email=" + email + ", budget="
				+ budget + ", content=" + content + "]";
	}

	

	

}
