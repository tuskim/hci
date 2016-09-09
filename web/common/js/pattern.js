/**
 * @type : intro
 * @desc : pattern.js는 Trustform을 사용한 UI Pattern에서 공통으로 사용하는 자바 스크립트를
 * 기술한 자바스크립트 파일이다.
 *
 * 함수 Naming Rule은 다음과 같다.
 * <pre>
 *     - cf  : common function
 *     - cov : common object for validation
 * </pre>
 * @version : 1.0
 */

/* ********************************************************************************
 *                                 이벤트 핸들링
 * *******************************************************************************/

 /**
 * @type   : event
 * @access : private
 * @desc   : xrw가 로딩될 때 발생하는 xforms_model_construct() 이벤트이다.
 			 global로 선언해 놓았기 때문에 페이지 내부에서 생성하는 construct 이벤트를 선언하면,
 			 이벤트가 중복되게 된다.
 			 이를 방지하기 위해 'form_xforms_model_construct()' 라는 이름으로
 			 form별 이벤트를 선언할 수 있게 해 두었다.
 * @return : void
 */
function xforms_model_construct() {
    // form 별 개별 model_construct 이벤트를 수행하기 위함.
	try{
	    var f_name = 'form_xforms_model_construct()';	// 해당 이름으로 form에서 이벤트를 선언해 사용할 수 있다.
	    eval(f_name);
    } catch(E) {
        //model.alert(E);   // form에 해당 이벤트가 선언되지 않았을 때 처리를 할 수 있다.
    }

    // 이벤트의 중복 발생 방지한다. 이는 이벤트 버블링을 방지하기 위함이다.
	event.stopPropagation();
}


 /**
 * @type   : event
 * @access : private
 * @desc   : xrw에서 컨트롤의 값이 변경되었을 때 발생하는 xforms_value_changed() 이벤트이다.
 			 global로 선언해 놓았기 때문에 컨트롤에서 발생하는 value_changed 이벤트를 선언하면,
 			 이벤트가 중복되게 된다.
 			 이를 방지하기 위해 '컨트롤ID+_xforms_model_construct()' 라는 이름으로
 			 개별 이벤트를 선언할 수 있게 해 두었다.
 * @return : void
 */
function xforms_value_changed() {
	var ctrl = document.controls(event.target);

	if( ctrl != null) {
        var curNode = '';

		if (ctrl.elementName == "xforms:datagrid") {	// 그리드일 경우 NODESET에 정보가 들어있다.
			var gref = ctrl.attribute("nodeset");
			curNode = root.selectSingleNode(gref.substring(0, gref.lastIndexOf("/") ));
			if( curNode != null ) {
			    curNode.setattribute("update", true);
			}
		} else {
			var cref = ctrl.attribute("ref");			// 그리드 외의 컨트롤일 경우 REF에 정보가 들어있다.
			curNode = root.selectSingleNode(cref.substring(0, cref.lastIndexOf("/") ));

            if( curNode != null ) {
			    curNode.setattribute("update", true);
			}
		}
	}

    // form 별 개별 value_changed 이벤트를 수행하기 위함.
	try{
	    var f_name = event.target+'_xforms_value_changed()';
	    eval(f_name);
    } catch(E) {
        //model.alert(E);   // form function이 없을 때.
    }
}
/**
 * @type   : event
 * @access : private
 * @desc   : 그리드 취소 기능에 필요한 데이타를 설정.
		     xrw에서 그리드의 ROW가 변했을 때 발생하는 onrowchanged() 이벤트이다.
 			 global로 선언해 놓았기 때문에 그리드에서 발생하는 onrowchanged 이벤트를 선언하면,
 			 이벤트가 중복되게 된다.
 			 이를 방지하기 위해 '컨트롤ID+_onrowchanged()' 라는 이름으로
 			 개별 이벤트를 선언할 수 있게 해 두었다.
 * @return : void
 */

function onrowchanged() {
	var ctrl = document.controls(event.target);

	if( ctrl != null ) {
		if (ctrl.elementName == "xforms:datagrid" ) {
			if( ctrl.rowdata(ctrl.row) == "" ) {
				var undodata="";
				for( var i = 0; i < ctrl.cols; i++ ) {
					undodata += ctrl.valueMatrix(ctrl.row, i)+"^";
				}
				ctrl.rowdata(ctrl.row) = undodata;
			}

            // 컨트롤 별 onrowchanged 이벤트를 수행하기 위함.
        	try{
        	    var f_name = ctrl.attribute("id") + '_'+event.name+'()';	//event.name을 사용하면 다른 이벤트로 확장도 가능하다.
        	    eval(f_name);
            } catch(E) {
                //model.alert(E);   // form function이 없을 때.
            }
		}
	}

	event.stopPropagation();    // 이벤트의 중복 발생 방지.
}



/**
 * @type   : event
 * @access : private
 * @desc   : 그리드 삭제 항목은 그리드에 readonly상태로 변경.
 			 xrw에서 그리드의 CELL을 클릭했을 때 발생하는 onentercell() 이벤트이다.
 			 global로 선언해 놓았기 때문에 그리드에서 발생하는 onentercell 이벤트를 선언하면,
 			 이벤트가 중복되게 된다.
 			 이를 방지하기 위해 '컨트롤ID+_onentercell()' 라는 이름으로
 			 개별 이벤트를 선언할 수 있게 해 두었다.
 * @return : void
 */

