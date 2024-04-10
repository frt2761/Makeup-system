package com.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
/**
 * <p>Title: </p>
 * <p>Description:TestRandom </p>
 * <p>Company: </p> 
 * @author yuan 
 * @date 2016-4-11 下午8:44:38*/
public class ListSuiji {
 
	/** 
	 * @Title: main 
	 * @Description: TODO
	 * @param args 
	 * @return void  
	 * @throws 
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//从list中随机抽取n个不同的元素
		List list = new ArrayList();
		List listNew = new ArrayList();
		list.add(1);
		list.add(2);
		list.add(3);
		list.add(4);
		list.add(5);
		listNew = createRandomList(list,3);
	}
 
	/**从list中随机抽取元素
	 * @return  
	 * @Title: createRandomList 
	 * @Description: TODO
	 * @param list
	 * @param i 
	 * @return void  
	 * @throws 
	 */ 
	public static List createRandomList(List list, int n) {
		// TODO Auto-generated method stub
		Map map = new HashMap();
		List listNew = new ArrayList();
		if(list.size()<=n){
			return list;
		}else{
			while(map.size()<n){
				int random = (int) (Math.random() * list.size());
				if (!map.containsKey(random)) {
					map.put(random, "");
					System.out.println(random+"==========="+list.get(random));
					listNew.add(list.get(random));
				}
			}
			return listNew;
		}
	}
 
}