//package devonframework.sample.front.paging;
package comm.util;

/**
 * @(#) LDefaultPageNavigationByPost.java
 * 
 * Copyright 2008 by LG CNS, Inc.,
 * All rights reserved.
 *
 * Do Not Erase This Comment!!! (이 주석문을 지우지 말것)
 *
 * DevOn Framework의 클래스를 실제 프로젝트에 사용하는 경우 DevOn Framework 개발담당자에게
 * 프로젝트 정식명칭, 담당자 연락처(Email)등을 mail로 알려야 한다.
 *
 * 소스를 변경하여 사용하는 경우 DevOn Framework 개발담당자에게
 * 변경된 소스 전체와 변경된 사항을 알려야 한다.
 * 저작자는 제공된 소스가 유용하다고 판단되는 경우 해당 사항을 반영할 수 있다.
 * 중요한 Idea를 제공하였다고 판단되는 경우 협의하에 저자 List에 반영할 수 있다.
 *
 * (주의!) 원저자의 허락없이 재배포 할 수 없으며
 * LG CNS 외부로의 유출을 하여서는 안 된다.
 */

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import devon.core.collection.LMultiData;
import devonframework.front.paging.LAbstractPageNavigation;
import devonframework.front.paging.LPageConstants;
import devonframework.front.paging.LPageNavigationIF;
import devonframework.front.paging.LPageNavigationUtility;

/**
 * <pre>
 *   페이지의 Navigation 기능을 내부적으로 Post 방식으로 처리하는 Navigation Class
 *   이 LDefaultPageNavigationByPost Class는 페이지에서 각각의 페이지를 조회할 수 있는 기능을  html로 구현해서 보여주는 core logic을 가지고 있다.
 *   Navigation 기능을 위해 필요한 함수를 모두 가지고 있으며, 페이지 화면을 구성하게 되는 LAbstratPageRenderer가 이용하게 된다.
 * </pre>
 * @see LPageNavigationIF
 * @see LAbstractPageNavigation
 * @see LPageNavigationUtility
 * 
 * @since DevOn Framework 3.0
 * @version DevOn Framework 3.0
 * @author Corporate Asset팀, devon@lgcns.com<br>
 *         LG CNS Technical Service Division<br>
 *         작성 : 2008/04/01<br>
 */

public class LDefaultPageNavigationByPost extends LAbstractPageNavigation {
	private LMultiData pageMultiData;
    
    /**
     * LDefaultPageNavigationByPost 기본 생성자
     * @param pageMultiData LMultiData 페이지가 가지고 다닐 값들(보통 검색조건이 여기에 해당 된다)
     */
    public LDefaultPageNavigationByPost(LMultiData pageMultiData) {
        this.pageMultiData = pageMultiData;

    }
    
	/**
	 * 페이지 작업상 필요한 JavaScript 를 표시하는 함수이다.
	 * @return String JavaScript 함수 문자열.
	 */
	public String showJavaScript() {
		String targetRow = LPageConstants.TARGET_ROW;
		String devonOrderBy = LPageConstants.DEVON_ORDER_BY;

		StringBuffer retParam = new StringBuffer("\n\n");
		retParam
			.append("<!-- LPAGE JavaScript Start -->\n")
			.append("<script type=\"text/javascript\" language=\"javascript\">\n")
            .append("// <![CDATA[\n")
			.append("function goPage(row)\n")
			.append("{\n")
			.append("  var pageForm = document.getElementById(\"").append(targetRow).append("\").form;\n")
			.append("  pageForm.").append(targetRow).append(".value = row;\n")
			.append("  pageForm.submit();\n")
			.append("}\n")
			.append("function goOrderByPage(row,orderBy)\n")
			.append("{\n")
			.append("  var pageForm = document.getElementById(\"").append(targetRow).append("\").form;\n")
			.append("  pageForm.").append(targetRow).append(".value = row;\n")
			.append("  pageForm.").append(devonOrderBy).append(".value = orderBy;\n")
			.append("  pageForm.submit();\n")
			.append("}\n")
			.append("function changePage(pageSelect) {\n")
			.append("  var pageForm = pageSelect.form;\n")
			.append("  pageForm.").append(targetRow).append(".value = pageSelect.value;\n")
			.append("  pageForm.submit();\n")
			.append("}\n")
            .append("// ]]>\n")
			.append("</script>\n")
			.append("<!-- LPAGE JavaScript End -->\n");

		return retParam.toString();
	}

