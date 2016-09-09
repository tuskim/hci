/**
 * GMM07_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm07;

public class GMM07_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT15 ZMMMT15;
    private com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT16[] ZMMMT16;
    private com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT17[] ZMMMT17;

    public GMM07_GIMS_DT() {
    }

    public GMM07_GIMS_DT(
           com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT15 ZMMMT15,
           com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT16[] ZMMMT16,
           com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT17[] ZMMMT17) {
           this.ZMMMT15 = ZMMMT15;
           this.ZMMMT16 = ZMMMT16;
           this.ZMMMT17 = ZMMMT17;
    }


    /**
     * Gets the ZMMMT15 value for this GMM07_GIMS_DT.
     * 
     * @return ZMMMT15
     */
    public com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT15 getZMMMT15() {
        return ZMMMT15;
    }


    /**
     * Sets the ZMMMT15 value for this GMM07_GIMS_DT.
     * 
     * @param ZMMMT15
     */
    public void setZMMMT15(com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT15 ZMMMT15) {
        this.ZMMMT15 = ZMMMT15;
    }


    /**
     * Gets the ZMMMT16 value for this GMM07_GIMS_DT.
     * 
     * @return ZMMMT16
     */
    public com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT16[] getZMMMT16() {
        return ZMMMT16;
    }


    /**
     * Sets the ZMMMT16 value for this GMM07_GIMS_DT.
     * 
     * @param ZMMMT16
     */
    public void setZMMMT16(com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT16[] ZMMMT16) {
        this.ZMMMT16 = ZMMMT16;
    }

    public com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT16 getZMMMT16(int i) {
        return this.ZMMMT16[i];
    }

    public void setZMMMT16(int i, com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT16 _value) {
        this.ZMMMT16[i] = _value;
    }


    /**
     * Gets the ZMMMT17 value for this GMM07_GIMS_DT.
     * 
     * @return ZMMMT17
     */
    public com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT17[] getZMMMT17() {
        return ZMMMT17;
    }


    /**
     * Sets the ZMMMT17 value for this GMM07_GIMS_DT.
     * 
     * @param ZMMMT17
     */
    public void setZMMMT17(com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT17[] ZMMMT17) {
        this.ZMMMT17 = ZMMMT17;
    }

    public com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT17 getZMMMT17(int i) {
        return this.ZMMMT17[i];
    }

    public void setZMMMT17(int i, com.lgicorp.gims.sap.gmm07.GMM07_GIMS_DTZMMMT17 _value) {
        this.ZMMMT17[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM07_GIMS_DT)) return false;
        GMM07_GIMS_DT other = (GMM07_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZMMMT15==null && other.getZMMMT15()==null) || 
             (this.ZMMMT15!=null &&
              this.ZMMMT15.equals(other.getZMMMT15()))) &&
            ((this.ZMMMT16==null && other.getZMMMT16()==null) || 
             (this.ZMMMT16!=null &&
              java.util.Arrays.equals(this.ZMMMT16, other.getZMMMT16()))) &&
            ((this.ZMMMT17==null && other.getZMMMT17()==null) || 
             (this.ZMMMT17!=null &&
              java.util.Arrays.equals(this.ZMMMT17, other.getZMMMT17())));
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
        if (getZMMMT15() != null) {
            _hashCode += getZMMMT15().hashCode();
        }
        if (getZMMMT16() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZMMMT16());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZMMMT16(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getZMMMT17() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZMMMT17());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZMMMT17(), i);
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
        new org.apache.axis.description.TypeDesc(GMM07_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", "GMM07_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT15");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT15"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM07_GIMS_DT>ZMMMT15"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT16");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT16"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM07_GIMS_DT>ZMMMT16"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT17");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT17"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM07_GIMS_DT>ZMMMT17"));
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
