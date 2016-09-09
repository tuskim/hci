
var TRIM_PATTERN = /(^\s*)|(\s*$)/g; // 내용의 값을 빈공백을 trim하기 위한것(앞/뒤)

/**
 * String 객체에 trim메소드 추가
 **/
String.prototype.trim = function() {
	return this.replace(TRIM_PATTERN, "");
}


/***********************************************************************************************
 * 가우스를 사용시 프로그래스(조회중, 처리중)을 표시해주는 오브젝트
 * @author : 최재원
 * @history : 2007/12/28 - 유니코드 추가 및 이벤트 할당/제거를 ref멤버 변수로 처리
 *                2009/02/16 - Callback함수 호출 기능 추가 setCallBack()
 ***********************************************************************************************
 * usage : var rs = new Progress();	// 객체 생성.
 *             
 *         rs.submit(데이터셋오브젝트, x좌표, y좌표);			// 데이터셋을 통한 조회시
 *  
 *         rs.submit(트랜젝션오브젝트, x좌표, y좌표);			// 트랜젝션 처리시
 *  
 *         rs.submit(트랜젝션오브젝트, "R", x좌표, y좌표);	    // 트랜젝션 컴포넌트로 조회시
 *
 ***********************************************************************************************/
function Progress() {
	/** MAX 컴포넌트 기준으로 작성됨 :: 유니코드인 경우 해당 CLSID로 변경해 주면 된다. **/
	var DS_CLSID = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";	  // 데이터셋
	var TR_CLSID = "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5";	  // 트랜젝션 
	var UNI_DS_CLSID = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";  // 유니코드 데이터셋
	var UNI_TR_CLSID = "CLSID:223216F6-B9FE-406D-9ED6-143FCE3A07B8";  // 유니코드 트랜젝션
	var GLB_SUBMIT_STATUS = false;	// reset/post 중복방지.
	var GLO_OBJECT = document.all;
	var GLO_INTERVAL = "";
	var GLO_TEMP_OBJECT = "";
	var GLS_GRID  = "";
	var GLS_CALLBACK = "";											// 트랜젝션 및 조회후에 실행될 CallBack함수

	var ds_html = "<body leftmargin=0 topmargin=0><center><table cellpadding=0 cellspacing=0 width=259 height=44><tr><td>" +
					   "<img src='/sys/images/loading.gif' width=259 height=44></td></tr></table></center></body>";

	var tr_html = "<body leftmargin=0 topmargin=0><center><table cellpadding=0 cellspacing=0 width=228 height=25><tr><td>" +
					   "<img src='/sys/images/loading.gif' width=259 height=44></td></tr></table></center></body>";

	//	정상적으로 실행된 경우 메시지 출력 및 프로그래스 제거.
	this.close = function() {
	
		GLB_SUBMIT_STATUS = false;
		try {
			GLO_OBJECT.oProgressBar.outerHTML = "";
		} catch(exception) {}

		for (i=0; i<GLO_OBJECT.length; i++) {
			try {
				if (GLO_OBJECT[i].type.toUpperCase() == "BUTTON") {
					GLO_OBJECT[i].disabled = false;
				}

			} catch (exception) {}
		}

		/** 정상적으로 실행된 경우에 서버에서 메시지를 전송한 경우 해당 메시지를 출력해 준다. **/
		//if (GLO_TEMP_OBJECT.ErrorMsg.trim() != "") {
		//	if(GLO_TEMP_OBJECT.ErrorCode.trim() != "50000") {
		//		alert(GLO_TEMP_OBJECT.ErrorMsg);
		//	}
		//}

		// 이벤트를 제거하여 준다.
		if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			 GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
				GLO_TEMP_OBJECT.detachEvent ('OnLoadCompleted', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnLoadError', EVENT_VIEW_ERROR);


		} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			        GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션.
				GLO_TEMP_OBJECT.detachEvent ('OnSuccess', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnFail', EVENT_VIEW_ERROR);
		}
		
		try {
			if (GLS_CALLBACK != "") {
				eval(GLS_CALLBACK);
			}
		} catch(exception) {}

		try {
			if (GLS_GRID != "") {
				//cfFillGridNoDataMsg(GLS_GRID,"gridColLineCnt=2");
			}
		} catch(exception) {}
		
	}

	/**  에러가 발생한 경우 에러를 표시 및 프로그래스바를 제거  **/
	this.viewError = function() {
		GLB_SUBMIT_STATUS = false;
		GLO_OBJECT.oProgressBar.outerHTML = "";

		for (i=0; i<GLO_OBJECT.length; i++) {
			try {
				if (GLO_OBJECT[i].type.toUpperCase() == "BUTTON") {
					GLO_OBJECT[i].disabled = false;
				}

			} catch (exception) {}
		}
		
		/*************************************************************************
		 * 프로젝트별로 커스터 마이징이 필요한 부분
		 *************************************************************************
		 * 서비스 실행시 오류가 발생한 경우 해당 오류를 출력해 준다. 
		 * 이부분에서 서비스에서 넘어온 Exception타입에 따라 Biz, SysException등에
		 * 따라 팝업창, alert유형등으로 처리해 주면 된다. 
		 *************************************************************************/
		alert(GLO_TEMP_OBJECT.ErrorMsg);

		// 이벤트를 제거하여 준다.
		if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			 GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
				GLO_TEMP_OBJECT.detachEvent ('OnLoadCompleted', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnLoadError', EVENT_VIEW_ERROR);

		} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			        GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션.
				GLO_TEMP_OBJECT.detachEvent ('OnSuccess', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnFail', EVENT_VIEW_ERROR);
		}
	}
	
	/**
	 * 조회 및 트랜젝션 수행후에 실행될 JavaScript 함수
	 **/
	this.setCallBack = function(param) {
		GLS_CALLBACK = param;
	}
	
	/**
	 * 그리드 no date  함수 
	 **/
	this.setGrid = function(param) {
		GLS_GRID = param;
	}	

	// 실제 reset/post수행
	this.submit = function() {

		/** 중복 처리를 막기 위해 처리한 부분 **/
		if (GLB_SUBMIT_STATUS == true)	{
			return;
		}
		GLB_SUBMIT_STATUS = true;
		if (arguments.length == 1)	{
			try {
				GLO_TEMP_OBJECT = arguments[0];
			} catch (exception) {
				try {
					GLO_OBJECT.oProgressBar.style.top = arguments[0];
				} catch (exception) {}
			}
			this.create(GLO_TEMP_OBJECT);
		} else if (arguments.length == 2) {
			try {
				GLO_TEMP_OBJECT = arguments[0];
			} catch (exception) {
				try {
					GLO_OBJECT.oProgressBar.style.top = arguments[0];
				} catch (exception) {}
			}
			this.create(GLO_TEMP_OBJECT, arguments[1]);
		} else if (arguments.length == 3) {
			try {
				GLO_TEMP_OBJECT = arguments[0];
			} catch (exception) {
				try {
					GLO_OBJECT.oProgressBar.style.top = arguments[0];
				} catch (exception) {}
			}
			this.create(GLO_TEMP_OBJECT, arguments[1], arguments[2]);

		} else if (arguments.length == 4) {
			try {
				GLO_TEMP_OBJECT = arguments[0];
			} catch (exception) {
				try {
					GLO_OBJECT.oProgressBar.style.top = arguments[0];
				} catch (exception) {}
			}
			this.create(GLO_TEMP_OBJECT, arguments[1], arguments[2], arguments[3]);
		}

			
		if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
		     GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
				GLO_TEMP_OBJECT.attachEvent ('OnLoadCompleted', EVENT_CLOSE);
				GLO_TEMP_OBJECT.attachEvent ('OnLoadError', EVENT_VIEW_ERROR);
		} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
		            GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션 오브젝트.

				GLO_TEMP_OBJECT.attachEvent ('OnSuccess', EVENT_CLOSE);
				GLO_TEMP_OBJECT.attachEvent ('OnFail', EVENT_VIEW_ERROR);
		} else {
			alert("가우스 데이터셋/트랜젝션 컴포넌트가 아닙니다.\n데이터셋/트랜젝션 컴포넌트를 사용해 주세요.");
		}

		try	{
			//cfHideNoDataMsg(GLS_GRID);
			GLO_OBJECT.oProgressBar.style.visibility="visible";
			
		} catch (exception) {}
		GLO_INTERVAL = window.setInterval(this.progress,300);
	}

	this.create = function() {
		var progress = '<iframe  id=oProgressBar style="position:absolute;visibility:hidden;width:259;height:44;" width="259" height="44" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
		var doc = null;
		for (var i = 0; i < document.all.length; i++) {
			if (document.all[i].tagName.toUpperCase() == "BODY") {
				document.all[i].insertAdjacentHTML("beforeEnd", progress);
				doc = oProgressBar.document;
				break;
			}
		}
		if (doc == null) {
			alert("HTML Document에 body테그가 없습니다.");
			return;
		}

		doc.open("text/html");

		try	{
			if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			     GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
				doc.write(ds_html);
			} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			            GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션 오브젝트.

				if(arguments[1] == "R") {
					doc.write(ds_html);
				} else {
					doc.write(tr_html);
				}

			}
		} catch (exception) {
		}
		doc.close();

		/** 파라미터에 따라 처리 하는 부분 **/
		try	{
			GLO_OBJECT.oProgressBar.style.zIndex = 0;
			if (arguments.length==3) {
				GLO_OBJECT.oProgressBar.style.left = arguments[1];
				GLO_OBJECT.oProgressBar.style.top = arguments[2];
			} else if (arguments.length == 4) {
				GLO_OBJECT.oProgressBar.style.left = arguments[2];
				GLO_OBJECT.oProgressBar.style.top = arguments[3];
			} else {
				GLO_OBJECT.oProgressBar.style.left = 360;
				GLO_OBJECT.oProgressBar.style.top = 210;
			}	

		} catch (exception)	{
		}
	}

	this.progress = function() {

		for (i=0; i<GLO_OBJECT.length; i++) {
			try {
				if (GLO_OBJECT[i].type.toUpperCase() == "BUTTON") {
					GLO_OBJECT[i].disabled = true;
				}
			} catch (exception) {}
		}

		window.clearInterval(GLO_INTERVAL);

		try	{
			if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			     GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
				GLO_TEMP_OBJECT.reset();
			} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			            GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션 오브젝트.
				GLO_TEMP_OBJECT.post();
			}
		} catch (exception) {
			document.form1.submit();
		}
	}
	
	/** 이벤트 ref변수 **/
	var EVENT_VIEW_ERROR = this.viewError;
	var EVENT_CLOSE = this.close;
}