package com.action;

import java.util.ArrayList;
import java.util.Arrays;
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
public class ShujuAction {
	@Autowired
	private ShujuService shujuService;
	@Autowired
	private SjleixingService sjleixingService;
	@Autowired
	private SjxingtaiService sjxingtaiService;
	@Autowired
	private UserService userService;
	@Autowired
	private BuzhiService buzhiService;
	@Autowired
	private BuyuanService buyuanService;

	/***上传导入开始***/
	private InputStream excelFile;

	public InputStream getExcelFile() {
		return excelFile;
	}
	/***上传导入结束***/

	@RequestMapping("/biaoqianShujus")
	public void biaoqianShujus(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String page = (String) request.getParameter("page");
		String rows = (String) request.getParameter("rows");
		String userId = (String) request.getParameter("userId");
		String sdate = (String) request.getParameter("sdate");
		String edate = (String) request.getParameter("edate");
		String sdate1 = (String) request.getParameter("sdate1");
		String edate1 = (String) request.getParameter("edate1");
		User user = userService.getUser(Integer.parseInt(userId));
		List<String> shujuIds = new ArrayList<String>();
		if(user.getUserType2()!=0){//协同过滤
			List<User> users = new ArrayList<User>();
			user = new User();
			user.setUserType2(1);
			users = userService.queryUsers(user, null, 0, 0, null, null, null, null);
			String[][] userLikeLists = new String[users.size()][];
			for (int i = 0; i < users.size(); i++) {
				userLikeLists[i] = users.get(i).getUserMark4().split(",");
			}
			shujuIds = CFUtils.CF_shujus(users.size(), userLikeLists, userId);
		}
		if(shujuIds.size()!=0){
			List<Shuju> shujus = new ArrayList<Shuju>();
			shujus = shujuService.queryShujus(null, 0, 0, null, null, null, null);
			List<Shuju> tuijianShujus = new ArrayList<Shuju>();
			List<Integer> quanbuIds = new ArrayList<Integer>();
			List<Integer> tuijianIds = new ArrayList<Integer>();
			for (int i = 0; i < shujus.size(); i++) {
				quanbuIds.add(shujus.get(i).getShujuId());
			}
			for (int i = 0; i < shujuIds.size(); i++) {
				if(quanbuIds.contains(Integer.parseInt(shujuIds.get(i)))){
					tuijianIds.add(Integer.parseInt(shujuIds.get(i)));
				}
			}
			if(tuijianIds.size()>0){
				for (int i = 0; i < tuijianIds.size(); i++) {
					tuijianShujus.add(shujuService.getShuju(tuijianIds.get(i)));
				}
			}else{
				tuijianShujus = ListSuiji.createRandomList(shujus, 6);
			}
			JSONArray jsonArray = JSONArray.fromObject(tuijianShujus);
			JSONObject result = new JSONObject();
			int total = tuijianShujus.size();
			result.put("rows", jsonArray);
			result.put("total", total);
			ResponseUtil.write(response, result);
		}else{
			PageBean pageBean = null;
			if ((StringUtil.isNotEmpty(page))&&(!page.equals("null"))) {
				pageBean = new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
			}else{
				pageBean = new PageBean(0,0);
			}
			try {
				List<String> buyuanNameList = new ArrayList<String>();
				if (StringUtil.isNotEmpty(userId)) {
					user = userService.getUser(Integer.parseInt(userId));
					String buyuanName = user.getBuyuanName();
					if (StringUtil.isNotEmpty(buyuanName)) {
						buyuanNameList = Arrays.asList(buyuanName.split(","));
					}
				}
				if (StringUtil.isNotEmpty(sdate1)) {
					Date date = new Date();
					sdate1 = DateUtil.formatDate(date, "yyyy-MM-dd HH:mm:ss");
				}
				if (StringUtil.isNotEmpty(edate1)) {
					Date date = new Date();
					edate1 = DateUtil.formatDate(date, "yyyy-MM-dd HH:mm:ss");
				}
				List<Shuju> shujus = new ArrayList<Shuju>();
				shujus = shujuService.queryShujus(null, 0, 0, null, null, null, null);
				List<Shuju> tuijianShujus = shujuService.selectBiaoqian(buyuanNameList, pageBean.getStart(), pageBean.getRows(), sdate, edate, sdate1, edate1);
				if(tuijianShujus.size()==0){
					tuijianShujus = ListSuiji.createRandomList(shujus, 6);
				}
				JSONArray jsonArray = JSONArray.fromObject(tuijianShujus);
				JSONObject result = new JSONObject();
				int total = tuijianShujus.size();
				result.put("rows", jsonArray);
				result.put("total", total);
				ResponseUtil.write(response, result);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@RequestMapping("/getShujus")
	public void getShujus(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String page = (String) request.getParameter("page");
		String rows = (String) request.getParameter("rows");
		String shujuName = (String) request.getParameter("shujuName");
		String shujuId = (String) request.getParameter("shujuId");
		String shujuType = (String) request.getParameter("shujuType");
		String shujuType1 = (String) request.getParameter("shujuType1");
		String sjleixingId = (String) request.getParameter("sjleixingId");
		String sjxingtaiId = (String) request.getParameter("sjxingtaiId");
		String shujuZong2 = (String) request.getParameter("shujuZong2");
		String yonghuId = (String) request.getParameter("yonghuId");
		String byumenId = (String) request.getParameter("byumenId");
		String byuyuanId = (String) request.getParameter("byuyuanId");
		String byuzhiId = (String) request.getParameter("byuzhiId");
		String userId = (String) request.getParameter("userId");
		String bumenId = (String) request.getParameter("bumenId");
		String buyuanId = (String) request.getParameter("buyuanId");
		String buzhiId = (String) request.getParameter("buzhiId");
		String sdate = (String) request.getParameter("sdate");
		String edate = (String) request.getParameter("edate");
		String sdate1 = (String) request.getParameter("sdate1");
		String edate1 = (String) request.getParameter("edate1");
		String shujuMark = (String) request.getParameter("shujuMark");
		String shujuMark1 = (String) request.getParameter("shujuMark1");
		String shujuMark2 = (String) request.getParameter("shujuMark2");
		String shujuMark3 = (String) request.getParameter("shujuMark3");
		String shujuDouble3 = (String) request.getParameter("shujuDouble3");
		String shujuDouble4 = (String) request.getParameter("shujuDouble4");
		Shuju shuju = new Shuju();
		PageBean pageBean = null;
		if ((StringUtil.isNotEmpty(page))&&(!page.equals("null"))) {
			pageBean = new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}else{
			pageBean = new PageBean(0,0);
		}
		try {
			if (StringUtil.isNotEmpty(shujuMark)) {
				shuju.setShujuMark(shujuMark);
			}
			if (StringUtil.isNotEmpty(shujuMark1)) {
				shuju.setShujuMark1(shujuMark1);
			}
			if (StringUtil.isNotEmpty(shujuMark2)) {
				shuju.setShujuMark2(shujuMark2);
			}
			if (StringUtil.isNotEmpty(shujuMark3)) {
				shuju.setShujuMark3(shujuMark3);
			}
			if (StringUtil.isNotEmpty(shujuDouble3)) {
				shuju.setShujuDouble3(Double.parseDouble(shujuDouble3));
			}
			if (StringUtil.isNotEmpty(shujuDouble4)) {
				shuju.setShujuDouble4(Double.parseDouble(shujuDouble4));
			}
			if (StringUtil.isNotEmpty(shujuName)) {
				shuju.setShujuName(shujuName);
			}
			if (StringUtil.isNotEmpty(shujuId)) {
				shuju.setShujuId(Integer.parseInt(shujuId));
			}
			if (StringUtil.isNotEmpty(shujuType)) {
				shuju.setShujuType(Integer.parseInt(shujuType));
			}
			if (StringUtil.isNotEmpty(shujuType1)) {
				shuju.setShujuType1(Integer.parseInt(shujuType1));
			}
			if (StringUtil.isNotEmpty(sjleixingId)) {
				shuju.setSjleixingId(Integer.parseInt(sjleixingId));
			}
			if (StringUtil.isNotEmpty(sjxingtaiId)) {
				shuju.setSjxingtaiId(Integer.parseInt(sjxingtaiId));
			}
			if (StringUtil.isNotEmpty(shujuZong2)) {
				shuju.setShujuZong2(Integer.parseInt(shujuZong2));
			}
			if (StringUtil.isNotEmpty(userId)) {
				shuju.setUserId(Integer.parseInt(userId));
			}
			if (StringUtil.isNotEmpty(bumenId)) {
				shuju.setBumenId(Integer.parseInt(bumenId));
			}
			if (StringUtil.isNotEmpty(buyuanId)) {
				shuju.setBuyuanId(Integer.parseInt(buyuanId));
			}
			if (StringUtil.isNotEmpty(buzhiId)) {
				shuju.setBuzhiId(Integer.parseInt(buzhiId));
			}
			if (StringUtil.isNotEmpty(yonghuId)) {
				shuju.setYonghuId(Integer.parseInt(yonghuId));
			}
			if (StringUtil.isNotEmpty(byuyuanId)) {
				shuju.setByuyuanId(Integer.parseInt(byuyuanId));
			}
			if (StringUtil.isNotEmpty(byumenId)) {
				shuju.setByumenId(Integer.parseInt(byumenId));
			}
			if (StringUtil.isNotEmpty(byuzhiId)) {
				shuju.setByuzhiId(Integer.parseInt(byuzhiId));
			}
			if (StringUtil.isNotEmpty(sdate1)) {
				Date date = new Date();
				sdate1 = DateUtil.formatDate(date, "yyyy-MM-dd HH:mm:ss");
			}
			if (StringUtil.isNotEmpty(edate1)) {
				Date date = new Date();
				edate1 = DateUtil.formatDate(date, "yyyy-MM-dd HH:mm:ss");
			}
			JSONArray jsonArray = JSONArray.fromObject(shujuService.queryShujus(
					shuju, pageBean.getStart(), pageBean.getRows(), sdate, edate, sdate1, edate1));
			JSONObject result = new JSONObject();
			int total = shujuService.queryShujus(shuju, 0,0, sdate, edate, sdate1, edate1).size();
			result.put("rows", jsonArray);
			result.put("total", total);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/addShuju")
	public void addShuju(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			JSONObject result = new JSONObject();

			String shujuName = (String) request.getParameter("shujuName");
			String shujuMark = (String) request.getParameter("shujuMark");
			String shujuMark1 = (String) request.getParameter("shujuMark1");
			String shujuMark2 = (String) request.getParameter("shujuMark2");
			String shujuMark3 = (String) request.getParameter("shujuMark3");
			String shujuDate = (String) request.getParameter("shujuDate");
			String shujuDate1 = (String) request.getParameter("shujuDate1");
			String shujuZong = (String) request.getParameter("shujuZong");
			String shujuZong1 = (String) request.getParameter("shujuZong1");
			String shujuZong2 = (String) request.getParameter("shujuZong2");
			String shujuType = (String) request.getParameter("shujuType");
			String shujuType1 = (String) request.getParameter("shujuType1");
			String shujuType2 = (String) request.getParameter("shujuType2");
			String sjleixingId = (String) request.getParameter("sjleixingId");
			String sjxingtaiId = (String) request.getParameter("sjxingtaiId");
			String shujuDouble = (String) request.getParameter("shujuDouble");
			String shujuDouble1 = (String) request.getParameter("shujuDouble1");
			String shujuDouble2 = (String) request.getParameter("shujuDouble2");
			String shujuDouble3 = (String) request.getParameter("shujuDouble3");
			String shujuDouble4 = (String) request.getParameter("shujuDouble4");
			String yonghuId = (String) request.getParameter("yonghuId");
			String userId = (String) request.getParameter("userId");
			String buzhiId = (String) request.getParameter("buzhiId");
			String shujuId = (String) request.getParameter("shujuId");
			Shuju shuju = new Shuju();

			if (StringUtil.isNotEmpty(shujuId)) {
				shuju = shujuService.getShuju(Integer.parseInt(shujuId));
			}
			if (StringUtil.isNotEmpty(shujuName)) {
				shuju.setShujuName(shujuName);
			}
			if (StringUtil.isNotEmpty(shujuMark)) {
				shuju.setShujuMark(shujuMark);
			}
			if (StringUtil.isNotEmpty(shujuMark1)) {
				shuju.setShujuMark1(shujuMark1);
			}
			if (StringUtil.isNotEmpty(shujuMark2)) {
				shuju.setShujuMark2(shujuMark2);
			}
			if (StringUtil.isNotEmpty(shujuMark3)) {
				shuju.setShujuMark3(shujuMark3);
			}
			if (StringUtil.isNotEmpty(shujuDate)) {
				shuju.setShujuDate(DateUtil.formatString(shujuDate,
						"yyyy-MM-dd HH:mm:ss"));
			}
			if (StringUtil.isNotEmpty(shujuDate1)) {
				shuju.setShujuDate1(DateUtil.formatString(shujuDate1,
						"yyyy-MM-dd HH:mm:ss"));
			}
			if (StringUtil.isNotEmpty(shujuZong)) {
				shuju.setShujuZong(Integer.parseInt(shujuZong));
			}
			if (StringUtil.isNotEmpty(shujuZong1)) {
				shuju.setShujuZong1(Integer.parseInt(shujuZong1));
			}
			if (StringUtil.isNotEmpty(shujuZong2)) {
				shuju.setShujuZong2(Integer.parseInt(shujuZong2));
			}
			if (StringUtil.isNotEmpty(shujuType)) {
				shuju.setShujuType(Integer.parseInt(shujuType));
			}
			if (StringUtil.isNotEmpty(shujuType1)) {
				shuju.setShujuType1(Integer.parseInt(shujuType1));
			}
			if (StringUtil.isNotEmpty(shujuType2)) {
				shuju.setShujuType2(Integer.parseInt(shujuType2));
			}
			if (StringUtil.isNotEmpty(shujuDouble)) {
				shuju.setShujuDouble(Double.parseDouble(shujuDouble));
			}
			if (StringUtil.isNotEmpty(shujuDouble1)) {
				shuju.setShujuDouble1(Double.parseDouble(shujuDouble1));
			}
			if (StringUtil.isNotEmpty(shujuDouble2)) {
				shuju.setShujuDouble2(Double.parseDouble(shujuDouble2));
			}
			if (StringUtil.isNotEmpty(shujuDouble3)) {
				shuju.setShujuDouble3(Double.parseDouble(shujuDouble3));
			}
			if (StringUtil.isNotEmpty(shujuDouble4)) {
				shuju.setShujuDouble4(Double.parseDouble(shujuDouble4));
			}
			if (StringUtil.isNotEmpty(sjleixingId)) {
				shuju.setSjleixingId(Integer.parseInt(sjleixingId));
				Sjleixing sjleixing = new Sjleixing();
				sjleixing = sjleixingService.getSjleixing(Integer.parseInt(sjleixingId));
				shuju.setSjleixingName(sjleixing.getSjleixingName());
			}
			if (StringUtil.isNotEmpty(sjxingtaiId)) {
				shuju.setSjxingtaiId(Integer.parseInt(sjxingtaiId));
				Sjxingtai sjxingtai = new Sjxingtai();
				sjxingtai = sjxingtaiService.getSjxingtai(Integer.parseInt(sjxingtaiId));
				shuju.setSjxingtaiName(sjxingtai.getSjxingtaiName());
			}
			if (StringUtil.isNotEmpty(yonghuId)) {
				shuju.setYonghuId(Integer.parseInt(yonghuId));
			}
			if (StringUtil.isNotEmpty(userId)) {
				shuju.setUserId(Integer.parseInt(userId));
				User user = new User();
				user = userService.getUser(Integer.parseInt(userId));
				shuju.setUserName(user.getUserName());
				shuju.setBumenId(user.getBumenId());
				shuju.setBumenName(user.getBumenName());
				shuju.setBuyuanId(user.getBuyuanId());
				shuju.setBuyuanName(user.getBuyuanName());
				shuju.setBuzhiId(user.getBuzhiId());
				shuju.setBuzhiName(user.getBuzhiName());
			}
			if (StringUtil.isNotEmpty(buzhiId)) {
				shuju.setBuzhiId(Integer.parseInt(buzhiId));
				Buzhi buzhi = new Buzhi();
				buzhi = buzhiService.getBuzhi(Integer.parseInt(buzhiId));
				shuju.setBuzhiName(buzhi.getBuzhiName());
				shuju.setBumenId(buzhi.getBumenId());
				shuju.setBumenName(buzhi.getBumenName());
				shuju.setBuyuanId(buzhi.getBuyuanId());
				shuju.setBuyuanName(buzhi.getBuyuanName());
			}
			/******多选处理开始*****/
			String[] buyuanIds = request.getParameterValues("buyuanIds");
			if(buyuanIds != null){
				String roleName = org.apache.commons.lang.StringUtils.join(buyuanIds,",");
				shuju.setRoleName(roleName);
				List<String> buyuanNames = new ArrayList<String>();
				for (int i = 0; i < buyuanIds.length; i++) {
					Buyuan buyuan = buyuanService.getBuyuan(Integer.parseInt(buyuanIds[i]));
					buyuanNames.add(buyuan.getBuyuanName());
				}
				if(buyuanNames.size()>0){
					String buyuanName = org.apache.commons.lang.StringUtils.join(buyuanNames,",");
					shuju.setBuyuanName(buyuanName);
				}
			}
			/******多选处理结束*****/
			if (StringUtil.isNotEmpty(shujuId)) {
				shujuService.modifyShuju(shuju);
				result.put("success", "true");
				ResponseUtil.write(response, result);
			} else {
				Date date = new Date();
				shuju.setShujuDate(date);
				shuju.setShujuType(0);
				shuju.setShujuZong1(0);
				shujuService.save(shuju);
				result.put("success", "true");
				ResponseUtil.write(response, result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/deleteShuju")
	public void deleteShuju(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		JSONObject result = new JSONObject();
		String delIds = (String) request.getParameter("delIds");
		try {
			String str[] = delIds.split(",");
			for (int i = 0; i < str.length; i++) {
				shujuService.deleteShuju(Integer.parseInt(str[i]));
			}
			result.put("success", "true");
			result.put("delNums", str.length);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/duoxiangShuju")
	public void duoxiangShuju(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			String delIds = (String) request.getParameter("delIds");
			String shujuType = (String) request.getParameter("shujuType");
			JSONObject result = new JSONObject();
			String str[] = delIds.split(",");
			for (int i = 0; i < str.length; i++) {
				Shuju shuju = shujuService.getShuju(Integer.parseInt(str[i]));
				shuju.setShujuType(Integer.parseInt(shujuType));
				shujuService.modifyShuju(shuju);
			}
			result.put("success", "true");
			result.put("delNums", str.length);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/shujuComboList")
	public void shujuComboList(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String shujuName = (String) request.getParameter("shujuName");
		String shujuId = (String) request.getParameter("shujuId");
		String shujuType = (String) request.getParameter("shujuType");
		String shujuType1 = (String) request.getParameter("shujuType1");
		String sjleixingId = (String) request.getParameter("sjleixingId");
		String sjxingtaiId = (String) request.getParameter("sjxingtaiId");
		String shujuZong2 = (String) request.getParameter("shujuZong2");
		String yonghuId = (String) request.getParameter("yonghuId");
		String byumenId = (String) request.getParameter("byumenId");
		String byuyuanId = (String) request.getParameter("byuyuanId");
		String byuzhiId = (String) request.getParameter("byuzhiId");
		String userId = (String) request.getParameter("userId");
		String bumenId = (String) request.getParameter("bumenId");
		String buyuanId = (String) request.getParameter("buyuanId");
		String buzhiId = (String) request.getParameter("buzhiId");
		Shuju shuju = new Shuju();
		try {
			if (StringUtil.isNotEmpty(shujuName)) {
				shuju.setShujuName(shujuName);
			}
			if (StringUtil.isNotEmpty(shujuId)) {
				shuju.setShujuId(Integer.parseInt(shujuId));
			}
			if (StringUtil.isNotEmpty(shujuType)) {
				shuju.setShujuType(Integer.parseInt(shujuType));
			}
			if (StringUtil.isNotEmpty(shujuType1)) {
				shuju.setShujuType1(Integer.parseInt(shujuType1));
			}
			if (StringUtil.isNotEmpty(sjleixingId)) {
				shuju.setSjleixingId(Integer.parseInt(sjleixingId));
			}
			if (StringUtil.isNotEmpty(sjxingtaiId)) {
				shuju.setSjxingtaiId(Integer.parseInt(sjxingtaiId));
			}
			if (StringUtil.isNotEmpty(shujuZong2)) {
				shuju.setShujuZong2(Integer.parseInt(shujuZong2));
			}
			if (StringUtil.isNotEmpty(userId)) {
				shuju.setUserId(Integer.parseInt(userId));
			}
			if (StringUtil.isNotEmpty(bumenId)) {
				shuju.setBumenId(Integer.parseInt(bumenId));
			}
			if (StringUtil.isNotEmpty(buyuanId)) {
				shuju.setBuyuanId(Integer.parseInt(buyuanId));
			}
			if (StringUtil.isNotEmpty(buzhiId)) {
				shuju.setBuzhiId(Integer.parseInt(buzhiId));
			}
			if (StringUtil.isNotEmpty(yonghuId)) {
				shuju.setYonghuId(Integer.parseInt(yonghuId));
			}
			if (StringUtil.isNotEmpty(byuyuanId)) {
				shuju.setByuyuanId(Integer.parseInt(byuyuanId));
			}
			if (StringUtil.isNotEmpty(byumenId)) {
				shuju.setByumenId(Integer.parseInt(byumenId));
			}
			if (StringUtil.isNotEmpty(byuzhiId)) {
				shuju.setByuzhiId(Integer.parseInt(byuzhiId));
			}
			JSONArray jsonArray = new JSONArray();
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", "");
			jsonObject.put("shujuName", "请选择...");
			jsonArray.add(jsonObject);
			jsonArray.addAll(JSONArray.fromObject(shujuService.queryShujus(shuju,
					0,0, null, null, null, null)));
			ResponseUtil.write(response, jsonArray);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/shujuTongji")
	public void shujuTongji(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String sdate=request.getParameter("sdate");
		String edate=request.getParameter("edate");
		String sjleixingId=request.getParameter("sjleixingId");
		String tijiaoUrl = request.getParameter("tijiaoUrl");
		String tongjitu = request.getParameter("tongjitu");
		List<String> tongjiNames = new ArrayList<String>();
		List<Double> tongjiZongshus = new ArrayList<Double>();
		List<Shuju> shujus = new ArrayList<Shuju>();
		Double zongshu = 0.0;
		Shuju shuju = new Shuju();
		if (StringUtil.isNotEmpty(sjleixingId)) {
			shuju.setSjleixingId(Integer.parseInt(sjleixingId));
		}
		try {
			Double shujuZongshu = 0.0;
			shujus = shujuService.queryShujus(shuju, 0, 0,sdate,edate, null, null);
			for(int i=0;i<shujus.size();i++){
				shujuZongshu = 0.0 + shujus.get(i).getShujuZong();
				tongjiNames.add(shujus.get(i).getShujuName());
				tongjiZongshus.add(shujuZongshu);
			}
			zongshu = zongshu + shujuZongshu;
			
			HttpSession session = request.getSession();
			session.setAttribute("tijiaoUrl", tijiaoUrl);
			session.setAttribute("tongjiNames", tongjiNames);
			session.setAttribute("tongjiZongshus", tongjiZongshus);
			session.setAttribute("zongshu", zongshu);
			response.sendRedirect("admin/" + tongjitu + ".jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/shangchuanShuju")
	public void shangchuanShuju(HttpServletRequest request, HttpServletResponse response,MultipartFile uploadFile)
			throws Exception {
		try {
			String shujuId = (String) request.getParameter("shujuId");
			String directory = "//WebRoot//WEB-INF//classes//static//file";
			String targetDirectory = System.getProperty("user.dir") + directory;
	        String fileName = uploadFile.getOriginalFilename();  
	        String sname = fileName.substring(fileName.lastIndexOf("."));
	        fileName = System.currentTimeMillis() + sname;
			File dir = new File(targetDirectory,fileName); 
			
	        //MultipartFile自带的解析方法
	        uploadFile.transferTo(dir);

			String shangchuandizhi = "/file" + "/" + fileName;
			String shangchuanname = fileName;
			Shuju shuju = shujuService.getShuju(Integer.parseInt(shujuId));
			shuju.setShujuImg(shangchuandizhi);
			shuju.setShujuImgName(shangchuanname);
			shujuService.modifyShuju(shuju);
			JSONObject result = new JSONObject();
			result.put("success", "true");
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
