/* ------------------------------------------------------------------------
 * @source  : comm.js
 * @desc    : LILS 공통 자바스크립트
 * ------------------------------------------------------------------------
 *
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2009.09.15   hcSim                  최초생성
 * 1.1  2010.04.20   김현수               그리드 크기 변경(cfGridBigger,cfGridSmaller) 추가
 * ------------------------------------------------------------------------
 */

 /*********************************************************************************************
 *   함수리스트
 + - Map()     java map을 자바스그립트로 구현
 *********************************************************************************************/

/*********************************************************************************************
 *   공통변수 Start
 *********************************************************************************************/

/*********************************************************************************************
 *   공통변수 End
 *********************************************************************************************/


/**
* Map()
* 작 성 자 : hcSim
* 작 성 일 : 2009-09-15
* 개    요 : java map을 자바스그립트로 구현
* 사 용 법 :
*
*/
function Map(Delimitor) {
  this.Delimitor = (Delimitor == null ? "||" : Delimitor);
  this._MapClass = new ActiveXObject("Scripting.Dictionary");

  this.get = function(key) { return this._MapClass.exists(key) ? this._MapClass.item(key) : null; }
  this.getKey = function (value) {
    var keys = this.keys();
    var values = this.values();
    for (var i in values) {
       if (value == values[i]) return keys[i];
     }
    return "";
  }
  this.put = function(key, value) {
      var oldValue = this._MapClass.item(key);
      this._MapClass.item(key) = value;
      return value;
  }
  this.size = function() { return this._MapClass.count; }
  this.remove = function(key) {
    var value = this._MapClass.item(key);
    this._MapClass.remove(key);
    return value;
  }
  this.clear = function() {
    this._MapClass.removeAll();
  }
  this.keys = function() {
    return this._MapClass.keys().toArray();
  }
  this.values = function() {
    return this._MapClass.items().toArray();
  }
  this.containsKey = function(key) {
    return this._MapClass.exists(key);
  }
  this.containsValue = function(value) {
    var values = this.values();
    for (var i in values) {
      if (value == values[i]) {
        return true;
      }
    }
    return false;
  }
  this.isEmpty = function() { return this.size() <= 0;}
  this.putAll = function(map) {
    if (!(map instanceof Map)) {
      throw new Error(0, "Map.putAll(Map) method Map type parameter.");
    }
    var keys = map.keys();
    for (var i in keys) {
      this.put(keys[i], map.get(keys[i]));
    }
    return this;
  }

  this.toString = function(separator) {
    var keys = this.keys();
    var result = "";
    separator = separator == null ? "&" : separator;
    for (var i in keys) {
      result += (keys[i] + this.Delimitor + this._MapClass.item(keys[i]));
      if (i < this.size() - 1) {
        result += separator;
      }
    }
    return result;
  }
}

/**
* showModal()
* 작 성 자 : hcSim
* 작 성 일 : 2009-09-15
* 개    요 : 팝업 호출
* 사용방법 : showModal(url, "", width, height)
* return값 : Array
*/
function showModal(sUrl, sParam, sWidth, sHeight) {
    if(ie7 == true) {
        //sWidth = sWidth-"15";
        sHeight = sHeight-"30";
    }
    var returnVal = new Array();
    var winleft=(screen.width)?(screen.width-sWidth)/2:100;
    var wintop=(screen.height)?(screen.height-sHeight)/2:100;

    returnVal = window.showModalDialog(sUrl, sParam,
            "dialogWidth:" + sWidth + "px; dialogHeight:" + sHeight + "px; resizable:no; help:no; status:no; scroll:no; edge:sunken;");

    return returnVal;
}

/**
* removeDash()
* 작 성 자 : hcSim
* 작 성 일 : 2009-09-15
* 개    요 : 날짜형식에서 Mask 형태 제거
* 사용방법 : 
* return값 : 
*/
function removeDash( str , strDel )
{
	var len = str.length;
	var replace_chr;
	var cur_chr;
	var replace_str = '';

	for(var i=0; i < len; i++) {
		cur_chr = str.charAt(i);

		if( cur_chr == strDel ) {
		  replace_chr = '';
		} else {
		  replace_chr = cur_chr;
		}
		replace_str += replace_chr;
	}

	return replace_str;
}

/**
* removeComma()
* 작 성 자 : hcSim
* 작 성 일 : 2009-09-15
* 개    요 : 숫자형식에서 콤마 제거
* 사용방법 : 
* return값 : 
*/
function removeComma( str )
{
	var len = str.length;
	var replace_chr;
	var cur_chr;
	var replace_str = '';

	for(var i=0; i < len; i++) {
		cur_chr = str.charAt(i);

		if( cur_chr==',') {
		  replace_chr='';
		} else {
		  replace_chr = cur_chr;
		}
		replace_str += replace_chr;
	}

	return replace_str;
}

