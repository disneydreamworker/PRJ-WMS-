package wms_1.docs.산출물;

public class script {
  public static void main(String[] args) {
    System.out.println("============================================================================");
    System.out.println("=".repeat(70));

    System.out.printf("%40s", "창고천국에 오신 것을 환영합니다!");

    System.out.println("\n"
        + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠀⡀⣀⠀⠂⠤⡁⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⡎⠡⡈⠘⠲⠂⡖⢉⠉⢌⢱⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠱⢦⠐⢌⣬⠀⡇⣠⣈⠤⠋⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠀⡔⡑⠀⢈⡄⠂⠀⠉⢆⠀⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠀⠣⠌⠆⠋⠐⠁⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n"
        + "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n");
    System.out.println();
    System.out.println("1. 로그인  2. 출고 관리  3. 고객센터");
    System.out.println("============================================================================");
    System.out.println(); // 메뉴와 입력 사이에 한 줄 추가하기
    System.out.println("-> 1 ");
    System.out.println(); // 입력 받은 후 메뉴 출력 사이에 한 줄 추가하기
    System.out.println("1. 로그인  2. 아이디 찾기 3. 비밀번호 찾기  4. 회원 등록");
    System.out.println();
    System.out.println("-> 1 ");
    System.out.println("---로그인---"); // ---메뉴명--- 으로 메뉴명 함께 출력하기
    System.out.println("아이디를 입력해주세요."); // 문장 마지막에 마침표
    System.out.println("비밀번호를 입력해주세요."); // ~요, ~까, ~다
    System.out.println("<로그인 성공 시>");
    System.out.println("000 관리자님 반갑습니다!");
    System.out.println();
    System.out.println("============================================================================");
    System.out.println("---메인 메뉴---");
    System.out.println("1. 회원 관리    2. 입고 관리    3. 출고 관리"); // 메뉴는 모두 동일한 사이즈와 동일한 공백 주기
    System.out.println("4. 재고 관리    5. 창고 관리    6. 고객 센터");
    System.out.println("7. 로그아웃");
    System.out.println();
    System.out.println("<입고 관리 시 : 관리자 화면>");
    System.out.println("--- 입고 관리 메뉴 ---");
    System.out.println("1. 입고 요청 승인   2. 입고 요청 수정   3. 입고 요청 취소");
    System.out.println("4. 입고 지시서 출력 5. 입고 요청 리스트 출력  6. 입고 현황 조회");
    System.out.println("7. 메인메뉴로 이동하기"); // "메인 메뉴"라고 지정 / 나가기 X
    System.out.println();
    System.out.println("<입고 관리 시 : 회원 화면>");
    System.out.println("--- 입고 관리 메뉴 ---");
    System.out.println("1. 입고 요청 등록   2. 입고 요청 수정   3. 입고 요청 취소 ...");
    System.out.println();
    System.out.println("-> 입고 요청 등록");
    System.out.println();
    System.out.println("---입고 요청 등록---");
    System.out.println("<입고 요청서 항목 입력 받기>");
    System.out.println("<회원이 보유 중인 창고 리스트 출력>");
    System.out.println();
    System.out.println("창고ID  | 창고 주소  | 창고종류   | 상품명(재고) | 상품ID  | 입고날짜  | 수량");
    System.out.println("창고 아이디를 입력해주세요.");
    System.out.println("-> 120");
    System.out.println();
    System.out.println("1. 등록");
    System.out.println("2. 취소");
    System.out.println("-> 1 ");
    System.out.println();
    System.out.println("<DB에 입고 요청 등록이 성공했을 경우>");
    System.out.println("회원님의 입고 요청이 정상적으로 등록되었습니다.");
    System.out.println("<회원이 등록한 입고 요청서 화면 출력>");
    System.out.println("<입고 요청>");
    System.out.println("상품ID|  상품명 |수량 |날짜 | 창고ID  |창고 주소");
    System.out.println();
    System.out.println("<입고 관리 메뉴 출력>");
    System.out.println("1. 입고 요청 등록   2. 입고 요청 수정   3. 입고 요청 취소 ...");
    System.out.println("");
    System.out.println("");
  }
}
