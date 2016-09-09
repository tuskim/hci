<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.log.*;"
	pageEncoding="EUC-KR"%>
<%
	ServiceLoader loader = new ServiceLoader(request, response);
	GauceService service = loader.newService();
	GauceContext context = service.getContext();
	Logger logger = context.getLogger();
	try {
		GauceResponse res = service.getGauceResponse();
		GauceRequest req = service.getGauceRequest();

		GauceDataSet dSet = new GauceDataSet();
		res.enableFirstRow(dSet);
		dSet.addDataColumn(new GauceDataColumn("c_string",
				GauceDataColumn.TB_STRING, 10));
		dSet.addDataColumn(new GauceDataColumn("c_korean",
				GauceDataColumn.TB_STRING, 10));
		dSet.addDataColumn(new GauceDataColumn("c_int",
				GauceDataColumn.TB_INT, 10));
		dSet.addDataColumn(new GauceDataColumn("c_bigint",
				GauceDataColumn.TB_BIGINT, 15));
		dSet.addDataColumn(new GauceDataColumn("c_decimal",
				GauceDataColumn.TB_DECIMAL, 5, 3));
		dSet.addDataColumn(new GauceDataColumn("c_date",
				GauceDataColumn.TB_DATE, 15));
		dSet.addDataColumn(new GauceDataColumn("c_url",
				GauceDataColumn.TB_URL, 100));
		dSet.addDataColumn(new GauceDataColumn("c_blob",
				GauceDataColumn.TB_BLOB, 100));
	
		java.net.URL url = new java.net.URL("http://www.shift.co.kr");
		
		int count = 10;
		for (int i = 1; i <= count; i++) {
			GauceDataRow row = dSet.newDataRow();
			/*
			row.addColumnValue("gauce_" + i);
			row.addColumnValue("가우스_" + i);
			row.addColumnValue(i);
			row.addColumnValue(Long.parseLong("123456789123456"));
			row.addColumnValue(123451234512345.3);
			row.addColumnValue(new java.util.Date());
			row.addColumnValue("http://www.shift.co.kr");
			row.addColumnValue((new java.net.URL("http://www.shift.co.kr")).openStream());
			*/
			
			row.setString(0, "agauce_" + i);
			row.setString(1, "가우스_" + i);
			row.setInt(2, i);
			row.setLong(3, Long.parseLong("123456789123456"));
			row.setDouble(4, 123451234512345.3);
			row.setDate(5, new java.util.Date());
			row.setString(6, "http://www.shift.co.kr");
			row.setInputStream(7, (new java.net.URL("http://www.shift.co.kr")).openStream());			  
			
			dSet.addDataRow(row);
		}
		dSet.flush();
		res.flush();
		//res.writeException("Native", "70000", "오류가 발생하였습니다.");
		//res.commit();
		res.commit(count + "건 조회 성공입니다");
		res.close();
	} catch (Exception e) {
		logger.err.println(this, e);
		throw e;
	} finally {
		loader.restoreService(service);
	}
%>