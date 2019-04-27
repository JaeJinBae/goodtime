package com.webaid.util;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.webaid.domain.ClinicVO;
import com.webaid.domain.FixTherapyReservationVO;
import com.webaid.domain.NormalTherapyReservationVO;

public class ExcelDown{

	
	public void excelDown(int eno, String ename, String date, Map<String, Object> list, HttpServletResponse response) throws IOException {
		System.out.println("엑셀다운 Util 진입");
		int year = Integer.parseInt(date.split("-")[0]);
		int month = Integer.parseInt(date.split("-")[1])-1;

		Calendar cal = Calendar.getInstance();
		cal.set(year, month, 1);
		int lastDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		List<NormalTherapyReservationVO> ntrList = (List<NormalTherapyReservationVO>) list.get("ntrList");
		List<FixTherapyReservationVO> ftrList = (List<FixTherapyReservationVO>) list.get("ftrList");
		List<ClinicVO> clinicList = (List<ClinicVO>) list.get("clinicList");
		
		Collections.sort(ntrList);
		Collections.sort(ftrList);
		
		//엑셀에 환자명 넣기 위해 환자이름-차트번호 비교해서 중복제거
		ArrayList<String> pnoList = new ArrayList<String>();
		ArrayList<String> pList = new ArrayList<String>();
		for(int i=0; i<ntrList.size(); i++){
			pnoList.add(ntrList.get(i).getPname()+"-"+ntrList.get(i).getChart_no());
		}
		for(int i=0; i<ftrList.size(); i++){
			pnoList.add(ftrList.get(i).getPname()+"-"+ftrList.get(i).getChart_no());
		}
		
		for(int i=0; i< pnoList.size(); i++){
			if(!pList.contains(pnoList.get(i))){
				pList.add(pnoList.get(i));
			}
		}
		//환자명 가나다 순으로 정렬
		Collections.sort(pList);
		
		try {
			XSSFWorkbook objWorkBook = new XSSFWorkbook();
			XSSFSheet objSheet = null;
			XSSFRow objRow = null;
			XSSFCell objCell = null;

			objSheet = objWorkBook.createSheet("TestSheet");

			objRow = objSheet.createRow(0);

			objCell = objRow.createCell(0);
			objCell.setCellValue(ename+" 치료사 "+year+"년"+(month+1)+"월"+"통계");
			
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
			
			//순번, 환자명, 차트번호 엑셀에 입력
			String[] strArr;
			for (int i=0; i<pList.size(); i++) {
				strArr = pList.get(i).split("-");
				
				objRow = objSheet.createRow(i+2);

				objCell = objRow.createCell(0);
				objCell.setCellValue(i+1);

				objCell = objRow.createCell(1);
				objCell.setCellValue(strArr[0]);

				objCell = objRow.createCell(2);
				objCell.setCellValue(strArr[1]);
				
				for(int j=3; j<lastDate+3; j++){
					objRow.createCell(j);
				}
			}
			
			//환자별 날짜에 받은 치료 입력
			String selectCell;
			for(int i=0;i<pList.size(); i++){
				objRow = objSheet.getRow(i+2);
				selectCell = objRow.getCell(2).getStringCellValue();
				for(int j=0;j<ntrList.size(); j++){
					if(selectCell.equals(ntrList.get(j).getChart_no()+"")){
						int idx = Integer.parseInt(ntrList.get(j).getRdate().split("-")[2]);
						
						objRow.getCell(idx+2).setCellValue(ntrList.get(j).getClinic_name());
					}
				}
				for(int j=0;j<ftrList.size(); j++){
					if(selectCell.equals(ftrList.get(j).getChart_no()+"")){
						int idx = Integer.parseInt(ftrList.get(j).getRdate().split("-")[2]);
						
						objRow.getCell(idx+2).setCellValue(ftrList.get(j).getClinic_name());
					}
				}
			}
			
			objRow = objSheet.createRow(objSheet.getLastRowNum()+1);
			objRow.createCell(0).setCellValue("Total");
			objSheet.addMergedRegion(new CellRangeAddress(objRow.getRowNum(), objRow.getRowNum(), 0, 2));
			
			String sCell;
			String eCell;
			int eRowNum = objSheet.getLastRowNum()-1;//치료종류별 현황에 반복문에 쓰려고 미리 생성
			//날짜별 치료 합계
			for(int i=3; i<objSheet.getRow(1).getLastCellNum(); i++){
				sCell = objSheet.getRow(2).getCell(i).getReference();
				eCell = objSheet.getRow(eRowNum).getCell(i).getReference();
				objRow.createCell(i).setCellFormula("COUNTA("+sCell+":"+eCell+")");
			}
			
			//치료 종류별 현황 제목
			objRow = objSheet.createRow(objSheet.getLastRowNum()+2); 
			objCell = objRow.createCell(0);
			objCell.setCellValue("치료 종류별 현황");
			objSheet.addMergedRegion(new CellRangeAddress(objRow.getRowNum(), objRow.getRowNum(), 0, 2));
			
			
			//치료 종류별 현황 내용
			objRow = objSheet.createRow(objSheet.getLastRowNum()+1);
			objRow.createCell(0).setCellValue("번호");
			objRow.createCell(1).setCellValue("치료명");
			objRow.createCell(2).setCellValue("Total");
			
			for(int i=0; i<clinicList.size(); i++){
				objRow = objSheet.createRow(objSheet.getLastRowNum()+1);
				objRow.createCell(0).setCellValue(i+1);
				objRow.createCell(1).setCellValue(clinicList.get(i).getCode_name());
				objRow.createCell(2);
				for(int j=3; j<objSheet.getRow(1).getLastCellNum(); j++){
					sCell = objSheet.getRow(2).getCell(j).getReference();
					eCell = objSheet.getRow(eRowNum).getCell(j).getReference();
					objRow.createCell(j).setCellFormula("COUNTIF("+sCell+":"+eCell+",\""+clinicList.get(i).getCode_name()+"\")");	
				}
			}
			
			
			response.setContentType("Application/Msexcel");
			response.setHeader("Content-Disposition",
					"ATTachment; Filename=" + URLEncoder.encode("통계_"+ename+"치료사_" +year+"년"+(month+1)+"월", "UTF-8") + ".xlsx");

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
