/**
 * GFI05_GIMS_DTHEADER.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi05;

public class GFI05_GIMS_DTHEADER  implements java.io.Serializable {
    private java.lang.String ZXMLDOCNO;
    private java.lang.String BUKRS;
    private java.lang.String GJAHR;
    private java.lang.String BELNR;

    public GFI05_GIMS_DTHEADER() {
    }

    public GFI05_GIMS_DTHEADER(
           java.lang.String ZXMLDOCNO,
           java.lang.String BUKRS,
           java.lang.String GJAHR,
           java.lang.String BELNR) {
           this.ZXMLDOCNO = ZXMLDOCNO;
           this.BUKRS = BUKRS;
           this.GJAHR = GJAHR;
           this.BELNR = BELNR;
    }


    /**
     * Gets the ZXMLDOCNO value for this GFI05_GIMS_DTHEADER.
     * 
     * @return ZXMLDOCNO
     */
    public java.lang.String getZXMLDOCNO() {
        return ZXMLDOCNO;
    }


    /**
     * Sets the ZXMLDOCNO value for this GFI05_GIMS_DTHEADER.
     * 
     * @param ZXMLDOCNO
     */
    public void setZXMLDOCNO(java.lang.String ZXMLDOCNO) {
        this.ZXMLDOCNO = ZXMLDOCNO;
    }


    /**
     * Gets the BUKRS value for this GFI05_GIMS_DTHEADER.
     * 
     * @return BUKRS
     */
    public java.lang.String getBUKRS() {
        return BUKRS;
    }


    /**
     * Sets the BUKRS value for this GFI05_GIMS_DTHEADER.
     * 
     * @param BUKRS
     */
    public void setBUKRS(java.lang.String BUKRS) {
        this.BUKRS = BUKRS;
    }


    /**
     * Gets the GJAHR value for this GFI05_GIMS_DTHEADER.
     * 
     * @return GJAHR
     */
    public java.lang.String getGJAHR() {
        return GJAHR;
    }


    /**
     * Sets the GJAHR value for this GFI05_GIMS_DTHEADER.
     * 
     * @param GJAHR
     */
    public void setGJAHR(java.lang.String GJAHR) {
        this.GJAHR = GJAHR;
    }


    /**
     * Gets the BELNR value for this GFI05_GIMS_DTHEADER.
     * 
     * @return BELNR
     */
    public java.lang.String getBELNR() {
        return BELNR;
    }


    /**
     * Sets the BELNR value for this GFI05_GIMS_DTHEADER.
     * 
     * @param BELNR
     */
    public void setBELNR(java.lang.String BELNR) {
        this.BELNR = BELNR;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI05_GIMS_DTHEADER)) return false;
        GFI05_GIMS_DTHEADER other = (GFI05_GIMS_DTHEADER) obj;
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
            ((this.GJAHR==null && other.getGJAHR()==null) || 
             (this.GJAHR!=null &&
              this.GJAHR.equals(other.getGJAHR()))) &&
            ((this.BELNR==null && other.getBELNR()==null) || 
             (this.BELNR!=null &&
              this.BELNR.equals(other.getBELNR())));
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
        if (getGJAHR() != null) {
            _hashCode += getGJAHR().hashCode();
        }
        if (getBELNR() != null) {
            _hashCode += getBELNR().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI05_GIMS_DTHEADER.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI05_GIMS_DT>HEADER"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZXMLDOCNO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZXMLDOCNO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BUKRS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BUKRS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("GJAHR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "GJAHR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BELNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BELNR"));
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
