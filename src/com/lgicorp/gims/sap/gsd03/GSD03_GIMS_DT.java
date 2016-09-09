/**
 * GSD03_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gsd03;

public class GSD03_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gsd03.GSD03_GIMS_DTZIFMTS001 ZIFMTS001;

    public GSD03_GIMS_DT() {
    }

    public GSD03_GIMS_DT(
           com.lgicorp.gims.sap.gsd03.GSD03_GIMS_DTZIFMTS001 ZIFMTS001) {
           this.ZIFMTS001 = ZIFMTS001;
    }


    /**
     * Gets the ZIFMTS001 value for this GSD03_GIMS_DT.
     * 
     * @return ZIFMTS001
     */
    public com.lgicorp.gims.sap.gsd03.GSD03_GIMS_DTZIFMTS001 getZIFMTS001() {
        return ZIFMTS001;
    }


    /**
     * Sets the ZIFMTS001 value for this GSD03_GIMS_DT.
     * 
     * @param ZIFMTS001
     */
    public void setZIFMTS001(com.lgicorp.gims.sap.gsd03.GSD03_GIMS_DTZIFMTS001 ZIFMTS001) {
        this.ZIFMTS001 = ZIFMTS001;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GSD03_GIMS_DT)) return false;
        GSD03_GIMS_DT other = (GSD03_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZIFMTS001==null && other.getZIFMTS001()==null) || 
             (this.ZIFMTS001!=null &&
              this.ZIFMTS001.equals(other.getZIFMTS001())));
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
        if (getZIFMTS001() != null) {
            _hashCode += getZIFMTS001().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GSD03_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gsd", "GSD03_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZIFMTS001");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZIFMTS001"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gsd", ">GSD03_GIMS_DT>ZIFMTS001"));
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
