/**
 * GSD01R_GIMS_DTZSAPMSG.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gsd01;

public class GSD01R_GIMS_DTZSAPMSG  implements java.io.Serializable {
    private java.lang.String CBOMTYPE;
    private java.lang.String ZSSEQ;
    private java.lang.String ZSAPMSG;

    public GSD01R_GIMS_DTZSAPMSG() {
    }

    public GSD01R_GIMS_DTZSAPMSG(
           java.lang.String CBOMTYPE,
           java.lang.String ZSSEQ,
           java.lang.String ZSAPMSG) {
           this.CBOMTYPE = CBOMTYPE;
           this.ZSSEQ = ZSSEQ;
           this.ZSAPMSG = ZSAPMSG;
    }


    /**
     * Gets the CBOMTYPE value for this GSD01R_GIMS_DTZSAPMSG.
     * 
     * @return CBOMTYPE
     */
    public java.lang.String getCBOMTYPE() {
        return CBOMTYPE;
    }


    /**
     * Sets the CBOMTYPE value for this GSD01R_GIMS_DTZSAPMSG.
     * 
     * @param CBOMTYPE
     */
    public void setCBOMTYPE(java.lang.String CBOMTYPE) {
        this.CBOMTYPE = CBOMTYPE;
    }


    /**
     * Gets the ZSSEQ value for this GSD01R_GIMS_DTZSAPMSG.
     * 
     * @return ZSSEQ
     */
    public java.lang.String getZSSEQ() {
        return ZSSEQ;
    }


    /**
     * Sets the ZSSEQ value for this GSD01R_GIMS_DTZSAPMSG.
     * 
     * @param ZSSEQ
     */
    public void setZSSEQ(java.lang.String ZSSEQ) {
        this.ZSSEQ = ZSSEQ;
    }


    /**
     * Gets the ZSAPMSG value for this GSD01R_GIMS_DTZSAPMSG.
     * 
     * @return ZSAPMSG
     */
    public java.lang.String getZSAPMSG() {
        return ZSAPMSG;
    }


    /**
     * Sets the ZSAPMSG value for this GSD01R_GIMS_DTZSAPMSG.
     * 
     * @param ZSAPMSG
     */
    public void setZSAPMSG(java.lang.String ZSAPMSG) {
        this.ZSAPMSG = ZSAPMSG;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GSD01R_GIMS_DTZSAPMSG)) return false;
        GSD01R_GIMS_DTZSAPMSG other = (GSD01R_GIMS_DTZSAPMSG) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.CBOMTYPE==null && other.getCBOMTYPE()==null) || 
             (this.CBOMTYPE!=null &&
              this.CBOMTYPE.equals(other.getCBOMTYPE()))) &&
            ((this.ZSSEQ==null && other.getZSSEQ()==null) || 
             (this.ZSSEQ!=null &&
              this.ZSSEQ.equals(other.getZSSEQ()))) &&
            ((this.ZSAPMSG==null && other.getZSAPMSG()==null) || 
             (this.ZSAPMSG!=null &&
              this.ZSAPMSG.equals(other.getZSAPMSG())));
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
        if (getCBOMTYPE() != null) {
            _hashCode += getCBOMTYPE().hashCode();
        }
        if (getZSSEQ() != null) {
            _hashCode += getZSSEQ().hashCode();
        }
        if (getZSAPMSG() != null) {
            _hashCode += getZSAPMSG().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GSD01R_GIMS_DTZSAPMSG.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gsd", ">GSD01R_GIMS_DT>ZSAPMSG"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("CBOMTYPE");
        elemField.setXmlName(new javax.xml.namespace.QName("", "CBOMTYPE"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZSSEQ");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZSSEQ"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZSAPMSG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZSAPMSG"));
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
