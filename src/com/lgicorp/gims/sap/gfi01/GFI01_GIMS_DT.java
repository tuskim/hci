/**
 * GFI01_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi01;

public class GFI01_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0001[] ZFIMT0001;
    private com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0002[] ZFIMT0002;

    public GFI01_GIMS_DT() {
    }

    public GFI01_GIMS_DT(
           com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0001[] ZFIMT0001,
           com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0002[] ZFIMT0002) {
           this.ZFIMT0001 = ZFIMT0001;
           this.ZFIMT0002 = ZFIMT0002;
    }


    /**
     * Gets the ZFIMT0001 value for this GFI01_GIMS_DT.
     * 
     * @return ZFIMT0001
     */
    public com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0001[] getZFIMT0001() {
        return ZFIMT0001;
    }


    /**
     * Sets the ZFIMT0001 value for this GFI01_GIMS_DT.
     * 
     * @param ZFIMT0001
     */
    public void setZFIMT0001(com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0001[] ZFIMT0001) {
        this.ZFIMT0001 = ZFIMT0001;
    }

    public com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0001 getZFIMT0001(int i) {
        return this.ZFIMT0001[i];
    }

    public void setZFIMT0001(int i, com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0001 _value) {
        this.ZFIMT0001[i] = _value;
    }


    /**
     * Gets the ZFIMT0002 value for this GFI01_GIMS_DT.
     * 
     * @return ZFIMT0002
     */
    public com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0002[] getZFIMT0002() {
        return ZFIMT0002;
    }


    /**
     * Sets the ZFIMT0002 value for this GFI01_GIMS_DT.
     * 
     * @param ZFIMT0002
     */
    public void setZFIMT0002(com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0002[] ZFIMT0002) {
        this.ZFIMT0002 = ZFIMT0002;
    }

    public com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0002 getZFIMT0002(int i) {
        return this.ZFIMT0002[i];
    }

    public void setZFIMT0002(int i, com.lgicorp.gims.sap.gfi01.GFI01_GIMS_DTZFIMT0002 _value) {
        this.ZFIMT0002[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI01_GIMS_DT)) return false;
        GFI01_GIMS_DT other = (GFI01_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZFIMT0001==null && other.getZFIMT0001()==null) || 
             (this.ZFIMT0001!=null &&
              java.util.Arrays.equals(this.ZFIMT0001, other.getZFIMT0001()))) &&
            ((this.ZFIMT0002==null && other.getZFIMT0002()==null) || 
             (this.ZFIMT0002!=null &&
              java.util.Arrays.equals(this.ZFIMT0002, other.getZFIMT0002())));
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
        if (getZFIMT0001() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZFIMT0001());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZFIMT0001(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getZFIMT0002() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZFIMT0002());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZFIMT0002(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI01_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", "GFI01_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZFIMT0001");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZFIMT0001"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI01_GIMS_DT>ZFIMT0001"));
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZFIMT0002");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZFIMT0002"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI01_GIMS_DT>ZFIMT0002"));
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
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
