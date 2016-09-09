



//========================================================================================================
    var flag_command  = true;
    var click_command = false;
    var errorColor = 'EEFFB6';
    var successColor = '#FFFFFF';
    var successReadOnlyColor ='#ececec';
    
    var input_textfield_possible_color = '#FEFCE8';
    var input_textfield_essential_color = '#E5F0F0';
    var input_textfield_color = '#FFFFFF';


    var X_DISABLE_SUBMIT_TIMEOUT =  3000;//마우스가 눌린후 다시 튀어나오는 속도

    var bName = navigator.appName;
    var bVer = parseInt(navigator.appVersion);
    var bVersion = navigator.appVersion;
    var bUserAgent = navigator.userAgent
    var bPlatform = navigator.platform
    var NS = (bName == "Netscape" );
    var IE = (bName == "Microsoft Internet Explorer" );

    var NS4 = (bName == "Netscape" && bVer >= 4);
    var IE4 = (bName == "Microsoft Internet Explorer" && bVersion.indexOf("MSIE 4") != -1);
    var NS3 = (bName == "Netscape" && bVer < 4);
    var IE3 = (bName == "Microsoft Internet Explorer" && bVer < 4);

    var NS4_7 = (bName == "Netscape" && bVersion.substring(0,3) >= 4.7);
    var IE5 = (bName == "Microsoft Internet Explorer" && bVersion.indexOf("MSIE 5.") != -1);
    var NS6 = (bName == "Netscape" && bUserAgent.indexOf("6.0") != -1 );

    var IE5_5 = (bName == "Microsoft Internet Explorer" && bVersion.indexOf("MSIE 5.5") != -1);
    var IE6   = (bName == "Microsoft Internet Explorer" && bVersion.indexOf("MSIE 6") != -1);


    var IEver = parseInt(bVersion.split(";")[1].split(" ")[2]) ;
    var NSver = parseInt(bVersion.split(" ")[0]) ;
           //형식
             //navigator.appVersion : 4.0 (compatible; MSIE 5.5; Windows 98)형식일때
             //navigator.appVersion : 4.51 [ko] (Win98; I)

    //프로젝트 용
    //2003.09.01이후 버튼 생성및초기화  : 2003.09.01이전 보다 코딩량이 적어서 좋다.
    var img_path = "/CswWebApp/csw/images/"
/*
        butn_close_click      =  CreatePathImage(img_path,"butn_close"     );
        butn_close_off        =  CreatePathImage(img_path,"butn_close"     );  //닫기
        butn_close_on         =  CreatePathImage(img_path,"butn_close"     );

        butn_list_click       =  CreatePathImage(img_path,"butn_list"      );
        butn_list_off         =  CreatePathImage(img_path,"butn_list"      );  //조회
        butn_list_on          =  CreatePathImage(img_path,"butn_list"      );

        butn_save_click       =  CreatePathImage(img_path,"butn_save"      );
        butn_save_off         =  CreatePathImage(img_path,"butn_save"      );  //저장
        butn_save_on          =  CreatePathImage(img_path,"butn_save"      );

        butn_sort_click       =  CreatePathImage(img_path,"butn_sort"      );
        butn_sort_off         =  CreatePathImage(img_path,"butn_sort"      );  //정렬
        butn_sort_on          =  CreatePathImage(img_path,"butn_sort"      );

        butn_add_line_click   =  CreatePathImage(img_path,"butn_add_line"  );
        butn_add_line_off     =  CreatePathImage(img_path,"butn_add_line"  );  //항추가
        butn_add_line_on      =  CreatePathImage(img_path,"butn_add_line"  );

        butn_excel_click      =  CreatePathImage(img_path,"butn_excel"     );
        butn_excel_off        =  CreatePathImage(img_path,"butn_excel"     );  //엑셀
        butn_excel_on         =  CreatePathImage(img_path,"butn_excel"     );

        butn_help_click       =  CreatePathImage(img_path,"butn_help"      );
        butn_help_off         =  CreatePathImage(img_path,"butn_help"      );  //도움말
        butn_help_on          =  CreatePathImage(img_path,"butn_help"      );

        butn_delete_click     =  CreatePathImage(img_path,"butn_delete"    );
        butn_delete_off       =  CreatePathImage(img_path,"butn_delete"    );  //삭제
        butn_delete_on        =  CreatePathImage(img_path,"butn_delete"    );

        butn_register_click   =  CreatePathImage(img_path,"butn_register"  );
        butn_register_off     =  CreatePathImage(img_path,"butn_register"  );  //등록
        butn_register_on      =  CreatePathImage(img_path,"butn_register"  );

        butn_reset_click      =  CreatePathImage(img_path,"butn_reset"     );
        butn_reset_off        =  CreatePathImage(img_path,"butn_reset"     );  //Reset
        butn_reset_on         =  CreatePathImage(img_path,"butn_reset"     );

        butn_ok_click         =  CreatePathImage(img_path,"butn_ok"        );
        butn_ok_off           =  CreatePathImage(img_path,"butn_ok"        );  //확인
        butn_ok_on            =  CreatePathImage(img_path,"butn_ok"        );

        butn_dolist_click     =  CreatePathImage(img_path,"butn_dolist"    );
        butn_dolist_off       =  CreatePathImage(img_path,"butn_dolist"    );  //목록
        butn_dolist_on        =  CreatePathImage(img_path,"butn_dolist"    );

        butn_update_click     =  CreatePathImage(img_path,"butn_update"    );
        butn_update_off       =  CreatePathImage(img_path,"butn_update"    );  //수정
        butn_update_on        =  CreatePathImage(img_path,"butn_update"    );

        butn_reply_click      =  CreatePathImage(img_path,"butn_reply"     );
        butn_reply_off        =  CreatePathImage(img_path,"butn_reply"     );  //답변
        butn_reply_on         =  CreatePathImage(img_path,"butn_reply"     );

        butn_back_click       =  CreatePathImage(img_path,"butn_back"      );
        butn_back_off         =  CreatePathImage(img_path,"butn_back"      );  //이전
        butn_back_on          =  CreatePathImage(img_path,"butn_back"      );

        butn_request_click    =  CreatePathImage(img_path,"butn_request"   );
        butn_request_off      =  CreatePathImage(img_path,"butn_request"   );  //신청
        butn_request_on       =  CreatePathImage(img_path,"butn_request"   );

        butn_receive_click    =  CreatePathImage(img_path,"butn_receive"   );
        butn_receive_off      =  CreatePathImage(img_path,"butn_receive"   );  //접수
        butn_receive_on       =  CreatePathImage(img_path,"butn_receive"   );

        butn_analysis_click   =  CreatePathImage(img_path,"butn_analysis"  );
        butn_analysis_off     =  CreatePathImage(img_path,"butn_analysis"  );  //분석
        butn_analysis_on      =  CreatePathImage(img_path,"butn_analysis"  );

        butn_review_click     =  CreatePathImage(img_path,"butn_review"    );
        butn_review_off       =  CreatePathImage(img_path,"butn_review"    );  //검토
        butn_review_on        =  CreatePathImage(img_path,"butn_review"    );

        butn_confirm_click    =  CreatePathImage(img_path,"butn_confirm"   );
        butn_confirm_off      =  CreatePathImage(img_path,"butn_confirm"   );  //승인
        butn_confirm_on       =  CreatePathImage(img_path,"butn_confirm"   );

        butn_return_click     =  CreatePathImage(img_path,"butn_return"   );
        butn_return_off       =  CreatePathImage(img_path,"butn_return"   );  //반려
        butn_return_on        =  CreatePathImage(img_path,"butn_return"   );

        butn_q_a_click        =  CreatePathImage(img_path,"butn_q_a"     );
        butn_q_a_off          =  CreatePathImage(img_path,"butn_q_a"     );  //질문/답변
        butn_q_a_on           =  CreatePathImage(img_path,"butn_q_a"     );

        butn_ftp_click       =  CreatePathImage(img_path,"butn_ftp"      );
        butn_ftp_off         =  CreatePathImage(img_path,"butn_ftp"      );  //파일서버FTP
        butn_ftp_on          =  CreatePathImage(img_path,"butn_ftp"      );

//------------------------------------------  tab image    --------------------------------------//

    //2003.09.01이후 버튼 생성및초기화

        tab_repayment_click                =  CreatePathImage(img_path,"tab_repayment_cl"     );
        tab_repayment_off                  =  CreatePathImage(img_path,"tab_repayment_off"    );            //환불                          //
        tab_repayment_on                   =  CreatePathImage(img_path,"tab_repayment_on"     );

*/

    //  var check_obj  = eval("form.reg_mandatory_gubun"+index);
    //  if(check_obj.value=='Y')



    //현재 보이는 이미지
    var  showImage    = '';
    // 누르는 이미지
    var  clickImage    = '';
    // Disable 이미지
    //var disableImage   = '';


    var disableImage  = new Array();
    var disableImage_index = 0;


    // 조회된 내용중 클릭시에 색 반전
    var clickObj = null;


/*
특수문자코드 실제모양 특수문자코드 실제모양
&gt; > &auot; "
&lt; < &copy; 원문자 c
&amp; & &nbsp Space(공백)

*/


//-------------      공통 사용 시작             ---------------------//
    /**조회 결과 count가  0일때 메세지
    */
    function funcCountMsg( count, command)
    {
        //if (count =='0')

        //if ( command.toUpperCase() == 'LIST')   alert('총 ' +count+'건의 데이터가 조회되었습니다.');
    }

    /**서버에 있는 파일을 link를 걸어주면 화일에 따라 새로운 창이 뜨며 그 창에 뿌려질지 자동 다운로드가 될지 결정
    */
    function funcLinkFile(  file_path , left, top, width, height)
    {/*
        ▶win98,NT, unix서버에서  클라이언트가  netscape사용시 한글명이 깨질때 escape쓴다
        ▶win98,NT,unix서버에서 클라이언트가  internet explore5.0 상관 없음
     */


        var file_type = funcGetFileType(file_path).toLowerCase();
        if( NS )
        {

            if (isBlankOpenOfNetscape(file_type))
            {//빈화면 열리는것 방지,화일이 다운로드 묻는 창이 떠야 되는 경우
                location.href = escape(file_path);//escape
            }else
            {//화일이 바로 열리면 윈도우 창에 내용이 뿌려지는 경우
                var link_file = window.open( escape(file_path), 'file_view', 'scrollbars=yes,status=yes,menubar=yes,location=top,toolbar=yes,directory=no,resizable=yes,top='+top+',left='+left+',width='+width+',height='+height+'');
              //  link_file.focus();
           }
        }
        else
        {
          if(   file_type=='gif'
                || file_type=='jpg'
                || file_type=='bmp'
              )
           {//image사이즈에 맞게 크기조절
                  autoWinDrawImage(file_path);
           }
           else
           {

                if (IE5_5)
                {
                      var link_file = window.open( file_path, 'file_view', 'scrollbars=yes,status=yes,menubar=yes,location=top,toolbar=yes,directory=no,resizable=yes,top='+top+',left='+left+',width=='+width+',height='+height+'');

                }
                else
                {
                      var link_file = window.open( file_path, 'file_view', 'scrollbars=yes,status=yes,menubar=yes,location=top,toolbar=yes,directory=no,resizable=yes,top='+top+',left='+left+',width=='+width+',height='+height+'');

                }
           }


            //link_file.focus();
        }
    }

    /**netscape에서 download받는 화일을 windowopen해서 열면 빈화면이 열리고 저장,open질문창이 열린다
    */
    function isBlankOpenOfNetscape(  getFileType )
    {
        var file_type = getFileType.toLowerCase();
        if ( file_type == 'cab' || file_type == 'tgz' || file_type == 'zip'  || file_type == 'xls' || file_type == 'hwp' || file_type == 'pdf' || file_type == 'rar' || file_type == 'arj' || file_type == 'ppt' || file_type == 'doc' || file_type == 'exe' || file_type == 'vcd' || file_type == 'mp3' || file_type == 'mpeg' || file_type == 'ra' ||  file_type == 'rm' ) return true;
        else return false;

    }

    /**문자 변경
    */
    function funcReplaceStrAll( org_str,  find_str,  replace_str)
    {
        var pos = 0;
        pos = org_str.indexOf(find_str);

        while(pos != -1)
        {
            pre_str = org_str.substring(0, pos);
            post_str = org_str.substring(pos + find_str.length, org_str.length);
            org_str = pre_str + replace_str + post_str;

            pos = org_str.indexOf(find_str);
        }
        return org_str;
    }



    /**년월에 따른 day의 list 변경*/
    function getListOfDay( yyObj, mmObj, ddObj)

    {


        var year =yyObj.options[yyObj.selectedIndex].value;
        var month=mmObj.options[mmObj.selectedIndex].value;
        var endday= getEndOfMonthDay( year , month);

        ddObj.length=endday;

        for( i = 0; i < endday; i++ )
        {
           ddObj.options[i].value =toLen2(i+1);
           ddObj.options[i].text  =toLen2(i+1);
        }
        ddObj.selectedIndex = 0;
    }

    /**1자리 숫자에 0붙여서 2자리 반환
    */
    function toLen2 (   nums )
    {
        var num=0;

        if ( nums >= 1 && nums <=9 )
            num = '0' + nums;
        else
            num=nums;
        return num;
    }

    /**
      디렉토리 제외한 호출 프로그램반환
      html       c:\common program\test.html       -> test.html  반환
    */
    function getClientProgramName( path_file)
    {
        var name = "";
        var separator = "";
        if ( bPlatform.indexOf("Win") != -1 )
        {
             separator = "\\";
        }else
        {
             separator = "/";
        }

        var dash_pos = path_file.lastIndexOf(separator);
        if (dash_pos != -1 )
        {
            name = path_file.substring(dash_pos+1);
        }
        else
        {
            name = path_file;
        }
        return name ;
    }

    /**
    년월 입력시 마지막 일자
    */
    function  getEndOfMonthDay(  yy,  mm )
    {



        var max_days=0;

        if (mm == 1)        max_days = 31 ;
        else if (mm == 2) {

            if ((( yy % 4 == 0) && (yy % 100 != 0)) || (yy % 400 == 0))
                            max_days = 29;
            else
                            max_days = 28;
        }
        else if (mm == 3)   max_days = 31;
        else if (mm == 4)   max_days = 30;
        else if (mm == 5)   max_days = 31;
        else if (mm == 6)   max_days = 30;
        else if (mm == 7)   max_days = 31;
        else if (mm == 8)   max_days = 31;
        else if (mm == 9)   max_days = 30;
        else if (mm == 10)  max_days = 31;
        else if (mm == 11)  max_days = 30;
        else if (mm == 12)  max_days = 31;
        else {

            return '';
        }
            return max_days;
    }
    //날짜의 월을 추가는 함수
    //파라메터는 오브젝트로 전달, 리턴값은 Boolean 형식
    //date_length : 숫자 8or6만 가능 (dateObj의 입력받을 자리수
    function getChangeMonth(dateObj,add)
    {
        var _dateObj =  funcReplaceStrAll(dateObj.value, ".", "");
        var _dateObj =  funcReplaceStrAll(_dateObj, "/", "");

        var date_length =  _dateObj.length;
        if (date_length == 4 )
        {
            dateYear  = _dateObj;
            dateMonth = '01';
            dateDay   = '01';
        }
        else if (date_length == 6 )
        {
            dateYear  = _dateObj.substring(0, 4);
            dateMonth = _dateObj.substring(4, 6);
            dateDay = '01';

        }
        else
        {
            dateYear  = _dateObj.substring(0, 4);
            dateMonth = parseInt( _dateObj.substring(4, 6) ,10);
            dateDay = _dateObj.substring(6, 8);
        }

           var _dateYear  = dateYear
           var _dateMonth = dateMonth
           var _dateDay   = dateDay

        var add_month_time = 0;

        add_month_time += (getEndOfMonthDay(_dateYear,_dateMonth)-_dateDay)*24*60*60*1000;

        for(var i=1; i < add;i++)
        {
            //alert(getEndOfMonthDay(_dateYear,_dateMonth))


            _dateMonth++;
            if(_dateMonth==13)
            {
              _dateYear ++;
              _dateMonth = 1;
            }
            add_month_time += getEndOfMonthDay(_dateYear,_dateMonth)*24*60*60*1000;
        }

        add_month_time +=_dateDay*24*60*60*1000;


        var addDate = new Date(dateYear,dateMonth-1,dateDay);
        //alert(addDate);

        var newtimems=addDate.getTime()+add_month_time;
        addDate.setTime(newtimems);


        var newYear = addDate.getYear();
        if (newYear < 2000) newYear += 1900; // Y2K fix
        var newMonth = addDate.getMonth()+1;
        var newDay = addDate.getDate();

        return newYear.toString()+toLen2 (newMonth.toString())+ toLen2( newDay.toString())
    }
    //날짜의 일을 추가는 함수
    //파라메터는 오브젝트로 전달, 리턴값은 Boolean 형식
    //date_length : 숫자 8or6만 가능 (dateObj의 입력받을 자리수
    function getChangeDay(dateObj,add)
    {
        var _dateObj =  funcReplaceStrAll(dateObj.value, ".", "");
        var _dateObj =  funcReplaceStrAll(_dateObj, "/", "");

        var date_length =  _dateObj.length;
        if (date_length == 4 )
        {
            dateYear  = _dateObj;
            dateMonth = '01';
            dateDay   = '01';
        }
        else if (date_length == 6 )
        {
            dateYear  = _dateObj.substring(0, 4);
            dateMonth = _dateObj.substring(4, 6);
            dateDay = '01';

        }
        else
        {
            dateYear  = _dateObj.substring(0, 4);
            dateMonth = parseInt(_dateObj.substring(4, 6) ,10);
            dateDay = _dateObj.substring(6, 8);
        }


        var addDate = new Date(dateYear,dateMonth-1,dateDay);
        //alert(addDate);

        var newtimems=addDate.getTime()+(add*24*60*60*1000);
        addDate.setTime(newtimems);



        var newYear = addDate.getYear();
        if (newYear < 2000) newYear += 1900; // Y2K fix
        var newMonth = addDate.getMonth()+1;
        var newDay = addDate.getDate();

        //alert(addDate);

         //newtest =newYear+' '+toLen2 (newMonth)+' '+ toLen2( newDay)
         newtest =newYear.toString()+toLen2 (newMonth.toString())+ toLen2( newDay.toString())

         return  newtest
    }
    /** 한글을 2byte로 인식하여 length 체크 */
    function getByteLength(  data )
    {
        var len = 0;
        var str = data.substring(0);

        if ( str == null ) return 0;

        for(var i=0; i < str.length; i++)
        {
            var ch = escape(str.charAt(i));

            if( ch.length == 1 ) len++;
            else
            if( ch.indexOf("%u") != -1 ) len += 3;//Db가 한글을 3byte로 인식하여 2->3
            else
            if( ch.indexOf("%") != -1 ) len += ch.length/3;
       }

       return len;
    }


    /**확장자 반환
    */
    function funcGetFileType(  str )
    {
        var newstr="";
        var  len=0   ;
        if (str==null )   return "";

        var text = str.substring(0);
        if (text=='' || text.length < 1 )   return '';

        var  point = text.lastIndexOf( "." );
        if( point == -1 ) len = str.length;
        else len = point;

        newstr = text.substring(len+1);

        return newstr;

    }

    /**경고메세지 뿌리고 focus가고 선택효과 주기
    */
    function funcReturnWarn (  obj,  str )
    {
       if ( str != '')
       {
          alert( str );
       }

       obj.focus();
       if (obj.type=='text' && obj.value.length >=1  )
       {
            obj.select();
       }

       return ;
    }

    /**
    먼저 입력을 권하는 경고 메세지후 단순 return
    */
    function funcWantedInput( obj, comment)
    {
           if ( comment != '')
           {
              alert( comment+"를(을) 먼저 입력하세요");
              //alert( comment + " must be  inputted. \n  ");
           }

           obj.focus();
           if (obj.type=='text' && obj.value.length >=1  )
           {
                obj.select();
           }

           return ;
    }

    /**
    경고메세지 뿌리고 focus가고 선택효과 주기
    */
    function funcNotExistReturnWarn (  obj, str )
    {
       if ( str != '')
       {
          alert( '존재하지 않는 '+str+'입니다.' );
       }
       //obj.select();
       obj.focus();
       if (obj.type=='text' && obj.value.length >=1  )
       {
            obj.select();//--어떤 버전에서 는 <- 키를 누르면 백이 된다.
       }
       obj.focus();

       return false;
    }

    /** 오른쪽 공백 제거
    */
    function  funcRtrim( str)
    {

        var src = new String(str);
        var tmp = new String();
        var i,lastnum, len = src.length;

       for(i = len;i >= 0;i--)
       {
           tmp = src.substring(i,i-1);
           if (tmp != ' ' )
           {
             lastnum = i;
             break;
           }
       }
        tmp = src.substring(0,lastnum);
        return tmp;

    }

    /** 왼쪽 공백 제거
    */
    function  funcLtrim( str)
    {

        var src = new String(str);
        var tmp = new String();
        var i,firstnum, len = src.length;

       for(i = 0;i < len ;i++)
       {
           tmp = src.substring(i,i+1);
           if (tmp != ' ' )
           {
             firstnum = i;
             break;
           }
       }
        tmp = src.substring(firstnum);
        return tmp;

    }

    /** 공백 제거
    */
    function  funcTrim( str)
    {

        var src = new String(str);
        var tmp = new String();



        tmp = funcLtrim(funcRtrim(str));
        return tmp;

    }

    /** 원하지 않은 값을 오른쪽 부터  제거 */
    function  Rtrim( str, want_trim_value)
    {

        var src = new String(str);
        var tmp = new String();
        var i,lastnum, len = src.length;

       for(i = len;i >= 0;i--)
       {
           tmp = src.substring(i,i-1);
           if (tmp != want_trim_value )
           {
             lastnum = i;
             break;
           }
       }
        tmp = src.substring(0,lastnum);
        return tmp;

    }

    /** 원하지 않은 값을 왼쪽 부터  제거 */
    function  Ltrim( str, want_trim_value)
    {

        var src = new String(str);
        var tmp = new String();
        var i,firstnum, len = src.length;

       for(i = 0;i < len ;i++)
       {
           tmp = src.substring(i,i+1);
           if (tmp != want_trim_value)
           {
             firstnum = i;
             break;
           }
       }
        tmp = src.substring(firstnum);
        return tmp;

    }

    /** 원하지 않은 값을 왼쪽,오른쪽 부터  제거 */
    function  Trim( str, want_trim_value)
    {

        var src = new String(str);
        var tmp = new String();



        tmp = Ltrim(Rtrim(str,want_trim_value) ,want_trim_value);
        return tmp;

    }

     /** 특수문자를 변환한다 */
    function funcReplaceCode(  str )
    {
        var pos = 0;
        var len = str.length;
        var replace_chr;
        var cur_chr;
        var replace_str = '';

        for(var i=0; i < len; i++)
        {
            cur_chr = str.charAt(i);

            if( cur_chr=='\"') replace_chr='##34';
            else if( cur_chr=='\'') replace_chr='##39';
            else if( cur_chr=='>')  replace_chr='##60';
            else if( cur_chr=='<')  replace_chr='##62';
            else if( cur_chr=='/')  replace_chr='##47';
            else if( cur_chr=='\\') replace_chr='##92';
            else if( cur_chr=='(')  replace_chr='##40';
            else if( cur_chr==')')  replace_chr='##41';
            else if( cur_chr==',')  replace_chr='##44';
            else
                replace_chr = cur_chr;

            replace_str += replace_chr;
        }
        return replace_str;
    }

    /** 변환된 문자를 특수문자로 변환한다 */
    function funcReplaceSign(  str )
    {
        var pos = 0;
        var len = str.length;
        var replace_chr;
        var cur_chr;
        var replace_str = '';

        for(var i=0; i < len; i++)
        {
            cur_chr = str.charAt(i);

            if( cur_chr == '#' )
            {
                cur_chr = str.substring(i,i+4);
                i += 3;
            }

            if( cur_chr=='##34') replace_chr='\"';
            else if( cur_chr=='##39') replace_chr='\'';
            else if( cur_chr=='##60') replace_chr='>';
            else if( cur_chr=='##62') replace_chr='<';
            else if( cur_chr=='##47') replace_chr='/';
            else if( cur_chr=='##92') replace_chr='\\';
            else if( cur_chr=='##40') replace_chr='(';
            else if( cur_chr=='##41') replace_chr=')';
            else if( cur_chr=='##44') replace_chr=',';
            else
                replace_chr = cur_chr;

            replace_str += replace_chr;
        }
        return replace_str;
    }

    /** 브라우저를 체크한다 */
    function funcCheckBrowser()
    {
        var bName = navigator.appName;
        var bAgent = navigator.userAgent;
        var bVer = navigator.appVersion;

        if( bName == "Netscape" && bVer.indexOf("4.") != -1 )
            return "ns";
        else
        if( bName == "Microsoft Internet Explorer" && bVer.indexOf("4.") != -1 )
            return "ie";
        else
            alert('Netscape 4.X\n\nMicrosoft Internet Explorer 4.X\n\nbrowser에서만 사용이 가능합니다.');

        /* bAgent.indexOf("MISE") != -1 return "ie" */
    }

//-------------      공통 사용 완료             ---------------------//

