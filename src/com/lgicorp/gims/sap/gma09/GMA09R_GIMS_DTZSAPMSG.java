/**
 * GMA09R_GIMS_DTZSAPMSG.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gma09;

public class GMA09R_GIMS_DTZSAPMSG  implements java.io.Serializable {
    /* SAP Interface ?标车??(00 ?标车, 99 ?ろ尐) */
    private java.lang.String MTYPE;

    /* SAP Interface message(Success, ?ろ尐?挫毄) */
    private java.lang.String MTEXT;

    /* SAP ?濎劚 ?堧 旖旊摐 */
    private java.lang.String MATNR;

    /* SAP Request number */
    private java.lang.String ZREQNO;

    public GMA09R_GIMS_DTZSAPMSG() {
    }

    public GMA09R_GIMS_DTZSAPMSG(
           java.lang.String MTYPE,
           java.lang.String MTEXT,
           java.lang.String MATNR,
           java.lang.String ZREQNO) {
           this.MTYPE = MTYPE;
           this.MTEXT = MTEXT;
           this.MATNR = MATNR;
           this.ZREQNO = ZREQNO;
    }


    /**
     * Gets the MTYPE value for this GMA09R_GIMS_DTZSAPMSG.
     * 
     * @return MTYPE   * SAP Interface ?标车??(00 ?标车, 99 ?ろ尐)
     */
    public java.lang.String getMTYPE() {
        return MTYPE;
    }


    /**
     * Sets the MTYPE value for this GMA09R_GIMS_DTZSAPMSG.
     * 
     * @param MTYPE   * SAP Interface ?标车??(00 ?标车, 99 ?ろ尐)
     */
    public void setMTYPE(java.lang.String MTYPE) {
        this.MTYPE = MTYPE;
    }


    /**
     * Gets the MTEXT value for this GMA09R_GIMS_DTZSAPMSG.
     * 
     * @return MTEXT   * SAP Interface message(Success, ?ろ尐?挫毄)
     */
    public java.lang.String getMTEXT() {
        return MTEXT;
    }


    /**
     * Sets the MTEXT value for this GMA09R_GIMS_DTZSAPMSG.
     * 
     * @param MTEXT   * SAP Interface message(Success, ?ろ尐?挫毄)
     */
    public void setMTEXT(java.lang.String MTEXT) {
        this.MTEXT = MTEXT;
    }


    /**
     * Gets the MATNR value for this GMA09R_GIMS_DTZSAPMSG.
     * 
     * @return MATNR   * SAP ?濎劚 ?堧 旖旊摐
     */
    public java.lang.String getMATNR() {
        return MATNR;
    }


    /**
     * Sets the MATNR value for this GMA09R_GIMS_DTZSAPMSG.
     * 
     * @param MATNR   * SAP ?濎劚 ?堧 旖旊摐
     */
    public void setMATNR(java.lang.String MATNR) {
        this.MATNR = MATNR;
    }


    /**
     * Gets the ZREQNO value for this GMA09R_GIMS_DTZSAPMSG.
     * 
     * @return ZREQNO   * SAP Request number
     */
    public java.lang.String getZREQNO() {
        return ZREQNO;
    }


    /**
     * Sets the ZREQNO value for this GMA09R_GIMS_DTZSAPMSG.
     * 
     * @param ZREQNO   * SAP Request number
     */
    public void setZREQNO(java.lang.String ZREQNO) {
        this.ZREQNO = ZREQNO;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMA09R_GIMS_DTZSAPMSG)) return false;
        GMA09R_GIMS_DTZSAPMSG other = (GMA09R_GIMS_DTZSAPMSG) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.MTYPE==null && other.getMTYPE()==null) || 
             (this.MTYPE!=null &&
              this.MTYPE.equals(other.getMTYPE()))) &&
            ((this.MTEXT==null && other.getMTEXT()==null) || 
             (this.MTEXT!=null &&
              this.MTEXT.equals(other.getMTEXT()))) &&
            ((this.MATNR==null && other.getMATNR()==null) || 
             (this.MATNR!=null &&
              this.MATNR.equals(other.getMATNR()))) &&
            ((this.ZREQNO==null && other.getZREQNO()==null) || 
             (this.ZREQNO!=null &&
              this.ZREQNO.equals(other.getZREQNO())));
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
        if (getMTYPE() != null) {
            _hashCode += getMTYPE().hashCode();
        }
        if (getMTEXT() != null) {
            _hashCode += getMTEXT().hashCode();
        }
        if (getMATNR() != null) {
            _hashCode += getMATNR().hashCode();
        }
        if (getZREQNO() != null) {
            _hashCode += getZREQNO().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GMA09R_GIMS_DTZSAPMSG.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gma", ">GMA09R_GIMS_DT>ZSAPMSG"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MTYPE");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MTYPE"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MTEXT");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MTEXT"));
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
        elemField.setFieldName("ZREQNO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZREQNO"));
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
