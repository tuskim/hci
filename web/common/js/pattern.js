/**
 * @type : intro
 * @desc : pattern.js�� Trustform�� ����� UI Pattern���� �������� ����ϴ� �ڹ� ��ũ��Ʈ��
 * ����� �ڹٽ�ũ��Ʈ �����̴�.
 *
 * �Լ� Naming Rule�� ������ ����.
 * <pre>
 *     - cf  : common function
 *     - cov : common object for validation
 * </pre>
 * @version : 1.0
 */

/* ********************************************************************************
 *                                 �̺�Ʈ �ڵ鸵
 * *******************************************************************************/

 /**
 * @type   : event
 * @access : private
 * @desc   : xrw�� �ε��� �� �߻��ϴ� xforms_model_construct() �̺�Ʈ�̴�.
 			 global�� ������ ���ұ� ������ ������ ���ο��� �����ϴ� construct �̺�Ʈ�� �����ϸ�,
 			 �̺�Ʈ�� �ߺ��ǰ� �ȴ�.
 			 �̸� �����ϱ� ���� 'form_xforms_model_construct()' ��� �̸�����
 			 form�� �̺�Ʈ�� ������ �� �ְ� �� �ξ���.
 * @return : void
 */
function xforms_model_construct() {
    // form �� ���� model_construct �̺�Ʈ�� �����ϱ� ����.
	try{
	    var f_name = 'form_xforms_model_construct()';	// �ش� �̸����� form���� �̺�Ʈ�� ������ ����� �� �ִ�.
	    eval(f_name);
    } catch(E) {
        //model.alert(E);   // form�� �ش� �̺�Ʈ�� ������� �ʾ��� �� ó���� �� �� �ִ�.
    }

    // �̺�Ʈ�� �ߺ� �߻� �����Ѵ�. �̴� �̺�Ʈ ������ �����ϱ� �����̴�.
	event.stopPropagation();
}


 /**
 * @type   : event
 * @access : private
 * @desc   : xrw���� ��Ʈ���� ���� ����Ǿ��� �� �߻��ϴ� xforms_value_changed() �̺�Ʈ�̴�.
 			 global�� ������ ���ұ� ������ ��Ʈ�ѿ��� �߻��ϴ� value_changed �̺�Ʈ�� �����ϸ�,
 			 �̺�Ʈ�� �ߺ��ǰ� �ȴ�.
 			 �̸� �����ϱ� ���� '��Ʈ��ID+_xforms_model_construct()' ��� �̸�����
 			 ���� �̺�Ʈ�� ������ �� �ְ� �� �ξ���.
 * @return : void
 */
function xforms_value_changed() {
	var ctrl = document.controls(event.target);

	if( ctrl != null) {
        var curNode = '';

		if (ctrl.elementName == "xforms:datagrid") {	// �׸����� ��� NODESET�� ������ ����ִ�.
			var gref = ctrl.attribute("nodeset");
			curNode = root.selectSingleNode(gref.substring(0, gref.lastIndexOf("/") ));
			if( curNode != null ) {
			    curNode.setattribute("update", true);
			}
		} else {
			var cref = ctrl.attribute("ref");			// �׸��� ���� ��Ʈ���� ��� REF�� ������ ����ִ�.
			curNode = root.selectSingleNode(cref.substring(0, cref.lastIndexOf("/") ));

            if( curNode != null ) {
			    curNode.setattribute("update", true);
			}
		}
	}

    // form �� ���� value_changed �̺�Ʈ�� �����ϱ� ����.
	try{
	    var f_name = event.target+'_xforms_value_changed()';
	    eval(f_name);
    } catch(E) {
        //model.alert(E);   // form function�� ���� ��.
    }
}
/**
 * @type   : event
 * @access : private
 * @desc   : �׸��� ��� ��ɿ� �ʿ��� ����Ÿ�� ����.
		     xrw���� �׸����� ROW�� ������ �� �߻��ϴ� onrowchanged() �̺�Ʈ�̴�.
 			 global�� ������ ���ұ� ������ �׸��忡�� �߻��ϴ� onrowchanged �̺�Ʈ�� �����ϸ�,
 			 �̺�Ʈ�� �ߺ��ǰ� �ȴ�.
 			 �̸� �����ϱ� ���� '��Ʈ��ID+_onrowchanged()' ��� �̸�����
 			 ���� �̺�Ʈ�� ������ �� �ְ� �� �ξ���.
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

            // ��Ʈ�� �� onrowchanged �̺�Ʈ�� �����ϱ� ����.
        	try{
        	    var f_name = ctrl.attribute("id") + '_'+event.name+'()';	//event.name�� ����ϸ� �ٸ� �̺�Ʈ�� Ȯ�嵵 �����ϴ�.
        	    eval(f_name);
            } catch(E) {
                //model.alert(E);   // form function�� ���� ��.
            }
		}
	}

	event.stopPropagation();    // �̺�Ʈ�� �ߺ� �߻� ����.
}



/**
 * @type   : event
 * @access : private
 * @desc   : �׸��� ���� �׸��� �׸��忡 readonly���·� ����.
 			 xrw���� �׸����� CELL�� Ŭ������ �� �߻��ϴ� onentercell() �̺�Ʈ�̴�.
 			 global�� ������ ���ұ� ������ �׸��忡�� �߻��ϴ� onentercell �̺�Ʈ�� �����ϸ�,
 			 �̺�Ʈ�� �ߺ��ǰ� �ȴ�.
 			 �̸� �����ϱ� ���� '��Ʈ��ID+_onentercell()' ��� �̸�����
 			 ���� �̺�Ʈ�� ������ �� �ְ� �� �ξ���.
 * @return : void
 */

