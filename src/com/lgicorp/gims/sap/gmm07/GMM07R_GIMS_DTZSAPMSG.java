/**
 * GMM07R_GIMS_DTZSAPMSG.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm07;

public class GMM07R_GIMS_DTZSAPMSG  implements java.io.Serializable {
    private java.lang.String MBLNR;
    private java.lang.String BELNR;
    private java.lang.String MTYPE;
    private java.lang.String MTEXT;

    public GMM07R_GIMS_DTZSAPMSG() {
    }

    public GMM07R_GIMS_DTZSAPMSG(
           java.lang.String MBLNR,
           java.lang.String BELNR,
           java.lang.String MTYPE,
           java.lang.String MTEXT) {
           this.MBLNR = MBLNR;
           this.BELNR = BELNR;
           this.MTYPE = MTYPE;
           this.MTEXT = MTEXT;
    }


    /**
     * Gets the MBLNR value for this GMM07R_GIMS_DTZSAPMSG.
     * 
     * @return MBLNR
     */
    public java.lang.String getMBLNR() {
        return MBLNR;
    }


    /**
     * Sets the MBLNR value for this GMM07R_GIMS_DTZSAPMSG.
     * 
     * @param MBLNR
     */
    public void setMBLNR(java.lang.String MBLNR) {
        this.MBLNR = MBLNR;
    }


    /**
     * Gets the BELNR value for this GMM07R_GIMS_DTZSAPMSG.
     * 
     * @return BELNR
     */
    public java.lang.String getBELNR() {
        return BELNR;
    }


    /**
     * Sets the BELNR value for this GMM07R_GIMS_DTZSAPMSG.
     * 
     * @param BELNR
     */
    public void setBELNR(java.lang.String BELNR) {
        this.BELNR = BELNR;
    }


    /**
     * Gets the MTYPE value for this GMM07R_GIMS_DTZSAPMSG.
     * 
     * @return MTYPE
     */
    public java.lang.String getMTYPE() {
        return MTYPE;
    }


    /**
     * Sets the MTYPE value for this GMM07R_GIMS_DTZSAPMSG.
     * 
     * @param MTYPE
     */
    public void setMTYPE(java.lang.String MTYPE) {
        this.MTYPE = MTYPE;
    }


    /**
     * Gets the MTEXT value for this GMM07R_GIMS_DTZSAPMSG.
     * 
     * @return MTEXT
     */
    public java.lang.String getMTEXT() {
        return MTEXT;
    }


    /**
     * Sets the MTEXT value for this GMM07R_GIMS_DTZSAPMSG.
     * 
     * @param MTEXT
     */
    public void setMTEXT(java.lang.String MTEXT) {
        this.MTEXT = MTEXT;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM07R_GIMS_DTZSAPMSG)) return false;
        GMM07R_GIMS_DTZSAPMSG other = (GMM07R_GIMS_DTZSAPMSG) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.MBLNR==null && other.getMBLNR()==null) || 
             (this.MBLNR!=null &&
              this.MBLNR.equals(other.getMBLNR()))) &&
            ((this.BELNR==null && other.getBELNR()==null) || 
             (this.BELNR!=null &&
              this.BELNR.equals(other.getBELNR()))) &&
            ((this.MTYPE==null && other.getMTYPE()==null) || 
             (this.MTYPE!=null &&
              this.MTYPE.equals(other.getMTYPE()))) &&
            ((this.MTEXT==null && other.getMTEXT()==null) || 
             (this.MTEXT!=null &&
              this.MTEXT.equals(other.getMTEXT())));
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
        if (getMBLNR() != null) {
            _hashCode += getMBLNR().hashCode();
        }
        if (getBELNR() != null) {
            _hashCode += getBELNR().hashCode();
        }
        if (getMTYPE() != null) {
            _hashCode += getMTYPE().hashCode();
        }
        if (getMTEXT() != null) {
            _hashCode += getMTEXT().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GMM07R_GIMS_DTZSAPMSG.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM07R_GIMS_DT>ZSAPMSG"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MBLNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MBLNR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BELNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BELNR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MTYPE");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MTYPE"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MTEXT");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MTEXT"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
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
