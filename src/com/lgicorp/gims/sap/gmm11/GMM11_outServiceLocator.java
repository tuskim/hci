/**
 * GMM11_outServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.lgicorp.gims.sap.gmm11;

public class GMM11_outServiceLocator extends org.apache.axis.client.Service implements com.lgicorp.gims.sap.gmm11.GMM11_outService {

    public GMM11_outServiceLocator() {
    }


    public GMM11_outServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public GMM11_outServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for GMM11_outPort
    private java.lang.String GMM11_outPort_address = "http://lgiceaid02:8000/sap/xi/engine?type=entry&version=3.0&Sender.Service=GIMS&Interface=http%3A%2F%2Flgicorp.com%2Fgims%2Fsap%2Fgmm%5EGMM11_out";

    public java.lang.String getGMM11_outPortAddress() {
        return GMM11_outPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String GMM11_outPortWSDDServiceName = "GMM11_outPort";

    public java.lang.String getGMM11_outPortWSDDServiceName() {
        return GMM11_outPortWSDDServiceName;
    }

    public void setGMM11_outPortWSDDServiceName(java.lang.String name) {
        GMM11_outPortWSDDServiceName = name;
    }

    public com.lgicorp.gims.sap.gmm11.GMM11_out getGMM11_outPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(GMM11_outPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getGMM11_outPort(endpoint);
    }

    public com.lgicorp.gims.sap.gmm11.GMM11_out getGMM11_outPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.lgicorp.gims.sap.gmm11.GMM11_outBindingStub _stub = new com.lgicorp.gims.sap.gmm11.GMM11_outBindingStub(portAddress, this);
            _stub.setPortName(getGMM11_outPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setGMM11_outPortEndpointAddress(java.lang.String address) {
        GMM11_outPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.lgicorp.gims.sap.gmm11.GMM11_out.class.isAssignableFrom(serviceEndpointInterface)) {
                com.lgicorp.gims.sap.gmm11.GMM11_outBindingStub _stub = new com.lgicorp.gims.sap.gmm11.GMM11_outBindingStub(new java.net.URL(GMM11_outPort_address), this);
                _stub.setPortName(getGMM11_outPortWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("GMM11_outPort".equals(inputPortName)) {
            return getGMM11_outPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", "GMM11_outService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://lgicorp.com/gims/sap/gmm", "GMM11_outPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("GMM11_outPort".equals(portName)) {
            setGMM11_outPortEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
