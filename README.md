# 도서 리뷰 & 정보 웹사이트 프로젝트 

## 프로젝트 정리

깃허브 저장소 이름 :  Eun-Chan/Book-Review-website

> Clone URL : https://github.com/Eun-Chan/Book-Review-website.git



미리 구성할 목록(모르는 내용은 url통해  학습)

#### 1. DBCP (커넥션 풀)

> https://www.holaxprogramming.com/2013/01/10/devops-how-to-manage-dbcp/



#### 2. DAO 싱글톤 패턴(디자인 패턴 중 하나)

> http://zion437.tistory.com/157



#### 3. 서버 호스팅 (aws ec2)

</br>

#### 4. Front Controller Pattern (url Pattern - 확장자패턴 사용)  ===> FrontController.java + index.jsp 확인할 것
   클라이언트의 요청을 한 곳으로 집중 , 개발 및 유지보수의 효율성 극대화
   하나의 서블릿(Controller)에 요청을 주고 , 서블릿에서 각 요청에 대해 분기
   http://rongscodinghistory.tistory.com/80
</br>
url - pattern 을 위해 사용되는 Code
```jsp    // 컨텍스트 패스 + 요청한 command 이름
    String uri = request.getRequestURI();
    // 컨텍스트 패스
    String conPath = request.getContextPath();
    // 컨텍스트를 이용해 command
    String command = uri.substring(conPath.length());
```

#### 5. Command Pattern



초기 프로젝트 파일 구성

Project folder name : BookReviewWebsite

Context root : brw
