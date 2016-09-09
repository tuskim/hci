/*
 *------------------------------------------------------------------------------
 * RetrieveCustomerCreditLimitRFC.java,v 1.0  2015.11.16
 * 
 * PROJ : PT-PAM 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2015.11.16   jwhan     C20151030_07129 여신한도관리 신규  
 *----------------------------------------------------------------------------
 */


package rfc.entity;

public class CustomerCreditLimitEntity {
	
	
	public String KKBER;
	public String KUNNR;
	public String NAME1;
	
	public String AVAILABLE2;
	public String CRDT_LIMT2;
	public String EXPOSURE2;
	
	
	public String SKFOR2;
	public String SSOBL2;
	public String WAERS;
	
	public String SALES_VALUE2;

	
	public String DATAB;
	public String getDATAB() {
		return DATAB;
	}
	public void setDATAB(String dATAB) {
		DATAB = dATAB;
	}
	public String getDATBI() {
		return DATBI;
	}
	public void setDATBI(String dATBI) {
		DATBI = dATBI;
	}
	public String DATBI;
	
	
	public String getSALES_VALUE2() {
		return SALES_VALUE2;
	}
	public void setSALES_VALUE2(String sALES_VALUE2) {
		SALES_VALUE2 = sALES_VALUE2;
	}
	public String getWAERS() {
		return WAERS;
	}
	public void setWAERS(String wAERS) {
		WAERS = wAERS;
	}
	public String getSKFOR() {
		return SKFOR2;
	}
	public void setSKFOR(String sKFOR) {
		SKFOR2 = sKFOR;
	}
	public String getSSOBL() {
		return SSOBL2;
	}
	public void setSSOBL(String sSOBL) {
		SSOBL2 = sSOBL;
	}

	
	public String getKKBER() {
		return KKBER;
	}
	public void setKKBER(String kKBER) {
		KKBER = kKBER;
	}
	public String getKUNNR() {
		return KUNNR;
	}
	public void setKUNNR(String kUNNR) {
		KUNNR = kUNNR;
	}
	public String getNAME1() {
		return NAME1;
	}
	public void setNAME1(String nAME1) {
		NAME1 = nAME1;
	}
	public String getAVAILABLE() {
		return AVAILABLE2;
	}
	public void setAVAILABLE(String aVAILABLE) {
		AVAILABLE2 = aVAILABLE;
	}
	public String getCRDT_LIMT() {
		return CRDT_LIMT2;
	}
	public void setCRDT_LIMT(String cRDT_LIMT) {
		CRDT_LIMT2 = cRDT_LIMT;
	}
	public String getEXPOSURE() {
		return EXPOSURE2;
	}
	public void setEXPOSURE(String eXPOSURE) {
		EXPOSURE2 = eXPOSURE;
	}
	
	
}
