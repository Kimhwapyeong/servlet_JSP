package el;

public class MyElClass {

	public MyElClass() {
		// TODO Auto-generated constructor stub
	}
	
	// 주민번호를 입력받아 성별을 반환하는 메소드
	// 000000-1000000
	public String getGender(String jumin) {
		String gender = "";
		
		try {
			int startIndex = jumin.indexOf("-") + 1;
			int endIndex = startIndex + 1;
								// 시작인덱스(포함), 끝인덱스(불포함)
			String s = jumin.substring(startIndex, endIndex);
			if(s.equals("1") || s.equals("3")) {
				gender = "남자";
			} else if(s.equals("2") || s.equals("4")){
				gender = "여자";
			} else {
				// 예외를 발생
				// throw new Exception();
				gender = "주민등록 번호를 확인해주세요.";
			}
			
		} catch (Exception e) {
			gender = "주민등록 번호를 확인해주세요.";
		}
		return gender;
	}
	
	// 입력받은 문자열이 숫자인지 판별하는 정적 메소드
	public static boolean isNumber(String value) {
//		try {
//			Integer.parseInt(value);
//			return true;
//		} catch (Exception e) {
//			return false;
//		}
		char[] chArr = value.toCharArray();
		
		for(char ch : chArr) {
			// 문자가 포함되어 있으면 return false;
			// 48-57
			if(!(ch >= '0' && ch <= '9')) {
				return false;
			} 
		}
		return true;
	}
	
	// 입력받은 정수까지 구구단을 HTML 테이블로 출력하는 정적 메소드
	// 1~9단까지 출력
	public static String showGugudan(int limitDan) {
		StringBuffer sb = new StringBuffer();
		sb.append("<table border='1'>");
		
		for(int i=2; i<=limitDan; i++) {
			sb.append("<tr>");
			for(int j=1; j<=9; j++) {
				sb.append("<td>"+i+"*"+j+"="+j*i+"</td>");
			}
			sb.append("</tr>");
		}
		sb.append("</table>");
		
		return sb.toString();
		
//		String res = "<table border='1'>";
//		
//		for(int i=1; i<=limitDan; i++) {
//			res += "<tr>";
//			for(int j=1; j<=9; j++) {
//				res += "<td>"
//						+ i + " * " + j + " = " + i * j
//						+ "</td>";
//			}
//			res += "</tr>";
//		}
//		
//		res += "</table>";
//		return res;
	}
	
	public static void main(String[] args) {
		MyElClass el = new MyElClass();
		System.out.println(el.getGender("000000-1111111"));
		
		System.out.println(MyElClass.isNumber("d"));
		System.out.println(MyElClass.isNumber("7"));
		
		System.out.println(el.showGugudan(6));
	}
}
