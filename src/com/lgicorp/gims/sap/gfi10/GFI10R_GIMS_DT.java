/**
 * GFI10R_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi10;

public class GFI10R_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTITEM[] ITEM;

    private com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTZSAPMSG ZSAPMSG;

    public GFI10R_GIMS_DT() {
    }

    public GFI10R_GIMS_DT(
           com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTITEM[] ITEM,
           com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTZSAPMSG ZSAPMSG) {
           this.ITEM = ITEM;
           this.ZSAPMSG = ZSAPMSG;
    }


    /**
     * Gets the ITEM value for this GFI10R_GIMS_DT.
     * 
     * @return ITEM
     */
    public com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTITEM[] getITEM() {
        return ITEM;
    }


    /**
     * Sets the ITEM value for this GFI10R_GIMS_DT.
     * 
     * @param ITEM
     */
    public void setITEM(com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTITEM[] ITEM) {
        this.ITEM = ITEM;
    }

    public com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTITEM getITEM(int i) {
        return this.ITEM[i];
    }

    public void setITEM(int i, com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTITEM _value) {
        this.ITEM[i] = _value;
    }


    /**
     * Gets the ZSAPMSG value for this GFI10R_GIMS_DT.
     * 
     * @return ZSAPMSG
     */
    public com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTZSAPMSG getZSAPMSG() {
        return ZSAPMSG;
    }


    /**
     * Sets the ZSAPMSG value for this GFI10R_GIMS_DT.
     * 
     * @param ZSAPMSG
     */
    public void setZSAPMSG(com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DTZSAPMSG ZSAPMSG) {
        this.ZSAPMSG = ZSAPMSG;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI10R_GIMS_DT)) return false;
        GFI10R_GIMS_DT other = (GFI10R_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ITEM==null && other.getITEM()==null) || 
             (this.ITEM!=null &&
              java.util.Arrays.equals(this.ITEM, other.getITEM()))) &&
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
        if (getITEM() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getITEM());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getITEM(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getZSAPMSG() != null) {
            _hashCode += getZSAPMSG().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI10R_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", "GFI10R_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ITEM");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ITEM"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI10R_GIMS_DT>ITEM"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZSAPMSG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZSAPMSG"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI10R_GIMS_DT>ZSAPMSG"));
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
