
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
		GauceDataSet dSet1 = new GauceDataSet("detail_grid");		
		gos.fragment(dSet1, 40);
		java.io.FileInputStream is = new java.io.FileInputStream(pageContext.getServletContext().getRealPath("gauce40/detail.dat"));
    String[][] values = com.gauce.common.CommonUtil.loadCSV(is);
    String param_deptcd= request.getParameter("DEPTCD");
		int count = values.length;
		for(int i=0; i<count; i++) {
			if (values[i][0].equals(param_deptcd)) {
				dSet1.put("DEPTCD", values[i][0], 10);
				dSet1.put("EMPNO", values[i][1], 20);
				dSet1.put("EMPNM", values[i][2], 20);
				dSet1.put("POSITION", values[i][3], 20);
				dSet1.put("TELNO", values[i][4], 20);
				dSet1.put("EMAIL", values[i][5], 20);
			}
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
