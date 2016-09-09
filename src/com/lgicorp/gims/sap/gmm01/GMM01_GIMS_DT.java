/**
 * GMM01_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm01;

public class GMM01_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT004 ZMMMT004;
    private com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT005[] ZMMMT005;

    public GMM01_GIMS_DT() {
    }

    public GMM01_GIMS_DT(
           com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT004 ZMMMT004,
           com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT005[] ZMMMT005) {
           this.ZMMMT004 = ZMMMT004;
           this.ZMMMT005 = ZMMMT005;
    }


    /**
     * Gets the ZMMMT004 value for this GMM01_GIMS_DT.
     * 
     * @return ZMMMT004
     */
    public com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT004 getZMMMT004() {
        return ZMMMT004;
    }


    /**
     * Sets the ZMMMT004 value for this GMM01_GIMS_DT.
     * 
     * @param ZMMMT004
     */
    public void setZMMMT004(com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT004 ZMMMT004) {
        this.ZMMMT004 = ZMMMT004;
    }


    /**
     * Gets the ZMMMT005 value for this GMM01_GIMS_DT.
     * 
     * @return ZMMMT005
     */
    public com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT005[] getZMMMT005() {
        return ZMMMT005;
    }


    /**
     * Sets the ZMMMT005 value for this GMM01_GIMS_DT.
     * 
     * @param ZMMMT005
     */
    public void setZMMMT005(com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT005[] ZMMMT005) {
        this.ZMMMT005 = ZMMMT005;
    }

    public com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT005 getZMMMT005(int i) {
        return this.ZMMMT005[i];
    }

    public void setZMMMT005(int i, com.lgicorp.gims.sap.gmm01.GMM01_GIMS_DTZMMMT005 _value) {
        this.ZMMMT005[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM01_GIMS_DT)) return false;
        GMM01_GIMS_DT other = (GMM01_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZMMMT004==null && other.getZMMMT004()==null) || 
             (this.ZMMMT004!=null &&
              this.ZMMMT004.equals(other.getZMMMT004()))) &&
            ((this.ZMMMT005==null && other.getZMMMT005()==null) || 
             (this.ZMMMT005!=null &&
              java.util.Arrays.equals(this.ZMMMT005, other.getZMMMT005())));
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
        if (getZMMMT004() != null) {
            _hashCode += getZMMMT004().hashCode();
        }
        if (getZMMMT005() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZMMMT005());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZMMMT005(), i);
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
        new org.apache.axis.description.TypeDesc(GMM01_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", "GMM01_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT004");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT004"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM01_GIMS_DT>ZMMMT004"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT005");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT005"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM01_GIMS_DT>ZMMMT005"));
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