//-------------      기타 사용 시작             ---------------------//

    /**넘어온 sbu_code에 따른 name반환
    */
    function getSbuName(  str )
     {
        var newstr="";
        var  len=0   ;
        if (str==null )   return DA_name;

        if (str == DM)
        {
            newstr = DM_name;
        }
        else if (str==DD)
        {
            newstr = DD_name;
        }
        else
        {
            newstr = DA_name;
        }

        return newstr;

    }
    /**
     combo에 있는 text값을 임의의 객체에 담기

     <br>
     srcObj : 콤보객체,tarObj : Text 객체
    */


    function funcSendComboTextOfObj( srcObj, tarObj)
    {
        var result = "";
        if(srcObj.selectedIndex != -1)    result= srcObj.options[srcObj.selectedIndex].text;
        tarObj.value  =  result;
    }

    /**
     combo에 있는 Value값을 임의의 객체에 담기
     <br>
     srcObj : 콤보객체,tarObj : Text 객체
    */
    function funcSendComboValueOfObj( srcObj, tarObj)
    {
        var result = "";
        if(srcObj.selectedIndex != -1)    result= srcObj.options[srcObj.selectedIndex].value;

        tarObj.value  =  result;
    }

    /**
     combo에 있는 Text값을 반환
     <br>
     srcObj : 콤보객체
    */
    function funcSendComboText( srcObj)
    {
        var result = "";
        if(srcObj.selectedIndex != -1)         result = srcObj.options[srcObj.selectedIndex].text;



         return result;

    }
    function funcSendComboValueOnly( srcObj)
    {
        var result = "";
        if(srcObj.selectedIndex != -1)         result = srcObj.options[srcObj.selectedIndex].value;

        return result;

    }

    /**
     combo에 있는 Value값을 반환
     <br>
     srcObj : 콤보 객체 ,gubun : ; , index
    */
    function funcSendComboValue( srcObj, gubun, index)
    {
        var selectValue = srcObj.options[srcObj.selectedIndex].value;
        var result = '';
        if(selectValue.indexOf(gubun)==-1)
        {//gubun으로 구분되지 않았으면
            result  = selectValue;
        }
        else
        {
            result  = selectValue.split(gubun)[index];
        }

        return result;

    }

    /**
    data를 Text box에 전달
    */
    function funcSendText( tarObj ,  data)
    {
            var len  =  tarObj.length;
            if(len==null)
            {
                tarObj.value          = data;
            }else
            {
                for(var i=0;i< len; i++)
                {
                    tarObj[i].value          = data;
                }
            }

    }

    /**
    여러개의 라디오 박스중 선택된것의 값을 반환
    */
    function funcRadioCheckValue(obj) {
        if (obj == null)     return null;
        var len  = obj.length;
        if ( len  == null) {
            if  (obj.checked == true )      return obj.value;
        } else {
            for (var i=0 ; i< len ;i++) {
                if  (obj[i].checked == true )       return obj[i].value;
            }
        }
        return null;
    }

    /**ie5.0 only tr마우스 클릭시에 색 주기
    */
    function funcClickRow( obj)
    {   var dispField   = "#E8E8E8";
        var overField   = "#87ceeb";


        if ( clickObj != null) clickObj.style.background = dispField;
        clickObj             = obj;
        obj.style.background =  overField;
    }



    /**
    textbox에 작성중 focus가 떠날때 checkbox를 자동 체크
    */
    function funcOnBlurChecked( srcObj, tgtObj)
    {
      if(  tgtObj != null)
      {
        if (tgtObj.checked == false && srcObj.value.length > 0 ) tgtObj.checked = true;
        if (tgtObj.checked == true && srcObj.value.length == 0 ) tgtObj.checked = false;
      }
    }


    /**
    textbox에 작성중 focus가 떠날때 값이 없으면 다른 값 blank
    */
    function funcOnBlurBlank( srcObj, tgtObj)
    {

        if (srcObj.value.length == 0  || srcObj.value=='' ) tgtObj.value = '';

    }
    /**
    오브젝트의 값을 소문자에서 대문자로 전환시켜주는 함수
     <br>
    파라메터는 오브젝트로 전달
    */
    function lCase2Ucase( obj)
    {
        obj.value = obj.value.toUpperCase(); 

    }

    /**대문자를 소문자로 전환
    */
    function lCase2Lcase( obj)
    {
        obj.value = obj.value.toLowerCase();
    }



  /**

      첫글자를 대문자로
  */
  function initCap(str) {
      var index;
      var tmpStr;
      var tmpChar;
      var preString;
      var postString;
      var strlen;
      tmpStr = str.toLowerCase();
      strLen = tmpStr.length;

      if (strLen > 0)
      {
          for (index = 0; index < strLen; index++)
          {
              if (index == 0)
              {
                  tmpChar = tmpStr.substring(0,1).toUpperCase();
                  postString = tmpStr.substring(1,strLen);
                  tmpStr = tmpChar + postString;
              }
              else
              {
                  tmpChar = tmpStr.substring(index, index+1);
                  if (tmpChar == " " && index < (strLen-1))
                  {
                      tmpChar = tmpStr.substring(index+1, index+2).toUpperCase();
                      preString = tmpStr.substring(0, index+1);
                      postString = tmpStr.substring(index+2,strLen);
                      tmpStr = preString + tmpChar + postString;
                  }
              }
          }
      }

      return tmpStr;
  }

//-------------      기타 사용 완료             ---------------------//


//-------------      기타체크 시작            ---------------------//



    /** 처리중일때 다른 작업을 할경우  경고메세지를 보여준다 */
    function funcAlertOfProcessing( obj, comment )
    {

        if (obj.value=='Y')
        {
            alert('현재 '+comment+'중입니다.\n'+comment+' 결과 메세지가 나올때까지 기다리십시요.');
            //alert(comment + ' is working.\nPlease wait until the message of '+comment+'result.');
            return false;
         }
         else
         {
            return true;
         }



    }

    /** combo를 선택안했을때 경고메세지를 보여준다 */
    function check_Combo(  obj,  str, check_flag )
    {
        var message = "";
        var check_flag = check_flag.toUpperCase()  ;
        var error = false;
        if ( check_flag == "")
        {
            if ( obj.options[obj.selectedIndex].value == "" )
            {
                error = true;
                message = str + "를(을) 선택하세요";
                //message = 'Select '+str ;
            }
        }
        else if (check_flag == "0")
        {
            if ( obj.selectedIndex==0 )
            {
                error = true;
                message = str + "를(을) 선택하세요";
                //message = 'Select '+str ;
            }

        }
        else if ( check_flag == "KEY")
        {//아주 중요한 combo일때
            if ( obj.selectedIndex == -1  || obj.options[obj.selectedIndex].value == ""  )
            {
                error = true;
                message = str + "의 값은 필수값으로 공백이 들어가선 안됩니다.";
                //message = 'Result of '+str + "is the essential result.\nIt should not be empty.";
            }
        }
        else
        {// check_flag ="default"
            if (obj.selectedIndex == -1 )
            {
                error = true;
                message = str + "를(을) 선택하세요";
                //message = 'Select '+str ;
            }

        }


        if (error)
        {
            //에러 발생시 색깔을 진하게
            obj.style.backgroundColor = errorColor;

            alert(message);
            obj.focus();
            return   false;

        }

        //에러 발생하지 않을때 원래대로
                if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
                else                      obj.style.backgroundColor = successColor


        return true



    }


    function check_LengthOfMulti( obj, startLength, endLength, comment,  mendentory )
    {
        if( obj != null)
        {
             //alert('1');
            var len = obj.length
            if(len == null)
            {//1개
                if( ! check_Length( obj, startLength, endLength, comment,  mendentory) ) return false;
            }
            else
            {
                for(i=0 ; i < len ; i++)
                {
                    if( ! check_Length( obj[i], startLength, endLength, comment,  mendentory) ) return false;
                }



            }

        }
         return  true;

    }
    /**인자
      들어온 자리수 체크
     <br>
      obj           : 객체
      startLength   : 자리수부터(0이면  endLength까지만
      endLength     : 자리수까지(0이면 startLength부터 무한대
      comment       : head명
      mendentory    : 필수여부
    */

    function check_Length( obj, startLength, endLength, comment, mendentory, color)
    {
        //에러 발생하지 않을때 원래대로
                //if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
                //else                      obj.style.backgroundColor = successColor

        if(color == "input_textfield_possible")
            obj.style.backgroundColor = input_textfield_possible_color;
        else if(color == "input_textfield_essential")
            obj.style.backgroundColor = input_textfield_essential_color;
        else
            obj.style.backgroundColor = input_textfield_color;


        var data_length =  obj.value.length;
        //년월일이 입력되었는지 Check
        //필수 입력항목일 경우
        if( data_length == 0   && mendentory)
        {
            var mesg = "";
            if( startLength ==  endLength && startLength !=  0)
            {
                mesg = ""+startLength+"자리";
                //mesg = ""+startLength+"figure(s) ";

            }
            else if(startLength!=0 && endLength !=0)
            {
                mesg = ""+startLength+"자리이상 " +endLength +"자리이하";
                //mesg = " over "+startLength+"figure(s) " +" below "+endLength +"figure(s) ";


            }
            else if(startLength==0)
            {
                mesg = "" +endLength +"자리 이하 ";
                //mesg = " below " +endLength +"figure(s) ";
            }else if(endLength ==0)
            {
                mesg = "" +startLength +"자리 이상 ";
                //mesg = " over"+startLength+"figure(s) ";
            }


            alert(comment + " 필드가 입력되지 않았습니다.\n" +
                  comment + " 는(은) "+mesg+" 필수 입력항목입니다.\n  ");

            //alert(comment + " field is not inputted.\n" +
            //      comment + " must be inputted by  "+mesg+". \n  ");

            obj.focus();

        }
        else if (data_length != 0)
        {
            if(startLength==0 && endLength ==0)
            {
                return true;
            }
            else if(startLength ==  endLength && startLength !=  data_length )
            {
                alert(comment + "의 입력값은 길이 "+startLength+"자리가 입력되어야 합니다.\n");
                //alert('Inputted results of '+comment + " must be "+startLength+"figures(s).\n");
                obj.focus();
                obj.select();
            }

            else if(startLength==0 && endLength < data_length )
            {
                alert(comment + "의 입력값은 길이 "+endLength+"자리이하 입력되어야 합니다.\n");
                //alert('Inputted results of '+comment + " must be below "+endLength+"figures(s).\n");

                obj.focus();
                obj.select();
            }
            else if(startLength > data_length  && endLength == 0  )
            {
                alert(comment + "의 입력값은 길이 "+startLength+"자리이상  입력되어야 합니다.\n");
                //alert('Inputted results of '+comment + " must be over "+startLength+"figures(s).\n");

                obj.focus();
                obj.select();
            }
            else if( ( startLength > data_length ) || (data_length > endLength  ))
            {
                if (startLength !=0 && endLength !=0 )
                {
                    alert(comment + "의 입력값은 길이 "+startLength+"자리이상 "+endLength+"자리이하가 입력되어야 합니다.\n");
                    //alert('Inputted results of '+comment + " must be over "+startLength+"figures(s). , below "+endLength+"figures(s).\n");

                    obj.focus();
                    obj.select();
                }
                else
                {
                    return true;
                }
            }
            else
            {
                return true;
            }
        }
        else
        {
            return true;
        }

        //에러 발생시 색깔을 진하게
        obj.style.backgroundColor = errorColor;

        return false;

    }

    /**
      들어온 자리수 체크
      obj           : 객체
      startLength   : 자리수부터(0이면  endLength까지만
      endLength     : 자리수까지(0이면 startLength부터 무한대
      comment       : head명
      mendentory    : 필수여부

      Textarea는 개행도 2문자로 인식
    */

    function check_HangulLength( obj, startLength, endLength, comment, mendentory, color)
    {
        //에러 발생하지 않을때 원래대로
                //if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
                //else                      obj.style.backgroundColor = successColor
                
        if(color == "input_textfield_possible")
            obj.style.backgroundColor = input_textfield_possible_color;
        else if(color == "input_textfield_essential")
            obj.style.backgroundColor = input_textfield_essential_color;
        else
            obj.style.backgroundColor = input_textfield_color;


        var data_length =  getByteLength( obj.value );
        //년월일이 입력되었는지 Check
        //필수 입력항목일 경우
        if( data_length == 0   && mendentory)
        {
            var mesg = "";


            if( startLength ==  endLength && startLength !=  0)
            {
                mesg = ""+startLength+"자리";
                //mesg = ""+startLength+"figure(s) ";

            }
            else if(startLength!=0 && endLength !=0)
            {
                mesg = ""+startLength+"자리이상 " +endLength +"자리이하";
                //mesg = " over "+startLength+"figure(s) " +" below "+endLength +"figure(s) ";


            }
            else if(startLength==0)
            {
                mesg = "" +endLength +"자리 이하 ";
                //mesg = " below " +endLength +"figure(s) ";
            }else if(endLength ==0)
            {
                mesg = "" +startLength +"자리 이상 ";
                //mesg = " over"+startLength+"figure(s) ";
            }

            alert(comment + " 필드가 입력되지 않았습니다.\n" +
                  comment + " 는(은) "+mesg+" 필수 입력항목입니다.\n  ");
            //alert(comment + " field is not inputted.\n" +
            //      comment + " must be inputted by  "+mesg+". \n  ");


            obj.focus();

        }
        else if (data_length != 0)
        {
            if(startLength==0 && endLength ==0)
            {
                return true;
            }
            else if(startLength ==  endLength && startLength !=  data_length )
            {
                alert(comment + "의 입력값은 길이 "+startLength+"자리가 입력되어야 합니다.\n");
                //alert('Inputted results of '+comment + " must be "+startLength+"figures(s).\n");
                obj.focus();
                obj.select();
            }

            else if(startLength==0 && endLength < data_length )
            {
                alert(comment + "의 입력값은 길이 "+endLength+"자리이하 입력되어야 합니다.\n");
                //alert('Inputted results of '+comment + " must be below "+endLength+"figures(s).\n");

                obj.focus();
                obj.select();
            }
            else if(startLength > data_length  && endLength == 0  )
            {
                alert(comment + "의 입력값은 길이 "+startLength+"자리이상  입력되어야 합니다.\n");
                //alert('Inputted results of '+comment + " must be over "+startLength+"figures(s).\n");

                obj.focus();
                obj.select();
            }
            else if( ( startLength > data_length ) || (data_length > endLength  ))
            {
                if (startLength !=0 && endLength !=0 )
                {
                    alert(comment + "의 입력값은 길이 "+startLength+"자리이상 "+endLength+"자리이하가 입력되어야 합니다.\n");
                    //alert('Inputted results of '+comment + " must be over "+startLength+"figures(s). , below "+endLength+"figures(s).\n");

                    obj.focus();
                    obj.select();
                }
                else
                {
                    return true;
                }
            }
            else
            {
                return true;
            }
        }
        else
        {
            return true;
        }

        //에러 발생시 색깔을 진하게
        obj.style.backgroundColor = errorColor;

        return false;

    }

    //한글 체크 - 한글자라도 한글이들어가면 false
    function isHangul( obj)
    {
       if( obj.value.length == getByteLength( obj.value ) )  return false;

       return true;

    }


    /** number의 길이 체크
    */
    function check_NumberLength( obj, startLength, endLength, comment, mendentory, color)
    {
        //에러 발생하지 않을때 원래대로
                //if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
                //else                      obj.style.backgroundColor = successColor
                
        if(color == "input_textfield_possible")
            obj.style.backgroundColor = input_textfield_possible_color;
        else if(color == "input_textfield_essential")
            obj.style.backgroundColor = input_textfield_essential_color;
        else
            obj.style.backgroundColor = input_textfield_color;


        var data = removeComma(obj.value);
        var data_length =  data.length;
        //년월일이 입력되었는지 Check
        //필수 입력항목일 경우
        if( data_length == 0   && mendentory)
        {
            var mesg = "";
            if( startLength ==  endLength && startLength !=  0)
            {
                mesg = ""+startLength+"자리";
                //mesg = ""+startLength+"figure(s) ";

            }
            else if(startLength!=0 && endLength !=0)
            {
                mesg = ""+startLength+"자리이상 " +endLength +"자리이하";
                //mesg = " over "+startLength+"figure(s) " +" below "+endLength +"figure(s) ";


            }
            else if(startLength==0)
            {
                mesg = " " +endLength +"이하 ";
                //mesg = " below " +endLength +"figure(s) ";
            }else if(endLength ==0)
            {
                mesg = " "+startLength+"이상 ";
                //mesg = " over"+startLength+"figure(s) ";
            }


            alert(comment + " 필드가 입력되지 않았습니다.\n" +
                  comment + " 는(은) "+mesg+" 필수 입력항목입니다.\n  ");

            //alert(comment + " field is not inputted.\n" +
            //      comment + " must be inputted by  "+mesg+". \n  ");

            obj.focus();

        }
        else if (data_length != 0)
        {
            if(startLength==0 && endLength ==0)
            {
                return true;
            }
            else if(startLength ==  endLength && startLength !=  data_length )
            {
                alert(comment + "의 입력값은 길이 "+startLength+"자리가 입력되어야 합니다.\n");
                //alert('Inputted results of '+comment + " must be "+startLength+"figures(s).\n");
                obj.focus();
                obj.select();
            }

            else if(startLength==0 && endLength < data_length )
            {
                alert(comment + "의 입력값은 길이 "+endLength+"자리이하 입력되어야 합니다.\n");
                //alert('Inputted results of '+comment + " must be below "+endLength+"figures(s).\n");

                obj.focus();
                obj.select();
            }
            else if(startLength > data_length  && endLength == 0  )
            {
                alert(comment + "의 입력값은 길이 "+startLength+"자리이상  입력되어야 합니다.\n");
                //alert('Inputted results of '+comment + " must be over "+startLength+"figures(s).\n");

                obj.focus();
                obj.select();
            }
            else if( ( startLength > data_length ) || (data_length > endLength  ))
            {
                if (startLength !=0 && endLength !=0 )
                {
                    alert(comment + "의 입력값은 길이 "+startLength+"자리이상 "+endLength+"자리이하가 입력되어야 합니다.\n");
                    //alert('Inputted results of '+comment + " must be over "+startLength+"figures(s). , below "+endLength+"figures(s).\n");

                    obj.focus();
                    obj.select();
                }
                else
                {
                    return true;
                }
            }
            else
            {
                return true;
            }
        }
        else
        {
            return true;
        }

        //에러 발생시 색깔을 진하게
        obj.style.backgroundColor = errorColor;

        return false;

    }

    /** E-mail의 체크 */
    function check_Email( obj,  comment, mendentory)
    {

          var data = obj.value;


        if( obj.value.length == 0 && mendentory)
        {
            alert(comment + " E-mail필드가 입력되지 않았습니다.\n" +
                  comment + " E-mail필드는 필수 입력항목입니다.\n\n ");

            //alert(comment + " E-mail field is not inputted.\n" +
            //      comment + " E-mail field must be inputted.\n\n ");


            obj.focus();
            return false;

        }
        else if (obj.value.length != 0 )
        {
          var sign = data.indexOf("@");
          var dot = data.indexOf(".");

          if ( sign == -1 || dot == -1)
          {
             alert(comment + " E-mail 주소 형식이 잘못되었습니다. (xxx@yyy.co.kr) " );
             //alert(comment + " E-mail field must be inputted. (xxx@yyy.co.kr) " );
             obj.focus();
             obj.select();

             return false;
          }

        }
        return true;
    }


    /** Text field체크 */
    function check_text( obj, comment, color)
    {
      if(obj.length == null )
      {
        //if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
        //else                      obj.style.backgroundColor = successColor        
        
        if(color == "input_textfield_possible")
            obj.style.backgroundColor = input_textfield_possible_color;
        else if(color == "input_textfield_essential")
            obj.style.backgroundColor = input_textfield_essential_color;
        else
            obj.style.backgroundColor = input_textfield_color;
        

        if( obj.value == '' || obj.value.length == 0 )
        {
            //에러 발생시 색깔을 진하게
            obj.style.backgroundColor = errorColor;

            //에러 발생하지 않을때 원래대로
            //obj.style.backgroundColor = successColor

            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 필드는 필수 입력항목입니다.\n\n ");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n ");

                if(obj.type!= 'hidden' )
                {
                    obj.focus();
                    obj.select();
                }
            //obj.css_style= 'xjs_error'
            return false;

        }
        //obj.css_style =  obj.getAttribute("className")  //가능//alert( obj.getAttribute("className")) = 'dispRequiredInput'


      }
      else
      {
                var length = obj.length;
                var count = 0;

                for ( i=0 ; i< length ; i++)
                {
                    if(obj[i].readOnly == true)  obj[i].style.backgroundColor = successReadOnlyColor
                    else                         obj[i].style.backgroundColor = successColor

                    if( obj[i].value == '' || obj[i].value.length == 0 )
                    {
                        obj[i].style.backgroundColor = errorColor;

                    //alert(comment + " 필드가 입력되지 않았습니다.\n" +
                    //      comment + " 필드는 필수 입력항목입니다.\n\n ");

                      alert(comment + " field is not inputted.\n" +
                            comment + " field must be inputted.\n\n ");

                        if(obj[i].type != 'hidden' )
                        {
                            obj[i].focus();
                            obj[i].select();
                        }

                        return false;
                    }


                }
        /*




                var length = obj.length;
                var count = 0;
                for ( i=0 ; i< length ; i++)
                {
                    if( obj[i].value == '' || obj[i].value.length == 0 ) count ++;
                }

                if ( count == length )
                {
                    obj[0].style.backgroundColor = errorColor;

                    alert(comment + " 필드가 입력되지 않았습니다.\n" +
                          comment + " 필드는 필수 입력항목입니다.\n\n ");

                    //  alert(comment + " field is not inputted.\n" +
                    //        comment + " field must be inputted.\n\n ");

                    if(obj[0].type!= 'hidden' )
                    {
                        obj[0].focus();
                        obj[0].select();
                    }

                    return false;
                 }
            */

       }
        return true ;

    }




    /** Text field체크 : 마지막은 span tag에 있으므로 체크하지 않는다. */
    function check_textOfBTA(  obj, comment)
    {
      if(obj.length == null )
      {
        if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
        else                      obj.style.backgroundColor = successColor

        if( obj.value == '' || obj.value.length == 0 )
        {
            //에러 발생시 색깔을 진하게
            obj.style.backgroundColor = errorColor;

            //에러 발생하지 않을때 원래대로
            //obj.style.backgroundColor = successColor

            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 필드는 필수 입력항목입니다.\n\n ");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n ");

                if(obj.type!= 'hidden' )
                {
                    obj.focus();
                    obj.select();
                }
            //obj.css_style= 'xjs_error'
            return false;

        }
        //obj.css_style =  obj.getAttribute("className")  //가능//alert( obj.getAttribute("className")) = 'dispRequiredInput'


      }
      else
      {
                var length = obj.length;
                var count = 0;

                for ( i=0 ; i< length-1 ; i++)
                {
                    if(obj[i].readOnly == true)  obj[i].style.backgroundColor = successReadOnlyColor
                    else                         obj[i].style.backgroundColor = successColor

                    if( obj[i].value == '' || obj[i].value.length == 0 )
                    {
                        obj[i].style.backgroundColor = errorColor;

                    //alert(comment + " 필드가 입력되지 않았습니다.\n" +
                    //      comment + " 필드는 필수 입력항목입니다.\n\n ");

                      alert(comment + " field is not inputted.\n" +
                            comment + " field must be inputted.\n\n ");

                        if(obj[i].type != 'hidden' )
                        {
                            obj[i].focus();
                            obj[i].select();
                        }

                        return false;
                    }


                }
        /*




                var length = obj.length;
                var count = 0;
                for ( i=0 ; i< length ; i++)
                {
                    if( obj[i].value == '' || obj[i].value.length == 0 ) count ++;
                }

                if ( count == length )
                {
                    obj[0].style.backgroundColor = errorColor;

                    alert(comment + " 필드가 입력되지 않았습니다.\n" +
                          comment + " 필드는 필수 입력항목입니다.\n\n ");

                    //  alert(comment + " field is not inputted.\n" +
                    //        comment + " field must be inputted.\n\n ");

                    if(obj[0].type!= 'hidden' )
                    {
                        obj[0].focus();
                        obj[0].select();
                    }

                    return false;
                 }
            */

       }
        return true ;

    }
    /**Text area에 각라인에 입력값 제어 */
    function check_Textarea( obj, comment, len, mendentory)
    {
        var data = obj.value;
        if (obj.value.length == 0   && mendentory )
        {
            //에러 발생시 색깔을 진하게
            obj.style.backgroundColor = errorColor;
            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 는(은) 필수 입력항목입니다.\n\n ");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n ");

            obj.focus();
            return false;


        }
        else if (obj.value.length != 0 )
        {
            var data_array = data.split("\r\n");

            for(i=0;i< data_array.length;i++)
            {
                if(data_array[i].length != len)
                {
                    //에러 발생시 색깔을 진하게
                    obj.style.backgroundColor = errorColor;

                    //alert((i+1)+'번째라인의 '+comment+'의 입력이 ['+data_array[i]+']입니다.\n'+len+'자리를 입력하세요.');
                    alert('Inputting of '+comment+' of '+(i+1)+' line is ' +data_array[i]+ '.\nInput '+len+' figure(s).');
                    obj.focus();

                    return false;
                }
            }

        }
        //에러 발생하지 않을때 원래대로

         if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
         else                      obj.style.backgroundColor = successColor



        obj.value = obj.value.toUpperCase();
        return true;

    }
    /**
     오브젝의 값이 범위를 지정할 경우 시작값과 종료값의 범위를 Check하는 함수
     <br>
     파라메터는 오브젝트로 전달, 형식에 맞지 않으면 False 리턴
    */
    function check_Range( startObj,  endObj,  comment)
    {
        if (startObj.value > endObj.value)
        {
            //alert(comment + " 범위의 시작값이 종료값보다 큼니다.\n시작값과 종료값을 확인바랍니다.\n");
            alert('Starting result of '+comment+' range is bigger then ending result.\nPlease check starting result and ending result.');
            startObj.focus();
            startObj.select();
        }
        else
        {
            return true;
        }

        return false;

    }

    /**
    발행매수 값에 대해 Check하는 함수
    */
    function check_PrintCnt( obj,  comment,  mendentory)
    {
        //필수 입력항목일 경우
        if ((obj.value.length == 0) && mendentory)
        {
            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 필드는 발행시 필수 입력항목입니다.\n\n 예) 3");
            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n ");

            obj.focus();
            obj.select();
        }
        else if (isNaN(obj.value))
        {
            //alert(comment + "은 숫자만 입력 가능합니다.\n입력값을 확인바랍니다. 예) 3");
            alert(comment + " field must be inputted by numeric data.\n Please check inputted data. Ex) 3");
            obj.focus();
            obj.select();
        }
        else if (obj.value < 1 || obj.value > 3 )
        {
            //alert(comment + "는 1 ~ 3까지 입력 가능합니다.\n확인 후 다시 입력하십시요.");
            alert(comment + " field must be inputted by from 1 to 3..\nPlease check inputted data.");

            obj.focus();
            obj.select();
        }
        else
        {
            return true;
        }
        return false;
    }

    /**
    combo를 들어온 data에 따라 선택된 효과
    */
    function funcSelectCombo( comboObj, data, dataFlag)
    {

        var index = 0 ;
        var len = comboObj.length;
        var compare = '';
        for(var i=0;i < len;i++)
        {

            if ( dataFlag.toUpperCase()=='TEXT')
            {
                compare = comboObj.options[i].text;
            }
            else
            {
                compare = comboObj.options[i].value;
            }


            if (compare == data)
            {
                index = i;
                break;
            }

        }
       // alert( index +' '+data+' '+compare);
        comboObj.selectedIndex = index;

    }


