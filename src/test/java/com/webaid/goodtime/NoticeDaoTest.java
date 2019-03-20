package com.webaid.goodtime;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.webaid.domain.NoticeVO;
import com.webaid.persistence.FkTestDao;
import com.webaid.persistence.NoticeDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class NoticeDaoTest {

	@Autowired
	private NoticeDao dao;
	
	@Autowired
	private FkTestDao dao2;
	
	@Test
	public void selectAll(){
		dao2.selectAll();
	}
	
	//@Test
	public void selectOne(){
		dao.selectOne(1);
	}
	
	//@Test
	public void insert(){
		NoticeVO vo=new NoticeVO();
		vo.setWriter("관리자");
		vo.setTitle("안녕하세요");
		vo.setContent("가나다라마바사");
		dao.insert(vo);
	}
	
	//@Test
	public void update(){
		NoticeVO vo=new NoticeVO();
		vo.setBno(20);
		vo.setTitle("ㅋㅋㅋ");
		vo.setWriter("sadf");
		vo.setContent("ㅋㅋ이바이");
		dao.update(vo);
	}
	//@Test
	public void delete(){
		dao.delete(2);
	}
}
