package rfc.entity;

public class CurrentStockEntity {
	public String MATNR;
	public String MAKTX;
	public String MEINS;
	public String LABST;
	public String getLABST() {
		return LABST;
	}
	public void setLABST(String labst) {
		LABST = labst;
	}
	public String getMAKTX() {
		return MAKTX;
	}
	public void setMAKTX(String maktx) {
		MAKTX = maktx;
	}
	public String getMATNR() {
		return MATNR;
	}
	public void setMATNR(String matnr) {
		MATNR = matnr;
	}
	public String getMEINS() {
		return MEINS;
	}
	public void setMEINS(String meins) {
		MEINS = meins;
	}
}
