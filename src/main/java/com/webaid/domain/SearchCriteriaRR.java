package com.webaid.domain;

public class SearchCriteriaRR extends Criteria {
	private String keyword1;
	private String keyword2;
	private String keyword3;
	private String keyword4;

	public SearchCriteriaRR() {
		super();
	}

	public String getKeyword1() {
		return keyword1;
	}

	public void setKeyword1(String keyword1) {
		this.keyword1 = keyword1;
	}

	public String getKeyword2() {
		return keyword2;
	}

	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}

	public String getKeyword3() {
		return keyword3;
	}

	public void setKeyword3(String keyword3) {
		this.keyword3 = keyword3;
	}

	public String getKeyword4() {
		return keyword4;
	}

	public void setKeyword4(String keyword4) {
		this.keyword4 = keyword4;
	}

	@Override
	public String toString() {
		return "SearchCriteriaRR [keyword1=" + keyword1 + ", keyword2=" + keyword2 + ", keryword3=" + keyword3
				+ ", keyword4=" + keyword4 + "]";
	}

}
