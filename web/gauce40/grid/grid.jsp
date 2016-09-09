
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
		int count = 5;
		java.util.Date d = new java.util.Date();
		for(int i=0; i<count; i++) {
			dSet1.put("deptnm", "솔루션개발팀", 20);
			dSet1.put("year", d, 8);
			dSet1.put("amt1", 100000 + (i * 100), 15);
			dSet1.put("amt2", 300000 + (i * 10), 15);
			dSet1.heap();		
		}
		for(int i=0; i<count; i++) {
			dSet1.put("deptnm", "솔루션지원팀", 20);
			dSet1.put("year", d, 8);
			dSet1.put("amt1", 200000 + (i * 100), 15);
			dSet1.put("amt2", 500000 + (i * 10), 15);
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
