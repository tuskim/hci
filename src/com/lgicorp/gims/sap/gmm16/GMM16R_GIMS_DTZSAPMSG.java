/**
 * GMM16R_GIMS_DTZSAPMSG.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm16;

public class GMM16R_GIMS_DTZSAPMSG  implements java.io.Serializable {
    /* SAP Interface ?标车??( 00. ?标车, 99. ?ろ尐 ) */
    private java.lang.String SAP_IF_STATUS;

    /* SAP Interface message */
    private java.lang.String SAP_RTN_MSG;

    /* SAP PO No. */
    private java.lang.String SAP_PO_NO;

    public GMM16R_GIMS_DTZSAPMSG() {
    }

    public GMM16R_GIMS_DTZSAPMSG(
           java.lang.String SAP_IF_STATUS,
           java.lang.String SAP_RTN_MSG,
           java.lang.String SAP_PO_NO) {
           this.SAP_IF_STATUS = SAP_IF_STATUS;
           this.SAP_RTN_MSG = SAP_RTN_MSG;
           this.SAP_PO_NO = SAP_PO_NO;
    }


    /**
     * Gets the SAP_IF_STATUS value for this GMM16R_GIMS_DTZSAPMSG.
     * 
     * @return SAP_IF_STATUS   * SAP Interface ?标车??( 00. ?标车, 99. ?ろ尐 )
     */
    public java.lang.String getSAP_IF_STATUS() {
        return SAP_IF_STATUS;
    }


    /**
     * Sets the SAP_IF_STATUS value for this GMM16R_GIMS_DTZSAPMSG.
     * 
     * @param SAP_IF_STATUS   * SAP Interface ?标车??( 00. ?标车, 99. ?ろ尐 )
     */
    public void setSAP_IF_STATUS(java.lang.String SAP_IF_STATUS) {
        this.SAP_IF_STATUS = SAP_IF_STATUS;
    }


    /**
     * Gets the SAP_RTN_MSG value for this GMM16R_GIMS_DTZSAPMSG.
     * 
     * @return SAP_RTN_MSG   * SAP Interface message
     */
    public java.lang.String getSAP_RTN_MSG() {
        return SAP_RTN_MSG;
    }


    /**
     * Sets the SAP_RTN_MSG value for this GMM16R_GIMS_DTZSAPMSG.
     * 
     * @param SAP_RTN_MSG   * SAP Interface message
     */
    public void setSAP_RTN_MSG(java.lang.String SAP_RTN_MSG) {
        this.SAP_RTN_MSG = SAP_RTN_MSG;
    }


    /**
     * Gets the SAP_PO_NO value for this GMM16R_GIMS_DTZSAPMSG.
     * 
     * @return SAP_PO_NO   * SAP PO No.
     */
    public java.lang.String getSAP_PO_NO() {
        return SAP_PO_NO;
    }


    /**
     * Sets the SAP_PO_NO value for this GMM16R_GIMS_DTZSAPMSG.
     * 
     * @param SAP_PO_NO   * SAP PO No.
     */
    public void setSAP_PO_NO(java.lang.String SAP_PO_NO) {
        this.SAP_PO_NO = SAP_PO_NO;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM16R_GIMS_DTZSAPMSG)) return false;
        GMM16R_GIMS_DTZSAPMSG other = (GMM16R_GIMS_DTZSAPMSG) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.SAP_IF_STATUS==null && other.getSAP_IF_STATUS()==null) || 
             (this.SAP_IF_STATUS!=null &&
              this.SAP_IF_STATUS.equals(other.getSAP_IF_STATUS()))) &&
            ((this.SAP_RTN_MSG==null && other.getSAP_RTN_MSG()==null) || 
             (this.SAP_RTN_MSG!=null &&
              this.SAP_RTN_MSG.equals(other.getSAP_RTN_MSG()))) &&
            ((this.SAP_PO_NO==null && other.getSAP_PO_NO()==null) || 
             (this.SAP_PO_NO!=null &&
              this.SAP_PO_NO.equals(other.getSAP_PO_NO())));
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
        if (getSAP_IF_STATUS() != null) {
            _hashCode += getSAP_IF_STATUS().hashCode();
        }
        if (getSAP_RTN_MSG() != null) {
            _hashCode += getSAP_RTN_MSG().hashCode();
        }
        if (getSAP_PO_NO() != null) {
            _hashCode += getSAP_PO_NO().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GMM16R_GIMS_DTZSAPMSG.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM16R_GIMS_DT>ZSAPMSG"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("SAP_IF_STATUS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "SAP_IF_STATUS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("SAP_RTN_MSG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "SAP_RTN_MSG"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("SAP_PO_NO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "SAP_PO_NO"));
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
