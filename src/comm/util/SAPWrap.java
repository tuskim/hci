package comm.util;

import java.util.Vector;
import java.lang.reflect.*;

import com.sap.mw.jco.*;
import devon.core.log.LLog;

public abstract class SAPWrap
{
    public static int    SAP_MAXCONN          = 10;
    public static String SAP_CLIENT            = "";
    public static String SAP_USERNAME        = "";
    public static String SAP_PASSWD          = "";
    public static String SAP_LANGUAGE        = "";
    public static String SAP_HOST_NAME       = "";
    public static String SAP_SYSTEM_NUMBER   = "";
    public static String SAP_R3NAME          = "";
    public static String SAP_GROUP           = "";
    public static String SAP_REPOSITORY_NAME = "";
    public static String SID                 = "";
    public static IRepository mRepository    = null;
    private static int   SAP_COUNT           = 0;
    
      static {
            try{
                //Config conf = new Configuration();
                //boolean isLoadBalancing = conf.getBoolean("com.sns.jdf.sap.SAP_LOAD");
            //boolean isLoadBalancing = false;

            if( true ) {

            	/* Prod : 100
                SAP_MAXCONN         =  10;
                SAP_CLIENT          = "100";
                SAP_USERNAME        = "LILSCON";
                SAP_PASSWD          = "LILSADM1";
                SAP_LANGUAGE        = "EN";
                SAP_HOST_NAME       = "165.244.231.37";
                SAP_R3NAME          = "LIP";
                SAP_GROUP           = null;
                SAP_REPOSITORY_NAME = "LIP";
                SID                 = "LIP";
                SAP_SYSTEM_NUMBER   = "00";
                */

            	// QA : 210
            	SAP_MAXCONN         =  10;
                SAP_CLIENT          = "100";
                SAP_USERNAME        = "sd00";
                SAP_PASSWD          = "smile009!@";
                SAP_LANGUAGE        = "EN";
                SAP_HOST_NAME       = "165.244.231.39";
                SAP_R3NAME          = "LIQ";
                SAP_GROUP           = null;
                SAP_REPOSITORY_NAME = "LIQ";
                SID                 = "LIQ";
                SAP_SYSTEM_NUMBER   = "10";
                
            	/*
             	// QD : 310
                SAP_MAXCONN         =  10;
                SAP_CLIENT          = "310";
                SAP_USERNAME        = "sddev";
                SAP_PASSWD          = "smile008!@";
                SAP_LANGUAGE        = "EN";
                SAP_HOST_NAME       = "165.244.231.62";
                SAP_R3NAME          = "LID";
                SAP_GROUP           = null;
                SAP_REPOSITORY_NAME = "LID";
                SID                 = "LID";
                SAP_SYSTEM_NUMBER   = "00";
                */
                
               
                LLog.debug.println("11111111111111111111111111_OK_1");
                
                JCO.addClientPool(SID, SAP_MAXCONN,
                        SAP_CLIENT,
                        SAP_USERNAME,
                        SAP_PASSWD,
                        SAP_LANGUAGE,
                        SAP_HOST_NAME,
                        SAP_SYSTEM_NUMBER);


    mRepository = new JCO.Repository(SAP_REPOSITORY_NAME, SID);
                
                
                LLog.debug.println("11111111111111111111111111_OK_2");



            }
        } catch (Exception ex) {
        	
        	LLog.debug.println("11111111111111111111111111_OK :: " + ex.getMessage());
        }
    }

//  public void getCreateClient() throws Exception{
//
//      JCO.Client mConnection;
//
//      try {
//              mConnection = JCO.createClient (SAP_CLIENT, // SAP client
//                                   SAP_USERNAME,    // userid
//                                   SAP_PASSWD,        // password
//                                   SAP_LANGUAGE,       // language (null for default language)
//                                   SAP_HOST_NAME,      // application server host name
//                                   SAP_SYSTEM_NUMBER);         // system number
//              Logger.debug.println(this, "getConnection : " + mConnection.toString());
//          mConnection.connect();
//
//          Logger.debug.println(this,"getConnection : "+ mConnection.getAttributes());
//
//          mConnection.disconnect();
//
//      } catch (Exception ex) {
//              Logger.debug.println(this, "Can not getConnection : "+ex.toString());
//              throw new Exception(ex);
//      }
//  }