//-------------      기타체크 완료            ---------------------//
//-------------      NUMBER체크             ---------------------//
    /**
     자리수 유효성을 확인한다
     <br>
     before_len : 소수점 이전(0이면 상관 없음)
     <br>
     after_len  : 소수점 이하
    */
    function check_isFloat(  obj,  before_len,  after_len , comment, mendentory)
    {
        var before_ex ='';
        var after_ex = '';
        var i=0;
        //if (before_len ==0 ) before_len = 20;
        for(i=1;i<=before_len;i++)
        {

            if (i==1)   before_ex +=  Math.floor(Math.random()*9 +1);//1과 9 사이 정수
            else if(i <10)      before_ex +=  Math.floor(Math.random()*10);//0과 9 사이 정수
            else                before_ex += '3';

        }

        for(i=1;i<=after_len;i++)
        {

            if(i <10)           after_ex +=   Math.floor(Math.random()*10);
            else                after_ex += '2';

        }
        var ex = before_ex + '.'+ after_ex;
        var str = obj.value ;

        point = str.indexOf('.');
        if (point == -1  && mendentory )
        {
            //에러 발생시 색깔을 진하게
            obj.style.backgroundColor = errorColor;

            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 는(은) 필수 입력항목입니다.\n\n 예) "+ex);
              alert(comment + " field is not inputted.\n" +
                    comment + " field must be inputted.\n\n Ex) "+ex);

            obj.focus();
            return false;



        }
        else if (point != -1)
        {
            before_str = str.substring(0, point);
            after_str = str.substring(point+1, str.length);

            if (before_len !=0  && before_str.length > before_len)
            {
                //에러 발생시 색깔을 진하게
                obj.style.backgroundColor = errorColor;

                /* alert('자리수 초과입니다.'); */
                //alert(comment + " 필드는 소수점 이상 "+before_len+"자리로 입력하세요.\n\t\t 예) "+ex);
                alert(comment + " field must be inputted "+before_len+" figure(s)  over decimal point.\n\t\t 예) "+ex);
                obj.focus();
                obj.select();
                return false;
            }

            if (after_str.length > after_len)
            {
                //에러 발생시 색깔을 진하게
                obj.style.backgroundColor = errorColor;

                /* alert('소수점이하 ' + after_len + '자리로 입력하세요.');*/
                //alert(comment + " 필드는 소수점 이하 "+after_len+"자리로 입력하세요.\n\t\t 예) "+ex);
                alert(comment + " field must be inputted "+before_len+" figure(s)  below decimal point.\n\t\t 예) "+ex);

                obj.focus();
                obj.select();
                return false;
            }

        }
        else
        {
           //에러 발생하지 않을때 원래대로

          if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
          else                      obj.style.backgroundColor = successColor


            return true;
        }
        //에러 발생하지 않을때 원래대로
        if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
         else                      obj.style.backgroundColor = successColor

        return true;
    }
    
    /**
    오브젝트의 값이 숫자인지 Check하는 함수(콤마가 있을경우)
     <br>
    파라메터는 오브젝트로 전달
    */
    function check_Number( obj, comment, mendentory, color)
    {

        if (obj.value.length == 0 && mendentory)
        {
            //에러 발생시 색깔을 진하게
            obj.style.backgroundColor = errorColor;

            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 필드는 필수 입력항목입니다.\n\n 예) 12");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n Ex) 1234");

            obj.focus();
            return false;

        }else if(obj.value.length != 0)
        {
            var data = removeComma(obj.value)
            if (isNaN(data))
            {
                //에러 발생시 색깔을 진하게
                obj.style.backgroundColor = errorColor;

                //alert(comment + " 필드는 숫자만 입력 가능합니다.\n" +
                //                "문자는 사용할 수 없습니다.");

                alert(comment + " field is not inputted by numeric data.\n" +
                                "You can not input a word character .");

                obj.focus();
                obj.select();

                return false;
            }
            else
            {
                //에러 발생하지 않을때 원래대로
                if(color == "input_textfield_possible")
                    obj.style.backgroundColor = input_textfield_possible_color;
                else if(color == "input_textfield_essential")
                    obj.style.backgroundColor = input_textfield_essential_color;
                else
                    obj.style.backgroundColor = input_textfield_color;

                return true;
            }

        }
        //에러 발생하지 않을때 원래대로
        if(color == "input_textfield_possible")
            obj.style.backgroundColor = input_textfield_possible_color;
        else if(color == "input_textfield_essential")
            obj.style.backgroundColor = input_textfield_essential_color;
        else
            obj.style.backgroundColor = input_textfield_color;


        return true;
    }
    
    /**
    오브젝트의 값이 숫자인지 Check하는 함수(콤마가 없을경우)
     <br>
    파라메터는 오브젝트로 전달
    */
    function check_Number2( obj, comment, mendentory, color)
    {

        if (obj.value.length == 0 && mendentory)
        {
            //에러 발생시 색깔을 진하게
            obj.style.backgroundColor = errorColor;

            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 필드는 필수 입력항목입니다.\n\n 예) 12");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n Ex) 1234");

            obj.focus();
            return false;

        }else if(obj.value.length != 0)
        {
            var data = obj.value;
            if (isNaN(data))
            {
                //에러 발생시 색깔을 진하게
                obj.style.backgroundColor = errorColor;

                //alert(comment + " 필드는 숫자만 입력 가능합니다.\n" +
                 //               "문자는 사용할 수 없습니다.");

                alert(comment + " field is not inputted by numeric data.\n" +
                                "You can not input a word character .");

                obj.focus();
                obj.select();

                return false;
            }
            else
            {
                //에러 발생하지 않을때 원래대로
                if(color == "input_textfield_possible")
                    obj.style.backgroundColor = input_textfield_possible_color;
                else if(color == "input_textfield_essential")
                    obj.style.backgroundColor = input_textfield_essential_color;
                else
                    obj.style.backgroundColor = input_textfield_color;

                return true;
            }

        }
        //에러 발생하지 않을때 원래대로
        if(color == "input_textfield_possible")
            obj.style.backgroundColor = input_textfield_possible_color;
        else if(color == "input_textfield_essential")
            obj.style.backgroundColor = input_textfield_essential_color;
        else
            obj.style.backgroundColor = input_textfield_color;


        return true;
    }

//-------------      NUMBER체크 완료          ---------------------//



//-------------      IMAGE 및 Layer시작          ---------------------//

    /**
    detail정보 보이기
    */

    function funcDetailShowForLeft( L,left, e)
    {

            if(NS) {
                    var barron = document.layers[L];
                    /* 마우스 포인터가 layer맨위 - 60 (layer두께) = 포인터가 맨 아래*/
                    barron.top = e.pageY   +30  ;

                    left = left==null?15:left;

                    /* 마우스 포인터가 layer맨 왼쪽  */
                    //barron.left = e.pageX - parseInt(barron.document.width/2)+5;
                    barron.left = left;

                    barron.visibility = "visible";

                    //alert(e.pageY+":"+e.screenY+":"+barron.document.heigh);

            }
            else if(IE) {


                    var barron = document.all[L];
                    /* 마우스 포인터가 layer맨위 - 60 (layer두께) = 포인터가 맨 아래 */

                    barron.style.pixelTop = event.clientY + document.body.scrollTop + 18;

                    left = left==null?35:left;

                    /* 마우스 포인터가 layer맨 왼쪽   *//* +10 은 포인터에 딱 붙지 않게 */

                    //barron.style.pixelLeft = 15;
                    barron.style.pixelLeft = left;

                    barron.style.visibility = "visible";

         }

    }


    function funcDetailShow( L, e)
    {
	        if(NS) {
	                var barron = document.layers[L];
	                /* 마우스 포인터가 layer맨위 - 60 (layer두께) = 포인터가 맨 아래*/
  					var basis_line = screen.height-170
	                if (  e.screenY > basis_line  )
   			        	barron.top = e.pageY - 100
   			        else
						barron.top = e.pageY + 18
    	      		barron.left = e.pageX + 10

	                barron.visibility = "visible"

	                //document.scs.total.value='e.clientY:'+e.clientY+']e.offsetY:'+e.offsetY+']e.screenY:'+e.screenY+']document.body.scrollTop:'+''+''+']:'+''+']:'+''+':';
	               // alert(e.pageY+":"+e.screenY+":"+barron.document.heigh+":["+barron.clip.width);

	        }
	        else if(IE) {


	                var barron = document.all[L]
	                /* 마우스 포인터가 layer맨위 - 60 (layer두께) = 포인터가 맨 아래 */

	            	//barron.style.pixelTop = event.clientY + document.body.scrollTop + 18
	            	//170 : 기준라인부터 window toolbar까지
	            	var basis_line = screen.height-150//170
	                if (  event.screenY > basis_line  )
	                {//기준라인 이하로 마우스위치가 내려 왔을때
	                	//100 layer위치
	                   barron.style.pixelTop = event.clientY + document.body.scrollTop - 70;//
	                   //- 100

	            	}
	            	else
	            	{
	            		barron.style.pixelTop = event.clientY + document.body.scrollTop +18
	            		//+ 18

	            	}

	           		/* 마우스 포인터가 layer맨 왼쪽   *//* +10 은 포인터에 딱 붙지 않게 */

					//barron.style.pixelLeft = - parseInt(OBJ.offsetWidth/2)//15

					//마우스 포인트의 중간
					//barron.style.pixelLeft= event.clientX + document.body.scrollLeft- parseInt(barron.offsetWidth/2)
					//마우스 포인트의 왼쪽으로
                    var basis_line = screen.width-parseInt(barron.offsetWidth)//170
	                if (  event.screenX > basis_line  )
	                {//기준라인 오른쪽으로 마우스위치가 넘어갔을때
	                    barron.style.pixelLeft= event.clientX + document.body.scrollLeft - parseInt(barron.offsetWidth)
	                }
	                else
	                {
            			barron.style.pixelLeft= event.clientX + document.body.scrollLeft
                    }
	                barron.style.visibility = "visible"




	     }

    }

    /**detail정보 안보이기
    */
    function funcDetailDown( L)
    {
            if(NS) {
                    document.layers[L].visibility = "hidden";
            }
            else if(IE) {
                    document.all[L].style.visibility = "hidden";
            }
    }


    /**
    detail정보 보이기
    */
    function funcDetailShow_currPosition( L,  e)
    {

            if(NS) {
                    var barron = document.layers[L];
                    /* 마우스 포인터가 layer맨위 - 60 (layer두께) = 포인터가 맨 아래*/
                    var basis_line = screen.height-170
                    if (  e.screenY > basis_line  )
                        barron.top = e.pageY - 100
                    else
                        barron.top = e.pageY + 18
                    barron.left = e.pageX + 10

                    barron.visibility = "visible"

                    //document.scs.total.value='e.clientY:'+e.clientY+']e.offsetY:'+e.offsetY+']e.screenY:'+e.screenY+']document.body.scrollTop:'+''+''+']:'+''+']:'+''+':';
                   // alert(e.pageY+":"+e.screenY+":"+barron.document.heigh+":["+barron.clip.width);

            }
            else if(IE) {


                    var barron = document.all[L]
                    /* 마우스 포인터가 layer맨위 - 60 (layer두께) = 포인터가 맨 아래 */

                    //barron.style.pixelTop = event.clientY + document.body.scrollTop + 18
                    //170 : 기준라인부터 window toolbar까지
                        ///barron.style.pixelTop = event.clientY + document.body.scrollTop +18

                    /* 마우스 포인터가 layer맨 왼쪽   *//* +10 은 포인터에 딱 붙지 않게 */

                    //마우스 포인트의 왼쪽으로
                    //barron.style.pixelLeft= event.clientX
                    barron.style.visibility = "visible"

         }


    }

    /**
    detail정보 보이기
    */
    function funcDetailWantShow( L,align, e)
    {
            if(NS) {
                    var barron = document.layers[L];
                    /* 마우스 포인터가 layer맨위 - 60 (layer두께) = 포인터가 맨 아래*/
                    barron.top = e.pageY   +30  ;



                    /* 마우스 포인터가 layer맨 왼쪽  */
                    //barron.left = e.pageX - parseInt(barron.document.width/2)+5;
                    barron.left = 15;

                    barron.visibility = "visible";

                    //alert(e.pageY+":"+e.screenY+":"+barron.document.heigh);

            }
            else if(IE) {


                    var barron = document.all[L];
                    /* 마우스 포인터가 layer맨위 - 60 (layer두께) = 포인터가 맨 아래 */

                    barron.style.pixelTop = event.clientY + document.body.scrollTop + 18;




                    /* 마우스 포인터가 layer맨 왼쪽   *//* +10 은 포인터에 딱 붙지 않게 */
                    //마우스 포인트의 왼쪽으로
                    if(align=='LEFT')   barron.style.pixelLeft= event.clientX
                     else               barron.style.pixelLeft= event.clientX+barron.style.width

                    //barron.style.pixelLeft = 15;
                    //barron.style.pixelLeft = 35;

                    barron.style.visibility = "visible";



         }

    }


    /**detail정보 안보이기
    */
    function funcDetailDown_currPosition( L)
    {
            if(NS) {
                    document.layers[L].visibility = "hidden";
            }
            else if(IE) {
                    document.all[L].style.visibility = "hidden";
            }
    }

    /**click됬을때
    */
    function funcClickImageOn( name)
    {
            if( !isDisableImage (name) )
            {
                if (clickImage !='') document[clickImage].src = eval(clickImage + "_off.src");
                clickImage    = name;


                if (name !='') document[name].src = eval(name + "_click.src");
            }

    }

    /**마우스가 on되도 바로전에 클릭되었던 이미지는 클릭상태로 되있어야 하므로
    */
    function funcCurrClickImageOn()
    {


            if (clickImage !='')
            {
                 document[clickImage].src = eval(clickImage + "_click.src");
            }

    }

    /**Click되었던 image 클릭 Off
    */
    function funcCurrClickImageOff()
    {

        if (clickImage !='')
        {
             document[clickImage].src = eval(clickImage + "_off.src");
             clickImage ='';
        }

    }
    /**mouse move시 image on
    */
    function funcImageOn( name)
    {
        if( !isDisableImage (name) )
        {

            if(name!='')
            {
                showImage    = name;
                document[name].src = eval(name + "_on.src");
            }
         }
    }

    /**mouse move시 image off
    */
    function funcImageOff( name)
    {
        if( !isDisableImage (name) )
        {

            if(name!='')
            {
                document[name].src = eval(name + "_off.src");
            }

            //마우스가 on되도 바로전에 클릭되었던 이미지는 클릭상태로 되있어야 하므로
            funcCurrClickImageOn();
        }
    }

    /**mouse move시 image Disable
    */
    function funcImageDisable( name)
    {
        if(name!='')
        {
            disableImage[disableImage_index]    = name;

            disableImage_index++;
            document[name].src = eval(name + "_disable.src");
        }
    }


    /**Click되었던 image 클릭 Off
    */
    function funcImageOffAllDisable()
    {

            for(var i=0 ;i<disableImage.length;i++)
            {
                 var name = disableImage[i] ;

                 document[name].src = eval(name + "_off.src");

            }

    }

    /**mouse move시 image Disable
    */
    function funcImageDisableArrayClear( name)
    {
        if(name!='')
        {
            var temp  = new Array();
            var inx = 0;
            for(var i=0 ;i<disableImage.length;i++)
            {
                 if(disableImage[i] != name)
                 {
                    temp[inx] = disableImage[i];
                    inx++;
                 }
            }

            disableImage =  temp;
        }
    }

     /**Disable image와 name image가 같으면 아무 반응 없이
    */
     function isDisableImage( name)
     {
         if(name!='' )
         {
            for(var i=0 ;i<disableImage.length;i++)
            {
                 if(disableImage[i] == name)
                 {
                    return true;
                 }
            }

            return false;
         }

         return false;

     }
//-------------      IMAGE 및 Layer끝          ---------------------//

