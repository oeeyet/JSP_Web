package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

// 실질적으로 데이터베이스 접근할 수 있도록 만들
public class UserDAO {

	public int login(String userID, String userPassword) {
		// 사용자로부터 입력받은 아이디의 비밀번호를 불러온다는 의미
		String SQL = "select userPassword from user where userID = ?";

		Connection conn = null;
		// 특정한 SQL을 성공적으로 수행할 수 있도록 만들어줌
		PreparedStatement pstmt = null;
		// 특정한 SQL문을 행한 후 나온 결과값에 대해 처리하고자하는 클래스
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			// 사용자에게 받은 아이디 값을 저기 위에있는 물음표값에 넣는
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // 데이터베이스에서 검색하는 것(, 데이터를 조회할 때 사용)
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				} else {
					return 0; // 비밀번호 틀림
				}
			}
			return -1; // 아이디 없음.

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (rs != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -2; // 데이터베이스 오류
	}

	public int join(UserDTO user) {

		String SQL = "insert into user values = (?, ?, ?, ?, false)";

		Connection conn = null;
		// 특정한 SQL을 성공적으로 수행할 수 있도록 만들어줌
		PreparedStatement pstmt = null;
		// 특정한 SQL문을 행한 후 나온 결과값에 대해 처리하고자하는 클래스
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			// 사용자에게 받은 아이디 값을 저기 위에있는 물음표값에 넣는
			pstmt.setString(1, user.getUserID()); //
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate(); // 실제로 영향을 받은 데이터 개수를 반환.

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (rs != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 회원가입 실패
	}

	public String getUserEmail(String userID) {

		String SQL = "select userEmailChecked from user where userID = ?";

		Connection conn = null;
		// 특정한 SQL을 성공적으로 수행할 수 있도록 만들어줌
		PreparedStatement pstmt = null;
		// 특정한 SQL문을 행한 후 나온 결과값에 대해 처리하고자하는 클래스
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			// 사용자에게 받은 아이디 값을 저기 위에있는 물음표값에 넣는
			pstmt.setString(1, userID);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (rs != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null; // 데이터베이스 오류
	}

	public boolean getUserEmailChecked(String userID) {

		String SQL = "select userEmailChecked from user where userID = ?";

		Connection conn = null;
		// 특정한 SQL을 성공적으로 수행할 수 있도록 만들어줌
		PreparedStatement pstmt = null;
		// 특정한 SQL문을 행한 후 나온 결과값에 대해 처리하고자하는 클래스
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getBoolean(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (rs != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false; // 데이터베이스 오류
	}

	public boolean setUserEmailChecked(String userID) {

		String SQL = "update user set userEmailChecked = true where userID = ?";

		Connection conn = null;
		// 특정한 SQL을 성공적으로 수행할 수 있도록 만들어줌
		PreparedStatement pstmt = null;
		// 특정한 SQL문을 행한 후 나온 결과값에 대해 처리하고자하는 클래스
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			// 사용자에게 받은 아이디 값을 저기 위에있는 물음표값에 넣는
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (rs != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false; // 데이터베이스 오류
	}
}
