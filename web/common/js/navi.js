var beforeSelectBoard = 'board1';

function setSelectBoard(boardId, num) {
  
	var object = eval( beforeSelectBoard );
	if(num==3){
		if( object !=null) object.className ='';
		eval(boardId).className = 'left_menu_2depth_on';
	}
	else if(num==4){
		if( object !=null) object.className ='';
		eval(boardId).className = 'left_menu_2depth_on';
	}
    beforeSelectBoard = boardId;
}
function resetSelectBoard() {
  
	var object = eval( beforeSelectBoard );
	if( object !=null) object.className ='';
    beforeSelectBoard = '';
}
