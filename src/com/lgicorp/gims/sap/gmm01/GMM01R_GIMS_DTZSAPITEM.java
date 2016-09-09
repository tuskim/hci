/**
 * GMM01R_GIMS_DTZSAPITEM.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm01;

public class GMM01R_GIMS_DTZSAPITEM  implements java.io.Serializable {
    private java.lang.String BUKRS;
    private java.lang.String ZEBELN;
    private java.lang.String EBELP;
    private java.lang.String ZNETPR;

    public GMM01R_GIMS_DTZSAPITEM() {
    }

    public GMM01R_GIMS_DTZSAPITEM(
           java.lang.String BUKRS,
           java.lang.String ZEBELN,
           java.lang.String EBELP,
           java.lang.String ZNETPR) {
           this.BUKRS = BUKRS;
           this.ZEBELN = ZEBELN;
           this.EBELP = EBELP;
           this.ZNETPR = ZNETPR;
    }


    /**
     * Gets the BUKRS value for this GMM01R_GIMS_DTZSAPITEM.
     * 
     * @return BUKRS
     */
    public java.lang.String getBUKRS() {
        return BUKRS;
    }


    /**
     * Sets the BUKRS value for this GMM01R_GIMS_DTZSAPITEM.
     * 
     * @param BUKRS
     */
    public void setBUKRS(java.lang.String BUKRS) {
        this.BUKRS = BUKRS;
    }


    /**
     * Gets the ZEBELN value for this GMM01R_GIMS_DTZSAPITEM.
     * 
     * @return ZEBELN
     */
    public java.lang.String getZEBELN() {
        return ZEBELN;
    }


    /**
     * Sets the ZEBELN value for this GMM01R_GIMS_DTZSAPITEM.
     * 
     * @param ZEBELN
     */
    public void setZEBELN(java.lang.String ZEBELN) {
        this.ZEBELN = ZEBELN;
    }


    /**
     * Gets the EBELP value for this GMM01R_GIMS_DTZSAPITEM.
     * 
     * @return EBELP
     */
    public java.lang.String getEBELP() {
        return EBELP;
    }


    /**
     * Sets the EBELP value for this GMM01R_GIMS_DTZSAPITEM.
     * 
     * @param EBELP
     */
    public void setEBELP(java.lang.String EBELP) {
        this.EBELP = EBELP;
    }


    /**
     * Gets the ZNETPR value for this GMM01R_GIMS_DTZSAPITEM.
     * 
     * @return ZNETPR
     */
    public java.lang.String getZNETPR() {
        return ZNETPR;
    }


    /**
     * Sets the ZNETPR value for this GMM01R_GIMS_DTZSAPITEM.
     * 
     * @param ZNETPR
     */
    public void setZNETPR(java.lang.String ZNETPR) {
        this.ZNETPR = ZNETPR;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM01R_GIMS_DTZSAPITEM)) return false;
        GMM01R_GIMS_DTZSAPITEM other = (GMM01R_GIMS_DTZSAPITEM) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.BUKRS==null && other.getBUKRS()==null) || 
             (this.BUKRS!=null &&
              this.BUKRS.equals(other.getBUKRS()))) &&
            ((this.ZEBELN==null && other.getZEBELN()==null) || 
             (this.ZEBELN!=null &&
              this.ZEBELN.equals(other.getZEBELN()))) &&
            ((this.EBELP==null && other.getEBELP()==null) || 
             (this.EBELP!=null &&
              this.EBELP.equals(other.getEBELP()))) &&
            ((this.ZNETPR==null && other.getZNETPR()==null) || 
             (this.ZNETPR!=null &&
              this.ZNETPR.equals(other.getZNETPR())));
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
        if (getBUKRS() != null) {
            _hashCode += getBUKRS().hashCode();
        }
        if (getZEBELN() != null) {
            _hashCode += getZEBELN().hashCode();
        }
        if (getEBELP() != null) {
            _hashCode += getEBELP().hashCode();
        }
        if (getZNETPR() != null) {
            _hashCode += getZNETPR().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GMM01R_GIMS_DTZSAPITEM.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM01R_GIMS_DT>ZSAPITEM"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BUKRS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BUKRS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZEBELN");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZEBELN"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("EBELP");
        elemField.setXmlName(new javax.xml.namespace.QName("", "EBELP"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZNETPR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZNETPR"));
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
