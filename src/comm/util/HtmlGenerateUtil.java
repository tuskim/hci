/**
 * 
 */
package comm.util;

/**
 * <PRE>
 * 	HTML 코드를 출력하는 클래스
 * </PRE>
 *
 * @author    박대범
 * @version   2008. 09. 04
 * @see       HtmlGenerateUtil
 */
public class HtmlGenerateUtil {
    // DropDownPop 레이어 생성
    public static String makeDropDownPopup(String ddId, int width, int height) {
        StringBuffer str = new StringBuffer();
        str.append("<div id='div_ddpop_").append(ddId).append("' ")
            .append("class=\"dropdowndiv\" ")
            .append("style=\"")
            .append("width: ").append(width).append("; ")
            .append("height: ").append(height).append("; ")
            .append("position: absolute; left: 0px; top: 0px; visibility: 'hidden'; z-index: 10;\">")
            .append("<iframe name='").append("ifr_ddpop_" + ddId).append("' ")
            .append("id='").append("ifr_ddpop_" + ddId).append("' ")
            .append("frameborder=0 scrolling=no class=\"dropdownframe\" ")
            .append("style=\"")
            .append("width: ").append(width).append("; ")
            .append("height: ").append(height).append(";\" ")
            .append("src=''>")
            .append("</iframe>")
            .append("</div>");
        return str.toString();
    }

    // DropDownPop 레이어 생성
    public static String makeDropDownPopup(String ddId, String target, String option) {
        StringBuffer str = new StringBuffer();
        str.append("<div id='div_ddpop_").append(ddId).append("' ")
            .append("class=\"dropdowndiv\" >")            
            .append("\r\n").append("<script>")
            .append("\r\n").append("var dt_").append(ddId).append(" = new DatePicker('").append(ddId).append("'")
            .append(", new Date(), document.getElementById('").append(target).append("'), '").append(option).append("');")
            .append("\r\n").append("var el_").append(ddId).append(" = dt_").append(ddId).append(".create();")
            .append("\r\n").append("dt_").append(ddId).append(".setFirstWeekDay(6);")
            .append("\r\n").append("div_ddpop_").append(ddId).append(".appendChild(").append("el_").append(ddId).append(");")            
            .append("\r\n").append("</script>")
            .append("\r\n").append("</div>");        
        
        return str.toString();
    }
    
    // DropDownPop화면(html/jsp)에서 우측 상단에 Close button 생성
    // javascript function popClose() 메소드는 해당 DropDownPop화면(html/jsp)
    // 내에 구현되어야 함.
    public static String makeDropDownClose() {
        StringBuffer str = new StringBuffer();
        str.append("<div id='_ddpopclosebuttondiv' style='position: absolute; top: 2px; left: 0px;'>")
            .append("<table width='20px' border='0' cellspacing='0' cellpadding='0'>")
            .append("<tr><td style='text-align: right; padding-right: 1px;'>")
            .append("<input type='button' name='btnPopClose' value='x×' style='width: 18px; height: 20px; font-weight: bold;' onclick='popClose();'>")
            .append("</td></tr></table></div>");
        return str.toString();
    }
    
    // DropDownPop화면(html/jsp)에서 우측 상단에 Close button 생성
    public static String makeDropDownClose(String ddpopid) {
        StringBuffer str = new StringBuffer();
        str.append("<div id='_ddpopclosebuttondiv' style='position: absolute; top: 2px; left: 0px;'>")
            .append("<table width='20px' border='0' cellspacing='0' cellpadding='0'>")
            .append("<tr><td style='text-align: right; padding-right: 1px;'>")
            .append("<input type='button' name='btnPopClose' value='×' style='width: 18px; height: 20px; font-weight: bold;' onclick='_ddPopClose();'>")
            .append("</td></tr></table></div>");
        
        str.append("\r\n").append("<script>")
            .append("var _ddpopclosediv = document.getElementById('_ddpopclosebuttondiv');")
            .append("_ddpopclosediv.style.left = document.body.clientWidth - 20;")
            .append("\r\n").append("function _ddPopClose() {")
            .append("\r\n").append("if(window.popClose) popClose(); ")
            .append("\r\n").append("else { ")
            .append("\r\n").append("var ddpop = parent.document.getElementById('div_ddpop_" + ddpopid + "');")
            .append("\r\n").append("ddpop.style.visibility = 'hidden';")
            .append("\r\n").append("} } </script>");
        return str.toString();
    }
}
