
<%@ page
	import="java.io.*,
			com.gauce.*,
			com.gauce.io.*,
			com.gauce.http.*,
			com.gauce.common.*;" 
	pageEncoding="EUC-KR"
%>
<%	
	HttpGauceResponse gResponse = null;
	GauceOutputStream gos = null;
	try{
		gResponse = ((HttpGauceResponse) response);
		gos = gResponse.getGauceOutputStream();
		GauceDataSet dSet1 = new GauceDataSet("tbds_list");		
		gos.fragment(dSet1, 40);	
		String[] names = {"������", "����ȯ", "����ȣ", "������", "����", "�迵��", "�̹̼�", "�̼���", "���α�", "����ȣ"};
		int count = names.length;
		for(int i=0; i<count; i++) {
			dSet1.put("sabun", String.valueOf(10000 + i), 10);
			dSet1.put("name", names[i], 20);
			dSet1.put("amt1", 100000 + (i * 100), 15);
			dSet1.put("amt2", 300000 + (i * 10), 15);
			String check_value = "F";
			int gubun_value = i % 2;
			if(gubun_value == 0) check_value = "T";
			dSet1.put("chk", check_value, 2);
			dSet1.put("gubun", String.valueOf(gubun_value + 1) , 2);
			dSet1.heap();		
		}
		gos.write(dSet1);				
		gResponse.addMessage(count + "�� ��ȸ �����Դϴ�!");
	} catch(Exception e) {
		if (gResponse != null && gos != null) {
			gResponse.addException(e);
		} else {
			e.printStackTrace();
		}
	} finally {
		if (gos != null) {
			try { 
				gos.close();
			} catch(IOException ioe) {
				gos = null;
			}
		}	
	}		
%>