//-------------      DATE 시작          ---------------------//


    /**
    날짜 조건필드의 유효성을 검사하는 함수
     <br>
    파라메터는 오브젝트로 전달, 리턴값은 Boolean 형식
     <br>
    date_length : 숫자 8or6만 가능 (dateObj의 입력받을 자리수
    */
    function check_Date_Single_gauce( dateObj, comment, date_length, mendentory)
    {    	
        var _dateObj   =  funcReplaceStrAll(dateObj, ".", "");
        var _dateObj   =  funcReplaceStrAll(_dateObj, "/", "");

        var month = new Array( "31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31" );
        var dateYear = '';
        var dateMonth = '';
        var dateDay = '';

        if (date_length == 4 )
        {
            dateYear  =_dateObj;
            dateMonth = '01';
            dateDay = '01';
        }
        else if (date_length == 6 )
        {
            dateYear  =_dateObj.substring(0, 4);
            dateMonth = _dateObj.substring(4, 6);
            dateDay = '01';

        }
        else
        {
            dateYear  =_dateObj.substring(0, 4);
            dateMonth = _dateObj.substring(4, 6);
            dateDay = _dateObj.substring(6, 8);
        }

        var ex = "";
        if (date_length == 4) ex = "2000";
        else if (date_length == 6) ex = "200011";
        else                   ex = "20001130";

        month[1] = getEndOfMonthDay(  dateYear,  dateMonth )

        //년월일이 입력되었는지 Check
        //필수 입력항목일 경우
        if ((_dateObj.length == 0 )  && mendentory )
        {

            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 는(은) 필수 입력항목입니다.\n\n 예) "+ex);

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n Ex) "+ex);

            //dateObj.focus();
        }

        //필수입력항목이 아닌 경우에 입력한경우
        else if (_dateObj.length != 0)
        {
            if (_dateObj.length != date_length)
            {

                //alert(comment + " 날짜가 입력되지 않았거나\n날짜길이("+date_length+"자리)가 잘못 입력되었습니다.\n\n 예) "+ex);
                alert(comment + " Date inputted incorrectly. \n" + "Or date figure(s)("+date_length+"figure(s)) inputted incorrectly.\n\n Ex) "+ex);
                //dateObj.focus();
                //dateObj.select();
            }
            //날짜 형식 Check
            else if (isNaN(_dateObj))
            {

                //alert(comment + " 의 날짜 형식은 숫자만 가능합니다.\n날짜형식을 확인바랍니다.\n\n 예) "+ex);
                alert(" Date form of"+comment +"can input only number. \n Please check the inputted date form.  \n\n Ex) "+ex);
                //dateObj.focus();
                //dateObj.select();
            }
            //날짜형식중 '월'의 범위 Check
            else if ((dateMonth < '01') || (dateMonth > '12'))
            {

                //alert(comment + "의 날짜형식(월)이 잘못 입력되었습니다.\n월은 1월부터 12월까지 입력가능합니다.\n\n 예) "+ex);
                alert("Date form (Month) of"+comment + "is inputted incorrectly.\n Month field can be inputted from Jan to Dec.\n\n Ex) "+ex);
                //dateObj.focus();
                //dateObj.select();
            }
            //날짜형식중 '일'의 범위 Check
            else if (  date_length == 8  &&   (dateDay < '01') || (dateDay > month[dateMonth - 1])         )
            {
                //alert(comment + "의 날짜형식(일)이 잘못 입력되었습니다.\n" + dateMonth + " 월은 1일부터 " + month[dateMonth - 1] + "일까지 입력가능합니다.\n\n 예) "+ex);
                alert("Date forlm (Day) of "+comment + "inputted incorrectly. \n" + dateMonth + "month can be  inputted from 1 day to " + month[dateMonth - 1] + "days.\n\n Ex) "+ex);
                //dateObj.focus();
                //dateObj.select();
            }
            else
            {
                return true;
            }
        }
        else
        {
            return true;
        }

        return false;

    }


    /**
    날짜 조건필드의 유효성을 검사하는 함수
     <br>
    파라메터는 오브젝트로 전달, 리턴값은 Boolean 형식
     <br>
    date_length : 숫자 8or6만 가능 (dateObj의 입력받을 자리수
    */
    function check_Date_Single( dateObj, comment, date_length, mendentory, color)
    {
    	//에러 발생하지 않을때 원래대로
    	if(color == "input_textfield_possible")
            dateObj.style.backgroundColor = input_textfield_possible_color;
        else if(color == "input_textfield_essential")
            dateObj.style.backgroundColor = input_textfield_essential_color;
        else
            dateObj.style.backgroundColor = input_textfield_color;
            
    	
        var _dateObj   =  funcReplaceStrAll(dateObj.value, ".", "");
        var _dateObj   =  funcReplaceStrAll(_dateObj, "/", "");

        var month = new Array( "31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31" );
        var dateYear = '';
        var dateMonth = '';
        var dateDay = '';

        if (date_length == 4 )
        {
            dateYear  =_dateObj;
            dateMonth = '01';
            dateDay = '01';
        }
        else if (date_length == 6 )
        {
            dateYear  =_dateObj.substring(0, 4);
            dateMonth = _dateObj.substring(4, 6);
            dateDay = '01';

        }
        else
        {
            dateYear  =_dateObj.substring(0, 4);
            dateMonth = _dateObj.substring(4, 6);
            dateDay = _dateObj.substring(6, 8);
        }

        var ex = "";
        if (date_length == 4) ex = "2000";
        else if (date_length == 6) ex = "200011";
        else                   ex = "20001130";

        month[1] = getEndOfMonthDay(  dateYear,  dateMonth )

        //년월일이 입력되었는지 Check
        //필수 입력항목일 경우
        if ((_dateObj.length == 0 )  && mendentory )
        {

            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 는(은) 필수 입력항목입니다.\n\n 예) "+ex);

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n Ex) "+ex);

            dateObj.focus();
        }

        //필수입력항목이 아닌 경우에 입력한경우
        else if (_dateObj.length != 0)
        {
            if (_dateObj.length != date_length)
            {

                //alert(comment + " 날짜가 입력되지 않았거나\n날짜길이("+date_length+"자리)가 잘못 입력되었습니다.\n\n 예) "+ex);
                alert(comment + " Date inputted incorrectly. \n" + "Or date figure(s)("+date_length+"figure(s)) inputted incorrectly.\n\n Ex) "+ex);
                dateObj.focus();
                dateObj.select();
            }
            //날짜 형식 Check
            else if (isNaN(_dateObj))
            {

                //alert(comment + " 의 날짜 형식은 숫자만 가능합니다.\n날짜형식을 확인바랍니다.\n\n 예) "+ex);
                alert(" Date form of"+comment +"can input only number. \n Please check the inputted date form.  \n\n Ex) "+ex);
                dateObj.focus();
                dateObj.select();
            }
            //날짜형식중 '월'의 범위 Check
            else if ((dateMonth < '01') || (dateMonth > '12'))
            {

                //alert(comment + "의 날짜형식(월)이 잘못 입력되었습니다.\n월은 1월부터 12월까지 입력가능합니다.\n\n 예) "+ex);
                alert("Date form (Month) of"+comment + "is inputted incorrectly.\n Month field can be inputted from Jan to Dec.\n\n Ex) "+ex);
                dateObj.focus();
                dateObj.select();
            }
            //날짜형식중 '일'의 범위 Check
            else if (  date_length == 8  &&   (dateDay < '01') || (dateDay > month[dateMonth - 1])         )
            {
                //alert(comment + "의 날짜형식(일)이 잘못 입력되었습니다.\n" + dateMonth + " 월은 1일부터 " + month[dateMonth - 1] + "일까지 입력가능합니다.\n\n 예) "+ex);
                alert("Date forlm (Day) of "+comment + "inputted incorrectly. \n" + dateMonth + "month can be  inputted from 1 day to " + month[dateMonth - 1] + "days.\n\n Ex) "+ex);
                dateObj.focus();
                dateObj.select();
            }
            else
            {
                //에러 발생하지 않을때 원래대로
                //if(dateObj.readOnly == true)  dateObj.style.backgroundColor = successReadOnlyColor
                //else                          dateObj.style.backgroundColor = successColor

                return true;
            }
        }
        else
        {
                //에러 발생하지 않을때 원래대로
                //if(dateObj.readOnly == true)  dateObj.style.backgroundColor = successReadOnlyColor
                //else                          dateObj.style.backgroundColor = successColor

               return true;
        }

        //에러 발생시 색깔을 진하게                
        dateObj.style.backgroundColor = errorColor;


        return false;

    }


    function check_DateOfMulti(  startDate,  endDate,  comment,  mendentory, datalength)
    {
        if( startDate != null)
        {
             //alert('1');
            var len = startDate.length
            if(len == null)
            {//1개
                if( ! check_Date(  startDate,  endDate,  comment,  mendentory, datalength) ) return false;
            }
            else
            {
                for(i=0 ; i < len ; i++)
                {
                    if( ! check_Date(  startDate[i],  endDate[i],  (i+1)+'th '+comment,  mendentory, datalength )) return false;
                }


            }

        }
         return  true;

    }
    /**
    날짜 조건필드의 유효성을 검사하는 함수
     <br>
    파라메터는 오브젝트로 전달, 리턴값은 Boolean 형식
    */
    function check_Date( startDate,  endDate,  comment,  mendentory, datalength)
    {
        var _startDate =  funcReplaceStrAll(startDate.value, ".", "");
        var _startDate =  funcReplaceStrAll(_startDate, "/", "");
        var _endDate   =  funcReplaceStrAll(endDate.value, ".", "");
        var _endDate   =  funcReplaceStrAll(_endDate, "/", "");

        var start_month = new Array( "31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31" );
        var end_month = new Array( "31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31" );

        var startYear = _startDate.substring(0,4);
        var endYear   = _startDate.substring(0,4);


        var startMonth = _startDate.substring(4, 6);
        var endMonth   = _endDate.substring(4, 6);

        var startDay = '';
        var endDay =    '';
        var startEx = '';
        var endEx = '';
        //var datalength = 0;

        if (datalength  == null) datalength=8;

            if ( datalength == 6 )
            {
                startDay = '01';
                startEx = '200011'
                endDay = '01';
                endEx = '200012';


            }
            else
            {
                startDay = _startDate.substring(6, 8);
                startEx = '20001130';
                endDay = _endDate.substring(6, 8);
                endEx = '20001231'  ;


            }

        start_month[1] = getEndOfMonthDay(  startYear,  startMonth )
        end_month[1] = getEndOfMonthDay(  endYear,  endMonth )


        //시작일과 종료일이 입력되었는지 Check
        //필수 입력항목일 경우
        if (((_startDate.length == 0 ) && (_endDate.length == 0)) && mendentory)
        {
            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 범위는 필수 입력항목입니다.\n\n 예) "+startEx+" ~ " +endEx);

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n Ex) "+startEx+" ~ " +endEx);

            if(startDate.type!= 'hidden' )  startDate.focus();
        }

        //필수입력항목이 아닌 경우에 조회범위를 입력한 경우
        else if ((_startDate.length != 0) || (_endDate.length != 0))
        {
            if (_startDate.length != datalength)
            {
                //alert(comment + " 범위의 시작일이 입력되지 않았거나\n날짜길이("+datalength+"자리)가 잘못 입력되었습니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert('Starting day of '+comment + " range is not  inputted or day length("+datalength+"figure(s)) is incorrect.\n\n Ex) "+startEx+" ~ " +endEx);
                if(startDate.type!= 'hidden' ) startDate.focus();

            }
            else if (_endDate.length != datalength)
            {
                //alert(comment + " 범위의 종료일이 입력되지 않았거나\n날짜길이("+datalength+"자리)가 잘못 입력되었습니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert('Ending day of '+comment + " range is not  inputted or day length("+datalength+"figure(s)) is incorrect.\n\n Ex) "+startEx+" ~ " +endEx);

                if(endDate.type!= 'hidden' )   endDate.focus();

            }
            //날짜 형식 Check
            else if (isNaN(_startDate))
            {
                //alert(comment + " 범위의 시작일 형식은 숫자만 가능합니다.\n시작일 날짜형식을 확인바랍니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert('Starting day form of '+comment + " range can be inputted only number.\nPlease check the starting day form.\n\n Ex) "+startEx+" ~ " +endEx);

                if(startDate.type!= 'hidden' )
                {
                    startDate.focus();
                    startDate.select();
                }
            }
            else if (isNaN(_endDate))
            {
                //alert(comment + " 범위의 종료일 형식은 숫자만 가능합니다.\n종료일 날짜형식을 확인바랍니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert('Ending day form of '+comment + " range can be inputted only number.\nPlease check the ending day form.\n\n Ex) "+startEx+" ~ " +endEx);
                if(endDate.type!= 'hidden' )
                {
                    endDate.focus();
                    endDate.select();
                }
            }
            //날짜형식중 '월'의 범위 Check
            else if ((startMonth < '01') || (startMonth > '12'))
            {
                //alert("시작 " + comment + "의 날짜형식(월)이 잘못 입력되었습니다.\n월은 1월부터 12월까지 입력가능합니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Date form (Month) of"+comment + "is inputted incorrectly.\n Month can be inputted from Jan to Dec.\n\n Ex) "+startEx+" ~ " +endEx);
                if(startDate.type!= 'hidden' )
                {
                    startDate.focus();
                    startDate.select();
                }
            }
            else if ((endMonth < '01') || (endMonth > '12'))
            {
                //alert("종료 " + comment + "의 날짜형식(월)이 잘못 입력되었습니다.\n월은 1월부터 12월까지 입력가능합니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Date form (Month) of"+comment + "is inputted incorrectly.\n Month can be inputted from Jan to Dec.\n\n Ex) "+startEx+" ~ " +endEx);
                if(endDate.type!= 'hidden' )
                {
                    endDate.focus();
                    endDate.select();
                }
            }
            //날짜형식중 '일'의 범위 Check
            else if ((startDay < '01') || (startDay > start_month[startMonth - 1]))
            {
                //alert("시작 " + comment + "의 날짜형식(일)이 잘못 입력되었습니다.\n" + startMonth + " 월은 1일부터 " + start_month[startMonth - 1] + "일까지 입력가능합니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Date form (Day) of"+comment + "is inputted incorrectly.\n  "+ startMonth + " Month  can be inputted from 1 to "+ start_month[startMonth - 1] +" .\n\n Ex) "+startEx+" ~ " +endEx);
                if(startDate.type!= 'hidden' )
                {
                    startDate.focus();
                    startDate.select();
                }
            }
            else if ((endDay < '01') || (endDay > end_month[endMonth - 1]))
            {
                //alert("종료 " + comment + "의 날짜형식(일)이 잘못 입력되었습니다.\n" + endMonth + " 월은 1일부터 " + end_month[endMonth - 1] + "일까지 입력가능합니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Date form (Day) of"+comment + "is inputted incorrectly.\n  "+ startMonth + " Month  can be inputted from 1 to "+ end_month[endMonth - 1] +" .\n\n Ex) "+startEx+" ~ " +endEx);
                if(endDate.type!= 'hidden' )
                {
                    endDate.focus();
                    endDate.select();
                }
            }
            //시작일과 종료일보다 값이 큰 경우
            else if (_startDate > _endDate)
            {
                //alert(comment + " 범위의 시작일이 종료일보다 큼니다.\n시작일과 종료일을 확인바랍니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Ending day must be later than staring day.\nPlease check starting day and ending day. Ex)  "+startEx+" ~ " +endEx );
                if(startDate.type!= 'hidden' )
                {
                    startDate.focus();
                    startDate.select();
                }
            }
            else
            {
                return true;
            }

        }
        else
        {
            return true;
        }


        return false;

    }

    /**
    date자리수가 6자리가들어오든 8자리가 들어오든 date형식 체크
     <br>
    날짜 조건필드의 유효성을 검사하는 함수
     <br>
    파라메터는 오브젝트로 전달, 리턴값은 Boolean 형식
    */
    function check_Date_Length( startDate,  endDate,  comment,  mendentory)
    {
        var _startDate =  funcReplaceStrAll(startDate.value, ".", "");
        var _startDate =  funcReplaceStrAll(_startDate, "/", "");
        var _endDate   =  funcReplaceStrAll(endDate.value, ".", "");
        var _endDate   =  funcReplaceStrAll(_endDate, "/", "");

        var start_month = new Array( "31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31" );
        var end_month = new Array( "31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31" );

        var startYear = _startDate.substring(0,4);
        var endYear   = _startDate.substring(0,4);

        var startMonth = _startDate.substring(4, 6);
        var endMonth   = _endDate.substring(4, 6);

        var startDay = '';
        var endDay =    '';
        var startEx = '';
        var endEx = '';
        //var datalength = 0;

        if (_startDate.length != _endDate.length)
        {
             //alert('시작일과종료일의 자리수가 다르게 입력되었습니다.\n 다시 입력해 주시기 바랍니다.')
             alert('String day and ending day length is incorrect.\n Please check inputted data.')
             startDate.focus();
             endDate.select();
             return false;
        }

        var datalength = _startDate.length;
        if ( datalength == 6 )
        {
            startDay = '01';
            startEx = '2004/11';
            endDay = '01';
            endEx = '2004/12';


        }
        else
        {
            startDay = _startDate.substring(6, 8);
            startEx = '2004/11/30';
            endDay = _endDate.substring(6, 8);
            endEx = '2004/12/31' ;

        }


        start_month[1] = getEndOfMonthDay(  startYear,  startMonth )
        end_month[1] = getEndOfMonthDay(  endYear,  endMonth )


        //시작일과 종료일이 입력되었는지 Check
        //필수 입력항목일 경우
        if (((_startDate.length == 0 ) && (_endDate.length == 0)) && mendentory)
        {
            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 범위는 필수 입력항목입니다.\n\n ");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n ");

            startDate.focus();
        }
        //필수입력항목이 아닌 경우에 조회범위를 입력한 경우
        else if ((_startDate.length != 0) || (_endDate.length != 0))
        {
            if (_startDate.length != 6 && _startDate.length != 8)
            {
                //alert(comment + " 범위의 시작일이 자리수가 잘못 입력되었습니다.\n\n ");
                alert("Starting day length of "+comment + " range is incorrect.\n\n ");
                startDate.focus();
                startDate.select();

            }
            else if (_endDate.length != 6 && _endDate.length != 8)
            {
                //alert(comment + " 범위의 종료일이 자리수가 잘못 입력되었습니다.\n\n ");
                alert("Ending day length of "+comment + " range is incorrect.\n\n ");
                endDate.focus();
                endDate.select();
            }
            //날짜 형식 Check
            else if (isNaN(_startDate))
            {
                //alert(comment + " 범위의 시작일 형식은 숫자만 가능합니다.\n시작일 날짜형식을 확인바랍니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Starting day form of "+comment + " range can be inputted only number.\nPlease check the starting day form.\n\n Ex) "+startEx+" ~ " +endEx);
                startDate.focus();
                startDate.select();
            }
            else if (isNaN(_endDate))
            {
                //alert(comment + " 범위의 종료일 형식은 숫자만 가능합니다.\n종료일 날짜형식을 확인바랍니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Ending day form of "+comment + " range can be inputted only number.\nPlease check the ending day form.\n\n Ex) "+startEx+" ~ " +endEx);
                endDate.focus();
                endDate.select();
            }
            //날짜형식중 '월'의 범위 Check
            else if ((startMonth < '01') || (startMonth > '12'))
            {
                //alert("시작 " + comment + "의 날짜형식(월)이 잘못 입력되었습니다.\n월은 1월부터 12월까지 입력가능합니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Date form (Month) of "+comment + "is inputted incorrectly.\n Month can be inputted from Jan to Dec.\n\n Ex) "+startEx+" ~ " +endEx);

                startDate.focus();
                startDate.select();
            }
            else if ((endMonth < '01') || (endMonth > '12'))
            {
                //alert("종료 " + comment + "의 날짜형식(월)이 잘못 입력되었습니다.\n월은 1월부터 12월까지 입력가능합니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Date form (Month) of"+comment + "is inputted incorrectly.\n Month can be inputted from Jan to Dec.\n\n Ex) "+startEx+" ~ " +endEx);

                endDate.focus();
                endDate.select();
            }
            //날짜형식중 '일'의 범위 Check
            else if ((startDay < '01') || (startDay > start_month[startMonth - 1]))
            {
                //alert("시작 " + comment + "의 날짜형식(일)이 잘못 입력되었습니다.\n" + startMonth + " 월은 1일부터 " + start_month[startMonth - 1] + "일까지 입력가능합니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Date form (Day) of"+comment + "is inputted incorrectly.\n  "+ startMonth + " Month  can be inputted from 1 to "+ start_month[startMonth - 1] +" .\n\n Ex) "+startEx+" ~ " +endEx);
               startDate.focus();
                startDate.select();
            }
            else if ((endDay < '01') || (endDay > end_month[endMonth - 1]))
            {
                //alert("종료 " + comment + "의 날짜형식(일)이 잘못 입력되었습니다.\n" + endMonth + " 월은 1일부터 " + end_month[endMonth - 1] + "일까지 입력가능합니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Date form (Day) of"+comment + "is inputted incorrectly.\n  "+ startMonth + " Month  can be inputted from 1 to "+ end_month[endMonth - 1] +" .\n\n Ex) "+startEx+" ~ " +endEx);
                endDate.focus();
                endDate.select();
            }
            //시작일과 종료일보다 값이 큰 경우
            else if (_startDate > _endDate)
            {
                //alert(comment + " 범위의 시작일이 종료일보다 큼니다.\n시작일과 종료일을 확인바랍니다.\n\n 예) "+startEx+" ~ " +endEx);
                alert("Ending day must be later than starting day.\nPlease check starting day and ending day. Ex)  "+startEx+" ~ " +endEx );

                startDate.focus();
                startDate.select();
            }
            else
            {
                return true;
            }

        }
        else
        {
            return true;
        }

        return false;

   }


    function check_date_cmpOfMulti( cmpDateObj, baseDateObj,  comment, comment2, flag ,  mendentory)
    {
        if( cmpDateObj != null)
        {
             //alert('1');
            var len = cmpDateObj.length
            if(len == null)
            {//1개
                if( ! check_date_cmp( cmpDateObj, baseDateObj,  comment, comment2, flag ,  mendentory) ) return false;
            }
            else
            {
                for(i=0 ; i < len ; i++)
                {
                    if( ! check_date_cmp( cmpDateObj[i], baseDateObj,  (i+1)+'th '+comment, comment2, flag ,  mendentory) ) return false;
                }



            }

        }
         return  true;

    }

    /**
    날짜의 이후일짜 체크
     <br>
    function check_date_cmp('검사날짜','기준날짜','검사날짜' , '기준날짜','>',false)
    */
    function check_date_cmp( cmpDateObj, baseDateObj,  comment, comment2, flag ,  mendentory)
    {

        var baseDate = funcReplaceStrAll(baseDateObj.value, "-", "");
        baseDate     = funcReplaceStrAll(baseDate, "/", "");
        baseDate     = funcReplaceStrAll(baseDate, ".", "");

        var cmpDate = funcReplaceStrAll(cmpDateObj.value, "-", "");
        cmpDate     = funcReplaceStrAll(cmpDate, "/", "");
        cmpDate     = funcReplaceStrAll(cmpDate, ".", "");



        if (isNaN(cmpDate)  )
        {
          //alert('입력값 '+cmpDate+'가(이) 숫자형이 아닙니다.');
          alert( "Input data filed must be inputted by numeric data\n" );

          if( cmpDateObj.type!='hidden')
          {
              cmpDateObj.focus();
              cmpDateObj.select();
          }
          return false;
        }

        if(   mendentory
           && (    cmpDate.length==0
                || cmpDate ==''
              )
          )
         {
                //alert(comment + " 필드가 입력되지 않았습니다.\n" +
                //      comment + " 범위는 필수 입력항목입니다.\n\n ");
                alert(comment + " field is not inputted.\n" +
                      comment + " field must be inputted.\n\n ");

             return false
         }


        //시작일과 종료일이 입력되었는지 Check
        //필수 입력항목일 경우
        if ( cmpDate.length == 0  && mendentory)
        {
            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 범위는 필수 입력항목입니다.\n\n ");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n ");

            if( cmpDateObj.type!='hidden')
            {

                cmpDateObj.focus();
                cmpDateObj.select();
            }
            return false;
        }
        //필수입력항목이 아닌 경우에 조회범위를 입력한 경우
        else if (cmpDate.length != 0)
        {

            var check_error = true;

            if(flag =='>=')
            {//비교날짜가 늦거나같아야 하는데 기준날짜가 늦을때
                if  (baseDate > cmpDate)    check_error= true;
                else                        check_error= false   ;
            }
            else if(flag =='>')
            {//비교날짜가 늦어야 하는데  기준날짜가 같거나 늦을때
                if  (baseDate > cmpDate || baseDate == cmpDate)    check_error= true;
                else                        check_error= false;

            }
            else if(flag =='<=')
            {//비교날짜가 늦어야 하는데  기준날짜가 같거나 늦을때
                if  (baseDate < cmpDate )    check_error= true;
                else                        check_error= false;

            }
            else if(flag =='<')
            {//비교날짜가 늦어야 하는데  기준날짜가 같거나 늦을때
                if  (baseDate < cmpDate || baseDate == cmpDate)   check_error= true;
                else                        check_error= false;

            }
            else
            {
                if  (baseDate < cmpDate)    check_error= true;
                else                        check_error= false;

            }

            if  (check_error)
            {
                if(flag =='<=' || flag =='<')
                {
                    //alert(comment + "는 "+comment2+"보다 이전날짜여야 합니다.\n\n" );
                    alert(comment + " must be less than "+comment2+"." );
                }
                else
                {
                    //alert(comment + "는 "+comment2+"보다 이후날짜여야 합니다.\n\n" );
                    alert(comment + " must be later than "+comment2+"." );
                }


                if( cmpDateObj.type!='hidden')
                {
                    cmpDateObj.focus();
                    cmpDateObj.select();
                }
                return false;
            }
            else
            {
                return true;
            }

       }
       else
       {
          return true;
       }


    }


    /**
    날짜를 원하는 형식으로
    */
    function getFormatDate(  data,  flag)

    {

        var result = "";

        if (data.length==0 ) return data;

        if(data!="")
        {

            if (data.length==8)
            {
                var year  = data.substring(0,4);
                var month = data.substring(4,6);
                var day   = data.substring(6,8);
                if (flag.toUpperCase()=="KOR")
                {
                    result = year+"년 "+month+"월 "+day+"일";

                }else{

                    result = year+flag+month+flag+day;
                }
            }
            else if (data.length==6)
            {
                var year  = data.substring(0,4);
                var month = data.substring(4,6);

                if (flag.toUpperCase()=="KOR")
                {
                    result = year+"년 "+month+"월";
                }else
                {
                    result = year+flag+month;
                }
            }
            else if (data.length==4)
            {
                var month = data.substring(0,2);
                var day   = data.substring(2,4);

                if (flag.toUpperCase()=="KOR")
                {
                    result = month+"월 "+day+"일";
                }else
                {
                    result = month+flag+day;
                }
            }
            else
            {
                    result = data;
            }
        }

        return result;

    }


    /** Date의 영문 포맷 DD-MON-YYYYY 변경
       cmnUtil.java의  getFormatDateEng2Default와 연동되서 동작
    */
    function getFormatDateDefault2Eng( obj ,flag)
    {

      var strMonthArray = new Array(12);
      strMonthArray[0] = "JAN";
      strMonthArray[1] = "FEB";
      strMonthArray[2] = "MAR";
      strMonthArray[3] = "APR";
      strMonthArray[4] = "MAY";
      strMonthArray[5] = "JUN";
      strMonthArray[6] = "JUL";
      strMonthArray[7] = "AUG";
      strMonthArray[8] = "SEP";
      strMonthArray[9] = "OCT";
      strMonthArray[10] = "NOV";
      strMonthArray[11] = "DEC";

        var data = obj.value;
        var result = "";

        if (data.length==0 ) return data;

        if(data!="")
        {

            if (data.length==8)
            {
                var year  = data.substring(0,4);
                var month = data.substring(4,6);
                var day   = data.substring(6,8);

                result = funcReplaceStrAll(flag,"YYYY",year)
                result = funcReplaceStrAll(result,"MON",strMonthArray[month - 1])
                result = funcReplaceStrAll(result,"DD",day)


            }
            else
            {
                 result = data;
             }
        }

        return result;
    }

//-------------      DATE 끝          ---------------------//

//-------------      Alph,number 시작          ---------------------//


    /**
    오브젝트의 값에 Number만 입력
     <br>
    bug : IE에서 한글이 입력
     <br>
    &lt;input type=text name="phoneNumber" onKeyPress="return onlyNumberInput(event)"&gt;
     <br>
    0에서 9까지의 숫자, 하이픈(-), back space, . 총 13
    */
    function onlyNumberInput( e)
    {
        //alert(event.keyCode);
        //return true;

            if(NS) var keyValue = e.which;
            else if(IE) var keyValue = event.keyCode;


            if      (  ((keyValue >= 48) && (keyValue <= 57)) || keyValue == 45 || keyValue==8 || keyValue==46 )
                    return true;
            else return false;

    }



    /**
    오브젝트의 값에 한글이 포함되었는지 Check하는 함수
    <br>
    파라메터는 오브젝트로 전달, 한글이 포함되어 있으면 false 리턴
    */
    function check_AhpaNumeric( obj,  comment,  mendentory)
    {

        if ((obj.value.length == 0) && mendentory)
        {
            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 필드는 필수 입력항목입니다.\n\n 예) ABC124-01");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n Ex) ABC124-01");

            if( obj.type=='text') obj.focus();
        } else if (obj.value.length != 0)
        {
            check_ahpaNum = true;
            for (i = 0; i < obj.value.length && check_ahpaNum; i++)
            {
                if ((obj.value.charAt(i) >= 0 && obj.value.charAt(i) <= 9) ||
                    (obj.value.charAt(i) >= 'A' && obj.value.charAt(i) <= 'Z') ||
                    (obj.value.charAt(i) >= 'a' && obj.value.charAt(i) <= 'z') ||
                    (obj.value.charAt(i) == '-' ))
                {
                    ;
                }
                else
                {
                    check_ahpaNum = false;
                }
            }
            if (check_ahpaNum)
            {
                //에러 발생하지 않을때 원래대로
                if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
                else                      obj.style.backgroundColor = successColor


                //lCase2Ucase(obj);
                return true;
            }
            else
            {
                //alert(comment + " 필드는 영문자('-'포함)와 숫자만 입력가능합니다.\n" +
                //                "한글과 특수문자는 사용할 수 없습니다.");
                alert(comment + "filed must be inputted by English word, numeric data or (-).\n"+
                                "Does not allow to input Korean special characters." );
                if( obj.type=='text')
                {
                    obj.focus();
                    obj.select();
                }
            }
        } else
        {
            //에러 발생하지 않을때 원래대로

                if(obj.readOnly == true)  obj.style.backgroundColor = successReadOnlyColor
                else                      obj.style.backgroundColor = successColor


            lCase2Ucase(obj);
            return true;
        }
        //에러 발생시 색깔을 진하게
        obj.style.backgroundColor = errorColor;

        return false;
    }


    /**
    날짜의 이후일짜 체크
    <br>
    function check_numeric_cmp('검사날짜','기준날짜','검사날짜' , '기준날짜','>',false)
    */
    function check_numeric_cmp( cmpDateObj, baseDateObj,  comment, comment2, flag ,  mendentory)
    {

        var baseDate = removeComma(baseDateObj.value);
        var cmpDate = removeComma(cmpDateObj.value);

        var baseDate = parseFloat(baseDate);
        var cmpDate = parseFloat(cmpDate);



        if (isNaN(cmpDate)  )
        {
          //alert('입력값 '+cmpDate+'가(이) 숫자형이 아닙니다.');
          alert( "Input data filed must be inputted by numeric data\n" );

          cmpDateObj.focus();
          cmpDateObj.select();
          return ;
        }

        if (isNaN(baseDate)  )
        {
          //alert('입력값 '+cmpDate+'가(이) 숫자형이 아닙니다.');
          alert( "Input data filed must be inputted by numeric data\n" );

          baseDateObj.focus();
          baseDateObj.select();
          return ;
        }

        if(   mendentory
           && (    cmpDate.length==0
                || cmpDate ==''
              )
          )
          {
            return   alert(comment + " field is not inputted.\n" +
                           comment + " field must be inputted.\n\n ");
                    //alert(comment + " 필드가 입력되지 않았습니다.\n" +
                    //      comment + " 범위는 필수 입력항목입니다.\n\n ");
           }


        //시작일과 종료일이 입력되었는지 Check
        //필수 입력항목일 경우
        if ( cmpDate.length == 0  && mendentory)
        {
            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 범위는 필수 입력항목입니다.\n\n ");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n ");

            cmpDateObj.focus();
            cmpDateObj.select();
            return false;
        }
        //필수입력항목이 아닌 경우에 조회범위를 입력한 경우
        else if (cmpDate.length != 0)
        {

            var check_error = true;
            if(flag =='>=')
            {//비교날짜가 늦거나같아야 하는데 기준날짜가 늦을때
                if  (baseDate > cmpDate)    check_error= true;
                else                        check_error= false ;
            }
            else if(flag =='>')
            {//비교날짜가 늦어야 하는데  기준날짜가 같거나 늦을때
                if  (baseDate > cmpDate || baseDate == cmpDate)    check_error= true;
                else                        check_error= false;

            }
            else
            {
                if  (baseDate > cmpDate)    check_error= true;
                else                        check_error= false;

            }

            if  (check_error)
            {
                //alert(comment + "는 "+comment2+"보다 이후날짜여야 합니다.\n\n" );
                alert(comment + " must be more than "+comment2+"." );

                //위와 동일한 말
                //alert(comment2 + " must be less than "+comment+"." );
                cmpDateObj.focus();
                cmpDateObj.select();
                return false;
            }
            else
            {
                return true;
            }

       }
       else
       {
          return true;
       }

    }

    /**
    오브젝트의 값에 한글이 포함되었는지 Check하는 함수
     <br>
    파라메터는 오브젝트로 전달, 한글이 포함되어 있으면 false 리턴
     <br>
    toUpperCase()부분 제거
    */
    function checkLine_AhpaNumeric( obj, comment, mendentory, color)
    {

        if ((obj.value.length == 0) && mendentory)
        {
            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 필드는 필수 입력항목입니다.\n\n 예) ABC124-01");

            alert(comment + " field is not inputted.\n" +
                  comment + " field must be inputted.\n\n Ex) ABC124-01");

            if( obj.type=='text') obj.focus();
        } else if (obj.value.length != 0)
        {
            check_ahpaNum = true;
            for (i = 0; i < obj.value.length && check_ahpaNum; i++)
            {
                if ((obj.value.charAt(i) >= 0 && obj.value.charAt(i) <= 9) ||
                    (obj.value.charAt(i) >= 'A' && obj.value.charAt(i) <= 'Z') ||
                    (obj.value.charAt(i) >= 'a' && obj.value.charAt(i) <= 'z') ||
                    (obj.value.charAt(i) == '-' ))
                {
                    ;
                }
                else
                {
                    check_ahpaNum = false;
                }
            }
            if (check_ahpaNum)
            {
            	//에러 발생하지 않을때 원래대로
            	if(color == "input_textfield_possible")
                    obj.style.backgroundColor = input_textfield_possible_color;
                else if(color == "input_textfield_essential")
                    obj.style.backgroundColor = input_textfield_essential_color;
                else
                    obj.style.backgroundColor = input_textfield_color;

                return true;
            }
            else
            {
                //alert(comment + " 필드는 영문자('-'포함)와 숫자만 입력가능합니다.\n" +
                //                "한글과 특수문자는 사용할 수 없습니다.");

                alert(comment + "filed must be inputted by English word, numeric data or (-).\n"+
                                "Does not allow to input Korean special characters." );

                if( obj.type=='text')
                {
                    obj.focus();
                    obj.select();
                }
            }
        } else
        {
            //에러 발생하지 않을때 원래대로
            if(color == "input_textfield_possible")
                obj.style.backgroundColor = input_textfield_possible_color;
            else if(color == "input_textfield_essential")
                obj.style.backgroundColor = input_textfield_essential_color;
            else
                obj.style.backgroundColor = input_textfield_color;

            return true;
        }
        
        //에러 발생시 색깔을 진하게
        obj.style.backgroundColor = errorColor;

        return false;
    }

