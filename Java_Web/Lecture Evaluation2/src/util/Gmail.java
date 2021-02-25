package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{
	//지메일 stmp를 사용을 위해 계정 정보를 위해 외부라이브러리 2개 사용
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("ohejoh@gmail.com", "dmswl0130");
	}
}
