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
	HttpGauceRequest gRequest = null;
	GauceOutputStream gos = null;
	GauceInputStream gis = null;
	try{
		gResponse = ((HttpGauceResponse) response);
		gRequest = ((HttpGauceRequest) request);
		gos = gResponse.getGauceOutputStream();
		gis = gRequest.getGauceInputStream();
		String param_empno = gRequest.getParameter("empno");
		GauceDataSet dSet1 = new GauceDataSet("USER");				
		gos.fragment(dSet1, 40);	
		java.util.Date d = new java.util.Date();
		int count = 10;
		for(int i=0; i<count; i++) {
			if (Integer.parseInt(param_empno) == i) {
				dSet1.put("empno", i, 5);
				dSet1.put("ename", "김지영1", 10);
				dSet1.put("job", "DEVELOPER", 20);
				dSet1.put("mgr", 757 + i, 5);
				dSet1.put("sal", 8462 + i, 10);
				dSet1.put("comm", 0 , 10.3);
				dSet1.put("deptno", 8512 - i , 10);
				dSet1.heap();
			}
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