//-------------      Alph,number 끝          ---------------------//

//-------------      File Check 시작          ---------------------//

     function isNullAllFile( obj, filetype)
     {
            //파일업로드가 여러개일때 체크 로직
            var count = 0 ;
            var length = 0;

            if ( obj.length == null)
            {
                length = 1;
                if( obj.value == '' ) return true;
            }
            else
            {
                length = obj.length;

                for ( i=0 ; i< length ; i++)
                {
                    if (obj[i].value == '' ) count ++;
                }

                if ( count == length )
                {
                            return true;
                 }
          }
          return false;

    }
     /**파일업로드가 여러개일때 체크 로직
     */
     function check_AllFile( obj, filetype)
     {
            //파일업로드가 여러개일때 체크 로직
            var count = 0 ;
            var length = 0;

            if ( obj.length == null)
            {
                length = 1;
                if( check_File(obj ,filetype) == false ) return false;



            }
            else
            {
                length = obj.length;

                for ( i=0 ; i< length ; i++)
                {
                    if (obj[i].value == '' ) count ++;
                }

                if ( count == length )
                {
                   //var ans = confirm("첨부화일 없이 처리하시겠습니까?")
                   var ans = confirm("Do you want to save without attached file(s)?");
                   if ( ans == false )
                   {
                            obj[0].focus();
                            obj[0].select();
                            return false;
                   }
                   return true;
                 }
                 else
                 {
                    for ( i=0 ; i< length ; i++)
                    {
                        if ( obj[i].value != ''  && check_File(obj[i] ,filetype)== false )  return false;
                    }

                 }

                for(var i=0;i<length;i++)
               {
                  for (var j=i+1;j<length;j++)
                  {
                   // alert( 'i번째 : form.filename['+i+']:j+1번째 ['+(j)+']');
                   if( obj[i].value == obj[j].value && obj[i].value !='')
                   {
                     //alert((i+1)+'번째화일과 '+(j+1)+'번째 화일이 동일합니다.\n다른 파일을 선택하세요');
                     alert((i+1)+'file and'+(j+1)+'file are same.\nPlease Select another file.');
                     obj[j].focus();
                     obj[j].select();
                    return false;
                  }
                }
              }





            }

                var ans = confirm("저장하시겠습니까?")
                if ( ans == false )
                {
                     return false;
                }
                else
                {
                    return true
                }


         }



    /** file tag check
    */
    function check_File( obj , type)
    {
        var fileName     = obj.value;

        var errFlag      = "true";



        if(fileName == "")
        {
           //var ans = confirm("첨부화일 없이 처리하시겠습니까?")
           var ans = confirm("Do you want to save without attached file(s)?")
           if ( ans == false )
           {
                obj.focus();
                obj.select();
                return false;
           }
           else
           {
                return true;
           }

        }
        else
        {
            /*
            var upload_info = infoObj.value

            if (upload_info == 'P')
                alert('파일업로드 중입니다.\\n완료된후에 진행하세요..');
                //alert('File uploading.\\nTo be in process after completed.');

            else if (upload_info == 'N')
                alert('파일업로드메세지를 확인하시고 다시 확인 버튼을 누르십시오');
                //alert('Please check the file upload message and click [confirm] again.');
            */

            if( fileName == '' )
            {
                //alert('파일을 지정하세요 !!!');
                alert('Select the file !!!');
                if( obj.type=='text')
                {
                    obj.focus();
                    obj.select();
                 }
                    return false;
            }
            /*
            else if ( fileName.substring(1,2) != ':' )
            { //newtwork 드라이브 안됨
                alert('전송할 파일을 선택하세요!');
                //alert('Please select the  tansfering file !!!');
                obj.focus();
                obj.select();
                return false;
            }
            */
            /*
            else  if (  fileName.indexOf('(') != -1 ||
                        fileName.indexOf(')') != -1 ||
                        fileName.indexOf('<') != -1 ||
                        fileName.indexOf('>') != -1
                    )
            {//파일내에만 ' '가 없으면 된다
              //getClientProgramName(fileName).indexOf(' ') != -1 ||
                alert('전송할 화일명이 ),(, <,> 등을 포함하지 않아야 합니다.');
                //alert('The file name of transfering file must not include (,),<,>, etc.,');
                obj.focus();
                obj.select();
                return false;


            }
            */
            else
            {

                var  filetype = funcGetFileType(fileName).toLowerCase();

                if ( type.toLowerCase() != '*'  && type.toLowerCase() != filetype )
                {
                    //alert('전송할 화일명의 확장자는 반드시 .'+type+'이어야 합니다.');
                    alert('Extension must be'+type+' type.');
                    obj.focus();
                    obj.select();
                    return false;
                }

            }

            //파일 Upload때 파일의 한글사용제한-epis
            /*
            if(!check_Eng_Upload(obj,"첨부화일",true))
            {
                    obj.focus();
                    obj.select();

                return false;
            }
            */

            return true
        }//file태그에 값이 있을때



    }



/** 원하는 파일이 아닐때 리턴
*/
function check_Filename( obj , src_filename, comment,  mendentory, toChar)
{
    var data = getClientProgramName(obj.value);//파일명추출
    if ((obj.value.length == 0) && mendentory)
    {
        //alert(comment + " 필드가 입력되지 않았습니다.\n" +
        //      comment + " 필드는 필수 입력항목입니다.\n\n ");

        alert(comment + " field is not inputted.\n" +
              comment + " must be inputted.\n\n ");

        obj.focus();
    } else if (obj.value.length != 0)
    {
        var filename_comment = ''
        if (toChar.toUpperCase()=="TOUPPER")
        {
            filename_comment = " upper character "+src_filename;
            src_filename = src_filename.toUpperCase();
        }
        else if(toChar.toUpperCase()=="TOLOWER")
        {
            filename_comment = " lower character "+src_filename;
            src_filename = src_filename.toLowerCase();
        }
        else
        {
            filename_comment = src_filename;
        }


        if(data != src_filename)
        {
          //alert(comment + " 필드의 화일명은 "+filename_comment+"만 사용할 수 있습니다.");
          alert(comment + " field filename must be inputted by "+filename_comment+".");


          obj.focus();
          //obj.select();
          return false;
        }
        else
        {
          return true;
        }

    } else
    {
       return true;
    }

    return false;



}

/** 파일 Upload때 파일의 한글사용제한
*/
function check_Eng_Upload( obj , comment,  mendentory)
{
    var data = getClientProgramName(obj.value);//파일명추출
    var len1= parseInt(getByteLength(data));
    var len2= parseInt(data.length);
    if ((obj.value.length == 0) && mendentory)
    {
        //alert(comment + " 필드가 입력되지 않았습니다.\n" +
        //      comment + " 필드는 필수 입력항목입니다.\n\n ");

        alert(comment + " field is not inputted.\n" +
              comment + " field must be inputted.\n\n ");

        obj.focus();
    } else if (obj.value.length != 0)
    {
        if(len1!=len2)
        {//한글
          //alert(comment + " 필드는 한글과 특수문자를 포함한 화일은 사용할 수 없습니다.");
          alert(comment + " field does not allow to input Korean special characters.");
          obj.focus();
          obj.select();
          return false
        }
        else
        {//영문
          return true;
        }

    } else
    { //영문
       return true;
    }

    return false;



}

//-------------      File Check 끝          ---------------------//

//-------------      Cookie 시작          ---------------------//
   /** 쿠키 등록*/
    function setCookieOfDay( name, value, expiredays)
    {
      var todayDate = new Date();
      todayDate.setDate(todayDate.getDate() + expiredays);
      document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    //  절대 삭제 불가
    //  var today = new Date()
    //  var expire = new Date(today.getTime() + 60*60*1000*24*3650)//60*60*1000*시간*월

    }

    /** cookie등록*/
    function register( name,  value,  expire)
    {
    //  절대 삭제 불가
    //  var today = new Date()
    //  var expire = new Date(today.getTime() + 60*60*1000*24*3650)//60*60*1000*시간*월

              document.cookie = name + "=" + escape(value)
              + ( (expire) ? ";expires=" + expire.toGMTString() : "")
    }

    /** cookie가져오기*/
    function getCookie( name)
    {

        var flag = document.cookie.indexOf(name+'=');
        if (flag != -1) {
            flag += name.length + 1;
            end = document.cookie.indexOf(';', flag) ;

            if (end == -1) end = document.cookie.length;
            return unescape(document.cookie.substring(flag, end));
        }
    }

    /**cookie등록
    */
    function setCookie( name, value, hour, day)
    {//day==0 : 시간단위로 쿠키지정
            if (hour == 0)  hour=1;
            if (day > 0)    hour=24;//day에 값을 설정(0이외값)시 hour에 상관 없다
            var today = new Date();
            var expire = new Date(today.getTime() + 60*60*1000*hour*day);//60*60*1000*시간*일

            register(name, value, expire);
    }
//-------------      Cookie 끝          ---------------------//


//-------------      제번을 입력받을때 엔터를 쳐서 제번값을 area에 입력할때 시작            ---------------------//
/**
data자리수가 6자리가들어오든 8자리가 들어오든 data자리수 체크
     <br>
제번 조건필드의 유효성을 검사하는 함수
     <br>
파라메터는 오브젝트로 전달, 리턴값은 Boolean 형식
*/
function check_jebunTextarea_Length( obj,  comment, len , mendentory)
{


        //data 입력되었는지 Check
        //필수 입력항목일 경우
        if ( obj.value.length == 0  && mendentory)
        {
            //alert(comment + " 필드가 입력되지 않았습니다.\n" +
            //      comment + " 범위는 필수 입력항목입니다.\n\n ");

            alert(comment + " field is not inputted.\n" +
                 comment + " field must be inputted.\n\n ");

            obj.focus();
        }
        //필수입력항목이 아닌 경우에 조회범위를 입력한 경우
        else if (obj.value.length != 0)
        {

            if (len==999 )
            {
                if (obj.value.length != 5 &&  obj.value.length != 6 && obj.value.length != 7 && obj.value.length != 8)
                {
                    //alert(comment + " 의 자리수가 잘못 입력되었습니다.\n\n ");
                    alert("Length of "+comment + " is incorrect.\n\n ");
                    obj.focus();
                    obj.select();
                }
                else
                {
                    return true;
                }


            }else if(len!=999)
            {

                if (obj.value.length != len)
                {

                    //alert(comment + "의 자리수가 잘못 입력되었습니다.\n\n "+len+"자리를 입력하세요.");
                    alert("Length of "+comment + " is incorrect.\n\nPlease input "+leng+" figure(s)");
                    obj.focus();
                    obj.select();
                }
                else
                {
                    return true;
                }

            }
            else
            {
                return true;
            }

        }
        else
        {
            return true;
        }

        return false;

}
/**
공통 선언 가능
     <br>
funcJoinCombo(combo,'\'',','): 반환값: '233','1','11'
     <br>
funcJoinCombo(combo,'',';')  : 반환값:  233;1;11
*/
function funcJoinCombo( combo, flag1, flag2)
{
    var data='';


    var len = combo.length;
    for(var i=0;i < len;i++)
    {
        combo_value = combo.options[i].value;
        if (i != 0)
            data +=  flag2+flag1+combo_value+flag1;
        else
            //data += "'"+combo_value+"'" ;
            data += flag1+combo_value+flag1 ;
     }

    return data;
}


function funcJoinComboByCheck( combo, flag1, flag2)
{
    var data='';
    var check_count=0;

    var len = combo.length;
    for(var i=0;i < len;i++)
    {
        if(combo.options[i].selected )
        {
            combo_value = combo.options[i].value;
            if (check_count != 0)
                data +=  flag2+flag1+combo_value+flag1;
            else
                //data += "'"+combo_value+"'" ;
                data += flag1+combo_value+flag1 ;

           check_count++;
        }
     }

    return data;
}


//value : pdmdev1;test@test.co.kr;홍길동 에 요런 형식으로 들어간경우
//        0       1               2    : gubun_index
//Combo의 length만큼 gubun_idex별로  모우기
function funcJoinComboOfGubun( combo, flag1, flag2,gubun,gubun_index)
{
    var data='';
    var temp_value = '';
    var combo_value = '';

    var len = combo.length;
    for(var i=0;i < len;i++)
    {
        temp_value = combo.options[i].value;

        if(temp_value.indexOf(gubun)==-1)
        {//gubun으로 구분되지 않았으면
            combo_value  = temp_value;
        }
        else
        {
            combo_value  = temp_value.split(gubun)[gubun_index];
        }

        if (i != 0)
            data +=  flag2+flag1+combo_value+flag1;
        else
            data += flag1+combo_value+flag1 ;
     }
    return data;
}

//Combo의 중복된거 입력 안되게
function comboDupCheck(combo_value,name_obj)
{

    var len = name_obj.length
    var temp_value = '';

    for(i = 0 ; i < len ; i++ )
    {
        var value = name_obj.options[i].value;
        if(value  ==  combo_value)  return true;//중복은 안들어가게
    }

    return false;
}


//Combo의 중복된거 입력 안되게
function comboDupCheckOfGubun(combo_value,name_obj,gubun,gubun_index)
{

    var len = name_obj.length
    var temp_value = '';

    for(i = 0 ; i < len ; i++ )
    {
        temp_value = name_obj.options[i].value;

        if(temp_value.indexOf(gubun)==-1)
        {//gubun으로 구분되지 않았으면
            value  = temp_value;
        }
        else
        {
            value  = temp_value.split(gubun)[gubun_index];
        }

        //var value = name_obj.options[i].value;
        if(value  ==  combo_value)  return true;//중복은 안들어가게
    }

    return false;
}

/**
  사용법
     <br>
  &lt;INPUT type="text" name="text1" size="10" onKeyDown="return enterText(document,event,document.scs.text1,document.scs.select1,'텍스트',8,true,'TOUPPER');" &gt;
     <br>
  &lt;select name="select1" size="5"  multiple width=12  onKeyDown='return deleteKeyCombo(document,event,document.scs.select1); '&gt;
     <br>
  text box에서 enter칠때
*/
function enterText( docu, e, textObj, comboObj, comment, len, toChar)
{
    NS=(docu.layers)?true:false;
    IE=(docu.all)?true:false;

    if(NS) var keyValue = e.which;
    else   var keyValue = event.keyCode;

    if ( keyValue ==13 ) insertCombo(textObj,comboObj,comment,len,toChar);//alert('enter-init2');


}

/** combo box에서 delete key*/
function deleteKeyCombo( docu, e, comboObj)
{
    NS=(docu.layers)?true:false;
    IE=(docu.all)?true:false;

    if(NS) var keyValue = e.which;
    else   var keyValue = event.keyCode;

    if ( keyValue ==46 ) deleteCombo(comboObj);//alert('enter-init2');


}

/**
삭제 버튼 클릭때
     <br>
공통 선언 가능 - 하지만 각 프로그램에 심는게 추후에 각 프로그램마다 달라질때는 or java스크립트체크후 반환 유용
*/
function deleteCombo( comboObj)
{
    deleteComboData(comboObj);
}

/**
입력 버튼 클릭때,text box 엔터때
     <br>
공통 선언 가능 - 하지만 각 프로그램에 심는게 추후에 각 프로그램마다 달라질때는 or java스크립트체크후 반환 유용
*/
function insertCombo( textObj, comboObj, comment, len, toChar)
{

    form = document.scs;
    if (!check_jebunTextarea_Length(textObj,comment,len,true)  )
    //check_jebunTextarea_Length(obj, comment,len ,mendentory)
    //check_jebunTextarea(obj,comment,len,mendentory)
    {
        return;
    }
    if (toChar.toUpperCase()=="TOUPPER")       textObj.value = textObj.value.toUpperCase()
    else if(toChar.toUpperCase()=="TOLOWER")   textObj.value = textObj.value.toLowerCase()
    else                                       textObj.value = textObj.value

    insertComboData(textObj,comboObj);

//  funcSave();

}


/**
function deleteComboData(combo)
     <br>
function insertComboData(combo,enterText)
     <br>
위 두개의 함수는 textbox에서 enter쳐서 입력,combobox에서 delete눌렀을때 삭제때 사용
     <br>

공통 선언 가능
*/
function deleteComboData( combo)
{

    var len = combo.length-1;
    for(var i=len;i >= 0;i--)
    {
       if(combo.options[i].selected == true )
       {
            combo.options[i]  = null;
            //if(i!=len) combo.options[i].selected  = true; //삭제된다음에 바로 아래것이 선택되게한 로직
       }
     }
}


/**
공통 선언 가능
     <br>
Option(text,value);
*/
function insertComboData( enterText, combo)
{



    var pre_length       =  parseInt(combo.length,10) ;
    //default 넓이를 위해
    if (pre_length == 1 && combo.options[0].value == '' ) pre_length=0;

    var text_value =    enterText.value;
    enterText.value='';
    option = new Option(text_value,text_value);
    combo.options[pre_length] = option;


}


//-------------      제번을 입력받을때 엔터를 쳐서 제번값을 area에 입력할때 끝              ---------------------//


//-------------      Checkbox check 시작              ---------------------//
    /** checkBox 모두 체크 */
    function checkAll( obj)
    {
       if(obj!=null)
       {

          if (obj.length ==null)
          {//1개
                obj.checked = true;
          }
          else
          {
            for (var j = 0; j < obj.length; j++)
            {
                if (obj[j].checked == false) obj[j].checked = true;
            }

          }
       }
    }

    /** checkBox 모두  체크안함 */
    function uncheckAll( obj)
    {
       if(obj!=null)
       {

          if (obj.length ==null)
          {//1개
                obj.checked = false;
          }
          else
          {
            for (var j = 0; j < obj.length; j++)
            {
                if (obj[j].checked == true) obj[j].checked = false;
            }

          }
       }
    }

    /** checkBox switch */
    function switchAll( obj)
    {
       if(obj!=null)
       {

          if (obj.length ==null)
          {//1개
                obj.checked = !obj.checked;
          }
          else
          {
            for (var j = 0; j < obj.length; j++)
            {
                obj[j].checked = !obj[j].checked;
            }

          }
       }
    }


    /** checkBox switch
     <br>
     onClick="switchAllOfObj(document.gnms.key_create_date_del,this)"
     */
    function switchAllOfObj( obj, src_obj)
    {
       if(obj!=null)
       {
          if (obj.length ==null)
          {//1개
              if (!obj.disabled)    obj.checked = src_obj.checked;
          }
          else
          {
            for (var j = 0; j < obj.length; j++)
            {
               if (!obj[j].disabled)  obj[j].checked = src_obj.checked;
            }

          }
       }

    }


    /** checkBox 모두  disabled안함 */
    function undisabledAll( obj)
    {
       if(obj!=null)
       {

          if (obj.length ==null)
          {//1개
                obj.disabled = false;
          }
          else
          {
            for (var j = 0; j < obj.length; j++)
            {
                obj[j].disabled = false;
            }

          }
       }
    }



     /** checkBox에 의한 값들에 해당하는 form내의 객체들을  초기화함
         콤보박스는  처음으로 선택
     */
    function resetOfObjByValue( form,obj,inx)
    {
       if(obj!=null)
       {

          if (obj.length ==null)
          {//1개

                var inputName = obj.value;
                var _obj = eval("form."+inputName );
                if( _obj != null)
                {

                    if( _obj.type      == 'select-one') funcSelectResetMultiCombo( _obj, inx);
                    else if( _obj.type == 'text'      ) _obj.value = 'ALL';
                }
          }
          else
          {
            for (var j = 0; j < obj.length; j++)
            {
                var inputName = obj[j].value;
                var _obj = eval("form."+inputName );
                //alert(inputName);

                if( _obj != null)
                {
                    if( _obj.type      == 'select-one') funcSelectResetMultiCombo( _obj, inx);
                    else if( _obj.type == 'text'      ) _obj.value = 'ALL';
                }

            }

          }
       }
    }
    /** checkBox에 의한 값들에 해당하는 form내의 객체들을  disabled안함 */
    function undisabledAllByValue(form, obj)
    {
       if(obj!=null)
       {

          if (obj.length ==null)
          {//1개

                var inputName = obj.value;
                var _obj = eval("form."+inputName );

                if( _obj != null)
                {
                    _obj.disabled = false;
                }
          }
          else
          {
            for (var j = 0; j < obj.length; j++)
            {
                var inputName = obj[j].value;
                var _obj = eval("form."+inputName );

                if( _obj != null)
                {
                  _obj.disabled = false;
                }
            }

          }
       }
    }

    /** Check box Blur()시 체크박스세팅
     <br>
    onClick="CheckBoxSwitchOfBlur(this,document.gnms.text3[0])"
    */
    function CheckBoxSwitchOfBlur( checkObj, targetObj)
    {
        targetObj.checked=checkObj.checked;
    }

    /**
    check box Click()시 Text box세팅
    <br>
    onClick="TextBoxSwitchOfClick(this,document.gnms.text1[3])"
    <br>
    onClick="TextBoxSwitchOfClick(this,document.gnms.text1,3)"
    */
    function TextBoxSwitchOfClick( checkObj, targetObj, index)
    {
        if (targetObj.length ==null)
        {//1개
            if(checkObj.checked) targetObj.value = 'Y';
            else                 targetObj.value = 'N';
        }
        else
        {
            if(checkObj.checked) targetObj[index].value = 'Y';
            else                 targetObj[index].value = 'N';

        }

    }

    /** 갯수대로 모두 체크가 되 있어야 true */
    function checkOfAllCheck_AllCheckbox(  obj,  str , mendentory)
    {
        //    var  chk_val='';
        var len  = obj.length;
        var check_index = 0;

        if( len == null )
        {//객체가 1개
            len = '1';
            if ( obj.checked == true  )
            {
                check_index++;
            }

        }else
        {
            for( var i = 0 ; i < len; i++ )
            {
                if ( obj[i].checked == true  )
                {

                    check_index++;
                }
            }

        }

        if (check_index != len)
        {//check안되있음
             return   false;
        }
        else
        {
            return true ;
        }
    }

    /** checkBox,또는 radio를 하나라도 선택하면 true */
    function check_allCheckBox(  obj,  str , mendentory)
    {
        //    var  chk_val='';
        var len  = obj.length;
        var check_index = 0;

        if( len == null )
        {//객체가 1개
            if ( obj.checked == true  )
            {
                check_index++;
            }

        }else
        {
            for( var i = 0 ; i < len; i++ )
            {
                if ( obj[i].checked == true  )
                {

                    check_index++;
                }
            }

        }

        if (check_index == 0 && mendentory)
        {//check안되있음
             return   false;
        }
        else
        {
            return true ;
        }

    }

    /** checkBox,또는 radio를 하나도 선택안했을때 경고메세지를 보여준다 */
    function check_Checkbox(  obj,  str , mendentory)
    {
      if(obj!=null)
      {

        if (check_allCheckBox( obj, str ,mendentory))
        {//1개라도 선택
            return true         ;
        }
        else
        {
            //alert(str + "중 하나를 체크하세요");
            alert( "Check one among "+str );
            return   false;
        }
      }else
      {
         //alert(str+'가(이) 없어 사용할수 없는 기능입니다.');
         alert('As exeption of '+str+', the function can not use');
      }

    }

    /** checkBox,또는 radio를 하나도 선택안했을때 처리여부를 보여준다 */
    function confirmOfNull_Checkbox(  obj,  str , mendentory)
    {

        if (check_allCheckBox( obj, str ,mendentory))
        {//1개라도 선택

            return true ;

        }
        else
        {
           //var ans = confirm(str+" 선택없이 처리하시겠습니까?")
           var ans = confirm('Do you wish to work without choosing '+str+"?")
           if ( ans == false )
           {
                return false;
           }
           return    true;

        }

    }

    /** 삭제할때의 처리여부를 보여준다 */
    function confirmOfProcess(  str )
    {

           //var ans = confirm(str+"를(을) 하시겠습니까?")
           var ans = confirm('Do you wish to work '+str+"?")
           //var ans = confirm('Do you want to '+str+" this work?")
           if ( ans == false )
           {
                return false;
           }
           return    true;



    }

    /** 삭제할때의 처리여부를 보여준다 */
    function confirmOfDeleteLine(  str )
    {

           //var ans = confirm(str+"를(을) 하시겠습니까?")
           var ans = confirm('Do you wish to work '+str+"?")
           //var ans = confirm('Do you want to '+str+" this work?")
           if ( ans == false )
           {
                return false;
           }
           return    true;



    }

    /**
    check된것만 join
    <br>
    funcJoinCheck(combo,'\'',','): 반환값: '233','1','11'
    <br>
    funcJoinCheck(combo,'',';')  : 반환값:  233;1;11
    */
    function funcJoinCheck( obj, flag1, flag2)
    {
        var data='';

        var check_index = 0;

        if(obj!=null)
        {
            var len = obj.length;

            if (len==null)
            {//객체가 1개
                if (obj.checked == true )
                {
                    obj_value = obj.value;
                    data += flag1+obj_value+flag1   ;
                    check_index++;
                }


            }
            else
            {
                for(var i=0;i < len;i++)
                {
                    if (obj[i].checked == true )
                    {
                        obj_value = obj[i].value;

                        if (check_index != 0)
                        {
                            data +=  flag2+flag1+obj_value+flag1    ;
                        }
                        else
                        {
                            data += flag1+obj_value+flag1   ;
                            check_index++;
                        }
                    }
                 }

            }
        }

        return data;//반환값:233_1_11 //'233','1','11'
    }

    /**
    check된것만 join
     <br>
    funcJoinHiddenByCheck(obj,'\'',','): 반환값: '233','1','11'
     <br>
    funcJoinHiddenByCheck(obj,'',';')  : 반환값:  233;1;11
    */

    function funcJoinHiddenByCheck( obj, flag1, flag2, gubun, check_obj)
    {
        var data='';

        var check_index = 0;
        var len = obj.length;

        if(gubun)
        {//true 체크된것만 join
            if (len==null)
            {//객체가 1개
                 if (check_obj.checked == true )
                 {

                    obj_value = obj.value;
                    data += flag1+obj_value+flag1   ;
                    check_index++;
                }

            }
            else
            {
                for(var i=0;i < len;i++)
                {
                    if (check_obj[i].checked == true )
                     {

                        obj_value = obj[i].value;

                        if (check_index != 0)
                        {
                            data +=  flag2+flag1+obj_value+flag1   ;
                        }
                        else
                        {
                            data += flag1+obj_value+flag1  ;
                            check_index++;
                        }
                    }
                 }

            }

        }else
        {//체크 된것에 상관없이 모두 체크
            if (len==null)
            {//객체가 1개

                    obj_value = obj.value;
                    data += flag1+obj_value+flag1   ;
                    check_index++;

            }
            else
            {
                for(var i=0;i < len;i++)
                {

                        obj_value = obj[i].value;

                        if (check_index != 0)
                        {
                            data +=  flag2+flag1+obj_value+flag1  ;
                        }
                        else
                        {
                            data += flag1+obj_value+flag1   ;
                            check_index++;
                        }
                 }

            }

        }

        return data;//반환값:233_1_11 //'233','1','11'
    }