function onentercell() {
	var ctrl = document.all(event.target);
	if ( ctrl != null ) {

		//그리드의 속성 중 disabled="true"인 컬럼은 onentercell() 함수를 skip한다.
		if ( ctrl.elementName == "xforms:datagrid" ) {
			var child = ctrl.children;

		    for(var inx = 0; inx < child.length; inx++ ) {
		        if( child.item(inx).elementName == "xforms:col" ) {
		            var g_idx = inx + ctrl.col - 1;	//그리드가 가지고 있는 스크롤등의 child 갯수가 고정으로 6개임.
    				var type = child.item(g_idx).attribute("type");

    				if ( type != null && type != "" && type == "combo" ) {
        				var att = child.item(g_idx).attribute("disabled");
        				if ( att != null || att != "") {
        					return;
        				}
    				}

		            break;
		        }
		    }

		    // 컨트롤 별 onrowchanged 이벤트를 수행하기 위함.
        	try{
        	    var f_name = ctrl.attribute("id") + '_'+event.name+'()';
        	    eval(f_name);
            } catch(E) {
                //model.alert(E);   // form function이 없을 때.
            }
		}
	}
	event.stopPropagation();
}


//----------------------------- 2. control 처리 관련 -----------------------------//

// datagrid
/*
- 0 : new
- 1 : insert
- 2 : update
- 3 : insert & new
- 4 : delete
*/
var IDNEW = 0;
var IDINSERT = 1;
var IDUPDATE = 2;
var IDNEWINSERT = 3;
var IDDELETE = 4;

/**
 * @type   : method
 * @access : public
 * @desc   : 그리드 행 추가.
 * <pre>
 *     covGridAddRow("ds_emp")
 * </pre>
 * @param  : gridID    grid 컨트롤의 ID.
 * @return : void
 */
function covGridAddRow(gridID) {
	var grid = document.all(gridID);
	grid.addItem();
	grid.topRow = grid.rows - grid.fixedRows;
}

/**
 * @type   : method
 * @access : public
 * @desc   : 그리드 행 삭제.
 * <pre>
 *     covGridDelRow("ds_emp")
 * </pre>
 * @param  : gridID    grid 컨트롤의 ID.
 * @return : void
 */
function covGridDelRow(gridID) {
    var grid = document.all(gridID);
	if( grid.row >= grid.fixedRows ) {
		var gridStatus = grid.rowStatus(grid.row);
		covUndoGridRow(gridID, grid.row);  // 이전 데이터로 원복.

		if( gridStatus == IDINSERT || gridStatus == IDNEWINSERT ) {
			grid.isReadOnly(grid.row, 0, grid.row, grid.cols-1) = true;
		} else {
			grid.rowstatus(grid.row) = IDDELETE;
		}
	}
}


//----------------------------- 3. 공통 기능 관련 --------------------------------//


//----------------------------- 4. model 함수 재정의 -----------------------------//


//----------------------------- 5. value changed 관련  ---------------------------//

/**
 * @type   : function
 * @access : public
 * @desc   : 그리드 변경 유무를 검사한다.
 * @param  : gridID   검사하고자 하는 그리드 ID
 * @return : 변경 유무 ( true : 변경됨, false : 변경 없음)
 */

function isGridUpdated(gridID) {
	var ctrl = document.all(gridID);

	if( ctrl != null ) {
		var updateData = ctrl.getUpdateData();
		var headerpos = updateData.indexOf("|");
		if( updateData.indexOf("|",headerpos+1) < 0 ) {
			return false;
		}
		return true;
	}
}


/**
 * @type   : function
 * @access : public
 * @desc   : 노드 변경 유무를 검사한다..
 * @param  : 검사하고자 하는 노드
 * @return : 변경 유무 ( true : 변경됨, false : 변경 없음)
 */

function isUpdated(nodeName) {
	var targetNode = root.selectSingleNode("/"+nodeName);
	if( nodeName.substr(nodeName.length-1) == "/" ) {
		nodeName = nodeName.substr(0, nodeName.length-1);
	}

	var updateNode = targetNode.getAttribute("update");

	if (updateNode) {
		return true;
	}
	return false;
}


/**
 * @type   : function
 * @access : public
 * @desc   : 그리드 취소 기능
 *           추가된 행은 제거, 사용자 수정 취소, 삭제행 삭제 마크 제거
 * @param  : gridID  취소기능을 수행할 그리드ID
 * @param  : gridrow 취소기능을 수행할 row 번호
 * @return : void
 */
function covUndoGridRow(gridID, gridrow) {
	var grid = document.all(gridID);
	if ( grid != null ) {
		if( grid.rowstatus(gridrow) == IDINSERT || grid.rowstatus(gridrow) == IDNEWINSERT ) {
			grid.deleteitem(gridrow);
		} else if( grid.rowstatus(gridrow) == IDUPDATE || grid.rowstatus(gridrow) == IDDELETE ) {
			var undodata = grid.rowdata(gridrow).split("^");
			for ( var i = 0; i < grid.cols; i++ ) {
				grid.valueMatrix(grid.row, i) = undodata[i];
			}
			grid.isReadOnly(grid.row, 0, grid.row, grid.cols-1) = false;
			grid.rowstatus(gridrow) = IDNEW;
		}
	}
}
