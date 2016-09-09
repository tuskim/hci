<%@ page
	import="java.io.*,
			com.gauce.*,
			com.gauce.io.*,
			com.gauce.http.*,
			com.gauce.common.*;" 
	pageEncoding="EUC-KR"
%>
<%	
	HttpGauceResponse iResponse = null;
	GauceOutputStream ios = null;
	try{
		iResponse = ((HttpGauceResponse) response);
		ios = iResponse.getGauceOutputStream();
		GauceDataSet dSet1 = new GauceDataSet("guace");		
		ios.fragment(dSet1, 40);
		java.io.FileInputStream is = new java.io.FileInputStream(pageContext.getServletContext().getRealPath("gauce40/treeview.dat"));
    String[][] values = com.gauce.common.CommonUtil.loadCSV(is);
    int count = values.length;
		for(int i=0; i<count; i++) {
			dSet1.put("lev", values[i][0], 20);
			dSet1.put("root", values[i][1], 30);
			dSet1.put("text", values[i][2], 30);
			dSet1.put("type", values[i][3], 30);
			dSet1.put("seq", values[i][4], 5);
			dSet1.heap();		
		}
		ios.write(dSet1);
	} catch(Exception e) {
		if (iResponse != null && ios != null) {
			iResponse.addException(e);
		} else {
			e.printStackTrace();
		}
	} finally {
		if (ios != null) {
			try { 
				ios.close();
			} catch(IOException ioe) {
				ios = null;
			}
		}	
	}		
%>
