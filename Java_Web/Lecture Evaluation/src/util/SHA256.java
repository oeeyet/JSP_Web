package util;
// 특별한 입력값(이메일)을 해시를 적용한 값을 반환해서 이용하겠다는 의미고 솔티를 악의적인 해커로부터 예방
import java.security.MessageDigest;

// 회원가입 한 후 이메일 인증을 할 때 기존의 이메일 값의 해시값을 적용해서 사용자가 이것을 인증코드로 링크를 타고들어와서 쓰는거
public class SHA256 {
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256"); // 알고리즘을 적용시켜줌.
			byte[] salt = "Hello! This is salt.".getBytes();	// 해커 방지
			digest.reset();
			digest.update(salt);
			byte[] chars = digest.digest(input.getBytes("UTF-8"));
			for(int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) result.append("0");
				result.append(hex);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result.toString();
	}
}
