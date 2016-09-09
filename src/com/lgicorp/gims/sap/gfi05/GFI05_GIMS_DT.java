/**
 * GFI05_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi05;

public class GFI05_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gfi05.GFI05_GIMS_DTHEADER[] HEADER;

    public GFI05_GIMS_DT() {
    }

    public GFI05_GIMS_DT(
           com.lgicorp.gims.sap.gfi05.GFI05_GIMS_DTHEADER[] HEADER) {
           this.HEADER = HEADER;
    }


    /**
     * Gets the HEADER value for this GFI05_GIMS_DT.
     * 
     * @return HEADER
     */
    public com.lgicorp.gims.sap.gfi05.GFI05_GIMS_DTHEADER[] getHEADER() {
        return HEADER;
    }


    /**
     * Sets the HEADER value for this GFI05_GIMS_DT.
     * 
     * @param HEADER
     */
    public void setHEADER(com.lgicorp.gims.sap.gfi05.GFI05_GIMS_DTHEADER[] HEADER) {
        this.HEADER = HEADER;
    }

    public com.lgicorp.gims.sap.gfi05.GFI05_GIMS_DTHEADER getHEADER(int i) {
        return this.HEADER[i];
    }

    public void setHEADER(int i, com.lgicorp.gims.sap.gfi05.GFI05_GIMS_DTHEADER _value) {
        this.HEADER[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI05_GIMS_DT)) return false;
        GFI05_GIMS_DT other = (GFI05_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.HEADER==null && other.getHEADER()==null) || 
             (this.HEADER!=null &&
              java.util.Arrays.equals(this.HEADER, other.getHEADER())));
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
        if (getHEADER() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getHEADER());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getHEADER(), i);
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
        new org.apache.axis.description.TypeDesc(GFI05_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", "GFI05_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("HEADER");
        elemField.setXmlName(new javax.xml.namespace.QName("", "HEADER"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI05_GIMS_DT>HEADER"));
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
