
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
		GauceDataSet dSet1 = new GauceDataSet("ds_master");		
		gos.fragment(dSet1, 40);
		java.io.FileInputStream is = new java.io.FileInputStream(pageContext.getServletContext().getRealPath("gauce40/master.dat"));
    String[][] values = com.gauce.common.CommonUtil.loadCSV(is);
		int count = values.length;
		for(int i=0; i<count; i++) {
			dSet1.put("DEPTCD", values[i][0], 10);
			dSet1.put("DEPTNM", values[i][1], 15);
			dSet1.put("EMPNUM", values[i][2], 5);
			dSet1.put("DESCRIPTION", values[i][3], 20);
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
