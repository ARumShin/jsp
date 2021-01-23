	function checkMember(){
		var regExpId= /^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		var regExpName= /^[가-힣]*$/;
		var regExpPasswd= /^[0-9]*$/;
		var regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;
		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		var form=document.newMember;
		
		var id= form.id.value;
		var name=form.name.value;
		var passwd=form.passwd.value;
		var phone=form.phone1.value+"-"+form.phone2.value+"-"+form.phone3.value;
		var email= form.email.value;
		
		if(!regExpId.test(id)){
			alert("아이디는 문자로 시작해 주세요!");
			form.id.select();
			return;
		}
		if(!regExpName.test(name)){
			alert("이름은 한글만 입력해주세요!");
			return;
		}
		if(!regExpPasswd.test(passwd)){
			alert("비밀번호는 숫자만 입력해주세요!");
			return;
		}
		if(!regExpPhone.test(phone)){
			alert("연락처 입력을 확인해주세요!");
			return;
		}
		if(!regExpEmail.test(email)){
			alert("이메일 입력을 확인해주세요!");
			return;
		}
		form.submit();
	}

/**
 * 2020.06.10 유효성 검사
 */
function CheckAddProduct(){
	var productId = document.getElementById("productId");
	var name = document.getElementById("name");
	var unitPrice = document.getElementById("unitPrice");
	var unitsInStock = document.getElementById("unitsInStock");
	
	if(!check(/^P[0-9]{4,11}$/,productId,"[상품코드]\nP와 숫자를 조합하여 5~12자까지 " +
			"입력하세요\n첫 글자는 반드시 P로 시작하세요."))
		return false;
	if(name.value.length<4 || name.value.length>12){
		alert("[상품명]\n최소 4자에서 최대 12자까지 입력하세요.");
		name.select();
		name.focus();
		return false;
	}
	if(unitPrice.value.length == 0 || isNaN(unitPrice.value)){
		alert("[가격]\n숫자만 입력하세요.");
		unitPrice.select();
		unitPrice.focus();
		return false;
	}
	
	if(unitPrice.value<0){
		alert("[가격]\n음수는 입력할 수 없습니다.");
		unitPrice.select();
		unitPrice.focus();
		return false;
	}else if(!check(/^\d+(?:[.]?[\d]?[\d])?$/,unitPrice,"[가격]\n소수점 둘째 자리까지만 입력하세요"))
			return false;

	if(isNaN(unitsInStock.value)){
		alert("[재고 수]\n 숫자만 입력하세요.");
		unitsInStock.select();
		unitsInStock.focus();
		return false;
		
	}
	
	function check(regExp, e, msg){
		
		if(regExp.test(e.value)){
			return true;
		}
		alert(msg);
		e.select();
		e.focus();
		return false;
	}
	document.newProduct.submit();
}