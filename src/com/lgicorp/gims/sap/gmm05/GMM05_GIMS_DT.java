/**
 * GMM05_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm05;

public class GMM05_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT09 ZMMMT09;
    private com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT10[] ZMMMT10;

    public GMM05_GIMS_DT() {
    }

    public GMM05_GIMS_DT(
           com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT09 ZMMMT09,
           com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT10[] ZMMMT10) {
           this.ZMMMT09 = ZMMMT09;
           this.ZMMMT10 = ZMMMT10;
    }


    /**
     * Gets the ZMMMT09 value for this GMM05_GIMS_DT.
     * 
     * @return ZMMMT09
     */
    public com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT09 getZMMMT09() {
        return ZMMMT09;
    }


    /**
     * Sets the ZMMMT09 value for this GMM05_GIMS_DT.
     * 
     * @param ZMMMT09
     */
    public void setZMMMT09(com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT09 ZMMMT09) {
        this.ZMMMT09 = ZMMMT09;
    }


    /**
     * Gets the ZMMMT10 value for this GMM05_GIMS_DT.
     * 
     * @return ZMMMT10
     */
    public com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT10[] getZMMMT10() {
        return ZMMMT10;
    }


    /**
     * Sets the ZMMMT10 value for this GMM05_GIMS_DT.
     * 
     * @param ZMMMT10
     */
    public void setZMMMT10(com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT10[] ZMMMT10) {
        this.ZMMMT10 = ZMMMT10;
    }

    public com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT10 getZMMMT10(int i) {
        return this.ZMMMT10[i];
    }

    public void setZMMMT10(int i, com.lgicorp.gims.sap.gmm05.GMM05_GIMS_DTZMMMT10 _value) {
        this.ZMMMT10[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM05_GIMS_DT)) return false;
        GMM05_GIMS_DT other = (GMM05_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZMMMT09==null && other.getZMMMT09()==null) || 
             (this.ZMMMT09!=null &&
              this.ZMMMT09.equals(other.getZMMMT09()))) &&
            ((this.ZMMMT10==null && other.getZMMMT10()==null) || 
             (this.ZMMMT10!=null &&
              java.util.Arrays.equals(this.ZMMMT10, other.getZMMMT10())));
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
        if (getZMMMT09() != null) {
            _hashCode += getZMMMT09().hashCode();
        }
        if (getZMMMT10() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZMMMT10());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZMMMT10(), i);
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
        new org.apache.axis.description.TypeDesc(GMM05_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", "GMM05_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT09");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT09"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM05_GIMS_DT>ZMMMT09"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT10");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT10"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM05_GIMS_DT>ZMMMT10"));
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
