package com.lgicorp.gims.sap.gma09;

public class GMA09_outProxy implements com.lgicorp.gims.sap.gma09.GMA09_out {
  private String _endpoint = null;
  private com.lgicorp.gims.sap.gma09.GMA09_out gMA09_out = null;
  
  public GMA09_outProxy() {
    _initGMA09_outProxy();
  }
  
  public GMA09_outProxy(String endpoint) {
    _endpoint = endpoint;
    _initGMA09_outProxy();
  }
  
  private void _initGMA09_outProxy() {
    try {
      gMA09_out = (new com.lgicorp.gims.sap.gma09.GMA09_outServiceLocator()).getHTTP_Port();
      if (gMA09_out != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)gMA09_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)gMA09_out)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (gMA09_out != null)
      ((javax.xml.rpc.Stub)gMA09_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.lgicorp.gims.sap.gma09.GMA09_out getGMA09_out() {
    if (gMA09_out == null)
      _initGMA09_outProxy();
    return gMA09_out;
  }
  
  public com.lgicorp.gims.sap.gma09.GMA09R_GIMS_DT GMA09_out(com.lgicorp.gims.sap.gma09.GMA09_GIMS_DT GMA09_GIMS_MT) throws java.rmi.RemoteException{
    if (gMA09_out == null)
      _initGMA09_outProxy();
    return gMA09_out.GMA09_out(GMA09_GIMS_MT);
  }
  
  
}