	/**
	 * Navigation 기능이 Post방식으로 지원될때 사용된다.
	 * Navigation 기능을 위해 JavaScript를 구성하여 리턴하는 함수이다.	 
	 * @return String
	 */
	public String showHiddenParam() {
		String devonOrderBy = "";
        
		StringBuffer retParam = new StringBuffer("\n\n");
		retParam.append("\n<!-- LPAGE Hidden Parameters Start -->\n");

		Iterator iter = pageMultiData.entrySet().iterator();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			Object entryValObject = entry.getValue();
			if (entryValObject instanceof ArrayList) {
				ArrayList entryValList = (ArrayList) entryValObject;
				String key = (String) entry.getKey();
				if (key.equals(LPageConstants.DEVON_ORDER_BY)) {
                    devonOrderBy = ((String) entryValList.get(0)).trim();
				} else if (!(key.equals(LPageConstants.TARGET_ROW))) {
					for (int i = 0, size = entryValList.size(); i < size; i++) {
						Object paramValObj = entryValList.get(i);
						if (!(paramValObj instanceof String))
							continue;
						retParam.append("\n<input type=\"hidden\" name=\"")
                                .append(key)
                                .append("\" value=\"")
                                .append(((String) paramValObj).trim())
                                .append("\" />");
					}
				}
			}
		}

