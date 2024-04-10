package com.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class DataSheet {

	/***
	 * 获取设置信息
	 */
	public static List<List<String>> dataShezhi(String databaseName)
			throws Exception {
		try {
			List<List<String>> list = new ArrayList<List<String>>();
			List<String> rowList;
			// TODO Auto-generated method stub
			Class.forName("com.mysql.jdbc.Driver");

			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://127.0.0.1:3306/" + databaseName
							+ "?useUnicode=true&characterEncoding=utf8",
					"root", "root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from t_jcpeizhi");

			if (rs.next()) {
				rowList = new ArrayList<String>();
				rowList.add("BumenBieming");
				rowList.add(rs.getString(5));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("BuyuanBieming");
				rowList.add(rs.getString(6));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("BuzhiBieming");
				rowList.add(rs.getString(7));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("UserBieming");
				rowList.add(rs.getString(8));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("UxtypeBieming");
				rowList.add(rs.getString(9));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("UxinxiBieming");
				rowList.add(rs.getString(10));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("UyijianBieming");
				rowList.add(rs.getString(11));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("RoleBieming");
				rowList.add(rs.getString(12));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("ByumenBieming");
				rowList.add(rs.getString(13));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("ByuyuanBieming");
				rowList.add(rs.getString(14));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("ByuzhiBieming");
				rowList.add(rs.getString(15));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("YonghuBieming");
				rowList.add(rs.getString(16));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("YxtypeBieming");
				rowList.add(rs.getString(17));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("YxinxiBieming");
				rowList.add(rs.getString(18));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("YyijianBieming");
				rowList.add(rs.getString(19));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("YhroleBieming");
				rowList.add(rs.getString(20));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("GgtypeBieming");
				rowList.add(rs.getString(21));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("GonggaoBieming");
				rowList.add(rs.getString(22));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("GgpinglunBieming");
				rowList.add(rs.getString(23));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("ShujuBieming");
				rowList.add(rs.getString(24));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("SjduochuBieming");
				rowList.add(rs.getString(25));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("SjjianchuBieming");
				rowList.add(rs.getString(26));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("SjlaiyuanBieming");
				rowList.add(rs.getString(27));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("SjleixingBieming");
				rowList.add(rs.getString(28));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("SjpinglunBieming");
				rowList.add(rs.getString(29));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("SjqitaBieming");
				rowList.add(rs.getString(30));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("SjshaochuBieming");
				rowList.add(rs.getString(31));
				list.add(rowList);
				rowList = new ArrayList<String>();
				rowList.add("SjxingtaiBieming");
				rowList.add(rs.getString(32));
				list.add(rowList);
			}
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	/**
	 * 递归读取文件路径下的所有文件
	 * 
	 * @param path
	 * @param fileNameList
	 * @return
	 */
	public static List<String> readFiles(String path, List<String> fileNameList) {
		File file = new File(path);
		if (file.isDirectory()) {
			File[] files = file.listFiles();
			for (int i = 1; i < files.length; i++) {
				if (files[i].isDirectory()) {
					readFiles(files[i].getPath(), fileNameList);
				} else {
					String path1 = files[i].getPath();
					String fileName = path1
							.substring(path1.lastIndexOf("\\") + 1);
					fileNameList.add(fileName);
				}
			}
		} else {
			String path1 = file.getPath();
			String fileName = path1.substring(path1.lastIndexOf("\\") + 1);
			fileNameList.add(fileName);
		}
		return fileNameList;
	}

	/****
	 * 读取文件
	 */
	public static String readFile(String fileName) {
		String output = "";
		File file = new File(fileName);
		if (file.exists()) {
			if (file.isFile()) {
				try {
					BufferedReader input = new BufferedReader(new FileReader(
							file));
					StringBuffer buffer = new StringBuffer();
					String text;
					while ((text = input.readLine()) != null)
						buffer.append(text + "/n");
					output = buffer.toString();
				} catch (IOException ioException) {
					System.err.println("File Error!");
				}
			} else if (file.isDirectory()) {
				String[] dir = file.list();
				output += "Directory contents:/n";

				for (int i = 0; i < dir.length; i++) {
					output += dir[i] + "/n";
				}
			}
		} else {
			System.err.println("Does not exist!");
		}
		return output;
	}

	/***
	 * 截取页面内容
	 */
	public static String yemianXinxi(String fileNeirong){
		String biaogetouString = fileNeirong.substring(fileNeirong.indexOf("<table id=")+22, fileNeirong.indexOf("</table>")-9);
		return biaogetouString;
	}

	/***
	 * 替换页面内容
	 */
	public static String tihuanYemianXinxi(List<List<String>> tableNames,String fileNeirong){
		for (int i = 0; i < tableNames.size(); i++) {
			List<String> list = tableNames.get(i);
			String tiString = list.get(1);
			if(StringUtil.isNotEmpty(tiString)){
				String yuanString = list.get(0);
				String yuanString0 = "<%=newJcpeizhi.get" + yuanString + "()%>";
				String yuanString1 = "<%=newJcpeizhi.get" + yuanString + "() %>";
				fileNeirong = fileNeirong.replace(yuanString0,tiString);
				fileNeirong = fileNeirong.replace(yuanString1,tiString);
			}
		}
		return fileNeirong;
	}

	/***
	 * 提取关键内容
	 * 1、表名和意思
	 * 2、字段和意思
	 * 返回List<List<String>>
	 */
	public static List<List<String>> tiquXinxi(String fileNeirong){
		List<List<String>> list = new ArrayList<List<String>>();
		List<String> rowList0 = new ArrayList<String>();
		String biaoyisi = fileNeirong.substring(0, fileNeirong.indexOf("\" class=\"easyui-datagrid\""));
		//System.out.println(biaoyisi);
		//String biaoming = fileNeirong.substring(fileNeirong.indexOf("pagination=\"true\"")+29, fileNeirong.indexOf("s\" fit="));
		//biaoming = biaoming.toLowerCase();
		//biaoming = "t_"+biaoming;
		//System.out.println(biaoming);
		//rowList.add(biaoming);
		//rowList.add(biaoyisi);
		//list.add(rowList);
		Pattern compile = Pattern.compile("field=\"");//创建切割对象,将以"field=""切割字符串
		String[] split = compile.split(fileNeirong);//执行切割,获得字符串数组
		//System.out.println(fileNeirong);
		List<String> ziduanList = new ArrayList<String>();//创建集合用来装最终的字段名和意思
		for (int i = 1; i < split.length; i++) {
			String s1 = split[i];
		    if (s1.indexOf("cb")==-1) {
		    	List<String> rowList = new ArrayList<String>();
			    String result = s1.substring(0,s1.indexOf("</th>"));
			    ziduanList.add(result);
			    String ziduanming = result.substring(0, result.indexOf("\" width"));
			    if(i==2){
			    	String biaoming = ziduanming.substring(0, result.indexOf("Id"));
					biaoming = "t_"+biaoming;
					rowList0.add(biaoming);
					rowList0.add(biaoyisi);
					list.add(rowList0);
			    }
			    rowList.add(ziduanming);
				//System.out.println(ziduanming);
			    if(ziduanming.contains("Name")){
			    	rowList.add("varchar(20)");
			    }else if(ziduanming.contains("Mark")){
			    	rowList.add("varchar(20)");
			    }else if(ziduanming.contains("Img")){
			    	rowList.add("varchar(20)");
			    }else if(ziduanming.contains("Double")){
			    	rowList.add("double");
			    }else if(ziduanming.contains("Date")){
			    	rowList.add("datetime");
			    }else{
			    	rowList.add("int(3)");
			    }
			    if(i==2){
				    rowList.add("是");
			    }else{
				    rowList.add("否");
			    }
			    String ziduanyisi = result.substring(result.indexOf(">")+1);
			    ziduanyisi = ziduanyisi.replace("编号","序号Id");
			    ziduanyisi = ziduanyisi.replace("查看","序号Id");
			    rowList.add(ziduanyisi);
				//System.out.println(ziduanyisi);
				list.add(rowList);
		    }
		}
		//System.out.println(ziduanList);
		//System.out.println(list);
		return list;
	}

	/***
	 * 生成Excel表
	 */
	public static boolean shengchengExcel(List<List<List<String>>> biaoxinxiLists,String lujing){
		//System.out.println(lujing);

		// 创建一个Excel文件
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 创建一个工作表
		HSSFSheet sheet = workbook.createSheet("表结构");
		// 设置单元格格式居中
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		int hangshu = 0;
		for (int i = 0; i < biaoxinxiLists.size(); i++) {
			List<List<String>> list = biaoxinxiLists.get(i);
			List<String> rowList0 = list.get(0);
			HSSFRow hssfRow = sheet.createRow(hangshu);
			// 头行
			HSSFCell cell = hssfRow.createCell(0);
			cell.setCellValue(rowList0.get(0));
			cell.setCellStyle(cellStyle);
			
			cell = hssfRow.createCell(1);
			cell.setCellValue(rowList0.get(1));
			cell.setCellStyle(cellStyle);
			
			hangshu = hangshu + 1;

			hssfRow = sheet.createRow(hangshu);
			HSSFCell headCell = hssfRow.createCell(0);
			headCell.setCellValue("字段名称");
			headCell.setCellStyle(cellStyle);

			headCell = hssfRow.createCell(1);
			headCell.setCellValue("数据类型");
			headCell.setCellStyle(cellStyle);

			headCell = hssfRow.createCell(2);
			headCell.setCellValue("主键");
			headCell.setCellStyle(cellStyle);

			headCell = hssfRow.createCell(3);
			headCell.setCellValue("备注");
			headCell.setCellStyle(cellStyle);
			
			for (int j = 1; j < list.size(); j++) {
				
				hangshu = hangshu + 1;
				
				List<String> rowList = list.get(j);
				hssfRow = sheet.createRow(hangshu);
				
				cell = hssfRow.createCell(0);
				cell.setCellValue(rowList.get(0));
				cell.setCellStyle(cellStyle);

				cell = hssfRow.createCell(1);
				cell.setCellValue(rowList.get(1));
				cell.setCellStyle(cellStyle);

				cell = hssfRow.createCell(2);
				cell.setCellValue(rowList.get(2));
				cell.setCellStyle(cellStyle);

				cell = hssfRow.createCell(3);
				cell.setCellValue(rowList.get(3));
				cell.setCellStyle(cellStyle);
			}			
			hangshu = hangshu + 2;		
		}

		// 保存Excel文件
		try {
			Date date = new Date();
			String strdate = DateUtil.formatDate(date, "yyyyMMddHHmmss");
			OutputStream outputStream = new FileOutputStream(lujing + "\\" + strdate + "表结构.xls");
			workbook.write(outputStream);
			outputStream.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 测试主函数
	public static void main(String args[]) throws Exception {
		String databaseName = "db_z0caizhuangs";
		List<List<String>> tableNames = dataShezhi(databaseName);
		//System.out.println(tableNames);
		// 获取路径
		File directory = new File("");// 参数为空
		// 获取admin的jsp文件路径
		String courseFile = directory.getCanonicalPath() + "\\src\\main\\webapp\\admin\\";
		//System.out.println(directory.getCanonicalPath());
		System.out.println(courseFile);
		List<String> fileNames = new ArrayList<String>();
		fileNames = readFiles(courseFile, fileNames);
		//System.out.println(fileNames);
		List<List<List<String>>> biaoxinxiLists = new ArrayList<List<List<String>>>();//所有的表信息
		for (int i = 0; i < fileNames.size(); i++) {
			// 获取jsp文件内容
			String fileNeirongi = readFile(courseFile+fileNames.get(i));
			//System.out.println(fileNeirong0);
			//去除bingzhuangtu和zhuzhuangtu
			if((!fileNeirongi.contains("bingzhuangtu"))&&(!fileNeirongi.contains("zhuzhuangtu"))){
				String fileNeirong = yemianXinxi(fileNeirongi);
				//System.out.println(fileNeirong);
				fileNeirong = tihuanYemianXinxi(tableNames,fileNeirong);
				//System.out.println(fileNeirong);
				List<List<String>> biaoxinxiList = tiquXinxi(fileNeirong);
				biaoxinxiLists.add(biaoxinxiList);
			}
		}
		for (int i = 0; i < biaoxinxiLists.size(); i++) {
			System.out.println(biaoxinxiLists.get(i));
		}
		if(shengchengExcel(biaoxinxiLists,directory.getCanonicalPath())){
			System.out.println("生成Excel表成功");
		}else{
			System.out.println("生成Excel表失败");
		}
	}
}