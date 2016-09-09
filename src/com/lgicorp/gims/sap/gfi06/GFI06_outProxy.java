package com.lgicorp.gims.sap.gfi06;

public class GFI06_outProxy implements com.lgicorp.gims.sap.gfi06.GFI06_out {
  private String _endpoint = null;
  private com.lgicorp.gims.sap.gfi06.GFI06_out gFI06_out = null;
  
  public GFI06_outProxy() {
    _initGFI06_outProxy();
  }
  
  public GFI06_outProxy(String endpoint) {
    _endpoint = endpoint;
    _initGFI06_outProxy();
  }
  
  private void _initGFI06_outProxy() {
    try {
      gFI06_out = (new com.lgicorp.gims.sap.gfi06.GFI06_outServiceLocator()).getHTTPS_Port();
      if (gFI06_out != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)gFI06_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)gFI06_out)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (gFI06_out != null)
      ((javax.xml.rpc.Stub)gFI06_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.lgicorp.gims.sap.gfi06.GFI06_out getGFI06_out() {
    if (gFI06_out == null)
      _initGFI06_outProxy();
    return gFI06_out;
  }
  
  public com.lgicorp.gims.sap.gfi06.GFI06R_GIMS_DT GFI06_out(com.lgicorp.gims.sap.gfi06.GFI06_GIMS_DT GFI06_GIMS_MT) throws java.rmi.RemoteException{
    if (gFI06_out == null)
      _initGFI06_outProxy();
    return gFI06_out.GFI06_out(GFI06_GIMS_MT);
  }
  
  
}