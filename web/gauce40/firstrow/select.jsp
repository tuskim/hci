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
		int count = 2000;
		for(int i=0; i<count; i++) {
			dSet1.put("zip_code", (1000 + i) + "-00" , 8);
			dSet1.put("province", "제나", 15);
			dSet1.put("city", "shift", 10);
			dSet1.put("town", "Town", 50);
			dSet1.put("numtest", i, 5);
			dSet1.put("dec", 0.11 * i, 10.3);
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