    private void count( String flag ) throws Exception{
        if( flag.equals("x")  ){ //connection이 추가되는경우
            SAP_COUNT = SAP_COUNT + 1;
        } else {//connection이 종료되는경우
            SAP_COUNT = SAP_COUNT - 1;
        }
    }

    public JCO.Client getClient() throws Exception{
        try {
        	
        		LLog.info.println("getClient in ");
                JCO.Client mConnection = JCO.getClient(SID, true);
                LLog.info.println("getClient()");
                //synchronized(this){
                    count("x");
                //}
                return mConnection;
        } catch (Exception ex) {
                throw new Exception(ex);
        }
    }

    public JCO.Function createFunction( String functionName) throws Exception{
        try {

            return mRepository.getFunctionTemplate(functionName.toUpperCase()).getFunction();
        }
        catch (Exception ex) {
            throw new Exception(ex);
        }
    }

    public void excute(JCO.Client mConnection, JCO.Function function) throws Exception{
        try{
            boolean trace = true;
            long start = 0, end = 0;
            if ( trace ) {
                start = System.currentTimeMillis();
            }
            mConnection.execute(function);
            if ( trace ) {
                end = System.currentTimeMillis();
            }
        } catch(Exception ex) {
            throw new Exception(ex);
        }
    }

    public void close(JCO.Client mConnection){
        try{
            if(mConnection != null){
                JCO.releaseClient(mConnection);
                //synchronized(this){
                    count("y");
                //}
            }
        } catch(Exception ex){
        }
    }


// 한글/영문 컨버젼
    /*
    protected static String fromSAP(String data)   {
        try {
            com.sns.jdf.conf.Config conf = new com.sns.jdf.conf.Configuration();
            if( conf.getBoolean("com.sns.jdf.util.SAPConversion") ){
                return com.sns.jdf.util.DataUtil.E2K(data);
            }else{
                return data;
            }
        }catch(Exception e) {
            e.getMessage();
            return data;
        }
    }

    protected static String toSAP(String data)   {
        try {
            com.sns.jdf.conf.Config conf = new com.sns.jdf.conf.Configuration();
            if( conf.getBoolean("com.sns.jdf.util.SAPConversion") ){
                return com.sns.jdf.util.DataUtil.K2E(data);
            }else{
                return data;
            }
        }catch(Exception e) {
            e.getMessage();
            return data;
        }
    }
*/

    ////////////////////////////////////////////////
    // setTable : 아직 쓰지 말것...
    protected void setTable(JCO.Function function, String tableName, Vector entityVector) throws Exception{
        setTable( function, tableName, entityVector, "");
    }

    // setStructor : 아직 쓰지 말것...
    protected void setStructor(JCO.Function function, String structureName, Object data) throws Exception{
        setStructor( function, structureName, data, "");
    }

    protected void setFields(JCO.Function function, Object data) throws Exception{
        setFields( function, data, "");
    }

    protected void setField(JCO.Function function, String fieldName, String value) throws Exception{
        setField( function, fieldName, value, "");
    }

////////////////////////////////////////
    // 값을 trim() 하지 않고 반환함;
    protected Vector getTableNoTrim(String entityName, JCO.Function function, String tableName) throws Exception{
        return getTableNoTrim( entityName, function, tableName, "");
    }

    protected Vector getTable(String entityName, JCO.Function function, String tableName) throws Exception{
        return getTable( entityName, function, tableName, "");
    }

    protected Object getStructor(Object data, JCO.Function function, String structureName) throws Exception{
        return getStructor( data, function, structureName, "");
    }

    protected Object getFields(Object data, JCO.Function function) throws Exception{
        return getFields( data, function, "");
    }

    protected String getField(String fieldName, JCO.Function function) throws Exception{
        return getField( fieldName, function, "");
    }

