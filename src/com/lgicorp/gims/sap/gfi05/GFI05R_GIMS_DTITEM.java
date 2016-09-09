/**
 * GFI05R_GIMS_DTITEM.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi05;

public class GFI05R_GIMS_DTITEM  implements java.io.Serializable {
    private java.lang.String GFIMQ;

    public GFI05R_GIMS_DTITEM() {
    }

    public GFI05R_GIMS_DTITEM(
           java.lang.String GFIMQ) {
           this.GFIMQ = GFIMQ;
    }


    /**
     * Gets the GFIMQ value for this GFI05R_GIMS_DTITEM.
     * 
     * @return GFIMQ
     */
    public java.lang.String getGFIMQ() {
        return GFIMQ;
    }


    /**
     * Sets the GFIMQ value for this GFI05R_GIMS_DTITEM.
     * 
     * @param GFIMQ
     */
    public void setGFIMQ(java.lang.String GFIMQ) {
        this.GFIMQ = GFIMQ;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI05R_GIMS_DTITEM)) return false;
        GFI05R_GIMS_DTITEM other = (GFI05R_GIMS_DTITEM) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.GFIMQ==null && other.getGFIMQ()==null) || 
             (this.GFIMQ!=null &&
              this.GFIMQ.equals(other.getGFIMQ())));
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
        if (getGFIMQ() != null) {
            _hashCode += getGFIMQ().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI05R_GIMS_DTITEM.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI05R_GIMS_DT>ITEM"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("GFIMQ");
        elemField.setXmlName(new javax.xml.namespace.QName("", "GFIMQ"));
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
