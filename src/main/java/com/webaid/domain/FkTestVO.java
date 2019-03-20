package com.webaid.domain;

public class FkTestVO {
	private String empname;
	private String deptname;

	public FkTestVO() {
		super();
	}

	public String getEmpname() {
		return empname;
	}

	public void setEmpname(String empname) {
		this.empname = empname;
	}

	public String getDeptname() {
		return deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}

	@Override
	public String toString() {
		return "FkTest [empname=" + empname + ", deptname=" + deptname + "]";
	}

}