    ////////////////////////////////////////
    /*protected Vector getCodeVector( JCO.Function function, String tableName) throws Exception{
        Vector retvt = new Vector();
        try{
            JCO.Table table = function.getTableParameterList().getTable(tableName);
            for (int i = 0; i < table.getNumRows(); i++) {
                table.setRow(i);

                com.sns.jdf.util.CodeEntity ret = new com.sns.jdf.util.CodeEntity();

                ret.code = table.getString(0);
                ret.value = table.getString(1);


                DataUtil.fixNullAndTrim( ret );
                retvt.addElement(ret);
            }
        } catch ( Exception ex ){
            throw new Exception(ex);
        }
        return retvt;
    }*/
    ////////////////////////////////////////
    /*
    protected Vector getCodeVector( JCO.Function function, String tableName, String codeField, String valueField ) throws Exception{
        Vector retvt = new Vector();
        try{
            JCO.Table table = function.getTableParameterList().getTable(tableName);
            for (int i = 0; i < table.getNumRows(); i++) {
                table.setRow(i);

                com.sns.jdf.util.CodeEntity ret = new com.sns.jdf.util.CodeEntity();

                ret.code = table.getString(codeField);
                ret.value = table.getString(valueField);
                //Logger.debug.println(this, ret.toString());
                DataUtil.fixNullAndTrim( ret );
                retvt.addElement(ret);
            }
        } catch ( Exception ex ){
            throw new Exception(ex);
        }
        return retvt;
    }
*/
/*
 *  필드명에 접두어가 붙어서 필드명이 서로 다를경우 메칭하는 메소드...
 *  ex) XxxData.APPL_PERNR       ===>    JCO.Function의 PERNR
 *
 */
    protected void setTable(JCO.Function function, String tableName, Vector entityVector, String prev) throws Exception{

        try{
            JCO.Table table = function.getTableParameterList().getTable(tableName);
            if(table==null) {}//Logger.debug.println(this, "table is null");

            int alength = entityVector.size();

            for (int i = 0; i < alength; i++) {
                table.appendRow();
                Object data = entityVector.get(i);
                DataUtil.fixNull( data );

                Class c = data.getClass();
                Field[] fields = c.getFields();

                for (int k = 0 ; k < fields.length; k++) {
                    String fieldName = fields[k].getName();
                    if(fieldName.length() > prev.length()){ // 접두어 길이만큼 짜르자 APPL_PERNR ==> PERNR
                        fieldName = fieldName.substring(prev.length());
                    }

                    if( table.hasField(fieldName) ) {
                        table.setValue( (String)fields[k].get(data) , fieldName);
                    }
                }
            }
            function.getTableParameterList().setValue( table, tableName );

        } catch ( Exception ex ){
            throw new Exception(ex);
        }
    }

    // setStructor : 아직 쓰지 말것...
    protected void setStructor(JCO.Function function, String structureName, Object data, String prev) throws Exception{
        try{
            JCO.Structure structure = function.getImportParameterList().getStructure(structureName);

            DataUtil.fixNull( data );
            Class c = data.getClass();
            Field[] fields = c.getFields();

            for (int k = 0 ; k < fields.length; k++) {
                String fieldName = fields[k].getName();
                if(fieldName.length() > prev.length()){ // 접두어 길이만큼 짜르자 APPL_PERNR ==> PERNR
                    fieldName = fieldName.substring(prev.length());
                }
                if( structure.hasField(fieldName) ) {
                    //structure.setValue( structure , fieldName);
                    structure.setValue( (String)fields[k].get(data) , fieldName);
                }
            }
            //Logger.debug.println(this, "structure : "+structure.toString());
            function.getImportParameterList().setValue(structure, structureName);

        } catch ( Exception ex ){
            throw new Exception(ex);
        }
    }

    protected void setFields(JCO.Function function, Object data, String prev) throws Exception{
        try{
            //DataUtil.fixNull( data );
            Class c = data.getClass();
            Field[] fields = c.getFields();

            for (int k = 0 ; k < fields.length; k++) {
                String fieldName = fields[k].getName();
                if(fieldName.length() > prev.length()){ // 접두어 길이만큼 짜르자 APPL_PERNR ==> PERNR
                    fieldName = fieldName.substring(prev.length());
                }

                if( function.getImportParameterList().hasField(fieldName) ) {
                    function.getImportParameterList().setValue( (String)fields[k].get(data) , fieldName);
                }
            }
            //Logger.debug.println(this, "function : "+function.toString());
            //Logger.debug.println(this, "ImportParameterList : "+function.getImportParameterList().toString());
        } catch ( Exception ex ){
            throw new Exception(ex);
        }
    }

    protected void setField(JCO.Function function, String fieldName, String value, String prev) throws Exception{
        try{
            if(fieldName.length() > prev.length()){ // 접두어 길이만큼 짜르자 APPL_PERNR ==> PERNR
                fieldName = fieldName.substring(prev.length());
            }

            function.getImportParameterList().setValue( value , fieldName);
            //Logger.debug.println(this, "ImportParameterList : "+function.getImportParameterList().toString());
        } catch ( Exception ex ){
            throw new Exception(ex);
        }
    }

////////////////////////////////////////

