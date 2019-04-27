package com.webaid.util;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collector;

import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.synth.SynthSplitPaneUI;

import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

import com.webaid.domain.FixTherapyReservationVO;
import com.webaid.domain.NormalTherapyReservationVO;
import com.webaid.service.FixTherapyReservationService;
import com.webaid.service.NormalTherapyReservationService;

public class ExcelDown{
	@Autowired
	NormalTherapyReservationService ntrService;
	
	@Autowired
	FixTherapyReservationService ftrService;
	
	public void excelDown(int eno, String ename, String date, Map<String, Object> list, HttpServletResponse response) throws IOException {
		System.out.println("엑셀다운 Util 진입");
		int year = Integer.parseInt(date.split("-")[0]);
		int month = Integer.parseInt(date.split("-")[1])-1;
		String yearMonth = year+""+(month+1);
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, 1);
		int lastDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		List<NormalTherapyReservationVO> ntrList = (List<NormalTherapyReservationVO>) list.get("ntrList");
		for(int i=0; i<ntrList.size(); i++){
			System.out.println(ntrList.get(i));
		}
		System.out.println("=====================================");
		List<FixTherapyReservationVO> ftrList = (List<FixTherapyReservationVO>) list.get("ftrList");
		Collections.sort(ntrList);
		for(int i=0; i<ntrList.size(); i++){
			System.out.println(ntrList.get(i));
		}
		ArrayList<String> pnoList = new ArrayList<String>();
		ArrayList<String> pnoList2 = new ArrayList<String>();
		for(int i=0; i<ntrList.size(); i++){
			pnoList.add(ntrList.get(i).getPname()+"-"+ntrList.get(i).getChart_no());
		}
		for(int i=0; i<ftrList.size(); i++){
			pnoList.add(ftrList.get(i).getPname()+"-"+ftrList.get(i).getChart_no());
		}
		
		for(int i=0; i< pnoList.size(); i++){
			if(!pnoList2.contains(pnoList.get(i))){
				pnoList2.add(pnoList.get(i));
			}
		}
		Collections.sort(pnoList2);
		System.out.println(pnoList2);
		
		try {
			XSSFWorkbook objWorkBook = new XSSFWorkbook();
			XSSFSheet objSheet = null;
			XSSFRow objRow = null;
			XSSFCell objCell = null;

			objSheet = objWorkBook.createSheet("TestSheet");

			objRow = objSheet.createRow(0);

			objCell = objRow.createCell(0);
			objCell.setCellValue(ename+" 치료사 "+year+"년"+month+"월"+"통계");
			
			objRow.getSheet().addMergedRegion(new CellRangeAddress(0, 0, 0, 4));

			objRow = objSheet.createRow(1);

			// 행 높이 지정
			objRow.setHeight((short) 0x150);

			// 셀에 데이터 넣지
			objCell = objRow.createCell(0);
			objCell.setCellValue("번호");

			objCell = objRow.createCell(1);
			objCell.setCellValue("환자명");

			objCell = objRow.createCell(2);
			objCell.setCellValue("차트번호");
			
			for(int i=3; i<lastDate+3; i++){
				objCell = objRow.createCell(i);
				objCell.setCellValue(i-2+"일");
			}
			
			
			
			//선택한 행렬의 값 가져오기
			/*objRow=objSheet.getRow(1);
			objRow.getCell(3).getStringCellValue();*/
			String[] strArr;
			for (int i=0; i<pnoList2.size(); i++) {
				strArr = pnoList2.get(i).split("-");
				
				objRow = objSheet.createRow(i+2);

				objCell = objRow.createCell(0);
				objCell.setCellValue(i+1);

				objCell = objRow.createCell(1);
				objCell.setCellValue(strArr[0]);

				objCell = objRow.createCell(2);
				objCell.setCellValue(strArr[1]);
			}


			response.setContentType("Application/Msexcel");
			response.setHeader("Content-Disposition",
					"ATTachment; Filename=" + URLEncoder.encode("통계_"+ename+"치료사_" +year+"년"+month+"월", "UTF-8") + ".xlsx");

			OutputStream fileOut = response.getOutputStream();
			objWorkBook.write(fileOut);
			fileOut.close();

			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}
}
