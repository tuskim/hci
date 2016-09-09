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
		java.util.Date d = new java.util.Date();
		int count = 10;
		for(int i=0; i<count; i++) {
			dSet1.put("emp_name", "김지영", 10);
			dSet1.put("emp_id", 1000 + i, 5);
			dSet1.put("emp_code", i, 5);
			dSet1.put("emp_hiredate", d, 8);
			dSet1.put("emp_age", 27, 2);
			dSet1.put("emp_pay", 1000.32 * i , 10.3);
			dSet1.heap();		
		}
		gos.write(dSet1);				
		gResponse.addMessage(count + "건 조회 성공입니다!");
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
