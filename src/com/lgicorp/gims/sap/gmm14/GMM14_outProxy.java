package com.lgicorp.gims.sap.gmm14;

public class GMM14_outProxy implements com.lgicorp.gims.sap.gmm14.GMM14_out {
  private String _endpoint = null;
  private com.lgicorp.gims.sap.gmm14.GMM14_out gMM14_out = null;
  
  public GMM14_outProxy() {
    _initGMM14_outProxy();
  }
  
  public GMM14_outProxy(String endpoint) {
    _endpoint = endpoint;
    _initGMM14_outProxy();
  }
  
  private void _initGMM14_outProxy() {
    try {
      gMM14_out = (new com.lgicorp.gims.sap.gmm14.GMM14_outServiceLocator()).getHTTP_Port();
      if (gMM14_out != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)gMM14_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)gMM14_out)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (gMM14_out != null)
      ((javax.xml.rpc.Stub)gMM14_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.lgicorp.gims.sap.gmm14.GMM14_out getGMM14_out() {
    if (gMM14_out == null)
      _initGMM14_outProxy();
    return gMM14_out;
  }
  
  public com.lgicorp.gims.sap.gmm14.GMM14R_GIMS_DT GMM14_out(com.lgicorp.gims.sap.gmm14.GMM14_GIMS_DT GMM14_GIMS_MT) throws java.rmi.RemoteException{
    if (gMM14_out == null)
      _initGMM14_outProxy();
    return gMM14_out.GMM14_out(GMM14_GIMS_MT);
  }
  
  
}