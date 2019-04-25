package com.webaid.util;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelDown {
	
	public void excelDown(Map<String, Object> data, HttpServletResponse response) throws IOException {

		XSSFWorkbook objWorkBook = new XSSFWorkbook();
		XSSFSheet objSheet = null;
		XSSFRow objRow = null;
		XSSFCell objCell = null;

		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String nowDate = format.format(date);

		DateFormat format2 = DateFormat.getDateInstance(DateFormat.MEDIUM);

		objSheet = objWorkBook.createSheet("TestSheet");

		objRow = objSheet.createRow(0);

		// 행 높이 지정
		objRow.setHeight((short) 0x150);

		// 셀에 데이터 넣지
		objCell = objRow.createCell(0);
		objCell.setCellValue("아이디");

		objCell = objRow.createCell(1);
		objCell.setCellValue("비밀번호");

		objCell = objRow.createCell(2);
		objCell.setCellValue("이름");

		objCell = objRow.createCell(3);
		objCell.setCellValue("메일");

		objCell = objRow.createCell(4);
		objCell.setCellValue("등록일");

		//List<MemberVO> memberList = mService.selectAll();

		int index = 1;
		
		/*for (MemberVO vo : memberList) {

			objRow = objSheet.createRow(index);

			objCell = objRow.createCell(0);
			objCell.setCellValue(vo.getId());

			objCell = objRow.createCell(1);
			objCell.setCellValue(vo.getPw());

			objCell = objRow.createCell(2);
			objCell.setCellValue(vo.getName());

			objCell = objRow.createCell(3);
			objCell.setCellValue(vo.getMail());

			objCell = objRow.createCell(4);
			objCell.setCellValue(format2.format(vo.getRegdate()));

			index++;
		}

		for (int i = 0; i < memberList.size(); i++) {
			objSheet.autoSizeColumn(i);
		}*/

		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition",
				"ATTachment; Filename=" + URLEncoder.encode("관심고객현황_" + nowDate, "UTF-8") + ".xlsx");

		OutputStream fileOut = response.getOutputStream();
		objWorkBook.write(fileOut);
		fileOut.close();

		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
}
