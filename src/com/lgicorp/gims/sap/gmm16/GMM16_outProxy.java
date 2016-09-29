package com.lgicorp.gims.sap.gmm16;

public class GMM16_outProxy implements com.lgicorp.gims.sap.gmm16.GMM16_out {
  private String _endpoint = null;
  private com.lgicorp.gims.sap.gmm16.GMM16_out gMM16_out = null;
  
  public GMM16_outProxy() {
    _initGMM16_outProxy();
  }
  
  public GMM16_outProxy(String endpoint) {
    _endpoint = endpoint;
    _initGMM16_outProxy();
  }
  
  private void _initGMM16_outProxy() {
    try {
      gMM16_out = (new com.lgicorp.gims.sap.gmm16.GMM16_outServiceLocator()).getHTTP_Port();
      if (gMM16_out != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)gMM16_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)gMM16_out)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (gMM16_out != null)
      ((javax.xml.rpc.Stub)gMM16_out)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.lgicorp.gims.sap.gmm16.GMM16_out getGMM16_out() {
    if (gMM16_out == null)
      _initGMM16_outProxy();
    return gMM16_out;
  }
  
  public com.lgicorp.gims.sap.gmm16.GMM16R_GIMS_DT GMM16_out(com.lgicorp.gims.sap.gmm16.GMM16_GIMS_DT GMM16_GIMS_MT) throws java.rmi.RemoteException{
    if (gMM16_out == null)
      _initGMM16_outProxy();
    return gMM16_out.GMM16_out(GMM16_GIMS_MT);
  }
  
  
}