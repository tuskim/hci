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
			dSet1.put("sabun", String.valueOf((100000 + i)) , 6);
			dSet1.put("name", names[i], 20);
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