/**
* setComma()
* 작 성 자 : hcSim
* 작 성 일 : 2009-09-15
* 개    요 : 숫자형식에서 콤마 추가
* 사용방법 : 
* return값 : 
*/
function setComma(varb)
{
	var rpl_st = varb.toString();
	rpl_st = rpl_st.replace(/,/g, "");

	if (rpl_st == '' || rpl_st.length == 0 )  return "";

	//.이하를 제외한 길이
	var strLen = 0;

	// -가 있으면 잘라냈다  반환시 붙여 준다
	var dash = rpl_st.indexOf( "-" );

	// - 의 위치를 못 찾았으면
	if( dash == -1 ) {
	  rpl_st = rpl_st;
	} else {
	  rpl_st = rpl_st.substring(dash+1, rpl_st.length);
	}

	// .가 있으면 반환시 붙여 준다
	var point = rpl_st.indexOf( '.' );
	if( point == -1 ) {
	  strLen = rpl_st.length;
	} else {
	  strLen = point;
	}

	var underNum  = rpl_st.length - point;
	var front_m   = rpl_st.substring(0,strLen);
	var len		    = front_m.length;
	var skip_su   = len % 3;
	var temp_su	  = '';
	var cur_chr   = '';
	var return_su = '';
	var skip_cnt  = 1;

	if(len > 3) {
		for(var i=0; i < len; i++) {
			cur_chr = front_m.charAt(i);
			if( i < skip_su ) {
				temp_su += cur_chr;
				continue;
			} else {
				if( i == skip_su || skip_cnt > 2) {
					if(i != 0)   temp_su += ',';
					temp_su += cur_chr;
					skip_cnt  = 1 ;
				} else {
					skip_cnt++;
					temp_su += cur_chr;
				}
			}
		}

		// 소숫점이하 값이 있으면 마지막에 붙여 준다.
		if( point > -1 ) temp_su += rpl_st.substring( point, point+5);
		// - 가 있으면 앞에 붙여준다
		if( dash > -1 )  temp_su = '-'+temp_su;

		return temp_su;

	} else {
		// 소숫점이하 값이 있으면 마지막에 붙여 준다.
		if( point > -1 ) temp_su += rpl_st.substring( point, point+5);
		// - 가 있으면 앞에 붙여준다
		if( dash > -1 )  rpl_st = '-'+rpl_st;

		return rpl_st;
	}

}

/**
* fnMathRound()
* 작 성 자 : hcSim
* 작 성 일 : 2009-09-15
* 개    요 : 반올림 함수
* 사용방법 : 
* return값 : 
*/
function fnMathRound( fp_val , fp_Rd , fp_gubun ) {

    var vRound = Math.pow( 10 , parseInt(fp_Rd) );
    if( fp_gubun == 'T' ) {
        var vRtnVal = parseInt( parseFloat( fp_val ) * vRound ) / vRound;
    } else {
        var vRtnVal = Math.round( parseFloat( fp_val ) * vRound ) / vRound;
    }
    return vRtnVal;
}

/**
* gfn_runExcel()
* 작 성 자 : ymkang
* 작 성 일 : 2009-10-07
* 개    요 : 엑셀 출력
* 사용방법 : 
* return값 : 
*/
function gfn_runExcel(obj, titleName, srcCondition1, srcCondition2, gubun){
	var szPath = "";

	obj.SetExcelTitle(0, "");
	obj.SetExcelTitle(1, "value:" + titleName + "; font-face:'굴림체'; font-size:15pt; align:center; font-bold; font-underline; skiprow:1;");
	if(gubun == "Y") {
		obj.SetExcelTitle(1, "value:" + srcCondition1 + "; font-face:'굴림체'; font-size:9pt; font-color:black; align:left;");
	}
	obj.SetExcelTitle(1, "value:" + srcCondition2 + "; font-face:'굴림체'; font-size:9pt; font-color:black; align:left;");

	obj.GridToExcel(titleName, szPath, 1);
}

//-------------------------------------------------------------------------
// 그리드 크기 변경
//-------------------------------------------------------------------------	
function cfGridBigger(obj) {      
    var h = obj.height ; //현재크기 ;
	var scale = 100;
    if(parseFloat(h) < 10) h = '5';
    //h = h.substring(0, h.indexOf('px'));
	h = parseFloat(h) + scale;
	obj.height = h;
}

function cfGridSmaller(obj) {
	var basicH = 153;
	var h = obj.height;
	var scale = 100;
	if(parseFloat(h) < 10) h = '5';
	//h = h.substring(0, h.indexOf('px'));

	if(parseFloat(h) <= basicH) h = parseFloat(h);
	else h = parseFloat(h) - scale ;

	obj.height = h;
 	}


