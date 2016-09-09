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
		StringBuffer sb = new StringBuffer("");
		
		GauceDataSet[] inSet = gis.readAll();
		for(int i=0; i<inSet.length; i++) {
			if((inSet[i].getName()).equals("USERLIST")) {
				
				GauceDataSet dSet1 = gis.read("USERLIST");
				gos.fragment(dSet1, 40);	
				java.util.Date d = new java.util.Date();
				int count = 10;
				for(int j=0; j<count; j++) {
					dSet1.put("empno", j, 5);
					dSet1.put("ename", "김지영", 30);
					dSet1.put("job", "DEVELOPER", 20);
					dSet1.put("mgr", 757 + j, 5);
					dSet1.put("sal", 8462 + j, 10);
					dSet1.put("comm", 0 , 10);
					dSet1.put("deptno", 8512 - j , 10);
					dSet1.heap();		
				}
				gos.write(dSet1);						
			} else {
				sb.append("[INPUT GauceDataSet-name: " + inSet[i].getName() + "]\n");
				GauceDataRow[] rows = inSet[i].getDataRows();
				GauceDataColumn[] cols = inSet[i].getDataColumns();
				for (int j = 0; j < rows.length; j++) {
					if (rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT)
						sb.append("========== insert ==========\n");
					else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE)
						sb.append("========== update ==========\n");
					else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE)
						sb.append("========== delete ==========\n");					
					for (int k = 0; k < cols.length; k++) {
						sb.append("row[" + j + "]-> " + "col[" + k + "]-name:" + cols[k].getColName() + ", col[" + k + "]-value: " + rows[j].getColumnValue(k) + "\n");
					}
				}
			}
			sb.append("\n");
		}
		gResponse.addMessage(sb.toString());
		//gResponse.addMessage(count + "건 조회 성공입니다!");
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
