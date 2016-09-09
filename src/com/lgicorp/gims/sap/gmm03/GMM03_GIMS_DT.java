/**
 * GMM03_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm03;

public class GMM03_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gmm03.GMM03_GIMS_DTZMMMT08[] ZMMMT08;

    public GMM03_GIMS_DT() {
    }

    public GMM03_GIMS_DT(
           com.lgicorp.gims.sap.gmm03.GMM03_GIMS_DTZMMMT08[] ZMMMT08) {
           this.ZMMMT08 = ZMMMT08;
    }


    /**
     * Gets the ZMMMT08 value for this GMM03_GIMS_DT.
     * 
     * @return ZMMMT08
     */
    public com.lgicorp.gims.sap.gmm03.GMM03_GIMS_DTZMMMT08[] getZMMMT08() {
        return ZMMMT08;
    }


    /**
     * Sets the ZMMMT08 value for this GMM03_GIMS_DT.
     * 
     * @param ZMMMT08
     */
    public void setZMMMT08(com.lgicorp.gims.sap.gmm03.GMM03_GIMS_DTZMMMT08[] ZMMMT08) {
        this.ZMMMT08 = ZMMMT08;
    }

    public com.lgicorp.gims.sap.gmm03.GMM03_GIMS_DTZMMMT08 getZMMMT08(int i) {
        return this.ZMMMT08[i];
    }

    public void setZMMMT08(int i, com.lgicorp.gims.sap.gmm03.GMM03_GIMS_DTZMMMT08 _value) {
        this.ZMMMT08[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM03_GIMS_DT)) return false;
        GMM03_GIMS_DT other = (GMM03_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZMMMT08==null && other.getZMMMT08()==null) || 
             (this.ZMMMT08!=null &&
              java.util.Arrays.equals(this.ZMMMT08, other.getZMMMT08())));
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
        if (getZMMMT08() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZMMMT08());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZMMMT08(), i);
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
        new org.apache.axis.description.TypeDesc(GMM03_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", "GMM03_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT08");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT08"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM03_GIMS_DT>ZMMMT08"));
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
