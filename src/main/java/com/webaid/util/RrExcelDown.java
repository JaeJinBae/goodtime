package com.webaid.util;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.webaid.domain.ClinicVO;
import com.webaid.domain.FixTherapyReservationVO;
import com.webaid.domain.NormalTherapyReservationVO;
import com.webaid.domain.ReservationRecordVO;

public class RrExcelDown{

	
	public void excelDown(List<ReservationRecordVO> list, HttpServletResponse response) throws IOException {
		System.out.println("예약이력 엑셀다운 Util 진입");
		
		try {
			XSSFWorkbook objWorkBook = new XSSFWorkbook();
			XSSFSheet objSheet = null;
			XSSFRow objRow = null;
			XSSFCell objCell = null;
			XSSFCellStyle objStyle = objWorkBook.createCellStyle();
			objStyle.setAlignment(CellStyle.ALIGN_CENTER);
			
			objSheet = objWorkBook.createSheet("Sheet1");
			
			objRow = objSheet.createRow(0);

			objCell = objRow.createCell(0);
			objCell.setCellValue("환자명");
			objCell.setCellStyle(objStyle);
			objCell = objRow.createCell(1);
			objCell.setCellValue("담당자");
			objCell.setCellStyle(objStyle);
			objCell = objRow.createCell(2);
			objCell.setCellValue("분류");
			objCell.setCellStyle(objStyle);
			objCell = objRow.createCell(3);
			objCell.setCellValue("종류");
			objCell.setCellStyle(objStyle);
			objCell = objRow.createCell(4);
			objCell.setCellValue("예정일시");
			objCell.setCellStyle(objStyle);
			objCell = objRow.createCell(5);
			objCell.setCellValue("최초등록일시");
			objCell.setCellStyle(objStyle);
			objCell = objRow.createCell(6);
			objCell.setCellValue("접수일시");
			objCell.setCellStyle(objStyle);
			objCell = objRow.createCell(7);
			objCell.setCellValue("치료완료일시");
			objCell.setCellStyle(objStyle);
			objCell = objRow.createCell(8);
			objCell.setCellValue("예약메모");
			objCell.setCellStyle(objStyle);
			objCell = objRow.createCell(9);
			objCell.setCellValue("취소사유");
			objCell.setCellStyle(objStyle);
			
			for(int i=0; i<list.size(); i++){
				objRow = objSheet.createRow(i+1);
				objSheet.setColumnWidth(3, 15*256);
				objSheet.setColumnWidth(4, 16*256);
				objSheet.setColumnWidth(5, 25*256);
				objSheet.setColumnWidth(6, 35*256);
				objSheet.setColumnWidth(7, 25*256);
				objSheet.setColumnWidth(8, 25*256);
				objSheet.setColumnWidth(9, 25*256);
				
				// 행 높이 지
				objRow.setHeight((short) 0x150);

				// 셀에 데이터 넣지
				objCell = objRow.createCell(0);
				objCell.setCellValue(list.get(i).getPname());
				objCell.setCellStyle(objStyle);
				objCell = objRow.createCell(1);
				objCell.setCellValue(list.get(i).getEname());
				objCell.setCellStyle(objStyle);
				objCell = objRow.createCell(2);
				if(list.get(i).getRtype().equals("nt")){
					objCell.setCellValue("일반치료");
				}else if(list.get(i).getRtype().equals("nc")){
					objCell.setCellValue("일반진료");
				}else if(list.get(i).getRtype().equals("ft")){
					objCell.setCellValue("고정치료");
				}else if(list.get(i).getRtype().equals("fc")){
					objCell.setCellValue("고정진료");
				}
				
				objCell.setCellStyle(objStyle);
				objCell = objRow.createCell(3);
				objCell.setCellValue(list.get(i).getCname());
				objCell.setCellStyle(objStyle);
				objCell = objRow.createCell(4);
				objCell.setCellValue(list.get(i).getRdate());
				objCell.setCellStyle(objStyle);
				objCell = objRow.createCell(5);
				objCell.setCellValue(list.get(i).getRegister_info());
				objCell.setCellStyle(objStyle);
				objCell = objRow.createCell(6);
				objCell.setCellValue(list.get(i).getReception_info());
				objCell.setCellStyle(objStyle);
				objCell = objRow.createCell(7);
				objCell.setCellValue(list.get(i).getTherapy_info());
				objCell.setCellStyle(objStyle);
				objCell = objRow.createCell(8);
				objCell.setCellValue(list.get(i).getReception_memo());
				objCell.setCellStyle(objStyle);
				objCell = objRow.createCell(9);
				objCell.setCellValue(list.get(i).getResult_memo());
				objCell.setCellStyle(objStyle);
				
			}
			
			response.setContentType("Application/Msexcel");
			response.setHeader("Content-Disposition",
					"ATTachment; Filename=" + URLEncoder.encode("원마취통증의학과_예약이력", "UTF-8") + ".xlsx");

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
