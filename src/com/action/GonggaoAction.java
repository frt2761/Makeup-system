package com.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.model.*;
import com.service.*;
import com.util.*;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
//导入导出

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

@Controller
public class GonggaoAction {
	@Autowired
	private GonggaoService gonggaoService;
	@Autowired
	private GgtypeService ggtypeService;

	/***上传导入开始***/
	private InputStream excelFile;

	public InputStream getExcelFile() {
		return excelFile;
	}
	/***上传导入结束***/

	@RequestMapping("/getGonggaos")
	public void getGonggaos(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String page = (String) request.getParameter("page");
		String rows = (String) request.getParameter("rows");
		String gonggaoName = (String) request.getParameter("gonggaoName");
		String gonggaoId = (String) request.getParameter("gonggaoId");
		String ggtypeId = (String) request.getParameter("ggtypeId");
		String sdate = (String) request.getParameter("sdate");
		String edate = (String) request.getParameter("edate");
		PageBean pageBean = null;
		if ((StringUtil.isNotEmpty(page))&&(!page.equals("null"))) {
			pageBean = new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}else{
			pageBean = new PageBean(0,0);
		}
		Gonggao gonggao = new Gonggao();
		try {
			if (StringUtil.isNotEmpty(gonggaoName)) {
				gonggao.setGonggaoName(gonggaoName);
			}
			if (StringUtil.isNotEmpty(gonggaoId)) {
				gonggao.setGonggaoId(Integer.parseInt(gonggaoId));
			}
			if (StringUtil.isNotEmpty(ggtypeId)) {
				gonggao.setGgtypeId(Integer.parseInt(ggtypeId));
			}
			JSONArray jsonArray = JSONArray.fromObject(gonggaoService.queryGonggaos(
					gonggao, pageBean.getStart(), pageBean.getRows(), sdate, edate));
			JSONObject result = new JSONObject();
			int total = gonggaoService.queryGonggaos(gonggao, 0, 0, sdate, edate).size();
			result.put("rows", jsonArray);
			result.put("total", total);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/addGonggao")
	public void addGonggao(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		JSONObject result = new JSONObject();
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String gonggaoName = (String) request.getParameter("gonggaoName");
		String gonggaoMark = (String) request.getParameter("gonggaoMark");
		String gonggaoDate = (String) request.getParameter("gonggaoDate");
		String ggtypeId = (String) request.getParameter("ggtypeId");
		String gonggaoId = (String) request.getParameter("gonggaoId");
		Gonggao gonggao = new Gonggao();

		if (StringUtil.isNotEmpty(gonggaoId)) {
			gonggao = gonggaoService.getGonggao(Integer.parseInt(gonggaoId));
		}
		if (StringUtil.isNotEmpty(gonggaoName)) {
			gonggao.setGonggaoName(gonggaoName);
		}
		if (StringUtil.isNotEmpty(gonggaoMark)) {
			gonggao.setGonggaoMark(gonggaoMark);
		}
		if (StringUtil.isNotEmpty(gonggaoDate)) {
			gonggao.setGonggaoDate(DateUtil.formatString(gonggaoDate,
					"yyyy-MM-dd HH:mm:ss"));
		}
		if (StringUtil.isNotEmpty(ggtypeId)) {
			gonggao.setGgtypeId(Integer.parseInt(ggtypeId));
			Ggtype ggtype = new Ggtype();
			ggtype = ggtypeService.getGgtype(Integer.parseInt(ggtypeId));
			gonggao.setGgtypeName(ggtype.getGgtypeName());
		}
		try {
			if (StringUtil.isNotEmpty(gonggaoId)) {
				Date date = new Date();
				gonggao.setGonggaoDate(date);
				gonggaoService.modifyGonggao(gonggao);
				result.put("success", "true");
				ResponseUtil.write(response, result);
			} else {
				Date date = new Date();
				gonggao.setGonggaoDate(date);
				gonggaoService.save(gonggao);
				result.put("success", "true");
				ResponseUtil.write(response, result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/deleteGonggao")
	public void deleteGonggao(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		JSONObject result = new JSONObject();
		String delIds = (String) request.getParameter("delIds");
		try {
			String str[] = delIds.split(",");
			for (int i = 0; i < str.length; i++) {
				gonggaoService.deleteGonggao(Integer.parseInt(str[i]));
			}
			result.put("success", "true");
			result.put("delNums", str.length);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/gonggaoComboList")
	public void gonggaoComboList(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String ggtypeId = (String) request.getParameter("ggtypeId");
		Gonggao gonggao = new Gonggao();
		if (StringUtil.isNotEmpty(ggtypeId)) {
			gonggao.setGgtypeId(Integer.parseInt(ggtypeId));
		}
		try {
			JSONArray jsonArray = new JSONArray();
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", "");
			jsonObject.put("gonggaoName", "请选择...");
			jsonArray.add(jsonObject);
			jsonArray.addAll(JSONArray.fromObject(gonggaoService.queryGonggaos(gonggao, 0, 0, null, null)));
			ResponseUtil.write(response, jsonArray);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/gonggaoTongji")
	public void gonggaoTongji(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String sdate=request.getParameter("sdate");
		String edate=request.getParameter("edate");
		List<Integer> ggtypeIds = new ArrayList<Integer>();
		List<String> ggtypeNames = new ArrayList<String>();
		List<Integer> gonggaoZongshus = new ArrayList<Integer>();
		List<Ggtype> ggtypes = new ArrayList<Ggtype>();
		List<Gonggao> gonggaos = new ArrayList<Gonggao>();
		Gonggao gonggao = new Gonggao();
		Integer zongshu = 0;
		try {
			ggtypes = ggtypeService.queryGgtypes(null, 0,0);
			for(int i=0;i<ggtypes.size();i++){
				ggtypeIds.add(ggtypes.get(i).getGgtypeId());
				ggtypeNames.add(ggtypes.get(i).getGgtypeName());
			}
			for(int i=0;i<ggtypeIds.size();i++){
				Integer gonggaoZongshu = 0;
				gonggao.setGgtypeId(ggtypeIds.get(i));
				gonggaos = gonggaoService.queryGonggaos(gonggao, 0, 0, sdate, edate);
				for(int j=0;j<gonggaos.size();j++){
					gonggaoZongshu = gonggaoZongshu + gonggaos.size();
				}
				zongshu = zongshu + gonggaoZongshu;
				gonggaoZongshus.add(gonggaoZongshu);
			}
			
			HttpSession session = request.getSession();
			session.setAttribute("ggtypeNames", ggtypeNames);
			session.setAttribute("gonggaoZongshus", gonggaoZongshus);
			session.setAttribute("zongshu", zongshu);
			response.sendRedirect("admin/gonggaotongji.jsp");	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/shangchuanGonggao")
	public void shangchuanGonggao(HttpServletRequest request, HttpServletResponse response,MultipartFile uploadFile)
			throws Exception {
		try {
			String gonggaoId = (String) request.getParameter("gonggaoId");
			String directory = "//WebRoot//WEB-INF//classes//static//file";
			String targetDirectory = System.getProperty("user.dir") + directory;
	        String fileName = uploadFile.getOriginalFilename();  
	        String sname = fileName.substring(fileName.lastIndexOf("."));
	        fileName = System.currentTimeMillis() + sname;
			File dir = new File(targetDirectory,fileName); 
			
	        //MultipartFile自带的解析方法
	        uploadFile.transferTo(dir);

			String shangchuandizhi = "file" + "/" + fileName;
			String shangchuanname = fileName;
			Gonggao gonggao = gonggaoService.getGonggao(Integer.parseInt(gonggaoId));
			gonggao.setGonggaoImg(shangchuandizhi);
			gonggao.setGonggaoImgName(shangchuanname);
			gonggaoService.modifyGonggao(gonggao);
			JSONObject result = new JSONObject();
			result.put("success", "true");
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
