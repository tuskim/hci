/**
 * GMM16_GIMS_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm16;

public class GMM16_GIMS_DT  implements java.io.Serializable {
    private com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_MASTER TB_PO_MASTER;

    private com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_DETAIL[] TB_PO_DETAIL;

    public GMM16_GIMS_DT() {
    }

    public GMM16_GIMS_DT(
           com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_MASTER TB_PO_MASTER,
           com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_DETAIL[] TB_PO_DETAIL) {
           this.TB_PO_MASTER = TB_PO_MASTER;
           this.TB_PO_DETAIL = TB_PO_DETAIL;
    }


    /**
     * Gets the TB_PO_MASTER value for this GMM16_GIMS_DT.
     * 
     * @return TB_PO_MASTER
     */
    public com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_MASTER getTB_PO_MASTER() {
        return TB_PO_MASTER;
    }


    /**
     * Sets the TB_PO_MASTER value for this GMM16_GIMS_DT.
     * 
     * @param TB_PO_MASTER
     */
    public void setTB_PO_MASTER(com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_MASTER TB_PO_MASTER) {
        this.TB_PO_MASTER = TB_PO_MASTER;
    }


    /**
     * Gets the TB_PO_DETAIL value for this GMM16_GIMS_DT.
     * 
     * @return TB_PO_DETAIL
     */
    public com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_DETAIL[] getTB_PO_DETAIL() {
        return TB_PO_DETAIL;
    }


    /**
     * Sets the TB_PO_DETAIL value for this GMM16_GIMS_DT.
     * 
     * @param TB_PO_DETAIL
     */
    public void setTB_PO_DETAIL(com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_DETAIL[] TB_PO_DETAIL) {
        this.TB_PO_DETAIL = TB_PO_DETAIL;
    }

    public com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_DETAIL getTB_PO_DETAIL(int i) {
        return this.TB_PO_DETAIL[i];
    }

    public void setTB_PO_DETAIL(int i, com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DTTB_PO_DETAIL _value) {
        this.TB_PO_DETAIL[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GMM16_GIMS_DT)) return false;
        GMM16_GIMS_DT other = (GMM16_GIMS_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.TB_PO_MASTER==null && other.getTB_PO_MASTER()==null) || 
             (this.TB_PO_MASTER!=null &&
              this.TB_PO_MASTER.equals(other.getTB_PO_MASTER()))) &&
            ((this.TB_PO_DETAIL==null && other.getTB_PO_DETAIL()==null) || 
             (this.TB_PO_DETAIL!=null &&
              java.util.Arrays.equals(this.TB_PO_DETAIL, other.getTB_PO_DETAIL())));
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
        if (getTB_PO_MASTER() != null) {
            _hashCode += getTB_PO_MASTER().hashCode();
        }
        if (getTB_PO_DETAIL() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getTB_PO_DETAIL());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getTB_PO_DETAIL(), i);
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
        new org.apache.axis.description.TypeDesc(GMM16_GIMS_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", "GMM16_GIMS_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("TB_PO_MASTER");
        elemField.setXmlName(new javax.xml.namespace.QName("", "TB_PO_MASTER"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM16_GIMS_DT>TB_PO_MASTER"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("TB_PO_DETAIL");
        elemField.setXmlName(new javax.xml.namespace.QName("", "TB_PO_DETAIL"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", ">GMM16_GIMS_DT>TB_PO_DETAIL"));
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
