/**
 * GFI01R_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi01;

public class GFI01R_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gfi01.GFI01R_GIMS_DTZSAPMSG ZSAPMSG;

    public GFI01R_GIMS_DT() {
    }

    public GFI01R_GIMS_DT(
           com.lgicorp.gims.sap.gfi01.GFI01R_GIMS_DTZSAPMSG ZSAPMSG) {
           this.ZSAPMSG = ZSAPMSG;
    }


    /**
     * Gets the ZSAPMSG value for this GFI01R_GIMS_DT.
     * 
     * @return ZSAPMSG
     */
    public com.lgicorp.gims.sap.gfi01.GFI01R_GIMS_DTZSAPMSG getZSAPMSG() {
        return ZSAPMSG;
    }


    /**
     * Sets the ZSAPMSG value for this GFI01R_GIMS_DT.
     * 
     * @param ZSAPMSG
     */
    public void setZSAPMSG(com.lgicorp.gims.sap.gfi01.GFI01R_GIMS_DTZSAPMSG ZSAPMSG) {
        this.ZSAPMSG = ZSAPMSG;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI01R_GIMS_DT)) return false;
        GFI01R_GIMS_DT other = (GFI01R_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ZSAPMSG==null && other.getZSAPMSG()==null) || 
             (this.ZSAPMSG!=null &&
              this.ZSAPMSG.equals(other.getZSAPMSG())));
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
        if (getZSAPMSG() != null) {
            _hashCode += getZSAPMSG().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI01R_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", "GFI01R_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZSAPMSG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZSAPMSG"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI01R_GIMS_DT>ZSAPMSG"));
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
