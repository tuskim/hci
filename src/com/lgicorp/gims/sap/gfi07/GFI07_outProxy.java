package com.lgicorp.gims.sap.gfi07;

public class GFI07_outProxy implements com.lgicorp.gims.sap.gfi07.GFI07_out {
  private String _endpoint = null;
  private com.lgicorp.gims.sap.gfi07.GFI07_out gFI07_out = null;
  
  public GFI07_outProxy() {
    _initGFI07_outProxy();
  }
  
  public GFI07_outProxy(String endpoint) {
    _endpoint = endpoint;
    _initGFI07_outProxy();
  }
  
  private void _initGFI07_outProxy() {
    try {
      gFI07_out = (new com.lgicorp.gims.sap.gfi07.GFI07_outServiceLocator()).getHTTPS_Port();
      if (gFI07_out != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)gFI07_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)gFI07_out)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (gFI07_out != null)
      ((javax.xml.rpc.Stub)gFI07_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.lgicorp.gims.sap.gfi07.GFI07_out getGFI07_out() {
    if (gFI07_out == null)
      _initGFI07_outProxy();
    return gFI07_out;
  }
  
  public com.lgicorp.gims.sap.gfi07.GFI07R_GIMS_DTITEM[] GFI07_out(com.lgicorp.gims.sap.gfi07.GFI07_GIMS_DTITEM[] GFI07_GIMS_MT) throws java.rmi.RemoteException{
    if (gFI07_out == null)
      _initGFI07_outProxy();
    return gFI07_out.GFI07_out(GFI07_GIMS_MT);
  }
  
  
}