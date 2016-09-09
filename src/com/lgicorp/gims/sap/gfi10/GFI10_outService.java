/**
 * GFI10_outService.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gfi10;

public interface GFI10_outService extends javax.xml.rpc.Service {
    public java.lang.String getHTTPS_PortAddress();

    public com.lgicorp.gims.sap.gfi10.GFI10_out getHTTPS_Port() throws javax.xml.rpc.ServiceException;

    public com.lgicorp.gims.sap.gfi10.GFI10_out getHTTPS_Port(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
    public java.lang.String getHTTP_PortAddress();

    public com.lgicorp.gims.sap.gfi10.GFI10_out getHTTP_Port() throws javax.xml.rpc.ServiceException;

    public com.lgicorp.gims.sap.gfi10.GFI10_out getHTTP_Port(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