//-------------      Checkbox check 끝              ---------------------//
//-------------      Help              ---------------------//


/** Help
*/
var winHelp = null;
function funcOpenHelp(  workPath , pgmId)
{
   alert('Help is working.');

   return;
        //추가 : image를  클릭한후 몇초 후에 원래대로 off상태로
        setTimeout("funcCurrClickImageOff()", X_DISABLE_SUBMIT_TIMEOUT);
//alert(workPath+''+pgmId);
    if (winHelp != null)
    {
         winHelp.close();
         winHelp = null;
    }

    if(workPath!='' && workPath!='cmn_pgm_path' )
    {

    if(   pgmId =='UMN01'
       || pgmId =='UMN02'
       || pgmId =='UMN08'
       )

     {//사용자 신청, 패스워드 찾기,home이 필요 없을때
        var callPgm = "/help/html/"+workPath.toLowerCase()+"/"+pgmId+".html#";
        winHelp = window.open( callPgm, pgmId,'width=850,height=600,top=80,left=80,scrollbars=yes,status=yes,menubar=no,toolbar=no,directory=no,resizable=yes');

     }
     else
     {
        winHelp = window.open( 'about:blank', pgmId,'width=850,height=600,top=80,left=80,scrollbars=yes,status=yes,menubar=no,toolbar=no,directory=no,resizable=yes');

        winHelp.document.writeln("<html>");
        winHelp.document.writeln("<head>");
        winHelp.document.writeln("<title></title>");
        winHelp.document.writeln("</head>");
        winHelp.document.writeln("<frameset rows=\"0,*\"  >");//90
        winHelp.document.writeln(" <frame src='/education/06/help/help/helpofpgm.html'  name='det_con_frame'  scrolling='no'  scrolling='no' border='0' frameborder='no' marginwidth='0' >");
        winHelp.document.writeln(" <frame src='/education/06/help/help/html/"+workPath.toLowerCase()+"/"+pgmId+".html#'   name='det_lst_frame' noresize  scrolling='auto' border=1 marginwidth='0' frameborder='no'>");
        winHelp.document.writeln("</frameset></html>");
      }
   }
   else
   {
        //alert('도움말 작업중입니다.');
        alert('Help is working.');
   }

  // alert('도움말 작업중입니다.');


}

//-------------      Excel              ---------------------//
    /** Excel사용
                    if( command == 'file')
                    {
                        if(IE)
                        {
                            var target  ="XXXX01";

                            if(gubun == '') var userTop = '275' ;//
                            else            var userTop = '290' ;//

                            funcOpenExcel( userTop,target);
                            form.target = target;
                        }
                        else  form.target = 'lst_frame';//NS는 down인지 open인지 질의
                    }
                    else
                    {
                        form.target = 'lst_frame';
                    }

                form.method = 'post';
                form.action = '../servlet/XXXX01';
                form.submit();
    */
function funcOpenExcel(  userTop, target)
{

   var userWidth = 0;
   var userHeight = 0;
   userWidth=(screen.availWidth-10);
   userHeight=(parseInt(screen.availHeight,10)-90-userTop);

   var stat = 'resizable=yes,scrollbars=yes,status=yes,toolbar=no,personalbar=yes,menubar=yes,locationbar=no,top='+userTop+',left=0,width='+userWidth+',height='+userHeight+'';
   var file_viewer =  window.open('about:blank', target, stat );

}


//-------------      Window              ---------------------//

