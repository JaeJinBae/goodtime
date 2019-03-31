package com.webaid.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.webaid.domain.EmployeeVO;
import com.webaid.domain.HospitalInfoVO;
import com.webaid.domain.IdPwVO;
import com.webaid.domain.PageMaker;
import com.webaid.domain.PatientVO;
import com.webaid.domain.ReservationVO;
import com.webaid.domain.SearchCriteria;
import com.webaid.service.EmployeeService;
import com.webaid.service.HospitalInfoService;
import com.webaid.service.PatientService;
import com.webaid.service.ReservationService;
import com.webaid.util.DayGetUtil;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private EmployeeService empService;
	
	@Autowired
	private HospitalInfoService hService;
	
	@Autowired
	private ReservationService rService;
	
	@Autowired
	private PatientService pService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		logger.info("main GET");
				
		return "main/index";
	}
	
	@RequestMapping(value="/login_idpw_check", method=RequestMethod.POST)
	public ResponseEntity<String> idpw_check(IdPwVO user, HttpSession session){
		logger.info("idpw_chk post");
		logger.info("id= "+user.getId()+", pw= "+user.getPw());
		
		ResponseEntity<String> entity=null;
		
		try {
			EmployeeVO vo = empService.selectOneById(user.getId());
			if(vo.getId().equals(user.getId()) && vo.getPw().equals(user.getPw())){ 
				
				session.setAttribute("name", vo.getName());
				session.setAttribute("id", user.getId());
				session.setAttribute("type", vo.getType());
				session.setAttribute("eno", vo.getEno());
				logger.info("이름= "+session.getAttribute("name")+", 아이디= "+session.getAttribute("id")+", 타입= "+session.getAttribute("type"));
				entity = new ResponseEntity<String>("ok", HttpStatus.OK);
				
			}else{
				entity = new ResponseEntity<String>("no", HttpStatus.OK);
				logger.info("일치하는 아이디는 있으나 비번이 맞지 않음");
			}
		} catch (Exception e) {
			logger.info("일치하는 아이디 정보 없음!");
			entity = new ResponseEntity<String>("no", HttpStatus.OK);
			logger.info(e.getMessage());
		}
		
		return entity;
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session){
		logger.info("logout Get");
		
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value = "/sub_main", method = RequestMethod.GET)
	public String sub_main(Model model, HttpSession session) {
		logger.info("sub_main GET");
		
		//logger.info("이름= "+session.getAttribute("name")+", 아이디= "+session.getAttribute("id"));
		
		
		//HospitalInfoVO hospitalInfo = hService.selectOne(day); 
		List<EmployeeVO> doctorList = empService.selectByType("doctor");
		
		//model.addAttribute("hospitalInfo", hospitalInfo);
		model.addAttribute("doctorList", doctorList);
		
		return "sub/sub_main";
	}
	
	@RequestMapping(value="/reservationInfoGet/{date}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> reservationInfo(@PathVariable("date") String date) throws ParseException{
		logger.info("reservationInfo GET start");
		logger.info("받아온 날짜는 "+date);
		
		ResponseEntity<Map<String,Object>> entity=null;
		HashMap<String, Object> map=new HashMap<>();
		
		DayGetUtil getDay = new DayGetUtil();
		String day = getDay.getDay(date);
		
		List<ReservationVO> reservationList = rService.selectByDate(date);
		
		
		logger.info(day);
		map.put("reservationList", reservationList);
		
		entity=new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		logger.info("reservationInfo GET end");
		return entity;
	}
	
	@RequestMapping(value="/dayInfoGet/{day}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> dayInfoGet(@PathVariable("day") String day, Model model){
		logger.info("day info get start");
		ResponseEntity<Map<String,Object>> entity=null;
		HashMap<String, Object> map=new HashMap<>();
		
		DayGetUtil dg=new DayGetUtil();
		String selectDay = dg.getSelectDay(day);
		
		try {
			HospitalInfoVO hospitalInfo = hService.selectOne(selectDay);
			List<EmployeeVO> doctorList = empService.selectByType("doctor");
			
			map.put("hospitalInfo", hospitalInfo);
			map.put("doctorList", doctorList);

			entity=new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			
			logger.info("day info get end");
			return entity;
		} catch (Exception e) {
			
		}
		logger.info("day info get end");
		return entity;
	}
	
	@RequestMapping(value="/dayAndReservationInfo/{date}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> dayAndReservationInfoGET(@PathVariable("date") String date){
		logger.info("day And Reservation Info GET");
		ResponseEntity<Map<String,Object>> entity=null;
		HashMap<String, Object> map=new HashMap<>();
		
		try {
			DayGetUtil getDay = new DayGetUtil();
			String day = getDay.getDay(date);
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date selectDate = format.parse(date);
			
			List<ReservationVO> reservationListNormal = rService.selectByDate(date);
			List<ReservationVO> reservationListFix = rService.selectByFixDay(day);
			System.out.println(date);
			System.out.println(reservationListNormal.size());
			System.out.println(reservationListFix.size());
			Date getStartDate;
			Date getEndDate;
			
			for(int i=reservationListFix.size()-1; i >= 0; i--){
				//list에 담긴 내용 체크하고 지우는 과정인데 앞에서부터 지우면 하나 지워지면 뒤에내용이 자동으로 당겨지므로 뒤에서부터 반복문돌면서 조건에 따라 remove
				reservationListFix.get(i).getFix_day_start();
				getStartDate = format.parse(reservationListFix.get(i).getFix_day_start());
				getEndDate = format.parse(reservationListFix.get(i).getFix_day_end());
				
				if(selectDate.getTime() >= getStartDate.getTime() && selectDate.getTime() <= getEndDate.getTime()){
					//System.out.println("조건맞음"+reservationListFix.get(i));
				}else if(selectDate.getTime() <= getStartDate.getTime() || selectDate.getTime() >= getEndDate.getTime()){
					//System.out.println("조건틀림"+reservationListFix.get(i));
					reservationListFix.remove(i);
				}else{
					System.out.println("조건틀림2"+reservationListFix.get(i));
					reservationListFix.remove(i);
				}
				getStartDate = null;
				getEndDate = null;
			}
			HospitalInfoVO hospitalInfo = hService.selectOne(day);
			List<EmployeeVO> doctorList = empService.selectByType("doctor");
			List<EmployeeVO> therapistList = empService.selectByType("therapist");
			
			map.put("reservationListNormal", reservationListNormal);
			map.put("reservationListFix", reservationListFix);
			map.put("hospitalInfo", hospitalInfo);
			map.put("doctorList", doctorList);
			map.put("therapistList", therapistList);

			entity=new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			
			return entity;
		} catch (Exception e) {
			
		}
		
		return entity;
	}
	
	@RequestMapping(value="/reservationInfoByRno/{rno}", method=RequestMethod.GET)
	public ResponseEntity<ReservationVO> rservationInfoByRno(@PathVariable("rno") int rno){
		logger.info("reservationInfoByRno GET");
		ResponseEntity<ReservationVO> entity=null;
		
		try {
			ReservationVO vo=rService.selectByRno(rno);
			entity = new ResponseEntity<ReservationVO>(vo, HttpStatus.OK);
			return entity;
		} catch (Exception e) {
			
		}
		return entity;
	}
	
	@RequestMapping(value="patientAllGet", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> patientAllGet(@ModelAttribute("cri") SearchCriteria cri) throws Exception{
		logger.info("patient all Get");
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map=new HashMap<>();
		
		List<PatientVO> patientListAll = pService.listSearch(cri);
		System.out.println("넘겨받은 페이지는 "+cri.getPage());
		cri.setKeyword(null);
		cri.setSearchType("n");
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.makeSearch(cri.getPage());
		pageMaker.setTotalCount(pService.listSearchCount(cri));
		System.out.println(pageMaker.makeSearch(cri.getPage()));
		map.put("patientListAll", patientListAll);
		map.put("pageMaker", pageMaker);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		return entity;
	}
	
	
	
	
	
	
	
	
	
	
}
