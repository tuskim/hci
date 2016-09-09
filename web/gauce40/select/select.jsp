
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
		GauceDataSet dSet = new GauceDataSet("tbds_list");		
		gos.fragment(dSet, 40);		
		
		int count = 10;
		for(int i=0; i<count; i++) {
			dSet.put("c_string", "gauce50_" + i , 10);
			dSet.put("c_korean", "가우스50_" + i, 10);
			dSet.put("c_int", i, 10);
			dSet.put("c_bigint", Long.parseLong("123456789123456"), 15);
			dSet.put("c_decimal", 123451234512345.3, 10.3);
			dSet.put("c_date", new java.util.Date(), 15);
			dSet.put("c_url", "http://www.shift.co.kr", 100);
			dSet.put("c_blob", (new java.net.URL("http://www.shift.co.kr")).openStream(), 100);
			dSet.heap();		
		}
		
		gos.write(dSet);				
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
