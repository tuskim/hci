/**
 * @type : global
 * @desc : ocx.js�� ȭ�鿡 object�� �����ϴ� ���������� ����ϴ� �ڹ� ��ũ��Ʈ��
 * ����� �ڹٽ�ũ��Ʈ �����̴�.
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
