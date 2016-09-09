/**
 * GMA09_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gma09;

public class GMA09_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gma09.GMA09_GIMS_DTTB_MATER_REQUEST TB_MATER_REQUEST;

    public GMA09_GIMS_DT() {
    }

    public GMA09_GIMS_DT(
           com.lgicorp.gims.sap.gma09.GMA09_GIMS_DTTB_MATER_REQUEST TB_MATER_REQUEST) {
           this.TB_MATER_REQUEST = TB_MATER_REQUEST;
    }


    /**
     * Gets the TB_MATER_REQUEST value for this GMA09_GIMS_DT.
     * 
     * @return TB_MATER_REQUEST
     */
    public com.lgicorp.gims.sap.gma09.GMA09_GIMS_DTTB_MATER_REQUEST getTB_MATER_REQUEST() {
        return TB_MATER_REQUEST;
    }


    /**
     * Sets the TB_MATER_REQUEST value for this GMA09_GIMS_DT.
     * 
     * @param TB_MATER_REQUEST
     */
    public void setTB_MATER_REQUEST(com.lgicorp.gims.sap.gma09.GMA09_GIMS_DTTB_MATER_REQUEST TB_MATER_REQUEST) {
        this.TB_MATER_REQUEST = TB_MATER_REQUEST;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMA09_GIMS_DT)) return false;
        GMA09_GIMS_DT other = (GMA09_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.TB_MATER_REQUEST==null && other.getTB_MATER_REQUEST()==null) || 
             (this.TB_MATER_REQUEST!=null &&
              this.TB_MATER_REQUEST.equals(other.getTB_MATER_REQUEST())));
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
        if (getTB_MATER_REQUEST() != null) {
            _hashCode += getTB_MATER_REQUEST().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GMA09_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gma", "GMA09_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("TB_MATER_REQUEST");
        elemField.setXmlName(new javax.xml.namespace.QName("", "TB_MATER_REQUEST"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gma", ">GMA09_GIMS_DT>TB_MATER_REQUEST"));
        elemField.setMinOccurs(0);
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