function onentercell() {
	var ctrl = document.all(event.target);
	if ( ctrl != null ) {

		//�׸����� �Ӽ� �� disabled="true"�� �÷��� onentercell() �Լ��� skip�Ѵ�.
		if ( ctrl.elementName == "xforms:datagrid" ) {
			var child = ctrl.children;

		    for(var inx = 0; inx < child.length; inx++ ) {
		        if( child.item(inx).elementName == "xforms:col" ) {
		            var g_idx = inx + ctrl.col - 1;	//�׸��尡 ������ �ִ� ��ũ�ѵ��� child ������ �������� 6����.
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

		    // ��Ʈ�� �� onrowchanged �̺�Ʈ�� �����ϱ� ����.
        	try{
        	    var f_name = ctrl.attribute("id") + '_'+event.name+'()';
        	    eval(f_name);
            } catch(E) {
                //model.alert(E);   // form function�� ���� ��.
            }
		}
	}
	event.stopPropagation();
}


//----------------------------- 2. control ó�� ���� -----------------------------//

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
 * @desc   : �׸��� �� �߰�.
 * <pre>
 *     covGridAddRow("ds_emp")
 * </pre>
 * @param  : gridID    grid ��Ʈ���� ID.
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
 * @desc   : �׸��� �� ����.
 * <pre>
 *     covGridDelRow("ds_emp")
 * </pre>
 * @param  : gridID    grid ��Ʈ���� ID.
 * @return : void
 */
function covGridDelRow(gridID) {
    var grid = document.all(gridID);
	if( grid.row >= grid.fixedRows ) {
		var gridStatus = grid.rowStatus(grid.row);
		covUndoGridRow(gridID, grid.row);  // ���� �����ͷ� ����.

		if( gridStatus == IDINSERT || gridStatus == IDNEWINSERT ) {
			grid.isReadOnly(grid.row, 0, grid.row, grid.cols-1) = true;
		} else {
			grid.rowstatus(grid.row) = IDDELETE;
		}
	}
}


//----------------------------- 3. ���� ��� ���� --------------------------------//


//----------------------------- 4. model �Լ� ������ -----------------------------//


//----------------------------- 5. value changed ����  ---------------------------//

/**
 * @type   : function
 * @access : public
 * @desc   : �׸��� ���� ������ �˻��Ѵ�.
 * @param  : gridID   �˻��ϰ��� �ϴ� �׸��� ID
 * @return : ���� ���� ( true : �����, false : ���� ����)
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
 * @desc   : ��� ���� ������ �˻��Ѵ�..
 * @param  : �˻��ϰ��� �ϴ� ���
 * @return : ���� ���� ( true : �����, false : ���� ����)
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
 * @desc   : �׸��� ��� ���
 *           �߰��� ���� ����, ����� ���� ���, ������ ���� ��ũ ����
 * @param  : gridID  ��ұ���� ������ �׸���ID
 * @param  : gridrow ��ұ���� ������ row ��ȣ
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