/**
funcOpenWindow(form,'post','alert', '/kor/scsalert.html', 147,185, 590, 370, 0, 0, 0, 0, 1);
*/
var openPopup = null;
function funcOpenWindow( form, method, target, action,   left,  top,  width,  height,  toolbar,  menubar,  statusbar,  scrollbar,  resizable)
{

    left   = left==null? "30":left;
    top    = top ==null? "30":top;

    width   = width  ==null? "680":width;
    height  = height ==null? "550":height;
    target = target==null? "pop_win":target;


    if(toolbar!= null)
    {
        toolbar_str = toolbar ? 'yes' : 'no';
    }

    menubar_str = menubar ? 'yes' : 'no';
    statusbar_str = statusbar ? 'yes' : 'no';

    if(scrollbar!= null)
    {
        scrollbar_str = scrollbar ? 'auto' : 'no';
    }
    else
    {
        scrollbar_str = 'auto'
    }
    //alert(scrollbar_str);
    scrollbar_str = 'no';

    resizable_str = resizable ? 'yes' : 'no';



    if( openPopup != null) openPopup.close();
    openPopup =  window.open("about:blank","_blank", 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
    openPopup.name = target
    openPopup.focus();

    if( method.toUpperCase()== 'POST')
    {//

        form.method = 'post' ;
    }
    else
    {// html때문
        form.method = 'get' ;
    }
    form.target = target ;
    form.action = action ;
    form.submit( ) ;

}

/** funcOpenWindow(form,'post','alert', '/kor/scsalert.html','120', 147,185, 590, 370, 0, 0, 0, 0, 1);
*/
function funcOpenFrame( form, method, target, action,   row_heigh, left,  top,  width,  height,  toolbar, menubar,  statusbar,  scrollbar,  resizable)
{

    toolbar_str = toolbar ? 'yes' : 'no';
    menubar_str = menubar ? 'yes' : 'no';
    statusbar_str = statusbar ? 'yes' : 'no';
    scrollbar_str = scrollbar ? 'yes' : 'no';
    resizable_str = resizable ? 'yes' : 'no';

    var winFrame =  window.open("about:blank",target+"_xx", 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);

        winFrame.document.writeln("<html>");
        winFrame.document.writeln("<head>");
        winFrame.document.writeln("<title></title>");
        winFrame.document.writeln("</head>");
        winFrame.document.writeln("<frameset rows=\""+row_heigh+",*\"  >");
        winFrame.document.writeln(" <frame src='about:blank'  name='det_con_frame'  scrolling='no'  scrolling='no' border='0' frameborder='no' marginwidth='0' >");
        winFrame.document.writeln(" <frame src='about:blank'  name='det_lst_frame' noresize  scrolling='auto' border=1 marginwidth='0' frameborder='no'>");
        winFrame.document.writeln("</frameset></html>");

    winFrame.focus();

    if( method.toUpperCase()== 'POST')
    {//

        form.method = 'post' ;
    }
    else
    {// html때문
        form.method = 'get' ;
    }
    //form.target = target ;
    form.target = "det_con_frame" ;
    form.action = action ;
    form.submit( ) ;
}


//-------------      간단한 메세지           ---------------------//


/**
간단한 메세지
*/
function funcSimpleMessage( form, obj,  message)
{

    if(message!='' )
    {
        obj.value = message;

        winMessage = window.open( 'about:blank', '_blank' ,'width=500,height=230,top=150,left=150,scrollbars=yes,status=yes,menubar=no,toolbar=yes,directory=no,resizable=yes');
        //속도빠르게
        winMessage.name ='sim';

        form.method = 'POST' ;
        form.target = 'sim' ;
        form.action = '/CswWebApp/csw/pbf/remark.jsp' ;
        form.submit( ) ;


   }


}

/**
팝업을 띄어 쿼리 미리보기
*/
function funcPopupReviewQuery( form ,url)
{


        winMessage = window.open( 'about:blank', '_blank' ,'width=500,height=230,top=150,left=150,scrollbars=yes,status=yes,menubar=no,toolbar=yes,directory=no,resizable=yes');
        //속도빠르게
        winMessage.name ='query';

        form.method = 'POST' ;
        form.target = 'query' ;
        form.action = url;
        form.submit( ) ;


}

//-------------      수학계산 시작            ---------------------//


//-------------      소수이하 반올림          ---------------------//
/** funcRound('123.5678',2)
*/
function funcRound( _data, pntLen)
{
   var data = removeComma(_data);
   if (isNaN(data) || isNaN(pntLen) )
   {
      //alert('입력값 '+data+'또는 소수 이하'+pntLen+'가(이) 숫자형이 아닙니다.');
      alert("Input data or below decimal point is filed must be inputted by numeric data\n" );
      return ;
   }
   //data   = parseFloat(data);
   data   = parseFloat(data,5);
   pntLen = parseInt(pntLen,10)

   var round = Math.pow(10,pntLen);
   var newDoub = Math.floor(data * round +.5)/round;

   return newDoub;
}

//-------------      원하는 문자 제거         ---------------------//
/**
removeChar('222,333.00',',')
*/
function removeChar( str, delstr)
{
    var src = new String(str);
    var tar = new String();
    var i, len = src.length;

    for(i = 0;i < len;i++) {
        if(src.charAt(i) != delstr) {
            tar = tar + src.charAt(i);
        }
    }

    return tar;
}

//-------------      3자리마다 ','를 삽입한다          ---------------------//

/**  3자리마다 ,
*/
function setCommaObj( obj)
{
     var _temp = removeComma(obj.value);
     var  common_mesg = "Having Compute field must be inputted by numeric data.\n Please check inputted data. Ex) 1 ";
     if (isNaN(_temp)) return  funcReturnWarn(obj,common_mesg);//숫자를 입력해야 합니다.

     obj.value= setComma( _temp );
}

/** , 제거
*/
function removeCommaObj( obj)
{
     var _temp = obj.value;

     //var  common_mesg = "";
     /* 메세지가 setComma때문에 2번 나온다.
     if (isNaN(_temp))
     {   funcReturnWarn(obj,common_mesg);//숫자를 입력해야 합니다.
         return ;
     }
     */

     obj.value= removeComma( _temp );
     if( obj.type!="hidden")      obj.focus();
}

/**
setComma('222,333.00')
*/

function setComma(  str )
{

    num = removeComma( Ltrim(str,'0') ).toString();
    len = 0;



    if( num == "" ) return "";

    // .5면 0.5로 바꿔준다
    if( num.indexOf(".")==0  ) return '0'+num;

    /* - 가 있으면 잘라냈다  반환시 붙여 준다 */
    minus = num.indexOf( '-' );
    /* - 의 위치를 못 찾았으면 */
    if( minus == -1 )
        num = num;
    else
        num = num.substring(minus+1, num.length );

    /* 소숫점의 위치를 찾는다. */
    point = num.indexOf( '.' );

    /* 소숫점의 위지를 못찾으면 계산 길이는 값의 길이가 되고 */
    if( point == -1 )
        len = num.length;
    /* 소숫점의 위치를 찾으면 계산 길이는 소수점 앞자리 까지가 된다 */
    else
        len = point;

    /* 값에서 계산할 부분만 잘래내고 */
    rtn_num = num.substring(0, len );


    /* 뒤에서부터 3자리씩 잘라서 저장할 배열을 만든다 */
    //windows200  : 배열의 길이는 유한한 양수값이어야 합니다 ..-> parseInt를 쓴다
    array_num = new Array( parseInt(  len/3 ) + 1 );
    idx = 0;

    /* 뒤에서부터 3자리씩 잘라서 배열에 저장하고 */
    for( i = len ; i > 0 ; i -= 3 )
    {
        array_num[idx] = rtn_num.substring(i-3, i );
        idx++;
    }
    rtn_num = "";

    /* 배열의 뒷부분부터 , 와 함께 붙여 나간다 */
    for( i = idx-1; i >= 0 ;i-- )
    {
        if( i < (idx-1) ) rtn_num += ","; /* 맨 앞에 , 가 오지 않도록 한다 */
        rtn_num += array_num[i];
    }

    //alert(_result.indexOf(".")+" "+_result+" " +rtn_num)

    /* 소숫점이하 값이 있으면 마지막에 붙여 준다 */
    if( point > -1 ) rtn_num += num.substring( point, num.length );
    /* - 가 있으면 앞에 붙여준다 */
    if( minus > -1 ) rtn_num = '-' + rtn_num;
    /* , 를 삽입한 문자열을 return */


    return rtn_num;
}


//-------------      문자열의 ','를 삭제한다          ---------------------//
/**
removeComma('222,333.00')
*/

function removeComma(  str )
{
    num = Ltrim(str.toString() ,'0');


    if( num == "" ) return "";

    i = 0;
    pos_com = 0;
    rtn_num = "";



    while( i < num.length )
    {
        pos_com = num.indexOf(',',i);

        if( pos_com == -1 )
        {
            rtn_num += num.substring(i, num.length );
            break;
        }
        else
        {
            rtn_num += num.substring(i, pos_com );
            i = pos_com+1;
        }
    }
    return rtn_num;
}



/**콤마가 있을때 덧셈,뺄셈,곱셈,나눗셈
  if(!funcCalculateOfComma(form.srcObj_single_single,form.byObj_single_single,form.result_single_single,form.mark_single_single.value)  )
    {
    return
    }
*/
function funcCalculateOfComma( srcObj, byObj,  mark)
{
        var result = 0;
        if (srcObj == null)
        {
            alert('계산할 객체가 없습니다.');
            return false;
        }
        if (byObj == null)
        {
            alert('계산할 객체(byObj)가 없습니다.');
            return false;
        }
        /*
        if (tarObj == null)
        {
            alert('계산값을 저장할 객체가 없습니다.');
            return false;
        }
        */

        if (!(mark=='+' || mark=='-' ||mark=='*'||mark=='/') )
        {
            alert(mark+'는 연산자의 형식이 틀렸습니다.');
            return false;
        }

        //var common_mesg = "입력값에 숫자를 입력해 주세요. Ex) 3"+srcObj.name+" "+byObj.name+" "+mark;
        var common_mesg = "Having Compute field must be inputted by numeric data.\n Please check inputted data. Ex) 3"+srcObj.name+" "+byObj.name+" "+mark;

        var lenOfSrcObj  = srcObj.length;
        var lenOfByObj  = byObj.length;

        var srcObj_value = 0;
        var byObj_value =  0;
        var tempOfComp =  0;


        if(srcObj.value ==0 ||byObj.value==0 )
        {
            result = '0';
        }
        else
        {

            //계산당할 객체가 계산할 객체가 동일한 경우
            if(srcObj==byObj)
            {
                if ( lenOfSrcObj  == null)
                {
                        tempOfComp = removeComma( srcObj.value )
                        if (isNaN(tempOfComp))
                        {
                            //funcReturnWarn(srcObj,common_mesg);
                            srcObj.focus();
                            srcObj.select();
                            alert(common_mesg);
                            return false;
                        }


                        if(funcTrim(tempOfComp)!=''  )  srcObj_value = parseFloat(tempOfComp);

                }
                else
                {
                        for (var i=0 ; i < lenOfSrcObj ;i++)
                        {
                            tempOfComp = removeComma( srcObj[i].value);
                            if (isNaN(tempOfComp))
                            {
                                // return funcReturnWarn(srcObj[i],common_mesg);
                                srcObj[i].focus();
                                srcObj[i].select();
                                alert(common_mesg);
                                return false;

                            }

                            if(funcTrim(tempOfComp)!='' )
                            {//바로 아래에선 뺄셈에 영향을 주기때문에 한줄로 못쓴다.

                                tempOfComp = parseFloat(tempOfComp);
                                if( i==0)  srcObj_value = tempOfComp;
                                else       srcObj_value = eval(srcObj_value +mark+ tempOfComp);
                            }

                        }

                }
                result = srcObj_value
            }
            else
            {

                //계산당할 객체가 1개인 경우
                if ( lenOfSrcObj  == null)
                {

                    //계산할 객체가 1개인 경우
                    if(lenOfByObj== null)
                    {
                        tempOfComp =  removeComma(srcObj.value);
                        if (isNaN(tempOfComp))
                        {
                            //return funcReturnWarn(srcObj,common_mesg);

                                srcObj.focus();
                                srcObj.select();
                                alert(common_mesg);
                                return false;

                        }
                        if(funcTrim(tempOfComp)!=''  )  srcObj_value = parseFloat(tempOfComp);

                        tempOfComp = removeComma( byObj.value       )   ;

                        if (isNaN(tempOfComp))
                        {
                            //  return funcReturnWarn(byObj,"Doing Compute field must be inputted by numeric data.\n Please check inputted data. Ex) 3");
                                byObj.focus();
                                byObj.select();
                                alert(common_mesg);
                                return false;

                        }

                        if(funcTrim(tempOfComp)!=''  )  byObj_value = parseFloat(tempOfComp);

                    }
                    //계산할 객체가 여러개인 경우
                    else
                    {
                        tempOfComp =  removeComma(srcObj.value      )       ;
                        if (isNaN(tempOfComp))
                        {
                            //return funcReturnWarn(srcObj,common_mesg);

                                srcObj.focus();
                                srcObj.select();
                                alert(common_mesg);
                                return false;

                        }

                        if(funcTrim(tempOfComp)!='' )  srcObj_value = parseFloat(tempOfComp);


                        for ( i=0; i< lenOfByObj; i++)
                        {
                            tempOfComp =  removeComma(byObj[i].value    )   ;
                            if (isNaN(tempOfComp))
                            {
                                //return funcReturnWarn(byObj[i],common_mesg);


                                byObj[i].focus();
                                byObj[i].select();
                                alert(common_mesg);
                                return false;

                            }
                            if(funcTrim(tempOfComp)!='')  byObj_value += parseFloat(tempOfComp);

                        }


                    }
                }
                //계산당할 객체가 여러개인 경우
                else
                {
                    //계산할 객체가 1개인 경우
                    if(lenOfByObj== null)
                    {

                        for (var i=0 ; i< lenOfSrcObj ;i++)
                        {
                            tempOfComp =  removeComma(srcObj[i].value  )        ;
                            if (isNaN(tempOfComp))
                            {
                                //return funcReturnWarn(srcObj[i],common_mesg);

                                srcObj[i].focus();
                                srcObj[i].select();
                                alert(common_mesg);
                                return false;
                            }

                            if(funcTrim(tempOfComp)!='' ) srcObj_value += parseFloat(tempOfComp);

                        }

                        tempOfComp =  removeComma(byObj.value  )     ;
                        if (isNaN(tempOfComp))
                        {
                            // return funcReturnWarn(byObj,common_mesg);

                                byObj.focus();
                                byObj.select();
                                alert(common_mesg);
                                return false;
                        }

                        if(funcTrim(tempOfComp)!='' ) byObj_value = parseFloat(tempOfComp);


                    }
                    //계산할 객체가 여러개인 경우
                    else
                    {

                        for (var i=0 ; i< lenOfSrcObj ;i++)
                        {
                            tempOfComp =  removeComma(srcObj[i].value )      ;
                            if (isNaN(tempOfComp))
                            {
                                // return funcReturnWarn(srcObj[i],common_mesg);

                                srcObj[i].focus();
                                srcObj[i].select();
                                alert(common_mesg);
                                return false;

                            }

                            if(funcTrim(tempOfComp)!='' )  srcObj_value += parseFloat(tempOfComp);
                        }

                        for ( i=0; i< lenOfByObj; i++)
                        {
                            tempOfComp =  removeComma(byObj[i].value );
                            if (isNaN(tempOfComp))
                            {
                                //return funcReturnWarn(byObj[i],common_mesg);
                                byObj[i].focus();
                                byObj[i].select();
                                alert(common_mesg);
                                return false;


                            }

                            if(funcTrim(tempOfComp)!='' )  byObj_value += parseFloat(tempOfComp);
                        }


                    }//계산할 객체

                }//계산당할 객체

                result = eval( srcObj_value+mark+byObj_value )      ;
            }
        }

        //tarObj.value = setComma(result);
        // .5면 0.5로 바꿔준다
        var _result = result.toString();
        if(_result.indexOf(".")==0  )  result = '0'+result;

        return result;
        //tarObj.value = result;

}

//-------------      수학계산 끝            ---------------------//


//-------------      image크기알아내어 자동으로 Window Open  ---------------------//


var img = null;
//var img.src = null;
var winAutoObj=null; // 초기화
//autoWinDrawImage("/education/images/butn.gif")

/**
    image크기에 따른 window open
*/
function autoWinDrawImage( data)
{
    // 이미지를 담을 수 있는 객체를 하나 생성한다.
    // 그런다고 이미지가 화면에 보이는 것이 아님
    img = new Image();

    // 이미지 로딩. 이미지를 웹서버로부터 전송. 출력 안함
    img.src = data;
    // 로드된 이미지의 크기를 알아냄.
    // 그리고 이미지 크기 출력

    draw(data);
}

/**
    image크기에 따른 window open

*/
function draw( data)
{
    if(img.complete == false) {
        setTimeout("draw()", "200");
        return;
    }

/* width와 height표시
    if(navigator.appName == "Microsoft Internet Explorer")
        objSpan.innerText = img.width+" x " + img.height;

    window.status = img.width+" x " + img.height;
*/
    // 이미지의 크기에 맞는 윈도우 크기를 조절하기 위해
    // 윈도우 속성을 위한 문자열 생성
    // 아래에서 20과 30을 더하지 않으면 너무 붙어서 출력 되므로.
    // 더하기 싫으면 제거하면됨.

    width =img.width+20;
    height=img.height+30;

    attr = "left=50,top=50,status=yes,"+"width="+ width+ ",height=" + height;

    // 윈도우를 열고 이미지 출력.
    if(winAutoObj != null )
    {  //&& winAutoObj.closed == false
        winAutoObj.close();

    }
    winAutoObj = window.open(img.src,'imgwindow',attr);
}


//-------------     funcPageClear  ---------------------//
function funcPageClear( page_obj,value)
{
    //
    var _value =  value;
    if( value==null ) _value = '0';

    if(page_obj != null)  page_obj.value = value;
}

 /** insert 저장
 */
 var save_remotes = null;
 function savingWindow( form, method, action)
 {
    xval = '850'
    yval = '550'

    //유의사항 종료 버튼을 disable해야 함
    //window.name = 'win'
    var str_stat = "height="+yval+","+"width="+xval+',top=105,left=155,status=yes,resizable=yes,scrollbars=yes' ;
    //var str_stat = 'fullscreen=0,toolbar=0, menubar=0, resizable=1,scrollbars=1';

    //full screen으로 띄우기 -- ie5.0만
    //var str_stat = 'fullscreen=yes,type=fullWindow,scrollbars=no,exit=no'

    //var str_stat = 'fullscreen=yes,type=fullWindow,exit=no,status=yes,resizable=yes,scrollbars=yes'

    if( save_remotes!= null )
    {
         save_remotes.focus();
         return;
    }

    var name = '';



        save_remotes = window.open('about:blank', 'save_frame',str_stat);



        save_remotes.focus(); //focus 이동
        //save_remotes.moveTo(155,105); //사이즈 조정
        //save_remotes.resizeTo(850,550); //사이즈 조정



        if( method.toUpperCase()== 'POST')
        {//
            form.method = 'post' ;
        }
        else
        {// html때문
            form.method = 'get' ;
        }
        //form.target = target ;
        form.target = "save_frame" ;
        form.action = action ;
        form.submit( ) ;
}



 /** update저장
 */
 var update_remotes = null;

 function updateWindow( form, method, action)
 {
    xval = '450';
    yval = '250';

    //유의사항 종료 버튼을 disable해야 함
    //window.name = 'win'
    var str_stat = "height="+yval+","+"width="+xval+',top=155,left=205,status=yes,resizable=yes,scrollbars=yes' ;
    //var str_stat = 'fullscreen=0,toolbar=0, menubar=0, resizable=1,scrollbars=1';


    //Window.open용
        //var str_stat = "height="+yval+","+"width="+xval+',top=155,left=205,status=yes,resizable=yes,scrollbars=yes' ;
    //window.showModalDialog용
        //var str_stat = "dialogHeight="+yval+","+"dialogWidth="+xval+',dialogTop=155,dialogLeft=205,status=yes,resizable=yes,scroll=yes' ;

    var name = '';

        //window.showModalDialog('about:blank', 'update_frame',str_stat);


    //full screen으로 띄우기 -- ie5.0만
    //var str_stat = 'fullscreen=yes,type=fullWindow,scrollbars=no,exit=no';

    //var str_stat = 'fullscreen=yes,type=fullWindow,exit=no,status=yes,resizable=yes,scrollbars=yes';

    if( update_remotes!= null )
    {
         //sskim 2002-05-08
         update_remotes.focus();
         return;
         //update_remotes = null;
    }

    var name = '';

        update_remotes= window.open('about:blank', 'update_frame',str_stat);
        //update_remotes= window.showModalDialog('about:blank', 'update_frame',str_stat);



        update_remotes.focus(); //focus 이동
        //update_remotes.moveTo(window.left,window.top); //사이즈 조정

        //update_remotes.moveTo(document.body.left, document.body.top); //사이즈 조정
        //update_remotes.moveTo(self.left, self.top); //사이즈 조정
        //update_remotes.resizeTo(850,550); //사이즈 조정



        if( method.toUpperCase()== 'POST')
        {//
            form.method = 'post' ;
        }
        else
        {// html때문
            form.method = 'get' ;
        }
        //form.target = target ;
        form.target = "update_frame" ;
        form.action = action ;
        form.submit( ) ;




}
 /**수정화면 window*/
 var modify_remotes = null;
 function modifingWindow( form, method, action)
 {
    xval = '850'
    yval = '550'

    //유의사항 종료 버튼을 disable해야 함
    //window.name = 'win'
    var str_stat = "height="+yval+","+"width="+xval+',top=105,left=155,status=yes,resizable=yes,scrollbars=yes' ;


    //full screen으로 띄우기 -- ie5.0만
    //var str_stat = 'fullscreen=yes,type=fullWindow,scrollbars=no,exit=no';

    //var str_stat = 'fullscreen=yes,type=fullWindow,exit=no,status=yes,resizable=yes,scrollbars=yes';


    if( modify_remotes != null )
    {
         //modify_remotes.focus();
         //return;
         modify_remotes = null;

    }

    var name = '';

        modify_remotes = window.open('about:blank', 'modify_frame',str_stat);

        //hidn frame이용때문에 write하여  frame생성을 하려고 했는데 이미 같은 이름 body_frame이 있어 사용 불가.

        //modify_remotes.focus(); //focus 이동
        //modify_remotes.moveTo(155,105); //사이즈 조정
        //modify_remotes.resizeTo(850,600); //사이즈 조정


        if( method.toUpperCase()== 'POST')
        {//
            form.method = 'post' ;
        }
        else
        {// html때문
            form.method = 'get' ;
        }
        //form.target = target ;
        form.target = "modify_frame" ;
        form.action = action ;
        form.submit( ) ;


}

 /**코드 체크하기
 */
 var check_remotes = null;

 function checkingMesgWindow( form, method)
 {
    xval = '500';
    yval = '300';

    //유의사항 종료 버튼을 disable해야 함
    //window.name = 'win';
    var str_stat = "height="+yval+","+"width="+xval+',top=100,left=150,status=yes,resizable=yes,scrollbars=no' ;

    //full screen으로 띄우기 -- ie5.0만
    //var str_stat = 'fullscreen=yes,type=fullWindow,scrollbars=no,exit=no'

    if( check_remotes!= null )
    {
         //check_remotes.focus();
         //return;
         check_remotes =  null;
    }

    var name = '';

    /*
    if( NS )
    {
        name = escape('/education/html/checkingCode.html') ;//어떤 netscape는 한글이 안깨짐
        //name = './open되는창.html' ;//어떤 netscape는 한글이 안깨짐
    }
    else
    {
        name = '/education/html/checkingCode.html' ;
    }
    */

        check_remotes = window.open('about:blank', 'checking',str_stat);


        if( method.toUpperCase()== 'POST')
        {//
            form.method = 'post' ;
        }
        else
        {// html때문
            form.method = 'get' ;
        }
        //form.target = target ;

        form.target = "checking" ;
        form.action = "/gnms/servlet/EN_CHKM00" ;
        form.submit( ) ;

}


/**focus를 계속 체크하는 check_remotes로
*/
function focusCheckingCodeWindow()
{
    if(check_remotes !=null )
    {

        setTimeout('check_remotes.focus()',0);
    }
}


/**Combo의 초기화
*/
function funcResetCombo( source, firstValue,  firstText,vlen)
{
    //       .type=="text"
    // 콤보박스일경우 length를 재면 1개일때는       option의 갯수
    //                              여러개일때는   객체의 객수가 나오므로 문제가 여기서 for문은 문제가 있다.
    var len  = 4;
    var start= 0;

    if(vlen != null)
    {
        len = vlen;
    }

    if(firstValue != null)
    {
        start = 1;
        source.options[0].value = firstValue;
        source.options[0].text  = firstText ;
        len++;
    }


    source.length = len;

        for(var j=start; j < len  ;j++ )
        {
            var select_tmp  =  "";
            if(j == 4)          select_tmp = "              " ;
            source.options[j].value = '';
            source.options[j].text  = select_tmp;
        }

    source.selectedIndex = 0;

}


/** 여러개의 Combo의 초기화
*/
function funcResetMultiCombo( source, inx)
{
    //       .type=="text"
    // 콤보박스일경우 length를 재면 1개일때는       option의 갯수
    //                              여러개일때는   객체의 객수가 나오므로 문제가 여기서 for문은 문제가 있다.
    len = 5;

    if(inx == 1)
    {
        funcResetCombo(source);
    }
    else
    {
        for(var k=0; k < inx  ;k++ )
        {

            funcResetCombo(source[k]);
        }

    }

}

/** 여러개의 Combo의 Select 0번째로 초기화
*/

function funcSelectResetMultiCombo( source, inx)
{
    //       .type=="text"
    // 콤보박스일경우 length를 재면 1개일때는       option의 갯수
    //                              여러개일때는   객체의 객수가 나오므로 문제가 여기서 for문은 문제가 있다.
    len = 5;

    if(inx == 1)
    {
         source.selectedIndex=0;
    }
    else
    {
        for(var k=0; k < inx  ;k++ )
        {

            source[k].selectedIndex=0;
        }

    }

}

/** 여러개의 Text의 초기화
*/
function funcResetMultiText( source, inx)
{
    //       .type=="text"
    // 콤보박스일경우 length를 재면 1개일때는       option의 갯수
    //                              여러개일때는   객체의 객수가 나오므로 문제가 여기서 for문은 문제가 있다.
    len = 5;

    if(inx == 1)
    {
        source.value='';
    }
    else
    {
        for(var k=0; k < inx  ;k++ )
        {

            source[k].value='';
        }

    }

}
/**
    발행 화면
*/
function funcObjPrint( obj, form, method, action , print_target, gubun)
{

    var len = obj.length;
    if(len== null)
    {
        funcPrint(form,method,action,obj.value+'_'+gubun )  ;

    }
    else
    {
        for(var i=0 ;i<len; i++)
        {
            if(obj[i].checked)
            {
                funcPrint(form,method,action,obj[i].value +'_'+gubun )  ;
            }
        }
    }

}
/** 발행화면으로    */
function funcPrint( form, method, action , print_target, left, top)
{
    var winPrint = null;

    if (navigator.appName != 'Netscape')
    {//IE
        winPrint = window.open('about:blank', print_target+'00', 'toolbar=yes,resizable=yes,status=yes,left='+left+',top='+top+',width=750,height=600,scrollbars=yes');

        if (winPrint != null)
        {
            winPrint.document.write(" <HTML>");
            winPrint.document.write("<HEAD>");
            winPrint.document.write(" <TITLE></TITLE>");
            winPrint.document.write("  <LINK rel='stylesheet' href='/education/css/tdstyle.css' type='text/css'> ");
            winPrint.document.write(" </HEAD>");
            winPrint.document.write(" <frameset   rows='85%,*'  >");//frameset에서 border='0' framespacing='0' frameborder='0' 내용을 빼야 frame 구분선을 조정가능
            winPrint.document.write("     <frame src='about:blank'  name='"+print_target+"'  frameborder='no'     scrolling='auto' border=0 resize>");
            winPrint.document.write("     <frame src='/CswWebApp/csw/pbf/PRNT00btn.jsp?print_target="+print_target+"' name='button_frame'    frameborder='no' scrolling=no border=0   resize>");
            winPrint.document.write(" </frameset>");
            winPrint.document.write("</body>");
            winPrint.document.write("</HTML>");
         }



        if( method.toUpperCase()== 'POST')
        {//
            form.method = 'post' ;
        }
        else
        {// html때문
            form.method = 'get' ;
        }
        //form.target = target ;
        form.target = print_target ;
        form.action = action ;
        form.submit( ) ;

        /*
        //button을 안 보여줄때
        winPrint = window.open('about:blank', 'print_frame', 'toolbar=yes,resizable=yes,left=20,top=50,width=750,height=450,scrollbars=yes');
        if( method.toUpperCase()== 'POST')
        {//

            form.method = 'post' ;
        }
        else
        {// html때문
            form.method = 'get' ;
        }
        //form.target = target ;
        form.target = "print_frame" ;
        form.action = action ;
        form.submit( ) ;
        */

    }
    else
    {
        winPrint = window.open('about:blank', print_target+'00', 'toolbar=yes,resizable=yes,status=yes,left=20,top=50,width=750,height=600,scrollbars=yes');

        if (winPrint != null)
        {
            winPrint.document.write(" <HTML>");
            winPrint.document.write("<HEAD>");
            winPrint.document.write(" <TITLE></TITLE>");
            winPrint.document.write("  <LINK rel='stylesheet' href='/education/css/tdstyle.css' type='text/css'> ");
            winPrint.document.write(" </HEAD>");
            winPrint.document.write(" <frameset   rows='85%,*'  border='0' framespacing='0' frameborder='0'>");
            winPrint.document.write("     <frame src='about:blank'  name='"+print_target+"'  frameborder='no'     scrolling='auto'>");
            winPrint.document.write("     <frame src='/CswWebApp/csw/pbf/PRNT00btn.jsp?print_target="+print_target+"' name='button_frame'    frameborder='no' scrolling=no >");
            winPrint.document.write(" </frameset>");
            winPrint.document.write("</body>");
            winPrint.document.write("</HTML>");
         }



        if( method.toUpperCase()== 'POST')
        {//
            form.method = 'post' ;
        }
        else
        {// html때문
            form.method = 'get' ;
        }
        //form.target = target ;
        form.target = print_target ;
        form.action = action ;
        form.submit( ) ;


    }
}


/**  라인의 한개 객체 중복체크  */
function  func_duplicate_check_line( check_obj, obj, comment)
{


    //한개는 선택해야 합니다.
    if( !check_Checkbox( check_obj, '저장할 데이터' ,true) )
    {
        return false;
    }

    var len = obj.length;
    if(len==null)
    {//객체가 1개
    }
    else
    {
        for(var i=0;i< len ;i++)
        {
            for (var j=i+1;j< len;j++)
            {
                 // alert( 'i번째 : form.attach_file['+i+']:j+1번째 ['+(j)+']');
                 if( check_obj[i].checked==true &&  check_obj[j].checked==true )
                 {
                    var i_data = obj[i].type=="text" ? obj[i].value:  obj[i].options[obj[i].selectedIndex].value;
                    var j_data = obj[j].type=="text" ? obj[j].value:  obj[j].options[obj[j].selectedIndex].value;

                    if(  i_data == j_data )
                    {//&& obj[i].value !=''
                        alert((i+1)+'번째 '+comment+'과(와) '+(j+1)+'번째 '+comment+'가(이) 동일합니다.\n다른 '+comment+'를(을) 선택하세요');
                        obj[j].focus();
                        if(obj[j].type=="text" && obj[j].length>0)   obj[j].select();
                        return false;
                    }
                 }
            }
        }
    }
    return true;

}


/**  라인의 2개 객체 중복체크  */
function  func_duplicate_check_lineOfMulti( check_obj, obj, obj2, comment)
{


    //한개는 선택해야 합니다.
    if( !check_Checkbox( check_obj, '저장할 데이터' ,true) )
    {
        return false;
    }

    var len = obj.length;
    if(len==null)
    {//객체가 1개
    }
    else
    {
        for(var i=0;i< len ;i++)
        {
            for (var j=i+1;j< len;j++)
            {
                 // alert( 'i번째 : form.attach_file['+i+']:j+1번째 ['+(j)+']');
                 if( check_obj[i].checked==true &&  check_obj[j].checked==true )
                 {
                    var i_data = obj[i].type=="text" ? obj[i].value:  obj[i].options[obj[i].selectedIndex].value;
                    var j_data = obj[j].type=="text" ? obj[j].value:  obj[j].options[obj[j].selectedIndex].value;

                    var i_data2 = obj2[i].type=="text" ? obj2[i].value:  obj2[i].options[obj2[i].selectedIndex].value;
                    var j_data2 = obj2[j].type=="text" ? obj2[j].value:  obj2[j].options[obj2[j].selectedIndex].value;

                    if(  i_data == j_data  && i_data2 == j_data2)
                    {//&& obj[i].value !=''
                        alert((i+1)+'번째 '+comment+'과(와) '+(j+1)+'번째 '+comment+'가(이) 동일합니다.\n다른 '+comment+'를(을) 선택하세요');
                        obj[j].focus();
                        if(obj[j].type=="text" && obj[j].length>0)   obj[j].select();
                        return false;
                    }
                 }
            }
        }
    }
    return true;

}

/** 같은 내용만  통과
*/
function  func_duplicate_want_line( check_obj, obj, comment)
{


    //한개는 선택해야 합니다.
    if( !check_Checkbox( check_obj, '저장할 데이터' ,true) )
    {
        return false;
    }

    var len = obj.length;
    if(len==null)
    {//객체가 1개
    }
    else
    {
        for(var i=0;i< len ;i++)
        {
            for (var j=i+1;j< len;j++)
            {
                 // alert( 'i번째 : form.attach_file['+i+']:j+1번째 ['+(j)+']');
                 if( check_obj[i].checked==true &&  check_obj[j].checked==true )
                 {
                    var i_data = obj[i].type=="text"||obj[i].type=="hidden" ? obj[i].value:  obj[i].options[obj[i].selectedIndex].value;
                    var j_data = obj[j].type=="text"||obj[j].type=="hidden" ? obj[j].value:  obj[j].options[obj[j].selectedIndex].value;

                    if(  i_data != j_data )
                    {//&& obj[i].value !=''
                        alert((i+1)+'번째 '+comment+'과(와) '+(j+1)+'번째 '+comment+'가(이) 다릅니다.\n같은 '+comment+'를(을) 선택하세요');


                        if(obj[j].type=="text" && obj[j].length>0)
                        {
                            obj[j].focus();
                            obj[j].select();
                        }
                        return false;
                    }
                 }
            }
        }
    }
    return true;

}




/**frame에  form이 있는지 먼저 검사
*/
function funcCheckFrameConditionPrint( lst_form)
{
    if( lst_form == null)
    {
        alert('조회를 먼저 하세요.');
        return false;
    }

    return true

}

/**특정 객체를 선택했는지 먼저 검사
*/
function funcCheckObjectConditionPrint( lst_form_obj)
{
    if( lst_form_obj.value =='' )
    {
        //alert('프린트할 목록을 선택하세요.');
        alert('Select Print LIST');
        return false;
    }
    return true

}

    /**경고메세지 뿌리고 focus가고 선택효과 주기
    */

    function funcAlertBlank ()
    {
       alert('데이터의 정렬순서를 정의하셔야합니다.');
    }

    /**를 선택하세요
    */
    function funcAlertSelect (obj,comment)
    {
       //alert(comment+'를(을) 선택하세요.');
       alert('Select '+comment);

       if(obj != null) obj.focus();

    }

    /**를 확인하세요
    */
    function funcAlertConfirm (obj,comment)
    {
       //alert(comment+'를(을) 확인하세요.');
       alert('Confirm '+comment);
       if(obj != null) obj.focus();

    }



/**
    Sort순서를 정의하기 :Combo에 의해
    obj          :
    comboSortObj : ASC,DESC

*/

function funcGetOrderOfCombo(obj,comboSortObj,resultObj,inx)
{

    var data = '';
    if(obj.length ==null)
    {
            var value = obj.options[obj.selectedIndex].value;
            if(value !='')
            {//선택하세요가 아닌경우

                if( data== '')      data = value+' '+funcSendComboValueOnly(comboSortObj);
                else                data = data+' , '+value+' '+funcSendComboValueOnly(comboSortObj);
            }

    }
    else
    {//여러줄

        for(i=0;i< obj.length;i++)
        {
            var value = obj[i].options[obj[i].selectedIndex].value;
            if(value !='')
            {//선택하세요가 아닌경우

                if( data== '')      data = value+' '+funcSendComboValueOnly(comboSortObj[i]);
                else                data = data+' , '+value+' '+funcSendComboValueOnly(comboSortObj[i]);
            }

        }


    }
    return data;
}

/**
    Sort순서를 정의하기  : Check box에 의해,찍는순서대로
    obj          :
    comboSortObj : ASC,DESC

*/

function funcGetOrderOfCheck(obj,comboSortObj,resultObj,inx)
{

        var data = '';
    if(obj.length ==null)
    {

        if(obj.checked==true)
        {//선택 했을경우
            var con_order = resultObj.value;
            var data = '';

            if( con_order== '') data = obj.value+' '+funcSendComboValueOnly(comboSortObj);
            else                data = con_order+' , '+obj.value+' '+funcSendComboValueOnly(comboSortObj);

        }
        else
        {//선택 안 했을경우

            var data_array = resultObj.value.split(" , ");
            for(i=0;i< data_array.length;i++)
            {
                //if(data_array[i].indexOf(obj.value) == -1) data+= data_array[i];
                if(data_array[i].indexOf(obj.value) == -1)
                {//일치하는게 없으면
                    if( data== '')    data =  data_array[i]
                    else              data+=' , '+ data_array[i];
                }

            }
            //if(data.indexOf(",") == 0) data = data.substring(1)

        }

    }
    else
    {//여러줄

        if(obj[inx].checked==true)
        {//선택의 효과시
            var con_order = resultObj.value;
            var data = '';

            if( con_order== '') data = obj[inx].value+' '+funcSendComboValueOnly(comboSortObj[inx]);
            else                data = con_order+' , '+obj[inx].value+' '+funcSendComboValueOnly(comboSortObj[inx]);

        }
        else
        {//

            var data_array = resultObj.value.split(" , ");
            for(i=0;i< data_array.length;i++)
            {
                if(data_array[i].indexOf( obj[inx].value) == -1 )
                {//일치하는게 없으면
                    if( data== '')    data =  data_array[i]
                    else              data+=' , '+ data_array[i];
                }


            }
            //if(data.indexOf(",") == 0) data = data.substring(1)

        }

    }
    return data;
}

/**
    Sort순서를 정의하기
    obj          :
    comboSortObj : ASC,DESC

*/
function funcGetSortOfCombo(obj,comboSortObj,resultObj,inx)
{

     var data = '';
    if(obj.length ==null)
    {

        if(obj.value != '')
        {
            var data_array = resultObj.value.split(" , ");
            for(i=0;i< data_array.length;i++)
            {

                //if(data_array[i].indexOf(obj.value) == -1) data+= data_array[i];
                if(data_array[i].indexOf(obj.value) == -1)
                {//일치하는게 없으면
                    if( data== '')    data =  data_array[i]
                    else              data+=' , '+ data_array[i];
                }
                else
                {
                    if( data== '')    data = obj.value+' '+funcSendComboValueOnly(comboSortObj)
                    else              data+= ' , '+obj.value+' '+funcSendComboValueOnly(comboSortObj);
                }

            }
            //if(data.indexOf(",") == 0) data = data.substring(1)
        }
         else
         {
            data = resultObj.value
         }


    }
    else
    {//여러줄
        if(obj[inx].value != '')
        {

            var data_array = resultObj.value.split(" , ");
            for(i=0;i< data_array.length;i++)
            {

                    if(data_array[i].indexOf(obj[inx].value) == -1)
                    {//일치하는게 없으면
                        if( data== '')    data =  data_array[i]
                        else              data+=' , '+ data_array[i];

                    }
                    else
                    {//일치하는게 있으면
                        if( data== '')    data = obj[inx].value+' '+funcSendComboValueOnly(comboSortObj[inx])
                        else              data+= ' , '+obj[inx].value+' '+funcSendComboValueOnly(comboSortObj[inx]);

                    }


            }
         }
         else
         {
            data = resultObj.value
         }
            //if(data.indexOf(",") == 0) data = data.substring(1)

    }
    return data;
}

/**
글자가 원하는 숫자로 채워지면 다음 객체로 이동
onkeyUp="return autoTab(this, 3, event,document.education.컬럼명);"
*/

var isNN = (navigator.appName.indexOf("Netscape")!=-1);
function autoTab(obj,len, e,nextObj)
{
    var keyCode = (isNN) ? e.which : e.keyCode;
    var filter = (isNN) ? [0,8,9] : [0,8,9,16,17,18,37,38,39,40,46];
    if(obj.value.length >= len && !containsElement(filter,keyCode))
    {
    obj.value = obj.value.slice(0, len);
    nextObj.focus();
    }
}
function containsElement(arr, ele)
{
    var found = false, index = 0;
    while(!found && index < arr.length)
    if(arr[index] == ele)
    found = true;
    else
    index++;
    return found;
}
/**
콤보객체에 값세팅
*/
function funcSettingCombo(obj,inx,value,text)
{
    if( IE5 )
    {
        obj.options[inx].value = value ;
        obj.options[inx].text  = text ;
    }
    else
    {//OS : XP , IE : 6.0 에 대한 대비책
        //2004.05.11 - 6.0에서 심각한 오류 다시 back한다. 아래내용 삭제 금지
        //obj.options[inx] =  new Option(text,value);

        obj.options[inx].value = value ;
        obj.options[inx].text  = text ;
    }
}


/**
  사용법
     <br>
  &lt;INPUT type="text" name="text1" size="10" onKeyDown="return enterFunction(document,event,document.scs.text1,func);" &gt;
     <br>
  &lt;select name="select1" size="5"  multiple width=12  onKeyDown='return deleteKeyCombo(document,event,document.scs.select1); '&gt;
     <br>
  text box에서 enter칠때 실행될 함수
*/
function enterFunction( docu, e, textObj, func )
{
    NS=(docu.layers)?true:false;
    IE=(docu.all)?true:false;

    if(NS) var keyValue = e.which;
    else   var keyValue = event.keyCode;

    if ( keyValue ==13 ) eval(func);


}
/**
다른 컬럼의 포커스로 가기.
*/
function funcNextFocus( obj )
{
    if(obj!='null' && obj != null)   obj.focus();
}
//필터
function func_filter(sFilter) {
    if(sFilter){
    var sKey=String.fromCharCode(event.keyCode);
    var re=new RegExp(sFilter,"ig");
    if (sKey!="\r" && !re.test(sKey)) event.returnValue=false;

    }
}






    function isNull( obj)
    {

        if( funcTrim( obj.value) == '' || obj.value.length == 0 )
        {
            return true;
        }
        return false;
     }



/** 날짜에 / 없애주기 2004/10/08 KJO */
function unsetDateFormat( data ) {
    var newData = funcReplaceStrAll( data, '/', '' );
    return newData;
}
/** 날짜에 / 주기 2004/10/08 KJO */

function setDateFormat(obj,format,comment,form)
{
    data = obj.value
    if( !check_Date_Single( obj,  comment, 8,  false) )
    {

        return;
    }
    else
    {
        obj.value = getFormatDate( data, '/' );
        if(eval(form+'.tmp_'+obj.name ) != null )  eval(form+'.tmp_'+obj.name ).value = data;
        return;
    }
}

function funcFocusSelect(obj)
{
       if (obj.type=='text' && obj.value.length >=1  )
       {
            obj.select();
       }

}

function uncheckOfCondition(checkObj,obj)
{
   //check box가 여러개 일때
   if ( checkObj.length)
   {
        for (var idx = 0; idx < checkObj.length; idx++)
        {
            //현재 클릭한 check box를 제외하고 모두 false
            if(obj == checkObj[idx])
            {

            }else
            {
               checkObj[idx].checked = false;
            }
        }
     }
}




//-------------     Tab 사용 image시작             ---------------------//

    //현재 보이는 이미지
    var  showImageOfTab   = '';
    // 누르는 이미지
    var  clickImageOfTab    = '';
    // Disable 이미지
    var disableImageOfTab   = '';

    /**click됬을때
    */
    function funcClickImageOnOfTab( name)
    {
            if( !isDisableImageOfTab (name) )
            {
                if (clickImageOfTab !='') document[clickImageOfTab].src = eval(clickImageOfTab + "_off.src");
                clickImageOfTab    = name;


                if (name !='') document[name].src = eval(name + "_click.src");
            }

    }

    /**마우스가 on되도 바로전에 클릭되었던 이미지는 클릭상태로 되있어야 하므로
    */
    function funcCurrClickImageOnOfTab()
    {


            if (clickImageOfTab !='')
            {
                 document[clickImageOfTab].src = eval(clickImageOfTab + "_click.src");
            }

    }

    /**mouse move시 image on
    */
    function funcImageOnOfTab( name)
    {
        if( !isDisableImageOfTab (name) )
        {

            if(name!='')
            {
                showImageOfTab    = name;
                document[name].src = eval(name + "_on.src");
            }
         }
    }

    /**mouse move시 image off
    */
    function funcImageOffOfTab( name)
    {
        if( !isDisableImageOfTab (name) )
        {

            if(name!='')
            {
                document[name].src = eval(name + "_off.src");
            }

            //마우스가 on되도 바로전에 클릭되었던 이미지는 클릭상태로 되있어야 하므로
            funcCurrClickImageOnOfTab();
        }
    }


     /**Disable image와 name image가 같으면 아무 반응 없이
    */
     function isDisableImageOfTab( name)
     {
         if(name!='' )
         {
            if(disableImageOfTab == name)
            {
                 return true;
            }
            return false;
         }

         return false;

     }

//-------------     Tab 사용 image끝             ---------------------//

    /**
     Obj에 있는 Value값을 반환
     <br>
     srcObj : 콤보 객체 ,gubun : ; , index
    */
    function funcTokenStringObj( srcObj, gubun, index)
    {
        var selectValue = srcObj.value;
        var result = '';
        if(selectValue.indexOf(gubun)==-1)
        {//gubun으로 구분되지 않았으면
            result  = selectValue;
        }
        else
        {
            result  = selectValue.split(gubun)[index];
        }

        return result;

    }

    /**
     Obj에 있는 token의 length반환
     <br>
     srcObj : 콤보 객체 ,gubun : ; , index
    */
    function funcTokenLengthObj( srcObj, gubun)
    {
        var selectValue = srcObj.value;
        var result = '';

        var data_array = selectValue.split(gubun);

        result =  data_array.length

        return result;
    }


    /**
    날짜 차이의 일수를 가지고 처리
     <br>
    파라메터는 오브젝트로 전달, 리턴값은 Boolean 형식
    comment : 3개월, 90일
    date_chai : 90
    */
    function check_DateChai( startDate,  endDate,  comment,  datalength, date_chai)
    {
        var _startDate =  funcReplaceStrAll(startDate, ".", "");
        var _startDate =  funcReplaceStrAll(_startDate, "/", "");
        var _endDate   =  funcReplaceStrAll(endDate, ".", "");
        var _endDate   =  funcReplaceStrAll(_endDate, "/", "");

        var startYear  = '';
        var startMonth = '';
        var startDay   = '';

        var endYear    = '';
        var endMonth   = ''
        var endDay     = ''

        if ( datalength == 6 ) {
            startYear  = _startDate.substring(0,4);
            startMonth = _startDate.substring(4,6);
            startDay = '01';

            endYear  = _endDate.substring(0,4);
            endMonth = _endDate.substring(4,6);
            endDay   = '01';
        } else {
            startYear  = _startDate.substring(0,4);
            startMonth = _startDate.substring(4,6);
            startDay   = _startDate.substring(6,8);

            endYear  = _endDate.substring(0,4);
            endMonth = _endDate.substring(4,6);
            endDay   = _endDate.substring(6,8);
        }

        var newFromDate = new Date( startYear, startMonth-1, startDay );
        var newToDate   = new Date( endYear, endMonth-1, endDay );

        var doResult = newToDate.getTime() - newFromDate.getTime();
        doResult = Math.floor( doResult / (1000 * 60 * 60 * 24) );

        if( doResult <= 0 ) {
            alert("Data validation check failure.");
            return false;
        }

        return true;
    }

     /**
    날짜 차이의 일수를 가지고 처리
     <br>
    파라메터는 오브젝트로 전달, 리턴값은 Boolean 형식

    */
    function getSubtractDay( startDate,  endDate,  datalength)
    {
        var _startDate =  funcReplaceStrAll(startDate, ".", "");
        var _startDate =  funcReplaceStrAll(_startDate, "/", "");
        var _endDate   =  funcReplaceStrAll(endDate, ".", "");
        var _endDate   =  funcReplaceStrAll(_endDate, "/", "");

        var startYear  = '';
        var startMonth = '';
        var startDay   = '';

        var endYear    = '';
        var endMonth   = ''
        var endDay     = ''

            if ( datalength == 6 )
            {
                startYear  = _startDate.substring(0,4);
                startMonth = _startDate.substring(4,6);
                startDay = '01';

                endYear  = _endDate.substring(0,4);
                endMonth = _endDate.substring(4,6);
                endDay   = '01';


            }
            else
            {
                startYear  = _startDate.substring(0,4);
                startMonth = _startDate.substring(4,6);
                startDay   = _startDate.substring(6,8);

                endYear  = _endDate.substring(0,4);
                endMonth = _endDate.substring(4,6);
                endDay   = _endDate.substring(6,8);

            }

            var newFromDate = new Date( startYear, startMonth-1, startDay );
            var newToDate   = new Date( endYear, endMonth-1, endDay );

            var doResult = newToDate.getTime() - newFromDate.getTime();
            doResult = Math.floor( doResult / (1000 * 60 * 60 * 24) );


           return doResult;

    }



    /**원하는 사이즈만큼의 char넣기
    */

    function  setChar( loopNum , fillChar)

    {

        var rtn = "";

        for( var i = 0 ; i < loopNum ; i++ )
                rtn = rtn + fillChar;

        return rtn;

    }


/**
233,343.343-->  233,343.34300과 같은 형식으로
*/
function formatNum(data,underNum)
{

    var dot = data.indexOf(".");
    var _data = '';

    if(dot ==-1)
    {
        var under_data = fillChar2String (  '',  underNum , 0, "right")
        _data =  data+'.'+ under_data

    }
    else
    {
        var under_num = fillChar2String (  data.substring(dot+1 ),  underNum , 0, "right")
        _data =  data.substring(0  ,dot  )+'.'+ under_num
    }

    return setComma( _data );

}
 /**
    원하는 문자로 원하는 갯수(totalLength-data크기)만큼 채워준다
    <p>
    반환 크기 data length
    */

    function fillChar2String (  str,  totalLength , fillChar, align)

    {

        if ( str == null   )

            str="";

        var strData  =  "";

        var CheckNum  = totalLength - str.length;



        if(totalLength >= str.length  )
        {//원하는 크기가 더 크면 그 차이만큼 채워준다.
            for ( var i = 0 ; i < CheckNum ; i++ )
                    strData += fillChar;

            if( align.toUpperCase() == 'RIGHT')
                strData = str + strData;
            else
                strData = strData + str;


        }
        else
        {//원하는 크기가 작으면 잘라준다.
            for ( var i = 0 ; i < totalLength ; i++ )
                    strData += str.substring(i,i+1);

        }
        return strData;

    }



   /**
    사용 주의 사항 년/월/일 미리 체크 요망

    입력한날의 요일 가져오기

    0 :일,1:월, 2:화,   ... 6:토
    */
    function getWantDayOfWeek( x_nYear,x_nMonth, x_nDay ) {

            if(x_nMonth >= 3){
                    x_nMonth -= 2;
            }
            else {
                    x_nMonth += 10;
            }

            if( (x_nMonth == 11) || (x_nMonth == 12) ){
                    x_nYear--;
            }

            var nCentNum = parseInt(x_nYear / 100);
            var nDYearNum = x_nYear % 100;

            var g = parseInt(2.6 * x_nMonth - .2);

            g +=  parseInt(x_nDay + nDYearNum);
            g += nDYearNum / 4;
            g = parseInt(g);
            g += parseInt(nCentNum / 4);
            g -= parseInt(2 * nCentNum);
            g %= 7;

            if(x_nYear >= 1700 && x_nYear <= 1751) {
                    g -= 3;
            }
            else {
                    if(x_nYear <= 1699) {
                            g -= 4;
                    }
            }

            if(g < 0){
                    g += 7;
            }

            return g;
    }

  function getWantDayOfWeekTitle( x_nDayOfWeek) {

            var week='';
            if(x_nDayOfWeek == 0) {
                    week = "일";

            }
            if(x_nDayOfWeek == 1) {
                    week = "월";

            }
            if(x_nDayOfWeek == 2) {
                    week = "화";

            }
            if(x_nDayOfWeek == 3) {
                    week = "수";

            }
            if(x_nDayOfWeek == 4) {
                    week = "목";

            }
            if(x_nDayOfWeek == 5) {
                    week = "금";

            }
            if(x_nDayOfWeek == 6) {
                    week = "토";

            }

            return week;
    }
  /**
    그 주의 월요일부터 일요일을 제외하고 3일씩 끊어 Format대로 반환

    destday = 0 : 일요일
    destday = 1 : 월요일
    ....
    destday = 6 : 토요일



    */
    function  getHalfOfWeek( data  , destday, format )
    {

        //숫자로 형변환
        var pyear  =  parseInt ( data.substring(0,4) ,10);
        var pmonth =  parseInt ( data.substring(4,6) ,10);
        var pday   =  parseInt ( data.substring(6,8) ,10);

        //dayofweek (1-일,2-월,...7-토)
        var dayofweek =  getWantDayOfWeek( pyear  , pmonth ,pday)+1 ;

        //그주의 월요일을 받아오기
        var pDate = new Date(pyear,pmonth-1,pday - dayofweek + destday + 1);

        var newYear = pDate.getYear();
        if (newYear < 2000) newYear += 1900; // Y2K fix
        var newMonth = pDate.getMonth()+1;
        var newDay = pDate.getDate();


        //var newtest =newYear.toString()+toLen2 (newMonth.toString())+ toLen2( newDay.toString())

        format = funcReplaceStrAll( format, "YYYY", newYear );
        format = funcReplaceStrAll( format, "MM", toLen2 (newMonth) );
        format = funcReplaceStrAll( format, "DD", toLen2 (newDay  ) );

        return format;
    }


/*var images_path = img_path;
//이름이 같은 javascript는 아래것을 탄다
//이미지 생성
function CreateImage(url) {
    var objImg = new Image();
    objImg.src = "images/"+url+".gif";
    return objImg;
}

//이미지 생성

function CreatePathImage(url,name) {
    var objImg = new Image();

    var path_file = '';


    if ( url.charAt(url.length-1) == '/')     url = url+name+".gif";
    else                                      url = url+"/"+name+".gif";

    objImg.src = url;
    return objImg;
}
*/

    /**
    여러개의 체크 박스중 선택된 개수의 값을 반환
    */
    function getCountOfCheck( obj)
    {
        var count = 0 ;
        if (obj == null)     return count;

        var len  = obj.length
        if ( len  == null)
        {
            if  (obj.checked == true )      count = 1;

        }
        else
        {
            for (var i=0 ; i< len ;i++)
            {
                if  (obj[i].checked == true )       count++;
            }
        }
        return count;

    }


/**
    클릭한 순서에 의한 data들을 중간에 gubunOfData(,)를 찍어 가져오기
    obj          : [ a , b , c ]

*/

function getDataByCheck(chkObj,obj,resultObj,inx,gubunOfData)
{

    var data = '';
    if(chkObj.length ==null)
    {

        if(chkObj.checked==true)
        {//선택 했을경우
            var con_order = resultObj.value;
            var data = '';



            if( con_order== '') data = ' '+obj.value+' ';// obj[inx].value+' ';
            else                data = con_order+gubunOfData+' '+obj.value+' ';

        }
        else
        {//선택 안 했을경우

            var data_array = resultObj.value.split(' '+gubunOfData+' ');
            for(i=0;i< data_array.length;i++)
            {

                if(data_array[i].indexOf(obj.value) == -1)
                {//일치하는게 없으면
                    if( data== '')    data =' '+ data_array[i]+' '
                    else              data+=' '+gubunOfData+' '+ data_array[i]+' ';
                }

            }


        }
       // alert('1개');

    }
    else
    {//여러줄

        if(chkObj[inx].checked==true)
        {//선택의 효과시
            var con_order = resultObj.value;
            var data = '';

            if( con_order== '') data = ' '+obj[inx].value+' ';
            else                data = con_order+gubunOfData+' '+obj[inx].value+' ';

        }
        else
        {//

            var data_array = resultObj.value.split(' '+gubunOfData+' ');
            for(i=0;i< data_array.length;i++)
            {
                if(data_array[i].indexOf( obj[inx].value) == -1 )
                {//일치하는게 없으면
                    if( data== '')    data =' '+ data_array[i]+' '
                    else              data+=' '+gubunOfData+' '+ data_array[i]+' ';
                }


            }


        }
        alert('여러개');

    }
    return data;
}
/**
    클릭한 순서에 의한 data들을 중간에 gubunOfData(,)를 찍어 가져오기
    obj          : [ a , b , c ]

*/

function getDataByAll(obj,resultObj,inx,gubunOfData)
{

    var data = '';
    if(obj.length ==null)
    {
            var con_order = resultObj.value;
            var data = '';

            if( con_order== '') data = ' '+obj.value+' ';
            else                data = con_order+gubunOfData+' '+obj.value+' ';

    }
    else
    {//여러줄
            var con_order = resultObj.value;
            var data = '';

            if( con_order== '') data = ' '+obj[inx].value+' ';
            else                data = con_order+gubunOfData+' '+obj[inx].value+' ';

    }
    return data;
}







/*
 *팝업윈도우 띄우기
 *@param url : open할 url
 *@param width : 윈도우폭
 *@param height : 윈도우높이
 *@param winName : 윈도우이름
 */
function goSearchWindow(url, width, height, winName,LeftPosition,TopPosition){

        if( LeftPosition == null)  LeftPosition = (screen.width) ? (screen.width-width)/2 : 0;
        if( TopPosition  == null)  TopPosition = (screen.height) ? (screen.height-height)/2 : 0;

        var features = "";
        features += "toolbar=no,";
        features += "location=no,";
        features += "directories=no,";
        features += "status=yes,";
        features += "menubar=no,";
        features += "scrollbars=yes,";
        features += "resizable=yes,";
        features += "left=" + LeftPosition + ",";
        features += "top=" + TopPosition + ",";
        features += "width=" + width + ",";
        features += "height=" + height;

        var openwin = window.open(url, "_blank", features);

        //팝업 속도 빠르게
        openwin.name   = winName

        openwin.target = winName;
        openwin.focus();
    }




/*
 *Code Popup윈도우 띄우기
 *@param formName : form 이름
 *@param codeField : 조회할 code (필요한 경우만 사용)
 *@param nameField : 조회할 data2 (필요한경우만 사용)
 *@param checkData : 체크할 내용
 *@param con_index : 여러 라인일때 대비

 *@param width : 윈도우 폭
 *@param height : 윈도우 높이
 *@param winName : 윈도우이름
 */
function doUserSearch(frameName,formName, codeField, nameField,con_user_id, con_user_name,con_index, width, height, winName){

    con_index   = con_index  ==null? "0":con_index;
    width   = width  ==null? "680":width;
    width   = 625;
    height  = height ==null? "550":height;
    height  = 530;
    winName = winName==null? "pop_user":winName;

    var url = "/CswWebApp/csw/jsp/popup/user/UserFrame.jsp";
    url += "?formName=" + formName;
    url += "&frameName=" + frameName;
    url += "&codeField=" + codeField;
    url += "&nameField=" + nameField;
    url += "&con_user_id=" + con_user_id;
    url += "&con_user_name=" + con_user_name;
    url += "&con_index=" + con_index;





    goSearchWindow(url, width, height, winName);

}

function doManagerByIdSearch(frameName,formName, codeField, nameField,con_user_id, con_user_name, width, height, winName){
    width   = width  ==null? "680":width;
    height  = height ==null? "450":height;
    winName = winName==null? "pop_user":winName;

    var url = "/CswWebApp/csw/jsp/popup/user/UserFrame.jsp";
    url += "?formName=" + formName;
    url += "&frameName=" + frameName;
    url += "&codeField=" + codeField;
    url += "&nameField=" + nameField;
    url += "&con_user_id=" + con_user_id;
    url += "&con_user_name=" + con_user_name;



    goSearchWindow(url, width, height, winName);

}

//중복ID체크
function doUserDupSearch(frameName,formName, codeField, con_user_id,  width, height, winName){

    width   = width  ==null? "680":width;
    height  = height ==null? "550":height;
    winName = winName==null? "pop_user_dup":winName;

    var url = "/CswWebApp/csw/jsp/popup/user/UserDupFrame.jsp";
    url += "?formName=" + formName;
    url += "&frameName=" + frameName;
    url += "&codeField=" + codeField;
    url += "&con_user_id=" + con_user_id;




    goSearchWindow(url, width, height, winName);

}
//여러명을 opener의 콤보나 히든에 입력할 경우
//input_type : COMBO : 콤보에 값넣기
//             HIDDEN: hidden에 값넣기
//        doUserSearch('opener','document.info', 'order_user_id', 'order_user_name', document.info.order_user_id.value,document.info.order_user_name.value,"COMBO", '600', '500', 'PopupUser')    ;
function doMultiUserSearch(frameName,formName, codeField, nameField,con_user_id, con_user_name, input_type,width, height, winName){
    width   = width  ==null? "680":width;
    height  = height ==null? "550":height;
    winName = winName==null? "pop_user":winName;

    var url = "/CswWebApp/csw/jsp/popup/user/UserMultiFrame.jsp";
    url += "?formName=" + formName;
    url += "&frameName=" + frameName;
    url += "&codeField=" + codeField;
    url += "&nameField=" + nameField;
    url += "&input_type=" + input_type;

    url += "&con_user_id=" + con_user_id;
    url += "&con_user_name=" + con_user_name;

    goSearchWindow(url, width, height, winName);

}

//여러명을 opener의 콤보나 히든에 입력할 경우(메일수신그룹)
//input_type : COMBO : 콤보에 값넣기
//             HIDDEN: hidden에 값넣기
//        doUserSearch('opener','document.info', 'order_user_id', 'order_user_name', document.info.order_user_id.value,document.info.order_user_name.value,"COMBO", '600', '500', 'PopupUser')    ;
function doMultiMailUserSearch(frameName,formName, input_type,width, height, winName){
    width   = width  ==null? "680":width;
    height  = height ==null? "550":height;
    winName = winName==null? "pop_user":winName;

    var url = "/CswWebApp/csw/jsp/popup/mail/UserMailFrame.jsp";
    url += "?formName=" + formName;
    url += "&frameName=" + frameName;
    //url += "&codeField=" + codeField;
    //url += "&nameField=" + nameField;
    url += "&input_type=" + input_type;

    //url += "&con_user_id=" + con_user_id;
    //url += "&con_user_name=" + con_user_name;

    goSearchWindow(url, width, height, winName);

}


//파일다운로드때 로그 남기기
//function doPopupDownload(frameName,formName, codeField, nameField,con_user_id, con_user_name, input_type,width, height, winName){
function doPopupDownload(form,width, height, winName){
    width   = width  ==null? "580":width;
    height  = height ==null? "250":height;
    winName = winName==null? "pop_download":winName;





    //goSearchWindow(url, width, height, winName);
     funcOpenWindow(form,'post',winName, '/CswWebApp/csw/jsp/popup/download/chipset_confirm.jsp', 147,185, width, height, 0, 0, 1, 0, 1);
    //funcOpenWindow( form, method, target, action,   left,  top,  width,  height,  toolbar,  menubar,  statusbar,  scrollbar,  resizable)
}

//파일 다운로드 History Popup : csw_no가 있어야 한다.
function doPopupDownloadHis(form,csw_no,width, height, winName){
    width   = width  ==null? "760":width;
    height  = height ==null? "450":height;
    winName = winName==null? "pop_download_his":winName;

    form.csw_no.value = csw_no;

    //goSearchWindow(url, width, height, winName);
     funcOpenWindow(form,'post',winName, '/CswWebApp/csw/jsp/popup/his/download_his.jsp', 147,185, width, height, 0, 0, 1, 1, 1);
    //funcOpenWindow( form, method, target, action,   left,  top,  width,  height,  toolbar,  menubar,  statusbar,  scrollbar,  resizable)
}

//결재자 History Popup : csw_no가 있어야 한다.
function doPopupSettleHis(form,csw_no,width, height, winName){
    width   = width  ==null? "700":width;
    height  = height ==null? "450":height;
    winName = winName==null? "pop_setttle_his":winName;

    form.csw_no.value = csw_no;


    //goSearchWindow(url, width, height, winName);
     funcOpenWindow(form,'post',winName, '/CswWebApp/csw/jsp/popup/his/settle_his.jsp', 147,185, width, height, 0, 0, 1, 1, 1);
    //funcOpenWindow( form, method, target, action,   left,  top,  width,  height,  toolbar,  menubar,  statusbar,  scrollbar,  resizable)
}
/*
 *상태표시줄의 내용을 변경한다.
 *@param showString : 보여줄 문자열
 */
function showStatus(showString){
    top.status = showString;
}

    /*
    흰색 리스트에 선택이 될때
    : 얼룩달룩한 리스트에 선택이 될때로 하면 복잡해서 안된다.
    */
    function listSelected(f){
    	if (f.checked){
    		f.parentElement.parentElement.className='dispSelectedField';
    	}else {
    		f.parentElement.parentElement.className='dispField';
    	}
    }
/**
  //TR선택시 색깔주기
*/
    var pre_tr_id    = '';
    var pre_tr_color = '';

    function funcTrSelectColor(tr_id)
    {

        if( pre_tr_id != '')
        {
            eval("document.all."+pre_tr_id).style.backgroundColor = pre_tr_color;
        }
        if( eval("document.all."+tr_id) != null)
        {
            pre_tr_id    = tr_id;
            pre_tr_color = eval("document.all."+tr_id).style.backgroundColor;

            eval("document.all."+tr_id).style.backgroundColor = "#F6F5E3";
        }
    }

    function trMouseOut(f,i,j,m)
    {
        var obj = f
        if( i != null) obj = obj.childNodes[i]
        if( j != null) obj = obj.childNodes[j];
        if( m != null) obj = obj.childNodes[m];

      	if ( obj != null && obj.checked ) f.className='dispSelectedField';
       	else                              f.className='dispField';

    	//if (f.childNodes[0].childNodes[0].checked)  f.className='dispSelectedField';
    	//else                                        f.className='dispField';
    }
    function trMouseOver(f,i,j,m)
    {
        var obj = f
        if( i != null) obj = obj.childNodes[i]
        if( j != null) obj = obj.childNodes[j];
        if( m != null) obj = obj.childNodes[m];

    	if ( obj != null && obj.checked ) f.className='dispSelectedField_over';
    	else                              f.className='dispOverField';

    	//if (f.childNodes[0].childNodes[0].checked)	f.className='tb3_1';
    	//else                                		f.className='tb3_1';

    }


		function popupCalendar(key1, key2, key3, key4)
		{
            var url = "/CswWebApp/csw/jsp/popup/calendar/a01/cal_one_pop_new.jsp";
            url += "?p_user_one_date=" + key1;
            url += "&p_opener_one_date=" + key2;
            url += "&formName=" + key3;
            url += "&insForm=" + key4;

			winMessage = window.open(url,"_blank","left=600,top=200,width=370,height=270,scrollbars=no,toolbars=no,resizable=no");

            winMessage.name ='cal';


		}



function wpOpen() {

	var tmp_url = 'http://c4top.lge.com:7001/w00main/w02main/index.jsp';
	var tmp_close = '';
	if (typeof top.opener=='undefined')   tmp_close='true';
	else                                  tmp_close=top.opener.closed;

	if(tmp_close){   window.open( tmp_url ,'wpmain')   };
	else{
		top.opener.top.focus();
		top.opener.top.location = tmp_url;
	}
}

 //파일 서버 다운로드
  function ftpDownload( key_real_upload_path
                          , key_system_filename
                          , key_download_filename
                          , key_userGubun
                          )
  {
     //location.href = key_system_filename;

     //var link_file = window.open( key_system_filename, 'file_view', 'scrollbars=yes,status=yes,menubar=yes,location=top,toolbar=yes,directory=no,resizable=yes,top='100',left='100',width=='500',height='+height+'');
     var link_file = window.open( key_system_filename);
  }


    //1000원 단위 절상
    //값
    function raiseMoney(money , digit) {

        var chk = Math.ceil(money)%digit;
        var chk1 = parseInt(Math.ceil(money)/digit,10);

        if (Math.ceil(money)%digit != 0) {
           chk1 = (chk1 + 1) * digit;
        } else {
           chk1 = chk1 * digit;
        }

        return chk1;
    }


    //ORACLE의 LPAD 함수를 구현
    //(OBJECT명, 채울문자, 채워질 숫자)
    function makeLpad( obj , strFill , strLength) {
        var tempStr = '';
        var strValue = obj.value;

        for (i=0; i < strLength - strValue.length ; i++ ) {
            tempStr += strFill;
        }

        obj.value = tempStr + strValue;

    }


/***********************************************************************
*  설 명 : 소문자를 대문자로 변경할때 한글이 안먹는 현상 해결
*  사용예:
*         onKeyPress 이벤트에 사용.
*         onKeyPress 이벤트시 a: 97   z: 122
*         onKeyUp     이벤트시 a: 65   z:  90
*         onKeyDown  이벤트시 a: 65   z:  90
************************************************************************/
function KeyPressUpper(fld) {
   if((event.keyCode >= 97) && (event.keyCode <= 122)) {
      //if(fld.value.length < fld.getAttribute("maxlength")) {
         fld.value += String.fromCharCode(event.keyCode).toUpperCase();
      //}
      event.returnValue = false;
   }
}


	//url 의 특수문자를 encode 하여 반환한다.
	function urlEncode(inStr) {
		outStr=' '; //not '' for a NS bug!
		for (i=0; i < inStr.length; i++) {
			aChar=inStr.substring (i, i+1);
			switch(aChar){
				case '%': outStr += "%25"; break; case ',': outStr += "%2C"; break;
				case '/': outStr += "%2F"; break; case ':': outStr += "%3A"; break;
				case '~': outStr += "%7E"; break; case '!': outStr += "%21"; break;
				case '"': outStr += "%22"; break; case '#': outStr += "%23"; break;
				case '$': outStr += "%24"; break; case "'": outStr += "%27"; break;
				case '`': outStr += "%60"; break; case '^': outStr += "%5E"; break;
				case '&': outStr += "%26"; break; case '(': outStr += "%28"; break;
				case ')': outStr += "%29"; break; case '+': outStr += "%2B"; break;
				case '{': outStr += "%7B"; break; case '|': outStr += "%7C"; break;
				case '}': outStr += "%7D"; break; case ';': outStr += "%3B"; break;
				case '<': outStr += "%3C"; break; case '=': outStr += "%3D"; break;
				case '>': outStr += "%3E"; break; case '?': outStr += "%3F"; break;
				case '[': outStr += "%5B"; break; case '\\': outStr += "%5C"; break;
				case ']': outStr += "%5D"; break; case ' ': outStr += "+"; break;
				default: outStr += aChar;
			}
		}
		return outStr.substring(1, outStr.length);
	}



	//문자열에 특수문자가 있는지 확인	
	function isContainsSChar(str)
	{
		var schar = new Array('?','\\','|','&','\'');
		for (i=0; i<str.length; i++){
			for (j=0; j<schar.length; j++){
				if (schar[j] ==str.charAt(i)){
					return true;
				}
			}
		}  
		return false;		
	}
	

// ###################################################################################################
// LPL HUB Projec Project - 2006.06.26. 서영민 : P/O관리 개발 (시작)
// 버튼 깜박깜박 처리
function doBlink() {
    var blink = document.all.tags("BLINK")
    for (var i=0; i < blink.length; i++)
    blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""
}
function startBlink() {
    if (document.all)
    setInterval("doBlink()",500)
}
// LPL HUB Projec Project - 2006.06.26. 서영민 : P/O관리 개발 (끝)
// ###################################################################################################

/**
 * 입력개체와 입력값을 받아 검증
 * 사용 방법 : onKeyUp="javascript:fnCalByte(this, 10);"
 *
 * @version	1.0, 2007-02-23
 */
function fnCalByte(obj, maxbyte) {
	var tmpStr;
	var temp=0;
	var onechar;
	var tcount;
	tcount = 0;

	tmpStr = new String(obj.value);
	temp = tmpStr.length;

	for (k=0;k<temp;k++)
	{
		onechar = tmpStr.charAt(k);

		if (escape(onechar).length > 4) {
			tcount += 2;
		}
		else if (onechar!='\r') {
			tcount++;
		}
	}

	if(tcount>maxbyte) {
		reserve = tcount-maxbyte;
		alert("입력가능한 크기는 영문"+maxbyte+"자 한글 "+maxbyte/2+"자 이내입니다."); 
		fnCutText(obj,maxbyte);
		return;
	}	
}

function fnCutText(obj,maxbyte) {
	fnNetsCheck(obj, maxbyte);
}

function fnNetsCheck(obj,max) {
	var tmpStr;
	var temp=0;
	var onechar;
	var tcount;
	tcount = 0;

	tmpStr = new String(obj.value);
	temp = tmpStr.length;

	for (k=0;k<temp;k++) {
		onechar = tmpStr.charAt(k);

		if (escape(onechar).length > 4) {
			tcount += 2;
		} else if(onechar!='\r') {
			tcount++;
		}
		if(tcount>max) {
			tmpStr = tmpStr.substring(0,k);			
			break;
		}
	}
	
	if (max == max) {
		obj.value = tmpStr;
		fnCalByte(tmpStr);
	}
	return tmpStr;
}
/**
 * 숫자만 입력하게 하는 함수
 * ex) : onkeypress="fnOnlyNum()" style="ime-mode:disabled"
 */
function fnOnlyNum() {
  if((event.keyCode<48) || (event.keyCode>57) && event.keyCode != 9)
    event.returnValue=false;
}


/** 링크점선 없애는 스크립트 **/

function bluring(){ 
if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus(); 
} 
document.onfocusin=bluring; 



