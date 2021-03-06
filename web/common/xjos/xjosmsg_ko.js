var xa_messages_table = new Array(
 new Array("itemname", 0, "입력오류 발생 : 항목명[@]\n\n"),
 new Array("required", 0, "필수입력입니다."),
 new Array("minlength", 0, "입력된 항목의 자릿수가 너무 작습니다. \n최소 @자리이상 입니다."),
 new Array("maxbyte", 0, "입력된 항목의 자릿수가 너무 큽니다. \n최대 @ 자리이하 입니다. \n(한글 한글자를 2자리로 계산)"),
 new Array("minbyte", 0, "입력된 항목의 자릿수가 너무 작습니다. \n최소 @ 자리이상입니다. \n(한글 한글자를 2자리로 계산)"),
 new Array("maxbyte_utf8", 0, "입력된 항목의 자릿수가 너무 큽니다. \n최대 @ 자리이하 입니다. \n(한글 한글자를 3자리로 계산)"),
 new Array("minbyte_utf8", 0, "입력된 항목의 자릿수가 너무 작습니다. \n최소 @ 자리이상입니다. \n(한글 한글자를 3자리로 계산)"),
 new Array("maxvalue", 0, "입력된 항목의 값이 너무 큽니다. \n현재값은 @입니다. \n최대 @ 이하의 값이라야 합니다. "),
 new Array("minvalue", 0, "입력된 항목의 값이 너무 작습니다. \n현재값은 @ 입니다. \n최소 @ 이상의 값이라야 합니다. "),
 new Array("alphabetic", 0, "alphabetic 형식이 아닙니다."),
 new Array("alpha_numeric", 0, "alphabetic 혹은 numeric 형식이 아닙니다."),
 new Array("numeric", 0, "numeric 형식이 아닙니다."),
 new Array("money", 0, "적절한 금액 형식이 아닙니다."),
 new Array("integer", 0, "integer(정수) 형식이 아닙니다."),
 new Array("float", 0, "실수형식이 아닙니다."),
 new Array("hexa", 0, "16진수(Hexa)형식이 아닙니다."),
 new Array("is_value", 0, "xJos Says :\n[@]에서의 is_value 사용이 틀렸습니다. \n[@]에 해당하는 입력필드 오브젝트가 존재하지 않습니다."),
 new Array("is_value", 1, "xJos Says :\n[@]에서의 is_value 사용이 틀렸습니다. \n[@]에 해당하는 입력필드 오브젝트에 value가 존재하지 않습니다."),
 new Array("is_value", 2, "[@]항목의 입력값이 [@]항목의 입력값과 틀립니다."),
 new Array("mask", 0, "잘못된형식의 입력입니다.\n[@]형식으로 입력하셔야 합니다."),
 new Array("date", 0, "날짜입력이 잘못되었습니다."),
 new Array("psn", 0, "입력한 주민등록번호가 잘못되었습니다."),
 new Array("csn", 0, "입력한 사업자 등록번호가 잘못되었습니다."),
 new Array("credit_card", 0, "Credit Card 번호 형식이 아닙니다."),
 new Array("email", 0, "이메일 형식이 아닙니다."),
 new Array("advanced_email", 0, "이메일 형식이 아닙니다."),
 new Array("advanced_email", 1, "이메일 형식에 맞지 않습니다. \n사용자 이름 부분에 invalid character가 있습니다."),
 new Array("advanced_email", 2, "이메일 형식에 맞지 않습니다. \n도메인 이름 부분에 invalid character가 있습니다."),
 new Array("advanced_email", 3, "이메일 형식에 맞지 않습니다. \n사용자 이름 부분이 잘못되었습니다."),
 new Array("advanced_email", 4, "이메일 형식에 맞지 않습니다. \nIP address 부분이 잘못되었습니다."),
 new Array("advanced_email", 5, "이메일 형식에 맞지 않습니다. \nDomain name 부분이 잘못되었습니다."),
 new Array("advanced_email", 6, "이메일 형식에 맞지 않습니다. \nDomain name이 알려진 도메인이 아닙니다."),
 new Array("advanced_email", 7, "이메일 형식에 맞지 않습니다. \nhost name이 없습니다."),
 new Array("domain", 0, "도메인 형식이 잘못되었습니다."),
 new Array("reg_exp", 0, "Regular Expression 형식에 맞지 않습니다. \n형식이 @에 적합해야 합니다."),
 new Array("ddd", 0, "@는 올바른 DDD 번호가 아닙니다."),
 new Array("hpd", 0, "@는 올바른 휴대폰/PCS 국번이 아닙니다.")
);