/**
 * @type : global
 * @desc : ocx.js는 화면에 object를 포함하는 페이지에서 사용하는 자바 스크립트를
 * 기술한 자바스크립트 파일이다.
 *
 * @version : 1.0
 */

function writeTrustForm(objID, src, controlName, DomainName) {
	var objStr = "";
	objStr = "<OBJECT id='"+objID+"' classid='CLSID:4DA55DF4-4825-44CF-9790-4D29E8F02AC7' width='800' height='600'>";
	objStr = objStr + "<PARAM name='src' value='"+src+"'/>";
	objStr = objStr + "<PARAM name='controlName' value='"+controlName+"'/>";
	if ( DomainName != null )
	{
		objStr = objStr + "<PARAM name='DomainName' value='"+DomainName+"'/>";
	}
	objStr = objStr + "</OBJECT>";
	document.write (objStr);
}
