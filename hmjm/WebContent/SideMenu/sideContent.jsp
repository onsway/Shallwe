<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#css_tabs {
    font-family:'nanumgothic', '나눔고딕', 'malgun gothic', '맑은 고딕', 'dotum', '돋움', sans-serif
}

/* 탭 선택 시 표시할 요소(div) 정의(1번 탭 선택 시 첫 번째 div 요소 표시) */
#css_tabs input:nth-of-type(1), #css_tabs input:nth-of-type(1) ~ div:nth-of-type(1),
#css_tabs input:nth-of-type(2), #css_tabs input:nth-of-type(2) ~ div:nth-of-type(2),
#css_tabs input:nth-of-type(3), #css_tabs input:nth-of-type(3) ~ div:nth-of-type(3) {
    display:none
}
#css_tabs input:nth-of-type(1):checked ~ div:nth-of-type(1),
#css_tabs input:nth-of-type(2):checked ~ div:nth-of-type(2),
#css_tabs input:nth-of-type(3):checked ~ div:nth-of-type(3) {
    display:block
}

/* 라벨 기본 스타일 지정 */
#css_tabs > label {
    display:inline-block;
    font-variant:small-caps;
    font-size:.9em;
    padding:5px;
    text-align:center;
    width:20%;
    line-height:1.8em;
    font-weight:700;
    border-radius:3px 3px 0 0;
    background:#eee;
    color:#777;
    border:1px solid #ccc;
    border-width:1px 1px 0
}
#css_tabs > label:hover {
    cursor:pointer
}
#css_tabs label[for=tab1] {
    margin-left:1.5em
}

/* 선택된 라벨, 커서를 올린 라벨 스타일 지정 */
#css_tabs input:nth-of-type(1):checked ~ label:nth-of-type(1), #css_tabs > label[for=tab1]:hover {
    background:tomato;
    color:#fff
}
#css_tabs input:nth-of-type(2):checked ~ label:nth-of-type(2), #css_tabs > label[for=tab2]:hover {
    background:gold;
    color:#fff
}
#css_tabs input:nth-of-type(3):checked ~ label:nth-of-type(3), #css_tabs > label[for=tab3]:hover {
    background:green;
    color:#fff
}

/* 실제 내용이 담긴 div 요소 스타일 지정 */
#css_tabs .tab1_content, #css_tabs .tab2_content, #css_tabs .tab3_content {
    padding:2em;
    border:1px solid #ddd;
    width:70%;
    height:100%
}

</style>
</head>
<body>
 <div id="css_tabs">
        <!-- 라디오 버튼 -->
        <input id="tab1" type="radio" name="tab" checked="checked" />
        <input id="tab2" type="radio" name="tab" />
        <input id="tab3" type="radio" name="tab" />

        <!-- 라벨 : 화면에 표시되는 탭 제목 -->
        <label for="tab1">Tab 1</label>
        <label for="tab2">Tab 2</label>
        <label for="tab3">Tab 3</label>

        <!-- 탭 내용 : 탭 제목을 선택했을 때 표시되는 본문 -->
        <div class="tab1_content">
            Tab1 내용<br/>
			사이드메뉴는 뭘로 하시겠습니까?
        </div>
        <div class="tab2_content">
            Tab2 내용<br/>
			늘 먹던걸로 주세요.
        </div>
        <div class="tab3_content">
            Tab3 내용<br/>
			뭐래
        </div>
    </div>
</body>
</html>