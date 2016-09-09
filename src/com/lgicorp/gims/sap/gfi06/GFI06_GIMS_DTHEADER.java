/**
 * GFI06_GIMS_DTHEADER.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi06;

public class GFI06_GIMS_DTHEADER  implements java.io.Serializable {
    private java.lang.String COMPANY_CD;

    private java.lang.String POST_DATE;

    private java.lang.String BASELINE_DATE;

    private java.lang.String CURR_CD;

    private java.lang.String VEND_CD;

    private java.lang.String PERSONAL_ID;

    public GFI06_GIMS_DTHEADER() {
    }

    public GFI06_GIMS_DTHEADER(
           java.lang.String COMPANY_CD,
           java.lang.String POST_DATE,
           java.lang.String BASELINE_DATE,
           java.lang.String CURR_CD,
           java.lang.String VEND_CD,
           java.lang.String PERSONAL_ID) {
           this.COMPANY_CD = COMPANY_CD;
           this.POST_DATE = POST_DATE;
           this.BASELINE_DATE = BASELINE_DATE;
           this.CURR_CD = CURR_CD;
           this.VEND_CD = VEND_CD;
           this.PERSONAL_ID = PERSONAL_ID;
    }


    /**
     * Gets the COMPANY_CD value for this GFI06_GIMS_DTHEADER.
     * 
     * @return COMPANY_CD
     */
    public java.lang.String getCOMPANY_CD() {
        return COMPANY_CD;
    }


    /**
     * Sets the COMPANY_CD value for this GFI06_GIMS_DTHEADER.
     * 
     * @param COMPANY_CD
     */
    public void setCOMPANY_CD(java.lang.String COMPANY_CD) {
        this.COMPANY_CD = COMPANY_CD;
    }


    /**
     * Gets the POST_DATE value for this GFI06_GIMS_DTHEADER.
     * 
     * @return POST_DATE
     */
    public java.lang.String getPOST_DATE() {
        return POST_DATE;
    }


    /**
     * Sets the POST_DATE value for this GFI06_GIMS_DTHEADER.
     * 
     * @param POST_DATE
     */
    public void setPOST_DATE(java.lang.String POST_DATE) {
        this.POST_DATE = POST_DATE;
    }


    /**
     * Gets the BASELINE_DATE value for this GFI06_GIMS_DTHEADER.
     * 
     * @return BASELINE_DATE
     */
    public java.lang.String getBASELINE_DATE() {
        return BASELINE_DATE;
    }


    /**
     * Sets the BASELINE_DATE value for this GFI06_GIMS_DTHEADER.
     * 
     * @param BASELINE_DATE
     */
    public void setBASELINE_DATE(java.lang.String BASELINE_DATE) {
        this.BASELINE_DATE = BASELINE_DATE;
    }


    /**
     * Gets the CURR_CD value for this GFI06_GIMS_DTHEADER.
     * 
     * @return CURR_CD
     */
    public java.lang.String getCURR_CD() {
        return CURR_CD;
    }


    /**
     * Sets the CURR_CD value for this GFI06_GIMS_DTHEADER.
     * 
     * @param CURR_CD
     */
    public void setCURR_CD(java.lang.String CURR_CD) {
        this.CURR_CD = CURR_CD;
    }


    /**
     * Gets the VEND_CD value for this GFI06_GIMS_DTHEADER.
     * 
     * @return VEND_CD
     */
    public java.lang.String getVEND_CD() {
        return VEND_CD;
    }


    /**
     * Sets the VEND_CD value for this GFI06_GIMS_DTHEADER.
     * 
     * @param VEND_CD
     */
    public void setVEND_CD(java.lang.String VEND_CD) {
        this.VEND_CD = VEND_CD;
    }


    /**
     * Gets the PERSONAL_ID value for this GFI06_GIMS_DTHEADER.
     * 
     * @return PERSONAL_ID
     */
    public java.lang.String getPERSONAL_ID() {
        return PERSONAL_ID;
    }


    /**
     * Sets the PERSONAL_ID value for this GFI06_GIMS_DTHEADER.
     * 
     * @param PERSONAL_ID
     */
    public void setPERSONAL_ID(java.lang.String PERSONAL_ID) {
        this.PERSONAL_ID = PERSONAL_ID;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI06_GIMS_DTHEADER)) return false;
        GFI06_GIMS_DTHEADER other = (GFI06_GIMS_DTHEADER) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.COMPANY_CD==null && other.getCOMPANY_CD()==null) || 
             (this.COMPANY_CD!=null &&
              this.COMPANY_CD.equals(other.getCOMPANY_CD()))) &&
            ((this.POST_DATE==null && other.getPOST_DATE()==null) || 
             (this.POST_DATE!=null &&
              this.POST_DATE.equals(other.getPOST_DATE()))) &&
            ((this.BASELINE_DATE==null && other.getBASELINE_DATE()==null) || 
             (this.BASELINE_DATE!=null &&
              this.BASELINE_DATE.equals(other.getBASELINE_DATE()))) &&
            ((this.CURR_CD==null && other.getCURR_CD()==null) || 
             (this.CURR_CD!=null &&
              this.CURR_CD.equals(other.getCURR_CD()))) &&
            ((this.VEND_CD==null && other.getVEND_CD()==null) || 
             (this.VEND_CD!=null &&
              this.VEND_CD.equals(other.getVEND_CD()))) &&
            ((this.PERSONAL_ID==null && other.getPERSONAL_ID()==null) || 
             (this.PERSONAL_ID!=null &&
              this.PERSONAL_ID.equals(other.getPERSONAL_ID())));
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
        if (getCOMPANY_CD() != null) {
            _hashCode += getCOMPANY_CD().hashCode();
        }
        if (getPOST_DATE() != null) {
            _hashCode += getPOST_DATE().hashCode();
        }
        if (getBASELINE_DATE() != null) {
            _hashCode += getBASELINE_DATE().hashCode();
        }
        if (getCURR_CD() != null) {
            _hashCode += getCURR_CD().hashCode();
        }
        if (getVEND_CD() != null) {
            _hashCode += getVEND_CD().hashCode();
        }
        if (getPERSONAL_ID() != null) {
            _hashCode += getPERSONAL_ID().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI06_GIMS_DTHEADER.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI06_GIMS_DT>HEADER"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("COMPANY_CD");
        elemField.setXmlName(new javax.xml.namespace.QName("", "COMPANY_CD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("POST_DATE");
        elemField.setXmlName(new javax.xml.namespace.QName("", "POST_DATE"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BASELINE_DATE");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BASELINE_DATE"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("CURR_CD");
        elemField.setXmlName(new javax.xml.namespace.QName("", "CURR_CD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("VEND_CD");
        elemField.setXmlName(new javax.xml.namespace.QName("", "VEND_CD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("PERSONAL_ID");
        elemField.setXmlName(new javax.xml.namespace.QName("", "PERSONAL_ID"));
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
