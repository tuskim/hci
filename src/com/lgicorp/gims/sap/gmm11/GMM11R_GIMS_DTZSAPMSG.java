/**
 * GMM11R_GIMS_DTZSAPMSG.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm11;

public class GMM11R_GIMS_DTZSAPMSG  implements java.io.Serializable {
    private java.lang.String MTYPE;

    private java.lang.String MTEXT;

    private java.lang.String SAP_GI_NO;

    private java.lang.String SAP_GR_NO;

    private java.lang.String MJAHR;

    private java.lang.String STATUS;

    public GMM11R_GIMS_DTZSAPMSG() {
    }

    public GMM11R_GIMS_DTZSAPMSG(
           java.lang.String MTYPE,
           java.lang.String MTEXT,
           java.lang.String SAP_GI_NO,
           java.lang.String SAP_GR_NO,
           java.lang.String MJAHR,
           java.lang.String STATUS) {
           this.MTYPE = MTYPE;
           this.MTEXT = MTEXT;
           this.SAP_GI_NO = SAP_GI_NO;
           this.SAP_GR_NO = SAP_GR_NO;
           this.MJAHR = MJAHR;
           this.STATUS = STATUS;
    }


    /**
     * Gets the MTYPE value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @return MTYPE
     */
    public java.lang.String getMTYPE() {
        return MTYPE;
    }


    /**
     * Sets the MTYPE value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @param MTYPE
     */
    public void setMTYPE(java.lang.String MTYPE) {
        this.MTYPE = MTYPE;
    }


    /**
     * Gets the MTEXT value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @return MTEXT
     */
    public java.lang.String getMTEXT() {
        return MTEXT;
    }


    /**
     * Sets the MTEXT value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @param MTEXT
     */
    public void setMTEXT(java.lang.String MTEXT) {
        this.MTEXT = MTEXT;
    }


    /**
     * Gets the SAP_GI_NO value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @return SAP_GI_NO
     */
    public java.lang.String getSAP_GI_NO() {
        return SAP_GI_NO;
    }


    /**
     * Sets the SAP_GI_NO value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @param SAP_GI_NO
     */
    public void setSAP_GI_NO(java.lang.String SAP_GI_NO) {
        this.SAP_GI_NO = SAP_GI_NO;
    }


    /**
     * Gets the SAP_GR_NO value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @return SAP_GR_NO
     */
    public java.lang.String getSAP_GR_NO() {
        return SAP_GR_NO;
    }


    /**
     * Sets the SAP_GR_NO value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @param SAP_GR_NO
     */
    public void setSAP_GR_NO(java.lang.String SAP_GR_NO) {
        this.SAP_GR_NO = SAP_GR_NO;
    }


    /**
     * Gets the MJAHR value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @return MJAHR
     */
    public java.lang.String getMJAHR() {
        return MJAHR;
    }


    /**
     * Sets the MJAHR value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @param MJAHR
     */
    public void setMJAHR(java.lang.String MJAHR) {
        this.MJAHR = MJAHR;
    }


    /**
     * Gets the STATUS value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @return STATUS
     */
    public java.lang.String getSTATUS() {
        return STATUS;
    }


    /**
     * Sets the STATUS value for this GMM11R_GIMS_DTZSAPMSG.
     * 
     * @param STATUS
     */
    public void setSTATUS(java.lang.String STATUS) {
        this.STATUS = STATUS;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM11R_GIMS_DTZSAPMSG)) return false;
        GMM11R_GIMS_DTZSAPMSG other = (GMM11R_GIMS_DTZSAPMSG) obj;
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
            ((this.SAP_GI_NO==null && other.getSAP_GI_NO()==null) || 
             (this.SAP_GI_NO!=null &&
              this.SAP_GI_NO.equals(other.getSAP_GI_NO()))) &&
            ((this.SAP_GR_NO==null && other.getSAP_GR_NO()==null) || 
             (this.SAP_GR_NO!=null &&
              this.SAP_GR_NO.equals(other.getSAP_GR_NO()))) &&
            ((this.MJAHR==null && other.getMJAHR()==null) || 
             (this.MJAHR!=null &&
              this.MJAHR.equals(other.getMJAHR()))) &&
            ((this.STATUS==null && other.getSTATUS()==null) || 
             (this.STATUS!=null &&
              this.STATUS.equals(other.getSTATUS())));
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
        if (getSAP_GI_NO() != null) {
            _hashCode += getSAP_GI_NO().hashCode();
        }
        if (getSAP_GR_NO() != null) {
            _hashCode += getSAP_GR_NO().hashCode();
        }
        if (getMJAHR() != null) {
            _hashCode += getMJAHR().hashCode();
        }
        if (getSTATUS() != null) {
            _hashCode += getSTATUS().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GMM11R_GIMS_DTZSAPMSG.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM11R_GIMS_DT>ZSAPMSG"));
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
        elemField.setFieldName("SAP_GI_NO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "SAP_GI_NO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("SAP_GR_NO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "SAP_GR_NO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MJAHR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MJAHR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("STATUS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "STATUS"));
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