		retParam.append("\n<input type=\"hidden\" id=\"")
                .append(LPageConstants.TARGET_ROW)
                .append("\" name=\"")
                .append(LPageConstants.TARGET_ROW)
                .append("\" />");
		retParam.append("\n<input type=\"hidden\" name=\"")
                .append(LPageConstants.DEVON_ORDER_BY)
                .append("\" value=\"")
                .append(devonOrderBy)
                .append("\" />");
		retParam.append("\n\n<!-- LPAGE Hidden Parameters End -->\n");
		return retParam.toString();
	}

	/**
	 * 페이지 상에 사용하는 인덱스를 표시하는 함수이다.
	 * @return String 화면에 인덱스를 구성하는 문자열
	 */
	public String showIndex() {
		final int currentPage = getCurrentPage();
		final int currentIndexes = getCurrentIndex();
		final int startPage =
			LPageNavigationUtility.getFirstPageOfIndex(
				currentIndexes,
				getNumberOfPagesOfIndex());
		final int endPage =
			LPageNavigationUtility.getFirstPageOfIndex(
				currentIndexes + 1,
				getNumberOfPagesOfIndex());

		StringBuffer retStr = new StringBuffer();

		for (int targetPage = startPage; targetPage < endPage; targetPage++) {
			if (targetPage <= getPages()) {
				final int targetRow =
					LPageNavigationUtility.getFirstRowOfPage(
						targetPage,
						getNumberOfRowsOfPage());

				/* [CASE 1] 결과화면 : [1][2][3][4][5] */
                /*
					retStr.append("<a href=\"#\" onclick=\"goPage('" + targetRow + "'); return false;\">");
					if(currentPage == targetPage)	{
						retStr.append("<span>")
                              .append("[" + targetPage + "]")
                              .append("</span>");
					}
					else {
						retStr.append("[" + targetPage + "]");		 	    	 
					}
                    retStr.append("</a>");
                */

				/* [CASE 2] 결과화면 : 1 | 2 | 3 | 4 | 5 */
                /*
					retStr.append("<a href=\"#\" onclick=\"goPage('" + targetRow + "'); return false;\">");
					if(currentPage == targetPage)	{
						retStr.append("<span>")
				 	          .append(targetPage)
				 	    	  .append("</span>")
					}
					else {
						retStr.append(targetPage)		 	    	 
					}
                    retStr.append("</a>");
					if(targetPage != endPage-1 && targetPage != getPages())
						retStr.append(" | ");
                */	

				if (currentPage == targetPage) {
					retStr.append(" " + targetPage + " ");
				} else {
					retStr.append("<a href=\"#\" onclick=\"goPage('").append(targetRow).append("'); return false;\">")
                          .append("<span>")
					      .append(" [").append(targetPage).append("] ")
                          .append("</span>")
				          .append("</a>");
				}
			}
		}
		return retStr.toString();
	}
    
	/**
	 * 페이지 상에 이전 인덱스 이동을 표시하는 함수이다.
	 * @return String 화면에 이전 인덱스로 이동을 표기하는 문자열
	 */
	public String showMoveBeforeIndex() {
		/* 
			사용자가 링크를 걸고 싶은 문자나 이미지를 표기하면 된다 
			[사용예]
			final String moveBeforeIndexImage = "◀";
			final String moveBeforeIndexImage = "<IMG border = 0 src='/devon/ebook/common/index_previous.gif'>";
		*/
		final String moveBeforeIndexImage = "◀◀";
		final int targetIndex = getCurrentIndex() - 1;
		StringBuffer rtnStr = new StringBuffer();

		if (targetIndex > 0) {
			final int targetPage =
				LPageNavigationUtility.getFirstPageOfIndex(
					targetIndex,
					getNumberOfPagesOfIndex());
			final int targetRow =
				LPageNavigationUtility.getFirstRowOfPage(
					targetPage,
					getNumberOfRowsOfPage());
			rtnStr
				.append("<a href=\"#\" onclick=\"goPage('")
				.append(targetRow)
				.append("'); return false;\">")
				.append(moveBeforeIndexImage)
				.append("</a>");
		}
		return rtnStr.toString();
	}
    
	/**
	 * 페이지 상에 이전 페이지 이동을 표시하는 함수이다.
	 * @return String 화면에 이전 페이지로 이동을 표기하는 문자열
	 */
	public String showMoveBeforePage() {
		/* 
			사용자가 링크를 걸고 싶은 문자나 이미지를 표기하면 된다 
			[사용예]
			final String moveBeforePageImage = "◀";
			final String moveBeforePageImage = "<IMG border = 0 src='/devon/ebook/common/page_previous.gif'>";
		*/
		final String moveBeforePageImage = "◀";
		final int targetPage = getCurrentPage() - 1;
		StringBuffer rtnStr = new StringBuffer();

		if (targetPage > 0) {
			final int targetRow =
				LPageNavigationUtility.getFirstRowOfPage(
					getCurrentPage() - 1,
					getNumberOfRowsOfPage());
			rtnStr
				.append("<a href=\"#\" onclick=\"goPage('")
				.append(targetRow)
				.append("'); return false;\">")
				.append(moveBeforePageImage)
				.append("</a>");

			return rtnStr.toString();
		}

		return rtnStr.toString();

	}
    
	/**
	 * 페이지 상에 마지막 페이지 이동을 표시하는 함수이다.
	 * @return String 화면에 마지막 페이지로 이동을 표기하는 문자열
	 */
	public String showMoveEndPage() {
		/* 
			사용자가 링크를 걸고 싶은 문자나 이미지를 표기하면 된다 
			[사용예]
			final String moveEndPageImage = "END";
			final String moveEndPageImage = "<IMG border = 0 src='/devon/ebook/common/index_last.gif'>";
		*/
		final String moveEndPageImage = "END";
		final int targetPage = this.getPages();
		StringBuffer rtnStr = new StringBuffer();

		if (getCurrentPage() < targetPage) {
			final int targetRow =
				LPageNavigationUtility.getFirstRowOfPage(
					targetPage,
					getNumberOfRowsOfPage());
			rtnStr
				.append("<a href=\"#\" onclick=\"goPage('")
				.append(targetRow)
				.append("'); return false;\">")
				.append(moveEndPageImage)
				.append("</a>");
		}
		return rtnStr.toString();
	}
    
	/**
	 * 페이지 상에 첫 페이지 이동을 표시하는 함수이다.
	 * @return String 화면에 첫 페이지로 이동을 표기하는 문자열
	 */
	public String showMoveFirstPage() {
		/* 
			사용자가 링크를 걸고 싶은 문자나 이미지를 표기하면 된다 
			[사용예]
			final String moveFirstPageImage = "FIRST";
			final String moveFirstPageImage = "<IMG border = 0 src='/devon/ebook/common/index_first.gif'>";	
		*/
		final String moveFirstPageImage = "FIRST";
		StringBuffer rtnStr = new StringBuffer();

		if (this.getCurrentPage() > 1) {
			int targetRow = 1;
			rtnStr
				.append("<a href=\"#\" onclick=\"goPage('")
				.append(targetRow)
				.append("'); return false;\">")
				.append(moveFirstPageImage)
				.append("</a>");
		}

		return rtnStr.toString();
	}
    
	/**
	 * 페이지 상에 다음 인덱스 이동을 표시하는 함수이다.
	 * @return String 화면에 다음 인덱스로 이동을 표기하는 문자열
	 */
	public String showMoveNextIndex() {
		/*
			사용자가 링크를 걸고 싶은 문자나 이미지를 표기하면 된다 
			[사용예]
			final String moveNextIndexImage = "▶";
			final String moveNextIndexImage = "<IMG border = 0 src='/devon/ebook/common/index_next.gif'>";
		*/
		final int targetIndex = getCurrentIndex() + 1;
		final String moveNextIndexImage = "▶▶";
		StringBuffer rtnStr = new StringBuffer();

		if (targetIndex <= getIndexes()) {
			final int targetPage =
				LPageNavigationUtility.getFirstPageOfIndex(
					targetIndex,
					getNumberOfPagesOfIndex());
			final int targetRow =
				LPageNavigationUtility.getFirstRowOfPage(
					targetPage,
					getNumberOfRowsOfPage());
			rtnStr
				.append("<a href=\"#\" onclick=\"goPage('")
				.append(targetRow)
				.append("'); return false;\">")
				.append(moveNextIndexImage)
				.append("</a>");
		}

		return rtnStr.toString();
	}
    
	/**
	 * 페이지 상에 다음 페이지 이동을 표시하는 함수이다.
	 * @return String 화면에 다음 페이지로 이동을 표기하는 문자열
	 */
	public String showMoveNextPage() {
		/* 
			사용자가 링크를 걸고 싶은 문자나 이미지를 표기하면 된다 
			[사용예]
			final String moveNextPageImage = "▶";	
			final String moveNextPageImage = "<IMG border = 0 src='/devon/ebook/common/page_next.gif'>";	
		*/
		final String moveNextPageImage = "▶";
		final int targetPage = getCurrentPage() + 1;
		StringBuffer rtnStr = new StringBuffer();

		if (targetPage <= getPages()) {
			final int targetRow =
				LPageNavigationUtility.getFirstRowOfPage(
					targetPage,
					getNumberOfRowsOfPage());
			rtnStr
				.append("<a href=\"#\" onclick=\"goPage('")
				.append(targetRow)
				.append("'); return false;\">")
				.append(moveNextPageImage)
				.append("</a>");
		}

		return rtnStr.toString();
	}
    
	/**
	 * 페이지 상에 Select Box 형식으로 표기된 인덱스를 표시하는 함수이다.
	 * @return String 화면에  Select Box 형식으로 표기된 인덱스를 표기하는 문자열
	 */
	public String showSelectIndex() {
		final int currentPage = getCurrentPage();
		final StringBuffer retStr = new StringBuffer();

		retStr.append("\n<select onchange=\"changePage(this)\">");
		for (int targetPage = 1; targetPage <= getPages(); targetPage++) {

			int targetRow =
				LPageNavigationUtility.getFirstRowOfPage(
					targetPage,
					getNumberOfRowsOfPage());

			retStr.append("\n<option value=\"")
                  .append(targetRow)
                  .append("\"");
			if (targetPage == currentPage)
				retStr.append(" selected");
			retStr.append(">" + targetPage + "</option>");
		}
		retStr.append("\n</select>");
		return retStr.toString();
	}
    
	/**
	 * 페이지 상에 정렬 기능을 제공하는 필드를 구성할때 사용하는 함수이다.
	 * @return String 정렬 링크가 걸려있는 문자열
	 * @param title String 화면상에 표시될 필드 문자열
	 * @param devonOrderByColumnName String 정렬을 원하는 필드
	 */
	public String showSortField(String title, String devonOrderByColumnName) {
		/* 
			사용자가 링크를 걸고 싶은 문자나 이미지를 표기하면 된다 
			[사용예]
			final String ascImage = "";	
			final String ascImage = "<IMG border = 0 src='/devon/ebook/common/asc.gif'>";
			final String descImage = "";	
			final String descImage = "<IMG border = 0 src='/devon/ebook/common/desc.gif'>";		
		*/

		final String ascImage = "▲";
		final String descImage = "▼";		

		final String orderBy =
			pageMultiData.getLData(0).getString(LPageConstants.DEVON_ORDER_BY);

		StringBuffer content = new StringBuffer();
		StringBuffer devonOrderBy = new StringBuffer();
		StringBuffer rtnStr = new StringBuffer();

		if (("order by " + devonOrderByColumnName + " desc").equals(orderBy)) {
			content.append(descImage).append(title);
			devonOrderBy.append("order by ").append(
				devonOrderByColumnName).append(
				" asc");
		} else if (
			("order by " + devonOrderByColumnName + " asc").equals(orderBy)) {
			content.append(ascImage).append(title);
			devonOrderBy.append("order by ").append(
				devonOrderByColumnName).append(
				" desc");
		} else {
			content.append(title);
			devonOrderBy.append("order by ").append(
				devonOrderByColumnName).append(
				" asc");
		}

		rtnStr
			.append("<a href=\"#\" onclick=\"goOrderByPage(1,'")
			.append(devonOrderBy.toString())
			.append("')\">")
			.append(content.toString())
			.append("</a>");

		return rtnStr.toString();
	}

    /**
     * 이 클래스에서는 아무런 동작을 하지 않으며, 사용되지 않는 메서드이다.
     * @see devonframework.front.paging.LPageNavigationIF#getSpec()
     */
    public String getSpec()
    {
        // DO NOTHING.
        return null;
    }

    /**
     * 이 클래스에서는 아무런 동작을 하지 않으며, 사용되지 않는 메서드이다.
     * @see devonframework.front.paging.LPageNavigationIF#setSpec(java.lang.String)
     */
    public void setSpec(String spec)
    {
        // DO NOTHING.
    }

	public String showHiddenParam(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}
}
