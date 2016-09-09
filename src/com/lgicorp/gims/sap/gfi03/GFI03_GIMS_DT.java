/**
 * GFI03_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi03;

public class GFI03_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gfi03.GFI03_GIMS_DTT001B t001B;

    public GFI03_GIMS_DT() {
    }

    public GFI03_GIMS_DT(
           com.lgicorp.gims.sap.gfi03.GFI03_GIMS_DTT001B t001B) {
           this.t001B = t001B;
    }


    /**
     * Gets the t001B value for this GFI03_GIMS_DT.
     * 
     * @return t001B
     */
    public com.lgicorp.gims.sap.gfi03.GFI03_GIMS_DTT001B getT001B() {
        return t001B;
    }


    /**
     * Sets the t001B value for this GFI03_GIMS_DT.
     * 
     * @param t001B
     */
    public void setT001B(com.lgicorp.gims.sap.gfi03.GFI03_GIMS_DTT001B t001B) {
        this.t001B = t001B;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI03_GIMS_DT)) return false;
        GFI03_GIMS_DT other = (GFI03_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.t001B==null && other.getT001B()==null) || 
             (this.t001B!=null &&
              this.t001B.equals(other.getT001B())));
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
        if (getT001B() != null) {
            _hashCode += getT001B().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI03_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", "GFI03_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("t001B");
        elemField.setXmlName(new javax.xml.namespace.QName("", "T001B"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI03_GIMS_DT>T001B"));
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
