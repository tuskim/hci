/**
 * GMM02_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm02;

public class GMM02_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT006 ZMMMT006;
    private com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT007[] ZMMMT007;

    public GMM02_GIMS_DT() {
    }

    public GMM02_GIMS_DT(
           com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT006 ZMMMT006,
           com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT007[] ZMMMT007) {
           this.ZMMMT006 = ZMMMT006;
           this.ZMMMT007 = ZMMMT007;
    }


    /**
     * Gets the ZMMMT006 value for this GMM02_GIMS_DT.
     * 
     * @return ZMMMT006
     */
    public com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT006 getZMMMT006() {
        return ZMMMT006;
    }


    /**
     * Sets the ZMMMT006 value for this GMM02_GIMS_DT.
     * 
     * @param ZMMMT006
     */
    public void setZMMMT006(com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT006 ZMMMT006) {
        this.ZMMMT006 = ZMMMT006;
    }


    /**
     * Gets the ZMMMT007 value for this GMM02_GIMS_DT.
     * 
     * @return ZMMMT007
     */
    public com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT007[] getZMMMT007() {
        return ZMMMT007;
    }


    /**
     * Sets the ZMMMT007 value for this GMM02_GIMS_DT.
     * 
     * @param ZMMMT007
     */
    public void setZMMMT007(com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT007[] ZMMMT007) {
        this.ZMMMT007 = ZMMMT007;
    }

    public com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT007 getZMMMT007(int i) {
        return this.ZMMMT007[i];
    }

    public void setZMMMT007(int i, com.lgicorp.gims.sap.gmm02.GMM02_GIMS_DTZMMMT007 _value) {
        this.ZMMMT007[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM02_GIMS_DT)) return false;
        GMM02_GIMS_DT other = (GMM02_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZMMMT006==null && other.getZMMMT006()==null) || 
             (this.ZMMMT006!=null &&
              this.ZMMMT006.equals(other.getZMMMT006()))) &&
            ((this.ZMMMT007==null && other.getZMMMT007()==null) || 
             (this.ZMMMT007!=null &&
              java.util.Arrays.equals(this.ZMMMT007, other.getZMMMT007())));
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
        if (getZMMMT006() != null) {
            _hashCode += getZMMMT006().hashCode();
        }
        if (getZMMMT007() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getZMMMT007());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getZMMMT007(), i);
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
        new org.apache.axis.description.TypeDesc(GMM02_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", "GMM02_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT006");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT006"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM02_GIMS_DT>ZMMMT006"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZMMMT007");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZMMMT007"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM02_GIMS_DT>ZMMMT007"));
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
