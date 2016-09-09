/**
 * GMM11_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm11;

public class GMM11_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT909 ZMMMT909;

    private com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT008[] ZMMMT008;

    private com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT910[] ZMMMT910;

    public GMM11_GIMS_DT() {
    }

    public GMM11_GIMS_DT(
           com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT909 ZMMMT909,
           com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT008[] ZMMMT008,
           com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT910[] ZMMMT910) {
           this.ZMMMT909 = ZMMMT909;
           this.ZMMMT008 = ZMMMT008;
           this.ZMMMT910 = ZMMMT910;
    }


    /**
     * Gets the ZMMMT909 value for this GMM11_GIMS_DT.
     * 
     * @return ZMMMT909
     */
    public com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT909 getZMMMT909() {
        return ZMMMT909;
    }


    /**
     * Sets the ZMMMT909 value for this GMM11_GIMS_DT.
     * 
     * @param ZMMMT909
     */
    public void setZMMMT909(com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT909 ZMMMT909) {
        this.ZMMMT909 = ZMMMT909;
    }


    /**
     * Gets the ZMMMT008 value for this GMM11_GIMS_DT.
     * 
     * @return ZMMMT008
     */
    public com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT008[] getZMMMT008() {
        return ZMMMT008;
    }


    /**
     * Sets the ZMMMT008 value for this GMM11_GIMS_DT.
     * 
     * @param ZMMMT008
     */
    public void setZMMMT008(com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT008[] ZMMMT008) {
        this.ZMMMT008 = ZMMMT008;
    }

    public com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT008 getZMMMT008(int i) {
        return this.ZMMMT008[i];
    }

    public void setZMMMT008(int i, com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT008 _value) {
        this.ZMMMT008[i] = _value;
    }


    /**
     * Gets the ZMMMT910 value for this GMM11_GIMS_DT.
     * 
     * @return ZMMMT910
     */
    public com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT910[] getZMMMT910() {
        return ZMMMT910;
    }


    /**
     * Sets the ZMMMT910 value for this GMM11_GIMS_DT.
     * 
     * @param ZMMMT910
     */
    public void setZMMMT910(com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT910[] ZMMMT910) {
        this.ZMMMT910 = ZMMMT910;
    }

    public com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT910 getZMMMT910(int i) {
        return this.ZMMMT910[i];
    }

    public void setZMMMT910(int i, com.lgicorp.gims.sap.gmm11.GMM11_GIMS_DTZMMMT910 _value) {
        this.ZMMMT910[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM11_GIMS_DT)) return false;
        GMM11_GIMS_DT other = (GMM11_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZMMMT909==null && other.getZMMMT909()==null) || 
             (this.ZMMMT909!=null &&
              this.ZMMMT909.equals(other.getZMMMT909()))) &&
            ((this.ZMMMT008==null && other.getZMMMT008()==null) || 
             (this.ZMMMT008!=null &&
              java.util.Arrays.equals(this.ZMMMT008, other.getZMMMT008()))) &&
            ((this.ZMMMT910==null && other.getZMMMT910()==null) || 
             (this.ZMMMT910!=null &&
              java.util.Arrays.equals(this.ZMMMT910, other.getZMMMT910())));
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
        if (getZMMMT909() != null) {
            _hashCode += getZMMMT909().hashCode();
        }
        if (getZMMMT008() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZMMMT008());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZMMMT008(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getZMMMT910() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZMMMT910());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZMMMT910(), i);
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
        new org.apache.axis.description.TypeDesc(GMM11_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", "GMM11_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT909");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT909"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM11_GIMS_DT>ZMMMT909"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT008");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT008"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM11_GIMS_DT>ZMMMT008"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT910");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT910"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM11_GIMS_DT>ZMMMT910"));
        elemField.setMinOccurs(0);
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