    // 값을 trim() 하지 않고 반환함;
    protected Vector getTableNoTrim(String entityName, JCO.Function function, String tableName, String prev) throws Exception{
        Vector retvt = new Vector();
        try{
            JCO.Table table = function.getTableParameterList().getTable(tableName);
            //Logger.debug.println(this, "[]Package 경로가 잡혀있어야함 : "+entityName);
            Class c = Class.forName(entityName);
            Object data = null;
            Field[] fields = c.getFields();
            for (int i = 0; i < table.getNumRows(); i++) {
                table.setRow(i);
                data = c.newInstance();
                for (int k = 0 ; k < fields.length; k++) {
                    String fieldName = fields[k].getName();
                    if(fieldName.length() > prev.length()){ // 접두어 길이만큼 짜르자 APPL_PERNR ==> PERNR
                        fieldName = fieldName.substring(prev.length());
                    }
                    if( table.hasField(fieldName) ) {
                        fields[k].set( data, table.getString(fieldName) );
                    }
                }
                //Logger.debug.println(this, data.toString());
                //DataUtil.fixNull( data );    //  <=== No Trim()
                retvt.addElement(data);
            }
        } catch ( Exception ex ){
            throw new Exception(ex);
        }
        return retvt;
    }

    protected Vector getTable(String entityName, JCO.Function function, String tableName, String prev) throws Exception{
        Vector retvt = new Vector();
        try{
            JCO.Table table = function.getTableParameterList().getTable(tableName);
            //Logger.debug.println(this, "[]Package 경로가 잡혀있어야함 : "+entityName);
            Class c = Class.forName(entityName);
            Object data = null;
            Field[] fields = c.getFields();
            for (int i = 0; i < table.getNumRows(); i++) {
                table.setRow(i);
                data = c.newInstance();
                for (int k = 0 ; k < fields.length; k++) {
                    String fieldName = fields[k].getName();

                    if(fieldName.length() > prev.length()){ // 접두어 길이만큼 짜르자 APPL_PERNR ==> PERNR
                        fieldName = fieldName.substring(prev.length());
                    }
                    if( table.hasField(fieldName) ) {
                        fields[k].set( data, table.getString(fieldName) );
                    }
                }
                //Logger.debug.println(this, data.toString());
                //DataUtil.fixNullAndTrim( data );
                retvt.addElement(data);
            }
        } catch ( Exception ex ){
            throw new Exception(ex);
        }
        return retvt;
    }

    protected Object getStructor(Object data, JCO.Function function, String structureName, String prev) throws Exception{
        try{
            JCO.Structure structure = function.getExportParameterList().getStructure(structureName);

            Class c = data.getClass();
            Field[] fields = c.getFields();

            for (int k = 0 ; k < fields.length; k++) {
                String fieldName = fields[k].getName();
                if(fieldName.length() > prev.length()){ // 접두어 길이만큼 짜르자 APPL_PERNR ==> PERNR
                    fieldName = fieldName.substring(prev.length());
                }

                if( structure.hasField(fieldName) ) {
                    fields[k].set( data, structure.getString(fieldName) );
                }
            }
            //DataUtil.fixNullAndTrim( data );

            //Logger.debug.println(this, "data : "+data.toString());
        } catch ( Exception ex ){
            throw new Exception(ex);
        }
        return data;
    }

    protected Object getFields(Object data, JCO.Function function, String prev) throws Exception{
        try{
            Class c = data.getClass();
            Field[] fields = c.getFields();

            for (int k = 0 ; k < fields.length; k++) {
                String fieldName = fields[k].getName();
                if(fieldName.length() > prev.length()){ // 접두어 길이만큼 짜르자 APPL_PERNR ==> PERNR
                    fieldName = fieldName.substring(prev.length());
                }

                if( function.getExportParameterList().hasField(fieldName) ) {
                    fields[k].set( data, function.getExportParameterList().getString(fieldName) );
                }
            }
            //DataUtil.fixNullAndTrim( data );

            //Logger.debug.println(this, "data : "+data.toString());
        } catch ( Exception ex ){
            throw new Exception(ex);
        }
        return data;
    }

    protected String getField(String fieldName, JCO.Function function, String prev) throws Exception{
        if(fieldName.length() > prev.length()){ // 접두어 길이만큼 짜르자 APPL_PERNR ==> PERNR
            fieldName = fieldName.substring(prev.length());
        }
        String ret = function.getExportParameterList().getString(fieldName) ;

        return ret.trim();
    }
}
