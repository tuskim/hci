/**
 * GMA09_GIMS_DTTB_MATER_REQUEST.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gma09;

public class GMA09_GIMS_DTTB_MATER_REQUEST  implements java.io.Serializable {
    /* Interface IDëª?(YYYYMMDD24HHMISS) */
    private java.lang.String ZXMLDOCNO;

    /* Company Code */
    private java.lang.String BUKRS;

    /* WEB Requst number */
    private java.lang.String ZWEBNO;

    /* Material Name(?? */
    private java.lang.String MAKTXK1;

    /* Material Name(local) */
    private java.lang.String MAKTXK2;

    /* Material Type */
    private java.lang.String MTART;

    /* Base Unit of Measure */
    private java.lang.String MEINS;

    /* 01 : Create
     * 											02 : Change
     * 											03 : Delete */
    private java.lang.String ZASTATUS;

    /* 02 : Approval
     * 											03 : Canceled */
    private java.lang.String ZFSTATUS;

    /* Material Number[Change ?ëŠ” Delete???˜ì‹ ?? */
    private java.lang.String MATNR;

    /* Flag Material for Deletion at Client Level */
    private java.lang.String LVORM;

    /* Material Group */
    private java.lang.String MATKL;

    /* Reson Text(ë°˜ë ¤ ?¬ìœ ) */
    private java.lang.String RESON;

    /* ?ìµ?¼í? */
    private java.lang.String PRCTR;

    private java.lang.String ATTR1;

    private java.lang.String ATTR2;

    private java.lang.String ATTR3;

    private java.lang.String ATTR4;

    private java.lang.String ATTR5;

    private java.lang.String ATTR6;

    private java.lang.String ATTR7;

    private java.lang.String ATTR8;

    private java.lang.String ATTR9;

    private java.lang.String ATTR10;

    public GMA09_GIMS_DTTB_MATER_REQUEST() {
    }

    public GMA09_GIMS_DTTB_MATER_REQUEST(
           java.lang.String ZXMLDOCNO,
           java.lang.String BUKRS,
           java.lang.String ZWEBNO,
           java.lang.String MAKTXK1,
           java.lang.String MAKTXK2,
           java.lang.String MTART,
           java.lang.String MEINS,
           java.lang.String ZASTATUS,
           java.lang.String ZFSTATUS,
           java.lang.String MATNR,
           java.lang.String LVORM,
           java.lang.String MATKL,
           java.lang.String RESON,
           java.lang.String PRCTR,
           java.lang.String ATTR1,
           java.lang.String ATTR2,
           java.lang.String ATTR3,
           java.lang.String ATTR4,
           java.lang.String ATTR5,
           java.lang.String ATTR6,
           java.lang.String ATTR7,
           java.lang.String ATTR8,
           java.lang.String ATTR9,
           java.lang.String ATTR10) {
           this.ZXMLDOCNO = ZXMLDOCNO;
           this.BUKRS = BUKRS;
           this.ZWEBNO = ZWEBNO;
           this.MAKTXK1 = MAKTXK1;
           this.MAKTXK2 = MAKTXK2;
           this.MTART = MTART;
           this.MEINS = MEINS;
           this.ZASTATUS = ZASTATUS;
           this.ZFSTATUS = ZFSTATUS;
           this.MATNR = MATNR;
           this.LVORM = LVORM;
           this.MATKL = MATKL;
           this.RESON = RESON;
           this.PRCTR = PRCTR;
           this.ATTR1 = ATTR1;
           this.ATTR2 = ATTR2;
           this.ATTR3 = ATTR3;
           this.ATTR4 = ATTR4;
           this.ATTR5 = ATTR5;
           this.ATTR6 = ATTR6;
           this.ATTR7 = ATTR7;
           this.ATTR8 = ATTR8;
           this.ATTR9 = ATTR9;
           this.ATTR10 = ATTR10;
    }


    /**
     * Gets the ZXMLDOCNO value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ZXMLDOCNO   * Interface IDëª?(YYYYMMDD24HHMISS)
     */
    public java.lang.String getZXMLDOCNO() {
        return ZXMLDOCNO;
    }


    /**
     * Sets the ZXMLDOCNO value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ZXMLDOCNO   * Interface IDëª?(YYYYMMDD24HHMISS)
     */
    public void setZXMLDOCNO(java.lang.String ZXMLDOCNO) {
        this.ZXMLDOCNO = ZXMLDOCNO;
    }


    /**
     * Gets the BUKRS value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return BUKRS   * Company Code
     */
    public java.lang.String getBUKRS() {
        return BUKRS;
    }


    /**
     * Sets the BUKRS value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param BUKRS   * Company Code
     */
    public void setBUKRS(java.lang.String BUKRS) {
        this.BUKRS = BUKRS;
    }


    /**
     * Gets the ZWEBNO value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ZWEBNO   * WEB Requst number
     */
    public java.lang.String getZWEBNO() {
        return ZWEBNO;
    }


    /**
     * Sets the ZWEBNO value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ZWEBNO   * WEB Requst number
     */
    public void setZWEBNO(java.lang.String ZWEBNO) {
        this.ZWEBNO = ZWEBNO;
    }


    /**
     * Gets the MAKTXK1 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return MAKTXK1   * Material Name(??
     */
    public java.lang.String getMAKTXK1() {
        return MAKTXK1;
    }


    /**
     * Sets the MAKTXK1 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param MAKTXK1   * Material Name(??
     */
    public void setMAKTXK1(java.lang.String MAKTXK1) {
        this.MAKTXK1 = MAKTXK1;
    }


    /**
     * Gets the MAKTXK2 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return MAKTXK2   * Material Name(local)
     */
    public java.lang.String getMAKTXK2() {
        return MAKTXK2;
    }


    /**
     * Sets the MAKTXK2 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param MAKTXK2   * Material Name(local)
     */
    public void setMAKTXK2(java.lang.String MAKTXK2) {
        this.MAKTXK2 = MAKTXK2;
    }


    /**
     * Gets the MTART value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return MTART   * Material Type
     */
    public java.lang.String getMTART() {
        return MTART;
    }


    /**
     * Sets the MTART value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param MTART   * Material Type
     */
    public void setMTART(java.lang.String MTART) {
        this.MTART = MTART;
    }


    /**
     * Gets the MEINS value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return MEINS   * Base Unit of Measure
     */
    public java.lang.String getMEINS() {
        return MEINS;
    }


    /**
     * Sets the MEINS value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param MEINS   * Base Unit of Measure
     */
    public void setMEINS(java.lang.String MEINS) {
        this.MEINS = MEINS;
    }


    /**
     * Gets the ZASTATUS value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ZASTATUS   * 01 : Create
     * 											02 : Change
     * 											03 : Delete
     */
    public java.lang.String getZASTATUS() {
        return ZASTATUS;
    }


    /**
     * Sets the ZASTATUS value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ZASTATUS   * 01 : Create
     * 											02 : Change
     * 											03 : Delete
     */
    public void setZASTATUS(java.lang.String ZASTATUS) {
        this.ZASTATUS = ZASTATUS;
    }


    /**
     * Gets the ZFSTATUS value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ZFSTATUS   * 02 : Approval
     * 											03 : Canceled
     */
    public java.lang.String getZFSTATUS() {
        return ZFSTATUS;
    }


    /**
     * Sets the ZFSTATUS value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ZFSTATUS   * 02 : Approval
     * 											03 : Canceled
     */
    public void setZFSTATUS(java.lang.String ZFSTATUS) {
        this.ZFSTATUS = ZFSTATUS;
    }


    /**
     * Gets the MATNR value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return MATNR   * Material Number[Change ?ëŠ” Delete???˜ì‹ ??
     */
    public java.lang.String getMATNR() {
        return MATNR;
    }


    /**
     * Sets the MATNR value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param MATNR   * Material Number[Change ?ëŠ” Delete???˜ì‹ ??
     */
    public void setMATNR(java.lang.String MATNR) {
        this.MATNR = MATNR;
    }


    /**
     * Gets the LVORM value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return LVORM   * Flag Material for Deletion at Client Level
     */
    public java.lang.String getLVORM() {
        return LVORM;
    }


    /**
     * Sets the LVORM value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param LVORM   * Flag Material for Deletion at Client Level
     */
    public void setLVORM(java.lang.String LVORM) {
        this.LVORM = LVORM;
    }


    /**
     * Gets the MATKL value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return MATKL   * Material Group
     */
    public java.lang.String getMATKL() {
        return MATKL;
    }


    /**
     * Sets the MATKL value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param MATKL   * Material Group
     */
    public void setMATKL(java.lang.String MATKL) {
        this.MATKL = MATKL;
    }


    /**
     * Gets the RESON value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return RESON   * Reson Text(ë°˜ë ¤ ?¬ìœ )
     */
    public java.lang.String getRESON() {
        return RESON;
    }


    /**
     * Sets the RESON value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param RESON   * Reson Text(ë°˜ë ¤ ?¬ìœ )
     */
    public void setRESON(java.lang.String RESON) {
        this.RESON = RESON;
    }


    /**
     * Gets the PRCTR value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return PRCTR   * ?ìµ?¼í?
     */
    public java.lang.String getPRCTR() {
        return PRCTR;
    }


    /**
     * Sets the PRCTR value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param PRCTR   * ?ìµ?¼í?
     */
    public void setPRCTR(java.lang.String PRCTR) {
        this.PRCTR = PRCTR;
    }


    /**
     * Gets the ATTR1 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR1
     */
    public java.lang.String getATTR1() {
        return ATTR1;
    }


    /**
     * Sets the ATTR1 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR1
     */
    public void setATTR1(java.lang.String ATTR1) {
        this.ATTR1 = ATTR1;
    }


    /**
     * Gets the ATTR2 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR2
     */
    public java.lang.String getATTR2() {
        return ATTR2;
    }


    /**
     * Sets the ATTR2 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR2
     */
    public void setATTR2(java.lang.String ATTR2) {
        this.ATTR2 = ATTR2;
    }


    /**
     * Gets the ATTR3 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR3
     */
    public java.lang.String getATTR3() {
        return ATTR3;
    }


    /**
     * Sets the ATTR3 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR3
     */
    public void setATTR3(java.lang.String ATTR3) {
        this.ATTR3 = ATTR3;
    }


    /**
     * Gets the ATTR4 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR4
     */
    public java.lang.String getATTR4() {
        return ATTR4;
    }


    /**
     * Sets the ATTR4 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR4
     */
    public void setATTR4(java.lang.String ATTR4) {
        this.ATTR4 = ATTR4;
    }


    /**
     * Gets the ATTR5 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR5
     */
    public java.lang.String getATTR5() {
        return ATTR5;
    }


    /**
     * Sets the ATTR5 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR5
     */
    public void setATTR5(java.lang.String ATTR5) {
        this.ATTR5 = ATTR5;
    }


    /**
     * Gets the ATTR6 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR6
     */
    public java.lang.String getATTR6() {
        return ATTR6;
    }


    /**
     * Sets the ATTR6 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR6
     */
    public void setATTR6(java.lang.String ATTR6) {
        this.ATTR6 = ATTR6;
    }


    /**
     * Gets the ATTR7 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR7
     */
    public java.lang.String getATTR7() {
        return ATTR7;
    }


    /**
     * Sets the ATTR7 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR7
     */
    public void setATTR7(java.lang.String ATTR7) {
        this.ATTR7 = ATTR7;
    }


    /**
     * Gets the ATTR8 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR8
     */
    public java.lang.String getATTR8() {
        return ATTR8;
    }


    /**
     * Sets the ATTR8 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR8
     */
    public void setATTR8(java.lang.String ATTR8) {
        this.ATTR8 = ATTR8;
    }


    /**
     * Gets the ATTR9 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR9
     */
    public java.lang.String getATTR9() {
        return ATTR9;
    }


    /**
     * Sets the ATTR9 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR9
     */
    public void setATTR9(java.lang.String ATTR9) {
        this.ATTR9 = ATTR9;
    }


    /**
     * Gets the ATTR10 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @return ATTR10
     */
    public java.lang.String getATTR10() {
        return ATTR10;
    }


    /**
     * Sets the ATTR10 value for this GMA09_GIMS_DTTB_MATER_REQUEST.
     * 
     * @param ATTR10
     */
    public void setATTR10(java.lang.String ATTR10) {
        this.ATTR10 = ATTR10;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMA09_GIMS_DTTB_MATER_REQUEST)) return false;
        GMA09_GIMS_DTTB_MATER_REQUEST other = (GMA09_GIMS_DTTB_MATER_REQUEST) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZXMLDOCNO==null && other.getZXMLDOCNO()==null) || 
             (this.ZXMLDOCNO!=null &&
              this.ZXMLDOCNO.equals(other.getZXMLDOCNO()))) &&
            ((this.BUKRS==null && other.getBUKRS()==null) || 
             (this.BUKRS!=null &&
              this.BUKRS.equals(other.getBUKRS()))) &&
            ((this.ZWEBNO==null && other.getZWEBNO()==null) || 
             (this.ZWEBNO!=null &&
              this.ZWEBNO.equals(other.getZWEBNO()))) &&
            ((this.MAKTXK1==null && other.getMAKTXK1()==null) || 
             (this.MAKTXK1!=null &&
              this.MAKTXK1.equals(other.getMAKTXK1()))) &&
            ((this.MAKTXK2==null && other.getMAKTXK2()==null) || 
             (this.MAKTXK2!=null &&
              this.MAKTXK2.equals(other.getMAKTXK2()))) &&
            ((this.MTART==null && other.getMTART()==null) || 
             (this.MTART!=null &&
              this.MTART.equals(other.getMTART()))) &&
            ((this.MEINS==null && other.getMEINS()==null) || 
             (this.MEINS!=null &&
              this.MEINS.equals(other.getMEINS()))) &&
            ((this.ZASTATUS==null && other.getZASTATUS()==null) || 
             (this.ZASTATUS!=null &&
              this.ZASTATUS.equals(other.getZASTATUS()))) &&
            ((this.ZFSTATUS==null && other.getZFSTATUS()==null) || 
             (this.ZFSTATUS!=null &&
              this.ZFSTATUS.equals(other.getZFSTATUS()))) &&
            ((this.MATNR==null && other.getMATNR()==null) || 
             (this.MATNR!=null &&
              this.MATNR.equals(other.getMATNR()))) &&
            ((this.LVORM==null && other.getLVORM()==null) || 
             (this.LVORM!=null &&
              this.LVORM.equals(other.getLVORM()))) &&
            ((this.MATKL==null && other.getMATKL()==null) || 
             (this.MATKL!=null &&
              this.MATKL.equals(other.getMATKL()))) &&
            ((this.RESON==null && other.getRESON()==null) || 
             (this.RESON!=null &&
              this.RESON.equals(other.getRESON()))) &&
            ((this.PRCTR==null && other.getPRCTR()==null) || 
             (this.PRCTR!=null &&
              this.PRCTR.equals(other.getPRCTR()))) &&
            ((this.ATTR1==null && other.getATTR1()==null) || 
             (this.ATTR1!=null &&
              this.ATTR1.equals(other.getATTR1()))) &&
            ((this.ATTR2==null && other.getATTR2()==null) || 
             (this.ATTR2!=null &&
              this.ATTR2.equals(other.getATTR2()))) &&
            ((this.ATTR3==null && other.getATTR3()==null) || 
             (this.ATTR3!=null &&
              this.ATTR3.equals(other.getATTR3()))) &&
            ((this.ATTR4==null && other.getATTR4()==null) || 
             (this.ATTR4!=null &&
              this.ATTR4.equals(other.getATTR4()))) &&
            ((this.ATTR5==null && other.getATTR5()==null) || 
             (this.ATTR5!=null &&
              this.ATTR5.equals(other.getATTR5()))) &&
            ((this.ATTR6==null && other.getATTR6()==null) || 
             (this.ATTR6!=null &&
              this.ATTR6.equals(other.getATTR6()))) &&
            ((this.ATTR7==null && other.getATTR7()==null) || 
             (this.ATTR7!=null &&
              this.ATTR7.equals(other.getATTR7()))) &&
            ((this.ATTR8==null && other.getATTR8()==null) || 
             (this.ATTR8!=null &&
              this.ATTR8.equals(other.getATTR8()))) &&
            ((this.ATTR9==null && other.getATTR9()==null) || 
             (this.ATTR9!=null &&
              this.ATTR9.equals(other.getATTR9()))) &&
            ((this.ATTR10==null && other.getATTR10()==null) || 
             (this.ATTR10!=null &&
              this.ATTR10.equals(other.getATTR10())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getZXMLDOCNO() != null) {
            _hashCode += getZXMLDOCNO().hashCode();
        }
        if (getBUKRS() != null) {
            _hashCode += getBUKRS().hashCode();
        }
        if (getZWEBNO() != null) {
            _hashCode += getZWEBNO().hashCode();
        }
        if (getMAKTXK1() != null) {
            _hashCode += getMAKTXK1().hashCode();
        }
        if (getMAKTXK2() != null) {
            _hashCode += getMAKTXK2().hashCode();
        }
        if (getMTART() != null) {
            _hashCode += getMTART().hashCode();
        }
        if (getMEINS() != null) {
            _hashCode += getMEINS().hashCode();
        }
        if (getZASTATUS() != null) {
            _hashCode += getZASTATUS().hashCode();
        }
        if (getZFSTATUS() != null) {
            _hashCode += getZFSTATUS().hashCode();
        }
        if (getMATNR() != null) {
            _hashCode += getMATNR().hashCode();
        }
        if (getLVORM() != null) {
            _hashCode += getLVORM().hashCode();
        }
        if (getMATKL() != null) {
            _hashCode += getMATKL().hashCode();
        }
        if (getRESON() != null) {
            _hashCode += getRESON().hashCode();
        }
        if (getPRCTR() != null) {
            _hashCode += getPRCTR().hashCode();
        }
        if (getATTR1() != null) {
            _hashCode += getATTR1().hashCode();
        }
        if (getATTR2() != null) {
            _hashCode += getATTR2().hashCode();
        }
        if (getATTR3() != null) {
            _hashCode += getATTR3().hashCode();
        }
        if (getATTR4() != null) {
            _hashCode += getATTR4().hashCode();
        }
        if (getATTR5() != null) {
            _hashCode += getATTR5().hashCode();
        }
        if (getATTR6() != null) {
            _hashCode += getATTR6().hashCode();
        }
        if (getATTR7() != null) {
            _hashCode += getATTR7().hashCode();
        }
        if (getATTR8() != null) {
            _hashCode += getATTR8().hashCode();
        }
        if (getATTR9() != null) {
            _hashCode += getATTR9().hashCode();
        }
        if (getATTR10() != null) {
            _hashCode += getATTR10().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GMA09_GIMS_DTTB_MATER_REQUEST.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gma", ">GMA09_GIMS_DT>TB_MATER_REQUEST"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZXMLDOCNO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZXMLDOCNO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BUKRS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BUKRS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZWEBNO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZWEBNO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MAKTXK1");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MAKTXK1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MAKTXK2");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MAKTXK2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MTART");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MTART"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MEINS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MEINS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZASTATUS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZASTATUS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZFSTATUS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZFSTATUS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MATNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MATNR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("LVORM");
        elemField.setXmlName(new javax.xml.namespace.QName("", "LVORM"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MATKL");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MATKL"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("RESON");
        elemField.setXmlName(new javax.xml.namespace.QName("", "RESON"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("PRCTR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "PRCTR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR1");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR2");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR3");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR3"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR4");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR4"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR5");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR5"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR6");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR6"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR7");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR7"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR8");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR8"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR9");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR9"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ATTR10");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ATTR10"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
