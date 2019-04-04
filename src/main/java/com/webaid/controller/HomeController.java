package com.webaid.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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

import com.webaid.domain.ClinicVO;
import com.webaid.domain.EmployeeVO;
import com.webaid.domain.HospitalInfoVO;
import com.webaid.domain.IdPwVO;
import com.webaid.domain.PageMaker;
import com.webaid.domain.PatientVO;
import com.webaid.domain.ReservationVO;
import com.webaid.domain.SearchCriteria;
import com.webaid.service.ClinicService;
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
	
	@Autowired
	private ClinicService cService;
	
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
		
		//HospitalInfoVO hospitalInfo = hService.selectOne(day); 
		List<EmployeeVO> doctorList = empService.selectByType("doctor");
		List<EmployeeVO> therapistList = empService.selectByType("therapist");
		List<ClinicVO> clinicList = cService.selectByCodeType("진료");
		List<ClinicVO> therapyList = cService.selectByCodeType("치료");
		
		//model.addAttribute("hospitalInfo", hospitalInfo);
		model.addAttribute("doctorList", doctorList);
		model.addAttribute("therapistList", therapistList);
		model.addAttribute("clinicList", clinicList);
		model.addAttribute("therapyList", therapyList);
		return "sub/sub_main";
	}
	
	@RequestMapping(value = "/sub_main2", method = RequestMethod.GET)
	public String sub_main2(Model model, HttpSession session) {
		logger.info("sub_main GET");
		
		//HospitalInfoVO hospitalInfo = hService.selectOne(day); 
		List<EmployeeVO> doctorList = empService.selectByType("doctor");
		List<EmployeeVO> therapistList = empService.selectByType("therapist");
		//List<ClinicVO> clinicList = cService.selectAll();
		List<ClinicVO> clinicList = cService.selectByCodeType("진료");
		List<ClinicVO> therapyList = cService.selectByCodeType("치료");
		//model.addAttribute("hospitalInfo", hospitalInfo);
		model.addAttribute("doctorList", doctorList);
		model.addAttribute("therapistList", therapistList);
		model.addAttribute("clinicList", clinicList);
		model.addAttribute("therapyList", therapyList);
		
		return "sub/sub_main_backup_20190402";
	}
	
	@RequestMapping(value="/getDay/{date}", method=RequestMethod.GET)
	public ResponseEntity<String> getDay(@PathVariable("date") String date) throws ParseException, UnsupportedEncodingException{
		logger.info("getDay 진입");
		ResponseEntity<String> entity = null;
		
		DayGetUtil getDay = new DayGetUtil();
		String day = URLEncoder.encode(getDay.getDay(date), "UTF-8");
		logger.info("요일은 = "+day);
		entity = new ResponseEntity<String>(day, HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/hospitalInfoGetByDay/{date}", method=RequestMethod.GET)
	public ResponseEntity<HospitalInfoVO> hospitalInfoGet(@PathVariable("date") String date) throws ParseException{
		ResponseEntity<HospitalInfoVO> entity = null;
		DayGetUtil getDay = new DayGetUtil();
		String day = getDay.getDay(date);
		HospitalInfoVO vo = hService.selectOne(day);
		entity = new ResponseEntity<HospitalInfoVO>(vo, HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/clinicGetByCno/{cno}", method=RequestMethod.GET)
	public ResponseEntity<ClinicVO> clinicGetByCno(@PathVariable("cno") String cno){
		ResponseEntity<ClinicVO> entity = null;
		ClinicVO vo = cService.selectOneByCno(Integer.parseInt(cno));
		entity = new ResponseEntity<ClinicVO>(vo, HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/employeeListGetByType/{type}", method=RequestMethod.GET)
	public ResponseEntity<List<EmployeeVO>> doctorListGet(@PathVariable("type") String type) throws ParseException{
		ResponseEntity<List<EmployeeVO>> entity = null;
		
		List<EmployeeVO> list = empService.selectByType(type);		
		entity = new ResponseEntity<List<EmployeeVO>>(list, HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/employeeGetByEno{eno}", method=RequestMethod.GET)
	public ResponseEntity<EmployeeVO> employeeGetByEno(@PathVariable("eno") String eno){
		ResponseEntity<EmployeeVO> entity = null;
		EmployeeVO vo = empService.selectByEno(Integer.parseInt(eno));
		entity = new ResponseEntity<EmployeeVO>(vo, HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/reservationListGetByDate/{date}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> reservationListGetByDate(@PathVariable("date") String date) throws ParseException{
		ResponseEntity<Map<String,Object>> entity=null;
		HashMap<String, Object> map=new HashMap<>();
		
		try {
			DayGetUtil getDay = new DayGetUtil();
			String day = getDay.getDay(date);
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date selectDate = format.parse(date);
			
			List<ReservationVO> reservationListNormal = rService.selectByDate(date);
			List<ReservationVO> reservationListFix = rService.selectByFixDay(day);

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
			
			map.put("reservationListNormal", reservationListNormal);
			map.put("reservationListFix", reservationListFix);
			
			entity=new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			
			return entity;
		} catch (Exception e) {
			
		}
		return entity;
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
	
	@RequestMapping(value="/reservationRegister", method=RequestMethod.POST)
	public ResponseEntity<String> reservationRegisterPost(ReservationVO vo){
		logger.info("reservationRegister Post");
		ResponseEntity<String> entity= null;
		
		try {
			System.out.println(vo);
			rService.register(vo);
			entity = new ResponseEntity<String>("OK",HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("NO",HttpStatus.OK);
		}
		/*System.out.println(vo);
		rService.register(vo);
		entity = new ResponseEntity<String>("OK",HttpStatus.OK);*/
		return entity;
	}
	
	@RequestMapping(value="patientAllGet", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> patientAllGet(@ModelAttribute("cri") SearchCriteria cri) throws Exception{
		logger.info("patient all Get");
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map=new HashMap<>();
		
		List<PatientVO> patientListAll = pService.listSearch(cri);
		System.out.println("넘겨받은 페이지는 "+cri.getPage());
		
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
	
	@RequestMapping(value="/patientByPno/{pno}", method=RequestMethod.GET)
	public ResponseEntity<PatientVO> patientByPno(@PathVariable("pno") String pno){
		ResponseEntity<PatientVO> entity = null;
		
		PatientVO vo = pService.selectByPno(pno);
		entity= new ResponseEntity<PatientVO>(vo, HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/patientUpdate", method=RequestMethod.POST)
	public ResponseEntity<String> patientUpdate(PatientVO patient){
		logger.info("paitent update Post");
		
		ResponseEntity<String> entity = null;
		
		try {
			pService.update(patient);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>("no",HttpStatus.OK);
		}
		
		return entity;
	}
	
	
	
	
	
	
	
	
}
