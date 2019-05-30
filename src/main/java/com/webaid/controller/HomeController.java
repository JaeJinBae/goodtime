package com.webaid.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.webaid.domain.ClinicVO;
import com.webaid.domain.EmployeeVO;
import com.webaid.domain.FixClinicReservationVO;
import com.webaid.domain.FixOffVO;
import com.webaid.domain.FixTherapyReservationVO;
import com.webaid.domain.HospitalInfoVO;
import com.webaid.domain.IdPwVO;
import com.webaid.domain.NormalClinicReservationVO;
import com.webaid.domain.NormalOffVO;
import com.webaid.domain.NormalTherapyReservationVO;
import com.webaid.domain.OffData;
import com.webaid.domain.PageMaker;
import com.webaid.domain.PageMaker5;
import com.webaid.domain.PageMakerRR;
import com.webaid.domain.PatientVO;
import com.webaid.domain.ReservationRecordVO;
import com.webaid.domain.ReservationUpdateRecordVO;
import com.webaid.domain.SearchCriteria;
import com.webaid.domain.SearchCriteria5;
import com.webaid.domain.SearchCriteriaRR;
import com.webaid.domain.SelectByDateEmployeeVO;
import com.webaid.domain.SmsRecordVO;
import com.webaid.domain.SmsTemplateVO;
import com.webaid.domain.WaitingReservationVO;
import com.webaid.service.ClinicService;
import com.webaid.service.EmployeeService;
import com.webaid.service.FixClinicReservationService;
import com.webaid.service.FixOffService;
import com.webaid.service.FixTherapyReservationService;
import com.webaid.service.HospitalInfoService;
import com.webaid.service.NormalClinicReservationService;
import com.webaid.service.NormalOffService;
import com.webaid.service.NormalTherapyReservationService;
import com.webaid.service.PatientService;
import com.webaid.service.ReservationRecordService;
import com.webaid.service.ReservationUpdateRecordService;
import com.webaid.service.SmsRecordService;
import com.webaid.service.SmsTemplateService;
import com.webaid.service.WaitingReservationService;
import com.webaid.util.DayGetUtil;
import com.webaid.util.ExcelDown;
import com.webaid.util.SmsRemainGet;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private EmployeeService empService;
	
	@Autowired
	private HospitalInfoService hService;
	
	@Autowired
	private NormalClinicReservationService ncrService;
	
	@Autowired
	private NormalTherapyReservationService ntrService;
	
	@Autowired
	private FixClinicReservationService fcrService;
	
	@Autowired
	private FixTherapyReservationService ftrService;
	
	@Autowired
	private WaitingReservationService wrService;
	
	@Autowired
	private PatientService pService;
	
	@Autowired
	private ClinicService cService;
	
	@Autowired
	private ReservationRecordService rrService;
	
	@Autowired
	private ReservationUpdateRecordService rurService;
	
	@Autowired
	private NormalOffService noService;
	
	@Autowired
	private FixOffService foService;
	
	@Autowired
	private SmsTemplateService smsService;
	
	@Autowired
	private SmsRecordService smsrService;	
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
				entity = new ResponseEntity<String>(vo.getType(), HttpStatus.OK);
				
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
		
		List<EmployeeVO> doctorList = empService.selectByType("doctor");
		List<EmployeeVO> therapistList = empService.selectByType("therapist");
		List<ClinicVO> clinicList = cService.selectByCodeType("진료");
		List<ClinicVO> therapyList = cService.selectByCodeType("치료");
		
		model.addAttribute("doctorList", doctorList);
		model.addAttribute("therapistList", therapistList);
		model.addAttribute("clinicList", clinicList);
		model.addAttribute("therapyList", therapyList);
		return "sub/sub_main";
	}
	
	@RequestMapping(value = "/doctor", method = RequestMethod.GET)
	public String doctorView(Model model, HttpSession session) {
		logger.info("doctor GET");
		 
		List<EmployeeVO> doctorList = empService.selectByType("doctor");
		List<EmployeeVO> therapistList = empService.selectByType("therapist");
		List<ClinicVO> clinicList = cService.selectByCodeType("진료");
		List<ClinicVO> therapyList = cService.selectByCodeType("치료");
		
		model.addAttribute("doctorList", doctorList);
		model.addAttribute("therapistList", therapistList);
		model.addAttribute("clinicList", clinicList);
		model.addAttribute("therapyList", therapyList);
		return "sub/doctorView";
	}
	
	@RequestMapping(value = "/therapist", method = RequestMethod.GET)
	public String therapistView(Model model, HttpSession session) {
		logger.info("therapistView GET");
		 
		List<EmployeeVO> doctorList = empService.selectByType("doctor");
		List<EmployeeVO> therapistList = empService.selectByType("therapist");
		List<ClinicVO> clinicList = cService.selectByCodeType("진료");
		List<ClinicVO> therapyList = cService.selectByCodeType("치료");
		
		model.addAttribute("doctorList", doctorList);
		model.addAttribute("therapistList", therapistList);
		model.addAttribute("clinicList", clinicList);
		model.addAttribute("therapyList", therapyList);
		return "sub/therapistView";
	}
	
	@RequestMapping(value = "/nurse", method = RequestMethod.GET)
	public String nurseView(Model model, HttpSession session) {
		logger.info("nurseView GET");
		 
		List<EmployeeVO> doctorList = empService.selectByType("doctor");
		List<EmployeeVO> therapistList = empService.selectByType("therapist");
		List<ClinicVO> clinicList = cService.selectByCodeType("진료");
		List<ClinicVO> therapyList = cService.selectByCodeType("치료");
		
		model.addAttribute("doctorList", doctorList);
		model.addAttribute("therapistList", therapistList);
		model.addAttribute("clinicList", clinicList);
		model.addAttribute("therapyList", therapyList);
		return "sub/nurseView";
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
	
	@RequestMapping(value="/statistic", method=RequestMethod.GET)
	public String statisticView(Model model){
		logger.info("statisticView Get");
		Calendar now = Calendar.getInstance();
		String nowYear = now.get(Calendar.YEAR)+"";
		String nowMonth = ((now.get(Calendar.MONTH)+1)<10)?"0"+(now.get(Calendar.MONTH)+1):(now.get(Calendar.MONTH)+1)+"";
		String yearMonth = nowYear+"-"+nowMonth;
		
		List<EmployeeVO> empList = empService.selectByType("therapist");

		model.addAttribute("list", empList);
		
		return "sub/statisticView";
	}
	
	@RequestMapping(value="/statisticDown/{eno}/{ename}/{date}", method=RequestMethod.POST)
	public void excelDown(@PathVariable("eno") int eno,@PathVariable("ename") String ename, @PathVariable("date") String date, HttpServletResponse response) throws IOException {
		logger.info("엑셀 다운 진입");
		System.out.println(eno+"/"+date);
		ExcelDown exdn = new ExcelDown();
		Map<String, Object> list = new HashMap<>();
		
		NormalTherapyReservationVO ntrVO = new NormalTherapyReservationVO();
		FixTherapyReservationVO ftrVO = new FixTherapyReservationVO();
		
		ntrVO.setEno(eno);
		ntrVO.setRdate(date);
		ftrVO.setEno(eno);
		ftrVO.setRdate(date);
		
		List<NormalTherapyReservationVO> ntrList = ntrService.selectCompleteByDateEno(ntrVO);
		List<FixTherapyReservationVO> ftrList = ftrService.selectCompleteByDateEno(ftrVO);
		List<ClinicVO> clinicList = cService.selectByCodeType("치료");
		
		list.put("ntrList", ntrList);
		list.put("ftrList", ftrList);
		list.put("clinicList", clinicList);
		exdn.excelDown(eno, ename, date, list, response);
		
	}
	
	@RequestMapping(value="/reservationCountByDate/{date}", method=RequestMethod.GET)
	public ResponseEntity<List<String>> reservationCountByDate(@PathVariable("date") String date){
		ResponseEntity<List<String>> entity = null;
		Map<String, Object> map = new HashMap<>();
		List<EmployeeVO> empList = empService.selectByType("therapist");
		List<NormalTherapyReservationVO> ntrList = ntrService.selectCompleteTotalCount(date);
		List<FixTherapyReservationVO> ftrList = ftrService.selectCompleteTotalCount(date);
		List<String> str = new ArrayList();
		
		int num = 0;
		
		for(int i=0; i<empList.size(); i++){
			for(int j=0; j<ntrList.size(); j++){
				if(empList.get(i).getEno() == ntrList.get(j).getEno()){
					num++;
				}
			}
			str.add(empList.get(i).getEno()+"_ntr_"+num);
			num = 0;
			
			for(int j=0; j<ftrList.size(); j++){
				if(empList.get(i).getEno() == ftrList.get(j).getEno()){
					num++;
				}
			}
			str.add(empList.get(i).getEno()+"_ftr_"+num);
			num = 0;
		}
		
		entity = new ResponseEntity<List<String>>(str, HttpStatus.OK);
		
		return entity;
	}
	
	
	
	@RequestMapping(value="/hospitalInfo", method=RequestMethod.GET)
	public String hospitalInfoView(Model model){
		logger.info("hospitalInfo view Get");
		
		return "sub/hospitalInfoView";
	}
	
	@RequestMapping(value="/hospitalInfoGetAll", method=RequestMethod.GET)
	public ResponseEntity<List<HospitalInfoVO>> hospitalInfoGetAll(){
		ResponseEntity<List<HospitalInfoVO>> entity = null;
		try {
			List<HospitalInfoVO> list = hService.selectAll();
			entity = new ResponseEntity<List<HospitalInfoVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	@RequestMapping(value="/updateHospitalInfo", method=RequestMethod.POST)
	public ResponseEntity<String> updateHospitalInfo(@RequestBody List<HospitalInfoVO> list){
		ResponseEntity<String> entity= null;
		HospitalInfoVO vo = new HospitalInfoVO();
		String[] arrDOW = {"월", "화", "수", "목", "금", "토", "주간"};
		try {
			for(int i=0; i<list.size(); i++){
				System.out.println(list.get(i).getDay());
				vo.setDay(arrDOW[i]);
				vo.setStart_time(list.get(i).getStart_time());
				vo.setEnd_time(list.get(i).getEnd_time());
				hService.updateTime(vo);
			}
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<String>("no", HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/hospitalInfoGetByDay/{date}", method=RequestMethod.GET)
	public ResponseEntity<HospitalInfoVO> hospitalInfoGet(@PathVariable("date") String date) throws ParseException{
		ResponseEntity<HospitalInfoVO> entity = null;
		
		if(date.equals("7")){
			HospitalInfoVO vo = hService.selectOne("주간");
			entity = new ResponseEntity<HospitalInfoVO>(vo, HttpStatus.OK);
		}else{
			DayGetUtil getDay = new DayGetUtil();
			String day = getDay.getDay(date);
			HospitalInfoVO vo = hService.selectOne(day);
			entity = new ResponseEntity<HospitalInfoVO>(vo, HttpStatus.OK);
		}

		return entity;
	}
	
	@RequestMapping(value="/patientAllGet", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> patientAllGet(@RequestBody Map<String, String> info) throws Exception{
		logger.info("patient all Get");
		SearchCriteria5 cri = new SearchCriteria5();
		if(info.size() == 0){
			System.out.println("empty");
			System.out.println(info);
		}else{
			cri.setPage(Integer.parseInt(info.get("page")));
			cri.setPerPageNum(Integer.parseInt(info.get("perPageNum")));
			cri.setSearchType(info.get("searchType"));
			cri.setKeyword(info.get("keyword"));
		}
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map=new HashMap<>();
		
		List<PatientVO> patientListAll = pService.listSearch(cri);

		
		PageMaker5 pageMaker5 = new PageMaker5();
		pageMaker5.setCri(cri);
		pageMaker5.makeSearch(cri.getPage());
		pageMaker5.setTotalCount(pService.listSearchCount(cri));
		
		map.put("patientListAll", patientListAll);
		map.put("pageMaker5", pageMaker5);
		
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
	
	@RequestMapping(value="/patientCnoDuplicationChk/{cno}", method=RequestMethod.GET)
	public ResponseEntity<String> patientCnoDuplicationChk(@PathVariable("cno") int cno){
		ResponseEntity<String> entity = null;
		
		try {
			int result = pService.selectByCno(cno);
			if(result == 0){
				entity = new ResponseEntity<String>("ok", HttpStatus.OK);
			}else{
				entity = new ResponseEntity<String>("no", HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return entity;
	}
	
	@RequestMapping(value="/patientRegister", method=RequestMethod.POST)
	public ResponseEntity<String> patientRegister(PatientVO patient){
		logger.info("patient register Post");
		ResponseEntity<String> entity = null;
		System.out.println(patient);
		try {
			pService.register(patient);
			entity = new ResponseEntity<>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return entity;
	}
	
	@RequestMapping(value="/patientUpdate", method=RequestMethod.POST)
	public ResponseEntity<String> patientUpdate(PatientVO patient){
		logger.info("paitent update Post");
		
		ResponseEntity<String> entity = null;
		
		try {
			pService.update(patient);
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("no",HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/employeeView", method=RequestMethod.GET)
	public String employeeViewGet(){
		logger.info("employeeView Get");
		
		return "sub/employeeView";
	}
	
	@RequestMapping(value="/employeeAllGet", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> employeeAllGet(@RequestBody Map<String, String> info) throws Exception{
		logger.info("employee All Get");
		
		SearchCriteria cri = new SearchCriteria();
		
		if(info.size() == 0){

		}else{
			cri.setPage(Integer.parseInt(info.get("page")));
			cri.setPerPageNum(Integer.parseInt(info.get("perPageNum")));
			cri.setSearchType(info.get("searchType"));
			cri.setKeyword(info.get("keyword"));
		}
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map=new HashMap<>();
		
		List<EmployeeVO> employeeListAll = empService.listSearch(cri);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.makeSearch(cri.getPage());
		pageMaker.setTotalCount(empService.listSearchCount(cri));
		
		map.put("employeeListAll", employeeListAll);
		map.put("pageMaker", pageMaker);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/employeeIdCheck/{id}", method=RequestMethod.GET)
	public ResponseEntity<String> employeeIdCheck(@PathVariable("id") String id){
		logger.info("employee duplication id check");
		ResponseEntity<String> entity = null;
		
		try {
			EmployeeVO vo = empService.selectOneById(id);
			
			if(vo == null){
				entity = new ResponseEntity<String>("ok", HttpStatus.OK);
			}else{
				entity = new ResponseEntity<String>("no", HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return entity;
	}
	
	@RequestMapping(value="/employeeListGetByType/{type}", method=RequestMethod.GET)
	public ResponseEntity<List<EmployeeVO>> doctorListGet(@PathVariable("type") String type) throws ParseException{
		ResponseEntity<List<EmployeeVO>> entity = null;
		
		List<EmployeeVO> list = empService.selectByType(type);		
		entity = new ResponseEntity<List<EmployeeVO>>(list, HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/employeeGetByEno/{eno}", method=RequestMethod.GET)
	public ResponseEntity<EmployeeVO> employeeGetByEno(@PathVariable("eno") String eno){
		ResponseEntity<EmployeeVO> entity = null;
		EmployeeVO vo = empService.selectByEno(Integer.parseInt(eno));
		entity = new ResponseEntity<EmployeeVO>(vo, HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/employeeRegister", method=RequestMethod.POST)
	public ResponseEntity<String> employeeRegister(EmployeeVO employee){
		logger.info("employee register Post");
		ResponseEntity<String> entity = null;
		System.out.println(employee);
		try {
			empService.register(employee);
			entity = new ResponseEntity<>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return entity;
	}
	
	@RequestMapping(value="/employeeUpdate", method=RequestMethod.POST)
	public ResponseEntity<String> employeeUpdate(EmployeeVO employee){
		logger.info("employee update Post");
		ResponseEntity<String> entity = null;
		
		EmployeeVO prevVO = empService.selectByEno(employee.getEno());
		String prevPw = prevVO.getPw();
		String newPw = employee.getPw();
		
		try {
			if(newPw.equals("") || newPw == null){
				employee.setPw(prevPw);
			}
			empService.update(employee);
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("no",HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/employeeUpdate2", method=RequestMethod.POST)
	public ResponseEntity<String> employeeUpdate2(EmployeeVO employee){
		logger.info("employee update2 Post");
		ResponseEntity<String> entity = null;
		
		EmployeeVO prevVO = empService.selectByEno(employee.getEno());
		String prevPw = prevVO.getPw();
		String newPw = employee.getPw();
		
		try {
			if(newPw.equals("") || newPw == null){
				employee.setPw(prevPw);
			}
			empService.update2(employee);
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("no",HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/clinicView", method=RequestMethod.GET)
	public String clinicViewGet(){
		logger.info("clinicView Get");
		
		return "sub/clinicView";
	}
	
	@RequestMapping(value="/clinicAllGet", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> clinicAllGet(@RequestBody Map<String, String> info) throws Exception{
		logger.info("clinic all Get");
		SearchCriteria cri = new SearchCriteria();
		
		if(info.size() == 0){
			
		}else{
			cri.setPage(Integer.parseInt(info.get("page")));
			cri.setPerPageNum(Integer.parseInt(info.get("perPageNum")));
			cri.setSearchType(info.get("searchType"));
			cri.setKeyword(info.get("keyword"));
		}
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map=new HashMap<>();
		
		List<ClinicVO> clinicListAll = cService.listSearch(cri);
		System.out.println("넘겨받은 페이지는 "+cri.getPage());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.makeSearch(cri.getPage());
		pageMaker.setTotalCount(cService.listSearchCount(cri));
		System.out.println(pageMaker.makeSearch(cri.getPage()));
		map.put("clinicListAll", clinicListAll);
		map.put("pageMaker", pageMaker);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/clinicGetByCno/{cno}", method=RequestMethod.GET)
	public ResponseEntity<ClinicVO> clinicGetByCno(@PathVariable("cno") String cno){
		ResponseEntity<ClinicVO> entity = null;
		ClinicVO vo = cService.selectOneByCno(Integer.parseInt(cno));
		entity = new ResponseEntity<ClinicVO>(vo, HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/clinicGetByType/{type}", method=RequestMethod.GET)
	public ResponseEntity<List<ClinicVO>> clinicGetByType(@PathVariable("type") String type){
		ResponseEntity<List<ClinicVO>> entity = null;
		List<ClinicVO> list;
		if(type.equals("clinic")){
			list = cService.selectByCodeType("진료");
		}else{
			list = cService.selectByCodeType("치료");
		}
		
		entity = new ResponseEntity<List<ClinicVO>>(list, HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/clinicRegister", method=RequestMethod.POST)
	public ResponseEntity<String> clinicRegister(ClinicVO clinic){
		logger.info("clinic register Post");
		ResponseEntity<String> entity = null;
		System.out.println(clinic);
		try {
			cService.register(clinic);
			entity = new ResponseEntity<>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return entity;
	}
	
	@RequestMapping(value="/clinicUpdate", method=RequestMethod.POST)
	public ResponseEntity<String> clinicUpdate(ClinicVO clinic){
		logger.info("clinic update Post");
		ResponseEntity<String> entity = null;
		
		try {
			cService.update(clinic);
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("no", HttpStatus.OK);
			e.getMessage();
		}
		return entity;
	}	
	
	@RequestMapping(value="/reservationListGetByDate/{date}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> reservationListGetByDate(@PathVariable("date") String date) throws ParseException{
		ResponseEntity<Map<String,Object>> entity=null;
		HashMap<String, Object> map=new HashMap<>();
		
		try {
			List<NormalClinicReservationVO> ncReservationList = ncrService.selectByDate(date);
			List<NormalTherapyReservationVO> ntReservationList = ntrService.selectByDate(date);
			List<FixClinicReservationVO> fcReservationList = fcrService.selectByDate(date);
			List<FixTherapyReservationVO> ftReservationList = ftrService.selectByDate(date);
			
			map.put("ncReservationList", ncReservationList);
			map.put("ntReservationList", ntReservationList);
			map.put("fcReservationList", fcReservationList);
			map.put("ftReservationList", ftReservationList);
			
			entity=new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			
			return entity;
		} catch (Exception e) {
			
		}
		return entity;
	}
	
	@RequestMapping(value="/waitingReservationListGetByDate/{date}", method=RequestMethod.GET)
	public ResponseEntity<List<WaitingReservationVO>> waitingReservationListGetByDate(@PathVariable("date") String date) throws ParseException{
		ResponseEntity<List<WaitingReservationVO>> entity=null;
		HashMap<String, Object> map=new HashMap<>();
		
		try {
			List<WaitingReservationVO> list = wrService.selectByDate(date);
			
			entity=new ResponseEntity<List<WaitingReservationVO>>(list,HttpStatus.OK);
			
			return entity;
		} catch (Exception e) {
			
		}
		return entity;
	}
	
	@RequestMapping(value="/reservationListGetByDatePno/{date}/{pno}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> reservationListGetByDatePno(@PathVariable("date") String date, @PathVariable("pno") int pno) throws ParseException{
		ResponseEntity<Map<String,Object>> entity=null;
		HashMap<String, Object> map=new HashMap<>();
		
		try {
			NormalClinicReservationVO ncrvo = new NormalClinicReservationVO();
			ncrvo.setPno(pno);
			ncrvo.setRdate(date);
			
			NormalTherapyReservationVO ntrvo = new NormalTherapyReservationVO();
			ntrvo.setPno(pno);
			ntrvo.setRdate(date);
			
			FixClinicReservationVO fcrvo = new FixClinicReservationVO();
			fcrvo.setPno(pno);
			fcrvo.setRdate(date);
			
			FixTherapyReservationVO ftrvo = new FixTherapyReservationVO();
			ftrvo.setPno(pno);
			ftrvo.setRdate(date);
			
			List<NormalClinicReservationVO> ncrList = ncrService.selectByDatePno(ncrvo);
			List<NormalTherapyReservationVO> ntrList = ntrService.selectByDatePno(ntrvo);
			List<FixClinicReservationVO> fcrList = fcrService.selectByDatePno(fcrvo);
			List<FixTherapyReservationVO> ftrList = ftrService.selectByDatePno(ftrvo);
			
			map.put("ncrList", ncrList);
			map.put("ntrList", ntrList);
			map.put("fcrList", fcrList);
			map.put("ftrList", ftrList);
			
			entity=new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			
			return entity;
		} catch (Exception e) {
			
		}
		return entity;
	}
	
	@RequestMapping(value="/reservationListByDateEno/{type}/{eno}/{week}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> get_reservationList_byDate_byEmployee(@PathVariable("type") String type, @PathVariable("eno") String eno, @PathVariable("week") String week) throws ParseException{
		logger.info("reservationListByDateEno get");
		System.out.println(week);
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map=new HashMap<>();
		SelectByDateEmployeeVO sbdeVO = new SelectByDateEmployeeVO();
		List<NormalClinicReservationVO> ncrList = new ArrayList<NormalClinicReservationVO>();
		List<FixClinicReservationVO> fcrList = new ArrayList<FixClinicReservationVO>();
		List<NormalTherapyReservationVO> ntrList = new ArrayList<NormalTherapyReservationVO>();
		List<FixTherapyReservationVO> ftrList = new ArrayList<FixTherapyReservationVO>();
		String[] splitWeek = week.split(",");

		if(type.equals("doctor")){
			for(int i = 1; i <= splitWeek.length-1; i++){
				sbdeVO.setRdate(splitWeek[i]);
				sbdeVO.setEno(Integer.parseInt(eno));
				
				List<NormalClinicReservationVO> ncrVO = ncrService.selectByDateEno(sbdeVO);
				List<FixClinicReservationVO> fcrVO = fcrService.selectByDateEno(sbdeVO);
				
				if(ncrVO.size() != 0){
					for(int j=0; j<ncrVO.size(); j++){
						ncrList.add(ncrVO.get(j));
					}
				}
				if(fcrVO.size() != 0){
					for(int j=0; j<fcrVO.size(); j++){
						fcrList.add(fcrVO.get(j));
					}
				}
			}
			 
			map.put("ncr", ncrList);
			map.put("fcr", fcrList);
		}else{
			for(int i = 1; i < splitWeek.length-1; i++){
				sbdeVO.setRdate(splitWeek[i]);
				sbdeVO.setEno(Integer.parseInt(eno));
				
				List<NormalTherapyReservationVO> ntrVO = ntrService.selectByDateEno(sbdeVO);
				List<FixTherapyReservationVO> ftrVO = ftrService.selectByDateEno(sbdeVO);
				
				if(ntrVO.size() != 0){
					for(int j=0; j<ntrVO.size(); j++){
						ntrList.add(ntrVO.get(j));
					}
				}
				if(ftrVO.size() != 0){
					for(int j=0; j<ftrVO.size(); j++){
						ftrList.add(ftrVO.get(j));
					}
				}
			}
			map.put("ntr", ntrList);
			map.put("ftr", ftrList);
		}
		
		entity=new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/reservationListByPno/{pno}/{week}/{rtype}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getReservationListByPno(@PathVariable("pno") int pno, @PathVariable("week") String week, @PathVariable("rtype")String rtype){
		ResponseEntity<Map<String,Object>> entity = null;
		Map<String, Object> map = new HashMap<>();
		
		
		String[] splitWeek = week.split(",");
		
		if(rtype.equals("clinic")){
			List<NormalClinicReservationVO> ncrList = new ArrayList<NormalClinicReservationVO>();
			List<FixClinicReservationVO> fcrList = new ArrayList<FixClinicReservationVO>();
			
			NormalClinicReservationVO ncrVO = new NormalClinicReservationVO();
			FixClinicReservationVO fcrVO = new FixClinicReservationVO(); 
			ncrVO.setPno(pno);
			fcrVO.setPno(pno);
			
			for(int i = 1; i <= splitWeek.length-1; i++){
				ncrVO.setRdate(splitWeek[i]);	
				fcrVO.setRdate(splitWeek[i]);
				
				List<NormalClinicReservationVO> ncrVOlist = ncrService.selectByDatePno(ncrVO);
				List<FixClinicReservationVO> fcrVOlist = fcrService.selectByDatePno(fcrVO);
				
				if(ncrVOlist.size() != 0){
					for(int j=0; j<ncrVOlist.size(); j++){
						ncrList.add(ncrVOlist.get(j));
					}
				}
				if(fcrVOlist.size() != 0){
					for(int j=0; j<fcrVOlist.size(); j++){
						fcrList.add(fcrVOlist.get(j));
					}
				}
			}
			map.put("nr", ncrList);
			map.put("fr", fcrList);
			
		}else if(rtype.equals("therapy")){
			List<NormalTherapyReservationVO> ntrList = new ArrayList<NormalTherapyReservationVO>();
			List<FixTherapyReservationVO> ftrList = new ArrayList<FixTherapyReservationVO>();
			
			NormalTherapyReservationVO ntrVO = new NormalTherapyReservationVO();
			FixTherapyReservationVO ftrVO = new FixTherapyReservationVO(); 
			ntrVO.setPno(pno);
			ftrVO.setPno(pno);
			
			for(int i = 1; i <= splitWeek.length-1; i++){
				ntrVO.setRdate(splitWeek[i]);	
				ftrVO.setRdate(splitWeek[i]);
				
				List<NormalTherapyReservationVO> ntrVOlist = ntrService.selectByDatePno(ntrVO);
				List<FixTherapyReservationVO> ftrVOlist = ftrService.selectByDatePno(ftrVO);
				
				if(ntrVOlist.size() != 0){
					for(int j=0; j<ntrVOlist.size(); j++){
						ntrList.add(ntrVOlist.get(j));
					}
				}
				if(ftrVOlist.size() != 0){
					for(int j=0; j<ftrVOlist.size(); j++){
						ftrList.add(ftrVOlist.get(j));
					}
				}
			}
			map.put("nr", ntrList);
			map.put("fr", ftrList);
		}
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		return entity;
	}
	
	
	@RequestMapping(value="/fixReservationListByDateEno/{type}/{eno}/{week}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> get_fixReservationList_byDate_byEmployee(@PathVariable("type") String type, @PathVariable("eno") String eno, @PathVariable("week") String week) throws ParseException{
		logger.info("fixReservationListByDateEno get");
		System.out.println(week);
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map=new HashMap<>();
		SelectByDateEmployeeVO sbdeVO = new SelectByDateEmployeeVO();
		List<FixClinicReservationVO> fcrList = new ArrayList<FixClinicReservationVO>();
		List<FixTherapyReservationVO> ftrList = new ArrayList<FixTherapyReservationVO>();
		String[] splitWeek = week.split(",");

		if(type.equals("doctor")){
			for(int i = 1; i <= splitWeek.length-1; i++){
				sbdeVO.setRdate(splitWeek[i]);
				sbdeVO.setEno(Integer.parseInt(eno));
				
				List<FixClinicReservationVO> fcrVO = fcrService.selectByDateEno(sbdeVO);
				
				if(fcrVO.size() != 0){
					for(int j=0; j<fcrVO.size(); j++){
						fcrList.add(fcrVO.get(j));
					}
				}
			}
			map.put("vo", fcrList);
		}else{
			for(int i = 1; i < splitWeek.length-1; i++){
				sbdeVO.setRdate(splitWeek[i]);
				sbdeVO.setEno(Integer.parseInt(eno));
				
				List<FixTherapyReservationVO> ftrVO = ftrService.selectByDateEno(sbdeVO);
				
				if(ftrVO.size() != 0){
					for(int j=0; j<ftrVO.size(); j++){
						ftrList.add(ftrVO.get(j));
					}
				}
			}
			map.put("vo", ftrList);
		}
		
		entity=new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/ncReservationInfoByRno/{rno}", method=RequestMethod.GET)
	public ResponseEntity<NormalClinicReservationVO> ncReservationByRno(@PathVariable("rno") int rno){
		logger.info("ncReservation get by rno");
		ResponseEntity<NormalClinicReservationVO> entity = null;
		try {
			NormalClinicReservationVO vo = ncrService.selectByRno(rno);
			entity = new ResponseEntity<NormalClinicReservationVO>(vo, HttpStatus.OK);
		} catch (Exception e) {
			e.getMessage();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/ntReservationInfoByRno/{rno}", method=RequestMethod.GET)
	public ResponseEntity<NormalTherapyReservationVO> ntReservationByRno(@PathVariable("rno") int rno){
		ResponseEntity<NormalTherapyReservationVO> entity = null;
		try {
			NormalTherapyReservationVO vo = ntrService.selectByRno(rno);
			entity = new ResponseEntity<NormalTherapyReservationVO>(vo, HttpStatus.OK);
		} catch (Exception e) {
			e.getMessage();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/fcReservationInfoByRno/{rno}", method=RequestMethod.GET)
	public ResponseEntity<FixClinicReservationVO> fcReservationByRno(@PathVariable("rno") int rno){
		ResponseEntity<FixClinicReservationVO> entity = null;
		try {
			FixClinicReservationVO vo = fcrService.selectByRno(rno);
			entity = new ResponseEntity<FixClinicReservationVO>(vo, HttpStatus.OK);
		} catch (Exception e) {
			e.getMessage();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/ftReservationInfoByRno/{rno}", method=RequestMethod.GET)
	public ResponseEntity<FixTherapyReservationVO> ftReservationByRno(@PathVariable("rno") int rno){
		ResponseEntity<FixTherapyReservationVO> entity = null;
		try {
			FixTherapyReservationVO vo = ftrService.selectByRno(rno);
			entity = new ResponseEntity<FixTherapyReservationVO>(vo, HttpStatus.OK);
		} catch (Exception e) {
			e.getMessage();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/waitingReservationInfoByNo/{no}", method=RequestMethod.GET)
	public ResponseEntity<WaitingReservationVO> waitingReservationInfoByNo(@PathVariable("no") int no){
		logger.info("waitingReservationInfo get by no");
		ResponseEntity<WaitingReservationVO> entity = null;
		try {
			WaitingReservationVO vo = wrService.selectByNo(no);
			entity = new ResponseEntity<WaitingReservationVO>(vo, HttpStatus.OK);
		} catch (Exception e) {
			e.getMessage();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/ncReservationRegister", method=RequestMethod.POST)
	public ResponseEntity<String> ncReservationRegisterPost(NormalClinicReservationVO vo){
		logger.info("ncReservationRegister Post");
		ResponseEntity<String> entity= null;
		ReservationRecordVO rrvo = new ReservationRecordVO();
		EmployeeVO evo = empService.selectByEno(vo.getEno());
		
		try {
			ncrService.register(vo);
			rrvo.setNo(0);
			rrvo.setPno(vo.getPno());
			rrvo.setPname(vo.getPname());
			rrvo.setEname(evo.getName());
			rrvo.setRno(vo.getRno());
			rrvo.setRtype(vo.getRtype());
			rrvo.setCname(vo.getClinic_name());
			rrvo.setRdate(vo.getRdate());
			rrvo.setRtime(vo.getRtime());
			if(vo.getResult().equals("예약완료")){
				rrvo.setReception_info("");
			}else{
				rrvo.setReception_info(vo.getDesk_state_regdate()+" "+vo.getDesk_state_writer());
			}
			rrvo.setTherapy_info("");
			rrvo.setRegister_info(vo.getRegdate()+" "+vo.getWriter());
			rrvo.setResult(vo.getResult());
			rrvo.setResult_memo("");
			rrService.register(rrvo);
			entity = new ResponseEntity<String>("OK",HttpStatus.OK);
		} catch (Exception e) {
			e.getMessage();
			entity = new ResponseEntity<String>("NO",HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/ntReservationRegister", method=RequestMethod.POST)
	public ResponseEntity<String> ntReservationRegisterPost(NormalTherapyReservationVO vo){
		logger.info("ntReservationRegister Post");
		ResponseEntity<String> entity= null;
		ReservationRecordVO rrvo = new ReservationRecordVO();
		EmployeeVO evo = empService.selectByEno(vo.getEno());
		try {
			ntrService.register(vo);
			rrvo.setNo(0);
			rrvo.setPno(vo.getPno());
			rrvo.setPname(vo.getPname());
			rrvo.setEname(evo.getName());
			rrvo.setRno(vo.getRno());
			rrvo.setRtype(vo.getRtype());
			rrvo.setCname(vo.getClinic_name());
			rrvo.setRdate(vo.getRdate());
			rrvo.setRtime(vo.getRtime());
			if(vo.getResult().equals("예약완료")){
				rrvo.setReception_info("");
			}else{
				rrvo.setReception_info(vo.getDesk_state_regdate()+" "+vo.getDesk_state_writer());
			}
			rrvo.setTherapy_info("");
			rrvo.setRegister_info(vo.getRegdate()+" "+vo.getWriter());
			rrvo.setResult(vo.getResult());
			rrvo.setResult_memo("");
			rrService.register(rrvo);
			entity = new ResponseEntity<String>("OK",HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("NO",HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/fcReservationRegister", method=RequestMethod.POST)
	public ResponseEntity<String> fcReservationRegisterPost(@RequestBody Map<String, Object> data) throws IllegalAccessException, InvocationTargetException{
		logger.info("fcReservationRegister Post");
		
		ResponseEntity<String> entity= null;
		
		FixClinicReservationVO vo = new FixClinicReservationVO();
		BeanUtils.populate(vo, (Map) data.get("vo"));		
		
		String str = data.get("date").toString();
		String str2 = str.substring(1, str.length()-1);
		String[] splitDate = str2.split(", ");
		
		ReservationRecordVO rrvo = new ReservationRecordVO();
		EmployeeVO evo = empService.selectByEno(vo.getEno());
		System.out.println(vo);
		try {
			for(int i=0; i<splitDate.length; i++){
				vo.setRdate(splitDate[i]);
				fcrService.register(vo);
				rrvo.setNo(0);
				rrvo.setPno(vo.getPno());
				rrvo.setPname(vo.getPname());
				rrvo.setEname(evo.getName());
				rrvo.setRno(vo.getRno());
				rrvo.setRtype(vo.getRtype());
				rrvo.setCname(vo.getClinic_name());
				rrvo.setRdate(vo.getRdate());
				rrvo.setRtime(vo.getRtime());
				if(vo.getResult().equals("예약완료")){
					rrvo.setReception_info("");
				}else{
					rrvo.setReception_info(vo.getDesk_state_regdate()+" "+vo.getDesk_state_writer());
				}
				rrvo.setTherapy_info("");
				rrvo.setRegister_info(vo.getRegdate()+" "+vo.getWriter());
				rrvo.setResult(vo.getResult());
				rrvo.setResult_memo("");
				rrService.register(rrvo);
			}
			entity = new ResponseEntity<String>("OK",HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<String>("NO",HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/ftReservationRegister", method=RequestMethod.POST)
	public ResponseEntity<String> ftReservationRegisterPost(@RequestBody Map<String, Object> data) throws IllegalAccessException, InvocationTargetException{
		logger.info("ftReservationRegister Post");
		ResponseEntity<String> entity= null;
		
		FixTherapyReservationVO vo = new FixTherapyReservationVO();

		BeanUtils.populate(vo, (Map) data.get("vo"));
				
		String str = data.get("date").toString();
		String str2 = str.substring(1, str.length()-1);
		String[] splitDate = str2.split(", ");
		
		ReservationRecordVO rrvo = new ReservationRecordVO();
		EmployeeVO evo = empService.selectByEno(vo.getEno());
		
		try {
			for(int i=0; i<splitDate.length; i++){
				vo.setRdate(splitDate[i]);
				ftrService.register(vo);
				rrvo.setNo(0);
				rrvo.setPno(vo.getPno());
				rrvo.setPname(vo.getPname());
				rrvo.setEname(evo.getName());
				rrvo.setRno(vo.getRno());
				rrvo.setRtype(vo.getRtype());
				rrvo.setCname(vo.getClinic_name());
				rrvo.setRdate(vo.getRdate());
				rrvo.setRtime(vo.getRtime());
				if(vo.getResult().equals("예약완료")){
					rrvo.setReception_info("");
				}else{
					rrvo.setReception_info(vo.getDesk_state_regdate()+" "+vo.getDesk_state_writer());
				}
				rrvo.setTherapy_info("");
				rrvo.setRegister_info(vo.getRegdate()+" "+vo.getWriter());
				rrvo.setResult(vo.getResult());
				rrvo.setResult_memo("");
				rrService.register(rrvo);
			}
			entity = new ResponseEntity<String>("OK",HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("NO",HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/waitingReservationRegister", method=RequestMethod.POST)
	public ResponseEntity<String> waitingReservationRegisterPost(WaitingReservationVO vo){
		logger.info("waitingReservationRegister Post");
		ResponseEntity<String> entity= null;
		EmployeeVO evo = empService.selectByEno(vo.getEno());
		
		try {
			wrService.register(vo);
			
			entity = new ResponseEntity<String>("OK",HttpStatus.OK);
		} catch (Exception e) {
			e.getMessage();
			entity = new ResponseEntity<String>("NO",HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/waitingReservationDelete/{no}", method=RequestMethod.POST)
	public ResponseEntity<String> waitingReservationDelete(@PathVariable("no") int no){
		ResponseEntity<String> entity = null;
		try {
			wrService.delete(no);
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<String>("no", HttpStatus.OK);
		}
		return entity;
	}
	
	@RequestMapping(value="/updateReservationInfo",method=RequestMethod.POST)
	public ResponseEntity<String> updateReservationInfo(@RequestBody Map<String, String> info){
		ResponseEntity<String> entity = null;
		
		String pno = info.get("pno");
		String rno = info.get("rno");
		String rtype = info.get("rtype");
		String rdate = info.get("rdate");
		String rtime = info.get("rtime");
		int eno = Integer.parseInt(info.get("emp"));
		String ename = empService.selectByEno(eno).getName();
		String clinic = info.get("clinic");
		String clinic_name = info.get("clinic_name");
		String memo = info.get("memo");
		String before_info = info.get("before_info");
		String after_info = info.get("after_info");
		String update_type = info.get("update_type");
		String update_info = info.get("update_info");
		String update_memo = info.get("updateMemo");
		
		try {
			if(rtype.equals("nc")){
				NormalClinicReservationVO vo = new NormalClinicReservationVO();
				vo.setRno(Integer.parseInt(rno));
				vo.setRdate(rdate);
				vo.setRtime(rtime);
				vo.setEno(eno);
				vo.setClinic(clinic);
				vo.setClinic_name(clinic_name);
				vo.setMemo(memo);
				ncrService.updateInfo(vo);
			}else if(rtype.equals("nt")){
				NormalTherapyReservationVO vo = new NormalTherapyReservationVO();
				vo.setRno(Integer.parseInt(rno));
				vo.setRdate(rdate);
				vo.setRtime(rtime);
				vo.setEno(eno);
				vo.setClinic(clinic);
				vo.setClinic_name(clinic_name);
				vo.setMemo(memo);
				ntrService.updateInfo(vo);
			}else if(rtype.equals("fc")){
				FixClinicReservationVO vo = new FixClinicReservationVO();
				vo.setRno(Integer.parseInt(rno));
				vo.setRdate(rdate);
				vo.setRtime(rtime);
				vo.setEno(eno);
				vo.setClinic(clinic);
				vo.setClinic_name(clinic_name);
				vo.setMemo(memo);
				fcrService.updateInfo(vo);
			}else if(rtype.equals("ft")){
				FixTherapyReservationVO vo = new FixTherapyReservationVO();
				vo.setRno(Integer.parseInt(rno));
				vo.setRdate(rdate);
				vo.setRtime(rtime);
				vo.setEno(eno);
				vo.setClinic(clinic);
				vo.setClinic_name(clinic_name);
				vo.setMemo(memo);
				ftrService.updateInfo(vo);
			}
			
			ReservationUpdateRecordVO rurvo = new ReservationUpdateRecordVO();
			
			rurvo.setRno(Integer.parseInt(rno));
			rurvo.setRtype(rtype);
			rurvo.setPno(Integer.parseInt(pno));
			rurvo.setPname(pService.selectByPno(pno).getName());
			rurvo.setBefore_info(before_info);
			rurvo.setAfter_info(after_info);
			rurvo.setUpdate_type(update_type);
			rurvo.setUpdate_info(update_info);
			rurvo.setUpdate_memo(update_memo);
			rurService.register(rurvo);
			
			ReservationRecordVO rrvo = new ReservationRecordVO();
			rrvo.setRno(Integer.parseInt(rno));
			rrvo.setRtype(rtype);
			rrvo.setEname(ename);
			rrvo.setRdate(rdate);
			rrvo.setRtime(rtime);
			rrService.updateRdateRtime(rrvo);
			
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<String>("no", HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/updateReservationDeskState", method=RequestMethod.POST)
	public ResponseEntity<String> updateReservationDeskState(@RequestBody Map<String, String> info){
		ResponseEntity<String> entity = null;
		System.out.println(info.get("rtype")+"\n"+info.get("rno"));
		try {
			if(info.get("rtype").equals("nc")){
				NormalClinicReservationVO vo = new NormalClinicReservationVO();
				vo.setRno(Integer.parseInt(info.get("rno")));
				vo.setDesk_state(info.get("state"));
				vo.setDesk_state_writer(info.get("writer"));
				vo.setDesk_state_regdate(info.get("regdate"));
				vo.setResult(info.get("state"));
				if(info.get("state").equals("예약취소")){
					vo.setResult_memo(info.get("reason"));
				}else{
					vo.setResult_memo("");
				}
				ncrService.updateDeskState(vo);
				
				ReservationRecordVO rrvo = new ReservationRecordVO();
				rrvo.setRno(Integer.parseInt(info.get("rno")));
				rrvo.setRtype(info.get("rtype"));
				rrvo.setResult_memo(" ");
				if(info.get("state").equals("예약완료")){
					rrvo.setReception_info(" ");
				}else if(info.get("state").equals("접수완료")){
					rrvo.setReception_info(info.get("regdate")+" "+info.get("writer"));
				}else if(info.get("state").equals("예약취소")){
					rrvo.setReception_info("예약취소 "+info.get("regdate")+" "+info.get("writer"));
					rrvo.setResult_memo(info.get("reason"));
				}
				rrvo.setResult(info.get("state"));
				rrService.updateReceptionInfo(rrvo);
			}else if(info.get("rtype").equals("nt")){
				NormalTherapyReservationVO vo = new NormalTherapyReservationVO();
				vo.setRno(Integer.parseInt(info.get("rno")));
				vo.setDesk_state(info.get("state"));
				vo.setDesk_state_writer(info.get("writer"));
				vo.setDesk_state_regdate(info.get("regdate"));
				vo.setResult(info.get("state"));
				if(info.get("state").equals("예약취소")){
					vo.setResult_memo(info.get("reason"));
				}else{
					vo.setResult_memo("");
				}
				ntrService.updateDeskState(vo);
				
				ReservationRecordVO rrvo = new ReservationRecordVO();
				rrvo.setRno(Integer.parseInt(info.get("rno")));
				rrvo.setRtype(info.get("rtype"));
				rrvo.setResult_memo(" ");
				if(info.get("state").equals("예약완료")){
					rrvo.setReception_info(" ");
				}else if(info.get("state").equals("접수완료")){
					rrvo.setReception_info(info.get("regdate")+" "+info.get("writer"));
				}else if(info.get("state").equals("예약취소")){
					rrvo.setReception_info("예약취소 "+info.get("regdate")+" "+info.get("writer"));
					rrvo.setResult_memo(info.get("reason"));
				}
				rrvo.setResult(info.get("state"));
				rrService.updateReceptionInfo(rrvo);
			}else if(info.get("rtype").equals("fc")){
				FixClinicReservationVO vo = new FixClinicReservationVO();
				vo.setRno(Integer.parseInt(info.get("rno")));
				vo.setDesk_state(info.get("state"));
				vo.setDesk_state_writer(info.get("writer"));
				vo.setDesk_state_regdate(info.get("regdate"));
				vo.setResult(info.get("state"));
				if(info.get("state").equals("예약취소")){
					vo.setResult_memo(info.get("reason"));
				}else{
					vo.setResult_memo("");
				}
				fcrService.updateDeskState(vo);
				
				ReservationRecordVO rrvo = new ReservationRecordVO();
				rrvo.setRno(Integer.parseInt(info.get("rno")));
				rrvo.setRtype(info.get("rtype"));
				rrvo.setResult_memo(" ");
				if(info.get("state").equals("예약완료")){
					rrvo.setReception_info(" ");
				}else if(info.get("state").equals("접수완료")){
					rrvo.setReception_info(info.get("regdate")+" "+info.get("writer"));
				}else if(info.get("state").equals("예약취소")){
					rrvo.setReception_info("예약취소 "+info.get("regdate")+" "+info.get("writer"));
					rrvo.setResult_memo(info.get("reason"));
				}
				rrvo.setResult(info.get("state"));
				rrService.updateReceptionInfo(rrvo);
			}else if(info.get("rtype").equals("ft")){
				FixTherapyReservationVO vo = new FixTherapyReservationVO();
				vo.setRno(Integer.parseInt(info.get("rno")));
				vo.setDesk_state(info.get("state"));
				vo.setDesk_state_writer(info.get("writer"));
				vo.setDesk_state_regdate(info.get("regdate"));
				vo.setResult(info.get("state"));
				if(info.get("state").equals("예약취소")){
					vo.setResult_memo(info.get("reason"));
				}else{
					vo.setResult_memo("");
				}
				ftrService.updateDeskState(vo);
				
				ReservationRecordVO rrvo = new ReservationRecordVO();
				rrvo.setRno(Integer.parseInt(info.get("rno")));
				rrvo.setRtype(info.get("rtype"));
				rrvo.setResult_memo(" ");
				if(info.get("state").equals("예약완료")){
					rrvo.setReception_info(" ");
				}else if(info.get("state").equals("접수완료")){
					rrvo.setReception_info(info.get("regdate")+" "+info.get("writer"));
				}else if(info.get("state").equals("예약취소")){
					rrvo.setReception_info("예약취소 "+info.get("regdate")+" "+info.get("writer"));
					rrvo.setResult_memo(info.get("reason"));
				}
				rrvo.setResult(info.get("state"));
				rrService.updateReceptionInfo(rrvo);
			}
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("no", HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/updateReservationTherapistState", method=RequestMethod.POST)
	public ResponseEntity<String> updateReservationTherapistState(@RequestBody Map<String, String> info){
		ResponseEntity<String> entity = null;
		
		try {
			if(info.get("rtype").equals("nt")){
				NormalTherapyReservationVO vo = new NormalTherapyReservationVO();
				vo.setRno(Integer.parseInt(info.get("rno")));
				vo.setTherapist_state(info.get("state"));
				vo.setTherapist_state_writer(info.get("writer"));
				vo.setTherapist_state_regdate(info.get("regdate"));
				vo.setResult(info.get("state"));
				
				ntrService.updateTherapistState(vo);
			}else if(info.get("rtype").equals("ft")){
				FixTherapyReservationVO vo = new FixTherapyReservationVO();
				vo.setRno(Integer.parseInt(info.get("rno")));
				vo.setTherapist_state(info.get("state"));
				vo.setTherapist_state_writer(info.get("writer"));
				vo.setTherapist_state_regdate(info.get("regdate"));
				vo.setResult(info.get("state"));
				
				ftrService.updateTherapistState(vo);
			}
			ReservationRecordVO rrvo = new ReservationRecordVO();
			
			rrvo.setRno(Integer.parseInt(info.get("rno")));
			rrvo.setRtype(info.get("rtype"));
			rrvo.setTherapy_info(info.get("regdate")+" "+info.get("writer"));
			rrvo.setResult(info.get("state"));
			
			rrService.updateTherapyInfo(rrvo);
			
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("no", HttpStatus.OK);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/reservationRecordGetAll", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> reservationRecordGetAll(@RequestBody Map<String, String> info){
		logger.info("reservation record get all");
		SearchCriteriaRR cri = new SearchCriteriaRR();
		
		if(info.size() == 0){
			System.out.println("empty");
			System.out.println(info);
		}else{
			cri.setPage(Integer.parseInt(info.get("page")));
			cri.setPerPageNum(Integer.parseInt(info.get("perPageNum")));
			cri.setKeyword1(info.get("keyword1"));
			cri.setKeyword2(info.get("keyword2"));
			cri.setKeyword3(info.get("keyword3"));
			cri.setKeyword4(info.get("keyword4"));
		}
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map=new HashMap<>();
		
		try {
			if(cri.getKeyword1() == null){
				cri.setKeyword1("");
			}
			if(cri.getKeyword2() == null){
				cri.setKeyword2("");
			}
			if(cri.getKeyword3() == null){
				cri.setKeyword3("");
			}			
			if(cri.getKeyword4() == null){
				cri.setKeyword4("");
			}
			
			List<ReservationRecordVO> list = rrService.listSearch(cri);
			System.out.println(cri);
			PageMakerRR pageMaker = new PageMakerRR();
			pageMaker.setCri(cri);
			pageMaker.makeSearch(cri.getPage());
			pageMaker.setTotalCount(rrService.listSearchCount(cri));
			System.out.println("totalcount = "+rrService.listSearchCount(cri));
			map.put("list", list);
			map.put("pageMaker", pageMaker);
			System.out.println(cri.getPageStart());
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.NOT_FOUND);
			System.out.println(e.getMessage());
		}
		return entity;
	}
	
	@RequestMapping(value="reservationRecordByPno/{pno}", method=RequestMethod.GET)
	public ResponseEntity<List<ReservationRecordVO>> reservationRecordByPno(@PathVariable("pno") int pno){
		ResponseEntity<List<ReservationRecordVO>> entity = null;
		try {
			List<ReservationRecordVO> list = rrService.selectByPno(pno);
			entity = new ResponseEntity<List<ReservationRecordVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return entity;
	}
	
	@RequestMapping(value="reservationRecordGetCompleteByPno/{pno}", method=RequestMethod.GET)
	public ResponseEntity<List<ReservationRecordVO>> reservationRecordGetCompleteByPno(@PathVariable("pno") int pno){
		ResponseEntity<List<ReservationRecordVO>> entity = null;
		
		try {
			List<ReservationRecordVO> vo = rrService.selectCompleteTherapyByPno(pno);
			List<ReservationRecordVO> vo2 = rrService.selectCompleteClinicByPno(pno);
			vo.addAll(vo2);
			for(int i=0; i<vo.size(); i++){
				System.out.println(vo.get(i));
			}
			Collections.sort(vo);
			entity = new ResponseEntity<List<ReservationRecordVO>>(vo, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return entity;
	}
	
	@RequestMapping(value="/reservationUpdateRecordGetAll", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> reservationUpdateRecordGetAll(@RequestBody Map<String, String> info){
		logger.info("reservation update record get all");
		SearchCriteria cri = new SearchCriteria();
		
		if(info.size() == 0){
			System.out.println("empty");
			System.out.println(info);
		}else{
			cri.setPage(Integer.parseInt(info.get("page")));
			cri.setPerPageNum(Integer.parseInt(info.get("perPageNum")));
			cri.setSearchType(info.get("searchType"));
			cri.setKeyword(info.get("keyword"));
		}
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map=new HashMap<>();
		
		try {
			if(cri.getSearchType() == null){
				cri.setSearchType("n");
			}
			if(cri.getKeyword() == null){
				cri.setKeyword("");
			}
			
			List<ReservationUpdateRecordVO> list = rurService.listSearch(cri);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.makeSearch(cri.getPage());
			pageMaker.setTotalCount(rurService.listSearchCount(cri));
			
			map.put("list", list);
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.NOT_FOUND);
			System.out.println(e.getMessage());
		}
		return entity;
	}
	
	@RequestMapping(value="reservationUpdateRecordByPno/{pno}", method=RequestMethod.GET)
	public ResponseEntity<List<ReservationUpdateRecordVO>> reservationUpdateRecordByPno(@PathVariable("pno") int pno){
		ResponseEntity<List<ReservationUpdateRecordVO>> entity = null;
		try {
			List<ReservationUpdateRecordVO> list = rurService.selectByPno(pno);
			entity = new ResponseEntity<List<ReservationUpdateRecordVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return entity;
	}
	
	
	@RequestMapping(value="/normalOffGetAll", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> normalOffGetAll(@RequestBody Map<String, String> info) throws ParseException{
		SearchCriteriaRR cri = new SearchCriteriaRR();
		
		if(info.size() == 0){
			System.out.println("empty");
			System.out.println(info);
		}else{
			cri.setPage(Integer.parseInt(info.get("page")));
			cri.setPerPageNum(Integer.parseInt(info.get("perPageNum")));
			cri.setKeyword1(info.get("keyword1"));
			cri.setKeyword2(info.get("keyword2"));
			cri.setKeyword3(info.get("keyword3"));
			cri.setKeyword4(info.get("keyword4"));
		}
		
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map = new HashMap<>();
		
		Calendar now = new GregorianCalendar();
		int year = now.get(now.YEAR);
		String month = now.get(now.MONTH)+1+"";
		
		if(Integer.parseInt(month)<10){
			month = "0"+month;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date cDate = sdf.parse(year+"-"+month+"-01");
		now.setTime(cDate);
		int lastDate = now.getActualMaximum(now.DAY_OF_MONTH);
		
		try {
			if(cri.getKeyword1() == null){
				cri.setKeyword1(year+"-"+month+"-01");
			}
			if(cri.getKeyword2() == null){
				cri.setKeyword2(year+"-"+month+"-"+lastDate);
			}else{
				if(cri.getKeyword2().length() <= 7){
					cDate = sdf.parse(cri.getKeyword1());
					now.setTime(cDate);
					lastDate = now.getActualMaximum(now.DAY_OF_MONTH);
					cri.setKeyword2(cri.getKeyword2()+"-"+lastDate);
				}
			}
			if(cri.getKeyword3() == null){
				cri.setKeyword3("");
			}
			cri.setKeyword4("");
			
			List<NormalOffVO> list = noService.listSearch(cri);
			System.out.println(cri);
			PageMakerRR pageMaker = new PageMakerRR();
			pageMaker.setCri(cri);
			pageMaker.makeSearch(cri.getPage());
			pageMaker.setTotalCount(noService.listSearchCount(cri));
			
			map.put("list", list);
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return entity;
	}
	
	@RequestMapping(value="/normalOffGetByNo/{no}", method=RequestMethod.GET)
	public ResponseEntity<NormalOffVO> normalOffGetByNo(@PathVariable("no") int no){
		ResponseEntity<NormalOffVO> entity = null;
		try {
			NormalOffVO vo = noService.selectByNo(no);
			
			entity = new ResponseEntity<NormalOffVO>(vo, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<NormalOffVO>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/selectNormalOffByDate/{date}", method=RequestMethod.GET)
	public ResponseEntity<List<NormalOffVO>> normalOffSelectByDate(@PathVariable("date") String date){
		ResponseEntity<List<NormalOffVO>> entity = null;
		OffData offdata = new OffData();
		String[] str = date.split("-");
		offdata.setYearmonth(str[0]+"-"+str[1]);
		offdata.setSelect_date(date);
		
		List<NormalOffVO> list = noService.selectByDate(offdata);
		
		entity = new ResponseEntity<List<NormalOffVO>>(list, HttpStatus.OK);
		return entity;
	}
	
	
	@RequestMapping(value="/selectNormalOffByWeek/{week}/{eno}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> normalOffSelectByWeek(@PathVariable("week") List<String> week, @PathVariable("eno") int eno){
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map = new HashMap<>();
		OffData offdata = new OffData();
		offdata.setEno(eno);
		String[] str;
		for(int i=1; i<week.size(); i++){
			str = week.get(i).split("-");
			offdata.setYearmonth(str[0]+"-"+str[1]);
			offdata.setSelect_date(week.get(i));
			List<NormalOffVO> list=noService.selectByEnoDate(offdata);
			if(list.size() != 0){
				map.put(week.get(i), list);
			}
		}
		entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/normalOffRegister", method=RequestMethod.POST)
	public ResponseEntity<String> normalOffRegister(@RequestBody NormalOffVO vo){
		ResponseEntity<String> entity = null;
		try {
			noService.register(vo);
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<String>("no", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/normalOffUpdate", method=RequestMethod.POST)
	public ResponseEntity<String> normalOffUpdate(@RequestBody NormalOffVO vo){
		ResponseEntity<String> entity = null;
		
		try {
			noService.update(vo);
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<String>("no", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/fixOffGetAll", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> fixOffGetAll(@RequestBody Map<String, String> info) throws ParseException{
		 SearchCriteriaRR cri = new SearchCriteriaRR();
		 
		 if(info.size() == 0){
				System.out.println("empty");
				System.out.println(info);
			}else{
				cri.setPage(Integer.parseInt(info.get("page")));
				cri.setPerPageNum(Integer.parseInt(info.get("perPageNum")));
				cri.setKeyword1(info.get("keyword1"));
				cri.setKeyword2(info.get("keyword2"));
				cri.setKeyword3(info.get("keyword3"));
				cri.setKeyword4(info.get("keyword4"));
			}
		
		
		ResponseEntity<Map<String, Object>> entity = null;
		HashMap<String, Object> map = new HashMap<>();
		
		Calendar now = new GregorianCalendar();
		int year = now.get(now.YEAR);
		String month = now.get(now.MONTH)+1+"";
		if(Integer.parseInt(month)<10){
			month = "0"+month;
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date cDate = sdf.parse(year+"-"+month+"-01");
		now.setTime(cDate);
		int lastDate = now.getActualMaximum(now.DAY_OF_MONTH);
		System.out.println(cri);
		try {
			if(cri.getKeyword1() == null){
				cri.setKeyword1(year+"-"+month+"-01");
			}
			if(cri.getKeyword2() == null){
				cri.setKeyword2(year+"-"+month+"-"+lastDate);
			}else{
				if(cri.getKeyword2().length() <= 7){
				cDate = sdf.parse(cri.getKeyword1());
				now.setTime(cDate);
				lastDate = now.getActualMaximum(now.DAY_OF_MONTH);
				cri.setKeyword2(cri.getKeyword2()+"-"+lastDate);
				}
				
				System.out.println("set cri value= "+cri.getKeyword2()+"\n"+ cri.getKeyword2().length());
			}
			if(cri.getKeyword3() == null){
				cri.setKeyword3("");
			}
			if(cri.getKeyword4() == null){
				cri.setKeyword4("");
			}
			
			System.out.println(cri);
			List<FixOffVO> list = foService.listSearch(cri);
			
			PageMakerRR pageMaker = new PageMakerRR();
			pageMaker.setCri(cri);
			pageMaker.makeSearch(cri.getPage());
			pageMaker.setTotalCount(foService.listSearchCount(cri));
			
			map.put("list", list);
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return entity;
	}
	
	@RequestMapping(value="/fixOffGetByNo/{no}", method=RequestMethod.GET)
	public ResponseEntity<FixOffVO> fixOffGetByNo(@PathVariable("no") int no){
		ResponseEntity<FixOffVO> entity = null;
		try {
			FixOffVO vo = foService.selectByNo(no);
			
			entity = new ResponseEntity<FixOffVO>(vo, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<FixOffVO>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/selectFixOffByDate/{date}", method=RequestMethod.GET)
	public ResponseEntity<List<FixOffVO>> fixOffSelectByDate(@PathVariable("date") String date){
		ResponseEntity<List<FixOffVO>> entity = null;
		DayGetUtil dgu= new DayGetUtil();
		OffData offdata = new OffData();
		String[] str = date.split("-");
		try {
			offdata.setDow(dgu.getDay(date));
			offdata.setYearmonth(str[0]+"-"+str[1]);
			offdata.setSelect_date(date);
			
			List<FixOffVO> list = foService.selectByDate(offdata);
			entity = new ResponseEntity<List<FixOffVO>>(list, HttpStatus.OK);
		} catch (ParseException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return entity;
	}
	
	@RequestMapping(value="/selectFixOffByWeek/{week}/{eno}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> fixOffSelectByWeek(@PathVariable("week") List<String> week, @PathVariable("eno") int eno){
		ResponseEntity<Map<String, Object>> entity = null;
		
		HashMap<String, Object> map = new HashMap<>();
		DayGetUtil dgu= new DayGetUtil();
		OffData offdata = new OffData();
		offdata.setEno(eno);
		String[] str;
		
		try {
			for(int i=1; i<week.size(); i++){
				offdata.setDow(dgu.getDay(week.get(i)));
				str = week.get(i).split("-");
				offdata.setYearmonth(str[0]+"-"+str[1]);
				offdata.setSelect_date(week.get(i));
				List<FixOffVO> list=foService.selectByEnoDate(offdata);
				if(list.size() != 0){
					map.put(week.get(i), list);
				}
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/fixOffRegister", method=RequestMethod.POST)
	public ResponseEntity<String> fixOffRegister(@RequestBody FixOffVO vo){
		ResponseEntity<String> entity = null;
		try {
			foService.register(vo);
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<String>("no", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/fixOffUpdate", method=RequestMethod.POST)
	public ResponseEntity<String> fixOffUpdate(@RequestBody FixOffVO vo){
		ResponseEntity<String> entity = null;
		System.out.println("받은 vo= \n"+vo);
		try {
			foService.update(vo);
			entity = new ResponseEntity<String>("ok", HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			entity = new ResponseEntity<String>("no", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/smsView", method=RequestMethod.GET)
	public String smsview(Model model){
		
		List<SmsTemplateVO> list = smsService.selectAll();
		
		model.addAttribute("smsClinic", list.get(1));
		model.addAttribute("smsTherapy", list.get(0));
		
		return "sub/smsView";
	}
	
	@RequestMapping(value="/smsGetByNo/{no}", method=RequestMethod.GET)
	public ResponseEntity<SmsTemplateVO> smsview(@PathVariable("no") int no){
		ResponseEntity<SmsTemplateVO> entity = null;
		try {
			SmsTemplateVO vo = smsService.selectOne(no);
			entity = new ResponseEntity<SmsTemplateVO>(vo, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return entity;
	}
	
	@RequestMapping(value="/smsUpdate", method=RequestMethod.POST)
	public String smsUpdate(Model model, SmsTemplateVO vo){
		
		try {
			smsService.update(vo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		List<SmsTemplateVO> list = smsService.selectAll();
		
		model.addAttribute("smsClinic", list.get(1));
		model.addAttribute("smsTherapy", list.get(0));
		return "sub/smsView";
	}
	
	@RequestMapping(value="/smsSend", method=RequestMethod.POST)
	public ResponseEntity<String> sendSMS(SmsRecordVO vo){
		logger.info("sms send Post");
		System.out.println(vo);
		ResponseEntity<String> resentity = null;

		try{
			
			final String encodingType = "utf-8";
			final String boundary = "____boundary____";
		
			/**************** 문자전송하기 예제 ******************/
			/* "result_code":결과코드,"message":결과문구, */
			/* "msg_id":메세지ID,"error_cnt":에러갯수,"success_cnt":성공갯수 */
			/* 동일내용 > 전송용 입니다.  
			/******************** 인증정보 ********************/
			String sms_url = "https://apis.aligo.in/send/"; // 전송요청 URL
			
			Map<String, String> sms = new HashMap<String, String>();
			
			sms.put("user_id", "1clinic"); // SMS 아이디
			sms.put("key", "dxlaks0vqpw6579w9nuy20a3j1jnpj5s"); //인증키
			
			// dxlaks0vqpw6579w9nuy20a3j1jnpj5s 원마취통증 인증키
			/******************** 인증정보 ********************/
			
			/******************** 전송정보 ********************/
			sms.put("msg", vo.getContent()); // 메세지 내용
			sms.put("receiver", vo.getPhone()); // 수신번호
			sms.put("destination", "01111111111|담당자,01111111112|홍길동"); // 수신인 %고객명% 치환
			sms.put("sender", ""); // 발신번호
			sms.put("rdate", ""); // 예약일자 - 20161004 : 2016-10-04일기준
			sms.put("rtime", ""); // 예약시간 - 1930 : 오후 7시30분
			sms.put("testmode_yn", "Y"); // Y 인경우 실제문자 전송X , 자동취소(환불) 처리
			sms.put("title", "제목입력"); //  LMS, MMS 제목 (미입력시 본문중 44Byte 또는 엔터 구분자 첫라인)
			
			String image = "";
			//image = "/tmp/pic_57f358af08cf7_sms_.jpg"; // MMS 이미지 파일 위치
			
			/******************** 전송정보 ********************/
			
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			
			builder.setBoundary(boundary);
			builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
			builder.setCharset(Charset.forName(encodingType));
			
			for(Iterator<String> i = sms.keySet().iterator(); i.hasNext();){
				String key = i.next();
				builder.addTextBody(key, sms.get(key)
						, ContentType.create("Multipart/related", encodingType));
			}
			
			File imageFile = new File(image);
			if(image!=null && image.length()>0 && imageFile.exists()){
		
				builder.addPart("image",
						new FileBody(imageFile, ContentType.create("application/octet-stream"),
								URLEncoder.encode(imageFile.getName(), encodingType)));
			}
			
			HttpEntity entity = builder.build();
			
			HttpClient client = HttpClients.createDefault();
			HttpPost post = new HttpPost(sms_url);
			post.setEntity(entity);
			
			HttpResponse res = client.execute(post);
			
			String result = "";
			if(res != null){
				BufferedReader in = new BufferedReader(new InputStreamReader(res.getEntity().getContent(), encodingType));
				String buffer = null;
				while((buffer = in.readLine())!=null){
					result += buffer;
				}
				in.close();
			}
			
			System.out.println(result);
			if(result.contains("\"success_cnt\":1")){
				smsrService.register(vo);
				SmsRemainGet srg = new SmsRemainGet();
				System.out.println(srg.smsRemain());
				resentity = new ResponseEntity<String>(srg.smsRemain(), HttpStatus.OK);
			}else{
				resentity = new ResponseEntity<String>("no", HttpStatus.OK);
			}
			
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return resentity;
	}
	
	@RequestMapping(value="/sms_remain")
	public ResponseEntity<Map<String, String>> smsRemain(){
		ResponseEntity<Map<String, String>> entity = null;
		Map<String, String> map = new  HashMap<String, String>();
		try{

			/**************** 최근 전송 목록 ******************/
			/* "result_code":결과코드,"message":결과문구, */
			/** list : 전송된 목록 배열 ***/
			/******************** 인증정보 ********************/
			String sms_url = "https://apis.aligo.in/remain/"; // 전송요청 URL
			
			String sms = "";
			sms += "user_id=" + "1clinic"; // SMS 아이디 
			sms += "&key=" + "dxlaks0vqpw6579w9nuy20a3j1jnpj5s"; //인증키
			
			//dxlaks0vqpw6579w9nuy20a3j1jnpj5s 원마취통증인증키
			
			/******************** 인증정보 ********************/
			
			URL url = new URL(sms_url);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			
			OutputStream os = conn.getOutputStream();
			os.write(sms.getBytes());
			os.flush();
			os.close();
			
			String result = "";
			String buffer = null;
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			
			while((buffer = in.readLine())!=null){
				result += buffer;
			}
			
			in.close();
			
			System.out.println("잔여 결과값: "+result);
			String[] splitRes = result.split(",");
			for(int i=0; i< splitRes.length; i++){
				System.out.println(splitRes[i]);
			}
			map.put("sms", splitRes[2].split(":")[1]);
			map.put("lms", splitRes[3].split(":")[1]);
			
			System.out.println(map);
			entity = new ResponseEntity<Map<String, String>>(map, HttpStatus.OK);

		}catch(MalformedURLException e1){
			System.out.println(e1.getMessage());
		}catch(IOException e2){
			System.out.println(e2.getMessage());
		}
		return entity;
	}
	
	@RequestMapping(value="/smsRecordGetAll", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> smsRecordGetAll(@RequestBody Map<String, String> info){
		logger.info("sms record get All");
		SearchCriteria cri = new SearchCriteria();
		
		if(info.size() == 0){
			System.out.println("empty");
			System.out.println(info);
		}else{
			cri.setPage(Integer.parseInt(info.get("page")));
			cri.setPerPageNum(Integer.parseInt(info.get("perPageNum")));
			cri.setSearchType(info.get("searchType"));
			cri.setKeyword(info.get("keyword"));
		}
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<>();
		System.out.println(cri.getPage());
		if(cri.getKeyword() == null){
			cri.setKeyword("");
		}
		try {
			List<SmsRecordVO> list = smsrService.listSearch(cri);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.makeSearch(cri.getPage());
			pageMaker.setTotalCount(smsrService.listSearchCount(cri));
			
			map.put("list", list);
			map.put("pageMaker", pageMaker);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return entity;
	}
}
