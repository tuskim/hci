/**
 * GFI03R_GIMS_DTZSAPMSG.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2.1 Jun 14, 2005 (09:15:57 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi03;

public class GFI03R_GIMS_DTZSAPMSG  implements java.io.Serializable {
    private java.lang.String MTYPE;
    private java.lang.String MTEXT;
    private java.lang.String FRYE1;
    private java.lang.String FRPE1;
    private java.lang.String TOYE1;
    private java.lang.String TOPE1;

    public GFI03R_GIMS_DTZSAPMSG() {
    }

    public GFI03R_GIMS_DTZSAPMSG(
           java.lang.String MTYPE,
           java.lang.String MTEXT,
           java.lang.String FRYE1,
           java.lang.String FRPE1,
           java.lang.String TOYE1,
           java.lang.String TOPE1) {
           this.MTYPE = MTYPE;
           this.MTEXT = MTEXT;
           this.FRYE1 = FRYE1;
           this.FRPE1 = FRPE1;
           this.TOYE1 = TOYE1;
           this.TOPE1 = TOPE1;
    }


    /**
     * Gets the MTYPE value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @return MTYPE
     */
    public java.lang.String getMTYPE() {
        return MTYPE;
    }


    /**
     * Sets the MTYPE value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @param MTYPE
     */
    public void setMTYPE(java.lang.String MTYPE) {
        this.MTYPE = MTYPE;
    }


    /**
     * Gets the MTEXT value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @return MTEXT
     */
    public java.lang.String getMTEXT() {
        return MTEXT;
    }


    /**
     * Sets the MTEXT value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @param MTEXT
     */
    public void setMTEXT(java.lang.String MTEXT) {
        this.MTEXT = MTEXT;
    }


    /**
     * Gets the FRYE1 value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @return FRYE1
     */
    public java.lang.String getFRYE1() {
        return FRYE1;
    }


    /**
     * Sets the FRYE1 value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @param FRYE1
     */
    public void setFRYE1(java.lang.String FRYE1) {
        this.FRYE1 = FRYE1;
    }


    /**
     * Gets the FRPE1 value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @return FRPE1
     */
    public java.lang.String getFRPE1() {
        return FRPE1;
    }


    /**
     * Sets the FRPE1 value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @param FRPE1
     */
    public void setFRPE1(java.lang.String FRPE1) {
        this.FRPE1 = FRPE1;
    }


    /**
     * Gets the TOYE1 value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @return TOYE1
     */
    public java.lang.String getTOYE1() {
        return TOYE1;
    }


    /**
     * Sets the TOYE1 value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @param TOYE1
     */
    public void setTOYE1(java.lang.String TOYE1) {
        this.TOYE1 = TOYE1;
    }


    /**
     * Gets the TOPE1 value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @return TOPE1
     */
    public java.lang.String getTOPE1() {
        return TOPE1;
    }


    /**
     * Sets the TOPE1 value for this GFI03R_GIMS_DTZSAPMSG.
     * 
     * @param TOPE1
     */
    public void setTOPE1(java.lang.String TOPE1) {
        this.TOPE1 = TOPE1;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI03R_GIMS_DTZSAPMSG)) return false;
        GFI03R_GIMS_DTZSAPMSG other = (GFI03R_GIMS_DTZSAPMSG) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.MTYPE==null && other.getMTYPE()==null) || 
             (this.MTYPE!=null &&
              this.MTYPE.equals(other.getMTYPE()))) &&
            ((this.MTEXT==null && other.getMTEXT()==null) || 
             (this.MTEXT!=null &&
              this.MTEXT.equals(other.getMTEXT()))) &&
            ((this.FRYE1==null && other.getFRYE1()==null) || 
             (this.FRYE1!=null &&
              this.FRYE1.equals(other.getFRYE1()))) &&
            ((this.FRPE1==null && other.getFRPE1()==null) || 
             (this.FRPE1!=null &&
              this.FRPE1.equals(other.getFRPE1()))) &&
            ((this.TOYE1==null && other.getTOYE1()==null) || 
             (this.TOYE1!=null &&
              this.TOYE1.equals(other.getTOYE1()))) &&
            ((this.TOPE1==null && other.getTOPE1()==null) || 
             (this.TOPE1!=null &&
              this.TOPE1.equals(other.getTOPE1())));
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
        if (getMTYPE() != null) {
            _hashCode += getMTYPE().hashCode();
        }
        if (getMTEXT() != null) {
            _hashCode += getMTEXT().hashCode();
        }
        if (getFRYE1() != null) {
            _hashCode += getFRYE1().hashCode();
        }
        if (getFRPE1() != null) {
            _hashCode += getFRPE1().hashCode();
        }
        if (getTOYE1() != null) {
            _hashCode += getTOYE1().hashCode();
        }
        if (getTOPE1() != null) {
            _hashCode += getTOPE1().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI03R_GIMS_DTZSAPMSG.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI03R_GIMS_DT>ZSAPMSG"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MTYPE");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MTYPE"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("MTEXT");
        elemField.setXmlName(new javax.xml.namespace.QName("", "MTEXT"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("FRYE1");
        elemField.setXmlName(new javax.xml.namespace.QName("", "FRYE1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("FRPE1");
        elemField.setXmlName(new javax.xml.namespace.QName("", "FRPE1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("TOYE1");
        elemField.setXmlName(new javax.xml.namespace.QName("", "TOYE1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("TOPE1");
        elemField.setXmlName(new javax.xml.namespace.QName("", "TOPE1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
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
