/**
 * GFI10_GIMS_DTHEADER.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi10;

public class GFI10_GIMS_DTHEADER  implements java.io.Serializable {
    private java.lang.String COMPANY_CD;

    private java.lang.String FISCAL_YEAR;

    private java.lang.String COST_CENTER;

    private java.lang.String ASSET_CLASS;

    private java.lang.String ASSET_NO;

    private java.lang.String ASSET_NM;

    public GFI10_GIMS_DTHEADER() {
    }

    public GFI10_GIMS_DTHEADER(
           java.lang.String COMPANY_CD,
           java.lang.String FISCAL_YEAR,
           java.lang.String COST_CENTER,
           java.lang.String ASSET_CLASS,
           java.lang.String ASSET_NO,
           java.lang.String ASSET_NM) {
           this.COMPANY_CD = COMPANY_CD;
           this.FISCAL_YEAR = FISCAL_YEAR;
           this.COST_CENTER = COST_CENTER;
           this.ASSET_CLASS = ASSET_CLASS;
           this.ASSET_NO = ASSET_NO;
           this.ASSET_NM = ASSET_NM;
    }


    /**
     * Gets the COMPANY_CD value for this GFI10_GIMS_DTHEADER.
     * 
     * @return COMPANY_CD
     */
    public java.lang.String getCOMPANY_CD() {
        return COMPANY_CD;
    }


    /**
     * Sets the COMPANY_CD value for this GFI10_GIMS_DTHEADER.
     * 
     * @param COMPANY_CD
     */
    public void setCOMPANY_CD(java.lang.String COMPANY_CD) {
        this.COMPANY_CD = COMPANY_CD;
    }


    /**
     * Gets the FISCAL_YEAR value for this GFI10_GIMS_DTHEADER.
     * 
     * @return FISCAL_YEAR
     */
    public java.lang.String getFISCAL_YEAR() {
        return FISCAL_YEAR;
    }


    /**
     * Sets the FISCAL_YEAR value for this GFI10_GIMS_DTHEADER.
     * 
     * @param FISCAL_YEAR
     */
    public void setFISCAL_YEAR(java.lang.String FISCAL_YEAR) {
        this.FISCAL_YEAR = FISCAL_YEAR;
    }


    /**
     * Gets the COST_CENTER value for this GFI10_GIMS_DTHEADER.
     * 
     * @return COST_CENTER
     */
    public java.lang.String getCOST_CENTER() {
        return COST_CENTER;
    }


    /**
     * Sets the COST_CENTER value for this GFI10_GIMS_DTHEADER.
     * 
     * @param COST_CENTER
     */
    public void setCOST_CENTER(java.lang.String COST_CENTER) {
        this.COST_CENTER = COST_CENTER;
    }


    /**
     * Gets the ASSET_CLASS value for this GFI10_GIMS_DTHEADER.
     * 
     * @return ASSET_CLASS
     */
    public java.lang.String getASSET_CLASS() {
        return ASSET_CLASS;
    }


    /**
     * Sets the ASSET_CLASS value for this GFI10_GIMS_DTHEADER.
     * 
     * @param ASSET_CLASS
     */
    public void setASSET_CLASS(java.lang.String ASSET_CLASS) {
        this.ASSET_CLASS = ASSET_CLASS;
    }


    /**
     * Gets the ASSET_NO value for this GFI10_GIMS_DTHEADER.
     * 
     * @return ASSET_NO
     */
    public java.lang.String getASSET_NO() {
        return ASSET_NO;
    }


    /**
     * Sets the ASSET_NO value for this GFI10_GIMS_DTHEADER.
     * 
     * @param ASSET_NO
     */
    public void setASSET_NO(java.lang.String ASSET_NO) {
        this.ASSET_NO = ASSET_NO;
    }


    /**
     * Gets the ASSET_NM value for this GFI10_GIMS_DTHEADER.
     * 
     * @return ASSET_NM
     */
    public java.lang.String getASSET_NM() {
        return ASSET_NM;
    }


    /**
     * Sets the ASSET_NM value for this GFI10_GIMS_DTHEADER.
     * 
     * @param ASSET_NM
     */
    public void setASSET_NM(java.lang.String ASSET_NM) {
        this.ASSET_NM = ASSET_NM;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GFI10_GIMS_DTHEADER)) return false;
        GFI10_GIMS_DTHEADER other = (GFI10_GIMS_DTHEADER) obj;
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
            ((this.FISCAL_YEAR==null && other.getFISCAL_YEAR()==null) || 
             (this.FISCAL_YEAR!=null &&
              this.FISCAL_YEAR.equals(other.getFISCAL_YEAR()))) &&
            ((this.COST_CENTER==null && other.getCOST_CENTER()==null) || 
             (this.COST_CENTER!=null &&
              this.COST_CENTER.equals(other.getCOST_CENTER()))) &&
            ((this.ASSET_CLASS==null && other.getASSET_CLASS()==null) || 
             (this.ASSET_CLASS!=null &&
              this.ASSET_CLASS.equals(other.getASSET_CLASS()))) &&
            ((this.ASSET_NO==null && other.getASSET_NO()==null) || 
             (this.ASSET_NO!=null &&
              this.ASSET_NO.equals(other.getASSET_NO()))) &&
            ((this.ASSET_NM==null && other.getASSET_NM()==null) || 
             (this.ASSET_NM!=null &&
              this.ASSET_NM.equals(other.getASSET_NM())));
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
        if (getFISCAL_YEAR() != null) {
            _hashCode += getFISCAL_YEAR().hashCode();
        }
        if (getCOST_CENTER() != null) {
            _hashCode += getCOST_CENTER().hashCode();
        }
        if (getASSET_CLASS() != null) {
            _hashCode += getASSET_CLASS().hashCode();
        }
        if (getASSET_NO() != null) {
            _hashCode += getASSET_NO().hashCode();
        }
        if (getASSET_NM() != null) {
            _hashCode += getASSET_NM().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GFI10_GIMS_DTHEADER.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gfi", ">GFI10_GIMS_DT>HEADER"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("COMPANY_CD");
        elemField.setXmlName(new javax.xml.namespace.QName("", "COMPANY_CD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("FISCAL_YEAR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "FISCAL_YEAR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("COST_CENTER");
        elemField.setXmlName(new javax.xml.namespace.QName("", "COST_CENTER"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ASSET_CLASS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ASSET_CLASS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ASSET_NO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ASSET_NO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ASSET_NM");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ASSET_NM"));
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
