
function js_pop_menu(menuName, num) {
		if (eval(menuName + ".style.display != 'none'")) 
					js_pop_menuhide(menuName, num);
		else js_pop_menushow(menuName, num);			
}

function js_pop_menushow(menuName, num) {
		eval(menuName + ".style.display = 'block'");
		eval("img" + num + ".src='../images/popup_blt_open.gif'");
}

function js_pop_menuhide(menuName, num) {
		eval(menuName + ".style.display = 'none'");
		eval("img" + num + ".src='../images/popup_blt_close.gif'");
}


