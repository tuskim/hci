package com.lgicorp.gims.sap.gfi10;

public class GFI10_outProxy implements com.lgicorp.gims.sap.gfi10.GFI10_out {
  private String _endpoint = null;
  private com.lgicorp.gims.sap.gfi10.GFI10_out gFI10_out = null;
  
  public GFI10_outProxy() {
    _initGFI10_outProxy();
  }
  
  public GFI10_outProxy(String endpoint) {
    _endpoint = endpoint;
    _initGFI10_outProxy();
  }
  
  private void _initGFI10_outProxy() {
    try {
      gFI10_out = (new com.lgicorp.gims.sap.gfi10.GFI10_outServiceLocator()).getHTTPS_Port();
      if (gFI10_out != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)gFI10_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)gFI10_out)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (gFI10_out != null)
      ((javax.xml.rpc.Stub)gFI10_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.lgicorp.gims.sap.gfi10.GFI10_out getGFI10_out() {
    if (gFI10_out == null)
      _initGFI10_outProxy();
    return gFI10_out;
  }
  
  public com.lgicorp.gims.sap.gfi10.GFI10R_GIMS_DT GFI10_out(com.lgicorp.gims.sap.gfi10.GFI10_GIMS_DT GFI10_GIMS_MT) throws java.rmi.RemoteException{
    if (gFI10_out == null)
      _initGFI10_outProxy();
    return gFI10_out.GFI10_out(GFI10_GIMS_MT);
  }
  
  
}