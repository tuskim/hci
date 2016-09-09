/**
 * GFI07R_GIMS_DTITEM.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi07;

public class GFI07R_GIMS_DTITEM  implements java.io.Serializable {
    private java.lang.String COMPANY_CD;

    private java.lang.String REQUEST_NO;

    private java.lang.String PAYMENT_BLOCK_KEY;

    private java.lang.String SAP_REQUEST_NO;

    private java.lang.String SAP_STATUS;

    private java.lang.String SAP_RTN_MSG;

    public GFI07R_GIMS_DTITEM() {
    }

    public GFI07R_GIMS_DTITEM(
           java.lang.String COMPANY_CD,
           java.lang.String REQUEST_NO,
           java.lang.String PAYMENT_BLOCK_KEY,
           java.lang.String SAP_REQUEST_NO,
           java.lang.String SAP_STATUS,
           java.lang.String SAP_RTN_MSG) {
           this.COMPANY_CD = COMPANY_CD;
           this.REQUEST_NO = REQUEST_NO;
           this.PAYMENT_BLOCK_KEY = PAYMENT_BLOCK_KEY;
           this.SAP_REQUEST_NO = SAP_REQUEST_NO;
           this.SAP_STATUS = SAP_STATUS;
           this.SAP_RTN_MSG = SAP_RTN_MSG;
    }


    /**
     * Gets the COMPANY_CD value for this GFI07R_GIMS_DTITEM.
     * 
     * @return COMPANY_CD
     */
    public java.lang.String getCOMPANY_CD() {
        return COMPANY_CD;
    }


    /**
     * Sets the COMPANY_CD value for this GFI07R_GIMS_DTITEM.
     * 
     * @param COMPANY_CD
     */
    public void setCOMPANY_CD(java.lang.String COMPANY_CD) {
        this.COMPANY_CD = COMPANY_CD;
    }


    /**
     * Gets the REQUEST_NO value for this GFI07R_GIMS_DTITEM.
     * 
     * @return REQUEST_NO
     */
    public java.lang.String getREQUEST_NO() {
        return REQUEST_NO;
    }


    /**
     * Sets the REQUEST_NO value for this GFI07R_GIMS_DTITEM.
     * 
     * @param REQUEST_NO
     */
    public void setREQUEST_NO(java.lang.String REQUEST_NO) {
        this.REQUEST_NO = REQUEST_NO;
    }


    /**
     * Gets the PAYMENT_BLOCK_KEY value for this GFI07R_GIMS_DTITEM.
     * 
     * @return PAYMENT_BLOCK_KEY
     */
    public java.lang.String getPAYMENT_BLOCK_KEY() {
        return PAYMENT_BLOCK_KEY;
    }


    /**
     * Sets the PAYMENT_BLOCK_KEY value for this GFI07R_GIMS_DTITEM.
     * 
     * @param PAYMENT_BLOCK_KEY
     */
    public void setPAYMENT_BLOCK_KEY(java.lang.String PAYMENT_BLOCK_KEY) {
        this.PAYMENT_BLOCK_KEY = PAYMENT_BLOCK_KEY;
    }


    /**
     * Gets the SAP_REQUEST_NO value for this GFI07R_GIMS_DTITEM.
     * 
     * @return SAP_REQUEST_NO
     */
    public java.lang.String getSAP_REQUEST_NO() {
        return SAP_REQUEST_NO;
    }


    /**
     * Sets the SAP_REQUEST_NO value for this GFI07R_GIMS_DTITEM.
     * 
     * @param SAP_REQUEST_NO
     */
    public void setSAP_REQUEST_NO(java.lang.String SAP_REQUEST_NO) {
        this.SAP_REQUEST_NO = SAP_REQUEST_NO;
    }


    /**
     * Gets the SAP_STATUS value for this GFI07R_GIMS_DTITEM.
     * 
     * @return SAP_STATUS
     */
    public java.lang.String getSAP_STATUS() {
        return SAP_STATUS;
    }


    /**
     * Sets the SAP_STATUS value for this GFI07R_GIMS_DTITEM.
     * 
     * @param SAP_STATUS
     */
    public void setSAP_STATUS(java.lang.String SAP_STATUS) {
        this.SAP_STATUS = SAP_STATUS;
    }


    /**
     * Gets the SAP_RTN_MSG value for this GFI07R_GIMS_DTITEM.
     * 
     * @return SAP_RTN_MSG
     */
    public java.lang.String getSAP_RTN_MSG() {
        return SAP_RTN_MSG;
    }


    /**
     * Sets the SAP_RTN_MSG value for this GFI07R_GIMS_DTITEM.
     * 
     * @param SAP_RTN_MSG
     */
    public void setSAP_RTN_MSG(java.lang.String SAP_RTN_MSG) {
        this.SAP_RTN_MSG = SAP_RTN_MSG;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI07R_GIMS_DTITEM)) return false;
        GFI07R_GIMS_DTITEM other = (GFI07R_GIMS_DTITEM) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.COMPANY_CD==null && other.getCOMPANY_CD()==null) || 
             (this.COMPANY_CD!=null &&
              this.COMPANY_CD.equals(other.getCOMPANY_CD()))) &&
            ((this.REQUEST_NO==null && other.getREQUEST_NO()==null) || 
             (this.REQUEST_NO!=null &&
              this.REQUEST_NO.equals(other.getREQUEST_NO()))) &&
            ((this.PAYMENT_BLOCK_KEY==null && other.getPAYMENT_BLOCK_KEY()==null) || 
             (this.PAYMENT_BLOCK_KEY!=null &&
              this.PAYMENT_BLOCK_KEY.equals(other.getPAYMENT_BLOCK_KEY()))) &&
            ((this.SAP_REQUEST_NO==null && other.getSAP_REQUEST_NO()==null) || 
             (this.SAP_REQUEST_NO!=null &&
              this.SAP_REQUEST_NO.equals(other.getSAP_REQUEST_NO()))) &&
            ((this.SAP_STATUS==null && other.getSAP_STATUS()==null) || 
             (this.SAP_STATUS!=null &&
              this.SAP_STATUS.equals(other.getSAP_STATUS()))) &&
            ((this.SAP_RTN_MSG==null && other.getSAP_RTN_MSG()==null) || 
             (this.SAP_RTN_MSG!=null &&
              this.SAP_RTN_MSG.equals(other.getSAP_RTN_MSG())));
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
        if (getCOMPANY_CD() != null) {
            _hashCode += getCOMPANY_CD().hashCode();
        }
        if (getREQUEST_NO() != null) {
            _hashCode += getREQUEST_NO().hashCode();
        }
        if (getPAYMENT_BLOCK_KEY() != null) {
            _hashCode += getPAYMENT_BLOCK_KEY().hashCode();
        }
        if (getSAP_REQUEST_NO() != null) {
            _hashCode += getSAP_REQUEST_NO().hashCode();
        }
        if (getSAP_STATUS() != null) {
            _hashCode += getSAP_STATUS().hashCode();
        }
        if (getSAP_RTN_MSG() != null) {
            _hashCode += getSAP_RTN_MSG().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI07R_GIMS_DTITEM.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI07R_GIMS_DT>ITEM"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("COMPANY_CD");
        elemField.setXmlName(new javax.xml.namespace.QName("", "COMPANY_CD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("REQUEST_NO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "REQUEST_NO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("PAYMENT_BLOCK_KEY");
        elemField.setXmlName(new javax.xml.namespace.QName("", "PAYMENT_BLOCK_KEY"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("SAP_REQUEST_NO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "SAP_REQUEST_NO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("SAP_STATUS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "SAP_STATUS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("SAP_RTN_MSG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "SAP_RTN_MSG"));
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
